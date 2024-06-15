<template>
  <div class="go_top" :class="{ fly: isFlying }" @click="goBack"></div>
</template>

<script>
export default {
  name: "GoTop",
  data() {
    return {
      isVisible: true, // Keep it true to show the button always
      isFlying: false,
      timer: null,
      goer: null,
      positions: [-182, -325, -611, -469, -754, -897, -40],
      currentPositionIndex: 0,
    };
  },
  mounted() {
    window.addEventListener('scroll', this.handleScroll);
  },
  beforeDestroy() {
    window.removeEventListener('scroll', this.handleScroll);
  },
  methods: {
    handleScroll() {
      // You can implement other functionalities here if needed
    },
    goBack() {
      this.isFlying = true;
      let to = document.documentElement.scrollTop || document.body.scrollTop;
      this.changePosition();
      this.goer = setInterval(() => {
        to -= 100;
        if (to <= 0) {
          clearInterval(this.goer);
          this.isFlying = false;
          document.documentElement.scrollTop = document.body.scrollTop = 0;
        } else {
          document.documentElement.scrollTop = document.body.scrollTop = to;
        }
      }, 20);
    },
    changePosition() {
      this.timer = setInterval(() => {
        if (this.currentPositionIndex >= this.positions.length) {
          clearInterval(this.timer);
          this.currentPositionIndex = 0; // Reset for next use
        } else {
          this.$el.style.backgroundPositionX = `${this.positions[this.currentPositionIndex++]}px`;
        }
      }, 100);
    },
  }
}
</script>

<style scoped>
.go_top {
  position: fixed;
  bottom: 100px;
  right: 20px;
  transform: translateY(0);
  width: 62px;
  height: 90px;
  cursor: pointer;
  background-image: url('https://www.freeimg.cn/i/2024/02/24/65d9ccbc84633.png');
  background-position: -40px -44px;
  z-index: 1000;
}
.fly {
  transform: translateY(-1000px);
  transition: transform .3s ease-in;
}
</style>
