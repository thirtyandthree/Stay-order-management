<template>
  <div class="overlay1" v-if="modalVisible">
    <!-- Video Background -->
    <video autoplay loop muted class="video-background">
      <source
        src="https://qiniu.staykoi.asia/dfb2f0cfb7ea467fefdcca6f14a43df2_preview.mp4"
        type="video/mp4"
      />
      Your browser does not support the video tag.
    </video>
    <div class="modal1">
      <span class="close-btn1" @click="closeModal">&times;</span>
      <h2 class="title1">欢迎光临 Stay资源站</h2>
      <p class="content1">探索我们的最新特色和更新。我们非常高兴能与您分享！</p>
      <button class="confirm-btn1" @click="closeModal">我已了解</button>
    </div>
  </div>
</template>


<script>
export default {
  data() {
    return {
      modalVisible: false,
    };
  },
  methods: {
    checkModalDisplay() {
      const visited = localStorage.getItem("visited");
      const currentDate = new Date().toDateString();

      if (!visited || visited !== currentDate) {
        this.modalVisible = true;
        localStorage.setItem("visited", currentDate);
      }
    },
    closeModal() {
      this.modalVisible = false;
    },
  },
  mounted() {
    this.checkModalDisplay();
  },
};
</script>

<style scoped>
.video-background {
  position: absolute;
  right: 0;
  bottom: 0;
  min-width: 100%;
  min-height: 100%;
  width: auto;
  height: auto;
  z-index: -1; /* 保证视频不会覆盖模态窗口内容 */
  background-size: cover;
}
.overlay1 {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  display: flex;
  align-items: center;
  justify-content: center;

  background-color: rgba(
    0,
    0,
    0,
    0.5
  ); /* Add a dark semi-transparent background */
  z-index: 1000;
}
.modal1 {
  background: #ffffff;
  background-image: url("https://www.freeimg.cn/thumbnails/9538137c276924efe11483380d21206f.png");
  padding: 25px;
  border-radius: 15px;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
  width: 90%;
  max-width: 450px;
  margin: 0 auto;
  border: 5px solid #ffccd5;
  background-repeat: no-repeat;
  background-size: cover;
}
.close-btn1 {
  float: right;
  width: 30px;
  height: 30px;
  font-size: 28px;
  line-height: 30px;
  cursor: pointer;
  color: #fff;
  background-color: #ff5a92;
  border-radius: 50%;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
  display: flex;
  align-items: center;
  justify-content: center;
  position: absolute;
  top: 10px;
  right: 10px;
  background-color: transparent;
  border: none;
  outline: none;
  padding: 0;
}
.close-btn1:hover {
  background-color: #e64980;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
}
.title1,
.content1,
.confirm-btn1 {
  text-align: center;
  font-weight: bold;
  color: #e64980;
}
.confirm-btn1 {
  background-color: #ff5a92;
  color: white;
  border: none;
  border-radius: 20px;
  padding: 10px 25px;
  cursor: pointer;
  font-size: 16px;
  text-transform: uppercase;
  display: block;
  margin: 25px auto 0;
  transition: background-color 0.3s ease;
}
.confirm-btn1:hover {
  background-color: #e64980;
}
</style>
