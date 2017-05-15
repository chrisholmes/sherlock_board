<template>
  <div class="html-widget" v-html="payload.html"></div>
</template>

<script>
import Widget from 'web/static/js/widget'
export default Widget.register('htmlbox', {})
</script>

<style scoped>
.html-widget {
  background-color: #304D83;
  text-color: rgb(230,230,230);
  font-size: 200%;
  height: 100%;
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
