<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>
<script>
export default {
  name: 'App'
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
.el-message-box{
  width:200px;
  height:160px;
}
.el-message-box__header{
  height:55px;
}
/* 少女风背景、边框和阴影 */
.el-message-box__wrapper {
  background-image: url('https://www.freeimg.cn/i/2024/03/28/6605069170ff0.jpg');
  background-repeat: no-repeat;
  background-size: cover;
  border: 1px solid #ffadd2; /* 淡粉色边框 */
  box-shadow: 0 5px 15px rgba(255, 182, 193, 0.4); /* 细腻的粉色阴影 */
  background-color: #FFF0F5;
}
/* 少女风标题样式 */
.el-message-box__header {
  background-color: #ffadd2; /* 淡粉色背景 */
  color: #EE6363; /* 白色文字 */
  font-weight: bold;
  border-bottom: 1px solid #ffadd2; /* 标题下方边框，保持整体风格一致性 */
}
/* 少女风确定按钮的样式 */
.el-message-box__btns .el-button--primary {
  background-color: #ffadd2; /* 淡粉色背景 */
  border-color: #ffadd2; /* 淡粉色边框 */}
/* 全局样式文件例如 src/assets/main.css */
/* 普通指针样式 */
/* body {
  cursor: url('https://i.loli.net/2017/08/19/5997836b66d58.png'), default;
} */
* :hover {
  cursor: url('https://i.loli.net/2017/08/19/5997836b66d58.png'), pointer !important;
}
</style>
