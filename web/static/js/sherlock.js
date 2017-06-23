import Vue from 'vue';
import {Socket} from "phoenix"

var Grid = {
  template: '<div class="grid" v-bind:style="gridStyle"><slot></slot></div>',
  props: ["columns", "width", "height", "rows"],
  computed:  {
    gridTemplateColumns: function() {
      return "repeat(" + (this.columns || this.defaultColumns) + ", " + (this.width || this.defaultWidth) + ")"
    },
    gridTemplateRows: function() {
      return "repeat(" + (this.rows || this.defaultRows) + ", " + (this.height || this.defaultHeight) + ")";
    },
    gridStyle: function() {
      return {
        gridTemplateColumns: this.gridTemplateColumns,
        gridTemplateRows: this.gridTemplateRows
      }
    }
  },
  data: function() {
    return {
      defaultHeight: "200px",
      defaultWidth: "200px",
      defaultRows: 4,
      defaultColumns: 5
    }
  }
}

var SherlockInit =  function() {
  return new Vue({
    el: "#grid",
    components: {
      'grid': Grid
    }
  })
}

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

let channel = socket.channel("jobs", {});
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

class WidgetManager  {
  constructor() {
    this.base = {
      props: ["job"],
      mounted: function() {
        channel.on(this.job, payload => {
          this.payload = payload;
        })
      },
      data() {
        return {
          payload: {}
        }
      }
    };
    this.widgets = [];
  }

  register(name, component) {
    component.extends=this.base;
    var box = {
      template: '<div class="box"><widget v-bind:job="job"></widget></div>',
      props: ["job", "widget"],
      components: {
        'widget': component
      }
    }
    Vue.component(name, box)
    return component;
  }
}
var Widget = new WidgetManager()
export { Grid, SherlockInit, Widget };
