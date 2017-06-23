<template>
  <span>{{ payload.value }}</span>
</template>

<script>
import { Widget } from 'sherlock';

export default Widget.register('number', {});
</script>

<style scoped>
span {
  background-color: #C33A3D;
  text-color: rgb(230,230,230);
  font-size: 400%;
  height: 100%;
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
