<template>
<div class="number-widget">
  <p>{{ payload.value }}</p>
</div>
</template>

<script>
var widget = {
  props: ["payload"]
};

export default widget;
</script>

<style scoped>
.number-widget {
  background-color: red;
  height: 100%;
  width: 100%;
  display: flex;
  font-size: 200%;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
