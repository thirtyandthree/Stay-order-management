<template>
  <div></div>
</template>

<script>
export default {
  name: 'Live2dWidget',
  mounted() {
    const script = document.createElement('script');
    script.src = 'https://fastly.jsdelivr.net/gh/stevenjoezhang/live2d-widget@latest/autoload.js';
    script.onload = () => console.log('Live2D widget loaded successfully.');
    script.onerror = () => console.error('Failed to load Live2D widget.');
    document.body.appendChild(script);
  },
};
</script>
