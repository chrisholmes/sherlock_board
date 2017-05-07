// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import socket from "./socket";

let channel = socket.channel("jobs", {});
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

import Vue from 'vue';

Vue.component('htmlbox', {
  template: '<box widget="Html" job="html"></box>',
  props: ["job", "widget"]
})

Vue.component('box', {
  template: '<div class="box"><component v-bind:is="widget" v-bind:payload="payload"></component></div>',
  props: ["job", "widget"],
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
})

Vue.component('grid', {
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
})

var app = new Vue({
  el: "#grid"
})
