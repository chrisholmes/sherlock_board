import Vue from 'vue'
import channel from "./socket";

class Widget  {
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
    this.widgets.push([name, box])
    return component;
  }
}
export default new Widget(); 
