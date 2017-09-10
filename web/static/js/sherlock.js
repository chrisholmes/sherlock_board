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

class JobEvents {
  constructor() {
    this.eventListeners = []
    this.keepaliveTimer = null;
    this.connect();
  }

  gotActivity(){
    if(this.keepaliveTimer != null)clearTimeout(this.keepaliveTimer);
    this.keepaliveTimer = setTimeout(() => {this.connect();}, 30 * 1000);
  }

  wrapWithTimer(listener) {
    return (e) => {
      this.gotActivity();
      listener(e);
    }
  }

  connect(){
    this.gotActivity();
    let es = new EventSource("/events");
    es.addEventListener('message', (e) =>{
      this.gotActivity();
    })
    this.eventListeners.forEach((eventListener) => {
      let wrappedListener = this.wrapWithTimer(eventListener.listener);
      es.addEventListener(eventListener.job, wrappedListener);
    });
    this.eventSource = es;
  }

  addEventListener(job, listener) {
    this.eventListeners.push({job: job, listener: listener});
    let wrappedListener = this.wrapWithTimer(listener);
    this.eventSource.addEventListener(job, wrappedListener);
  }
}

let jobEvents = new JobEvents();

class WidgetManager  {
  constructor() {
    this.base = {
      props: ["job"],
      mounted: function() {
        jobEvents.addEventListener(this.job, (e) => {
          this.payload = JSON.parse(e.data);
        });
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
