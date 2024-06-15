<template>
  <div id="qrCode" ref="qrCodeDiv"></div>
</template>

<script>
import QRCode from "qrcodejs2";
export default {
  name: "qrCode",
  props: {
    url: {
      type: String,
      required: true,
    },
  },
  data() {
    return {};
  },
  watch: {
    url: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.bindQRCode();
      }
    },
  },
  mounted: function () {
    this.$nextTick(function () {
      this.bindQRCode();
    });
  },
  methods: {
    bindQRCode: function () {
      // 确保div已经渲染，在此之前清除之前的二维码
      this.$refs.qrCodeDiv.innerHTML = "";
      new QRCode(this.$refs.qrCodeDiv, {
        text: this.url, // 使用传入的prop
        width: 300,
        height: 300,
        colorDark: "#333333",
        colorLight: "#ffffff",
        correctLevel: QRCode.CorrectLevel.L,
      });
    },
  },
};
</script>
<style scoped>
#qrCode {
  border-radius: 25px;
  border: 8px solid #fff0f5; /* 与二维码颜色匹配的边框 */
  overflow: hidden; /* 确保边框内的内容不会溢出 */
}
</style>
