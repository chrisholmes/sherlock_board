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

import Vue from "vue";
import socket from "./socket"

let channel = socket.channel("jobs:my_job", {});
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

Vue.component('htmlbox', {
  template: '<div class="box"><div v-html="htmlPayload"></div></div>',
  mounted: function() {
    channel.on("html", payload => {
      this.htmlPayload = payload.html;
    })
  },
  data() {
    return {
      htmlPayload: null
    }
  }
})

Vue.component('Number', {
  template: '<p>{{ payload.value }}</p>',
  props: ["payload"]
})

Vue.component('box', {
  template: '<div class="box"><component v-bind:is="widget" v-bind:payload="payload"></component></div>',
  props: ["widget"],
  mounted: function() {
    channel.on("event", payload => {
      this.payload = payload;
    })
  },
  data() {
    return {
      payload: {}
    }
  }
})

var app = new Vue({
  el: "#grid"
})
