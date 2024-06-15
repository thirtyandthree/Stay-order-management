<template>
  <div class="not-found-container">
    <!-- 新增加的图片包裹容器 -->
    <div class="images-row">
       <img src="https://qiniu.staykoi.asia/%E7%AE%A1%E7%90%86/4.png" alt="新添加的装饰图片" class="not-found-image">
      <img src="https://qiniu.staykoi.asia/%E7%AE%A1%E7%90%86/404.png" alt="Cute and whimsical illustration related to 404 error" class="not-found-image">
      <!-- 新添加的图片 -->
     
    </div>
    <p>哎呀，Sorry辣，页面不见了！</p>
    <button @click="goHome">返回首页</button>
    <div class="error-split" id="up"></div>
    <img src="https://qiniu.staykoi.asia/%E7%AE%A1%E7%90%86/1582.png" alt="休闲图片">
  </div>
  
</template>

<script>
export default {
  name: "NotFound",
  methods: {
    goHome() {
      this.$router.push('/home'); // 确保你的Vue Router正确配置
    }
  }
};
</script>

<style scoped>
.not-found-container {
  text-align: center;
  color: #444;
  font-family: 'Comic Sans MS', 'Arial', sans-serif;
}

.images-row {
  display: flex;
  justify-content: space-around; /* 或者使用 space-between */
  align-items: center;
  flex-wrap: wrap; /* 确保在小屏幕上也能正常换行 */
}

.not-found-image {
  max-width: 40%; /* 控制图片最大宽度，确保两张图片可以并排显示 */
  height: auto;
  margin-bottom: 5px;
}
p {
  font-family: 'Comic Sans MS', 'Arial', sans-serif; /* 使用更加圆润的字体 */
  font-size: 1.5rem; /* 字体大小调整 */
  font-weight: bold;
  color: #FFB6C1; /* 选择柔和的粉红色 */
  padding: 10px 20px; /* 内边距调整 */
  border-radius: 20px; /* 圆角效果 */
  box-shadow: 0 4px 6px rgba(255, 105, 135, .3), 0 2px 4px rgba(255, 105, 135, .2); /* 添加阴影以增强立体感 */
  transition: transform 0.3s, box-shadow 0.3s; /* 过渡动画效果 */
}

p:hover {
  transform: translateY(-5px); /* 鼠标悬停时上移效果 */
  box-shadow: 0 10px 20px rgba(255, 105, 135, .4), 0 6px 6px rgba(255, 105, 135, .3); /* 悬停时增强阴影效果 */
}


button {
  padding: 5px 10px;
  font-size: 25px;
  background-color: #ff4081;
  color: white;
  border: 5px solid #FFC1C1;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.2s ease-in-out;
}

button:hover {
  background-color: #ec407a;
}
.error-split {
    width: 100%;
    height: 40px;
    background: url(https://qiniu.staykoi.asia/%E7%AE%A1%E7%90%86/have_rest.png) center no-repeat;
    padding: 50px;
}
</style>
