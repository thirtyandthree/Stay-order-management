<template>
  <div id="weather-widget-container" >
    <div style='border:3px solid #FF82AB;font-size:bold;font-size:18px;' id="ww_e724561391a37" v='1.3'
     loc='auto' a='{"t":"horizontal","lang":"zh",
     "sl_lpl":1,"ids":[],"font":"Arial","sl_ics":"one_a","sl_sot":"celsius",
     "cl_bkg":"#FFC0CB","cl_font":"#FFFAFA",
     "cl_cloud":"#FFFFFF","cl_persp":"#FFFFFF","cl_sun":"#FFC107","cl_moon":"#FFC107","cl_thund":"#FF5722"}'>
      <a href="https://weatherwidget.org/zh/" id="ww_e724561391a37_u" target="_blank">天气插件</a>
    </div>
  </div>
</template>
<script>
export default {
  mounted() {
    let script = document.createElement('script');
    script.async = true;
    script.src = 'https://app2.weatherwidget.org/js/?id=ww_e724561391a37';
    document.getElementById('weather-widget-container').appendChild(script);
  }
}
</script>

