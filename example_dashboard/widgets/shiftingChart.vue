<template>
  <!-- <linechart v-bind:chartData="payload"></linechart> -->
  <canvas></canvas>
</template>

<script>
var options = {
  responsive: true,
  maintainAspectRatio: false,
  animation: false,
  legend: {
    display: false
  },
  scales: {
    yAxes: [{
      ticks: {
        beginAtZero:true
      }
    }]
  }
}
var Chart = require("chart.js")
import { Widget } from 'sherlock'
export default Widget.register('shiftingChart', {
  data() {
    return {
      size: 10,
      dataset: [],
      intervals: []
    }
  },
  methods: {
    updateIntervals(newInterval) {
      if(this.intervals.length == this.size){
        this.intervals.shift()
      }
      this.intervals = this.intervals.map(function(n) {
        return n - newInterval;
      })
      this.intervals.push(0)
    },
    renderChart() {
      var ctx = this.$el.getContext("2d");
      var line = new Chart(ctx, {
        type: 'line',
        data: {
          labels: this.intervals,
          datasets: [ { data: this.dataset } ]
        },
        options: options
      });
    },
  },
  watch: {
    payload: function(newPayload) {
      if(this.dataset.length == this.size){
        this.dataset.shift()
      }
      this.dataset.push(newPayload.value)
      this.updateIntervals(newPayload.period)
      this.renderChart();
    }
  },
  mounted() {
    this.renderChart(this.payload); 
  }
})
</script>

<style scoped>
canvas {
  background-color: white;
}
</style>
