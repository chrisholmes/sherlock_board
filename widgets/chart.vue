<template>
  <canvas></canvas>
</template>

<script>
var options = {
  responsive: true,
  animation: false
}
import Widget from 'web/static/js/widget'
export default Widget.register('chart', {
  methods: {
    renderChart(payload) {
      var ctx = this.$el.getContext("2d");
      var line = new Chart(ctx, {
        type: 'line',
        data: payload,
        options: options
      });
    },
  },
  watch: {
    payload: function(newPayload) {
      this.renderChart(newPayload);
    }
  },
  mounted() {
    this.renderChart(this.payload); 
  }
})
</script>

<style scoped>
canvas {
  display: flex;
  background-color: white;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
