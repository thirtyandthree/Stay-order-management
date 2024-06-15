<template>  
  <div class="login-container">
    <video autoplay muted loop id="background-video">
      <source src="https://qiniu.staykoi.asia/17037419412023122805390180.mp4" type="video/mp4">
      Your browser does not support the video tag.
    </video>
    <el-card class="login-card">
      <div class="form-container">
        <h1>Login</h1>
        <el-form @submit.prevent="onLogin" ref="loginForm">
          <el-form-item prop="username" class="user">
            <el-input v-model="loginForm.username" placeholder="Username" clearable style="height:40px;">
              <template slot="prefix">
                <i class="el-icon-user" style="font-size:25px;color:#00EEEE;margin-top:7px;"></i>
              </template>
            </el-input>
          </el-form-item>
          <el-form-item prop="password" class="passwd">
            <el-input type="password" v-model="loginForm.password" placeholder="Password" clearable show-password style="height:40px;">
              <template slot="prefix">
               <i class="el-icon-lock" style="font-size:25px;color:	#708090;margin-top:7px;"></i>
              </template>
            </el-input>
          </el-form-item>
          <el-form-item>
            <el-checkbox v-model="loginForm.rememberMe">Remember me</el-checkbox>
          </el-form-item>
          <el-form-item>
            <Vcode :show="isShow" @success="success" @close="close" />
            <el-button type="primary" long @click="submit" class="login-button">Login</el-button>
          </el-form-item>
          <div class="link-container">
            <el-link @click.prevent="onForgotPassword">Forgot password?</el-link>
            <el-link @click.prevent="onRegister">Register</el-link>
          </div>
        </el-form>
      </div>
    </el-card>
  </div>
</template>

<script>
import Vcode from "vue-puzzle-vcode";
import { login } from '@/api/loginReg'
export default {
  data() {
    return {
      loginForm: {
        username: '',
        password: '',
        rememberMe: false,
      },
      isShow: false, // 验证码模态框是否出现,
    };
  },
  components: {
    Vcode,
  },
  methods: {
      async handleLogin() {
      try {
        const data = await login(this.loginForm.username, this.loginForm.password);
        this.$message.success('登录成功');
        window.sessionStorage.setItem('token', data.token);
        this.$router.push('/home');
      } catch (error) {
        this.$message.error('登录错误: ' + error.message);
      }
    },
     submit() {
      this.isShow = true;
    },
    onForgotPassword() {
      this.$router.push({ name: 'forgetPasswd' });
    },
    onRegister() {
      this.$router.push({ name: 'Register' });
    },
    success(msg) {
      this.isShow = false; // 通过验证后，需要手动隐藏模态框
      this.handleLogin();
    },
    // 用户点击遮罩层，应该关闭模态框
    close() {
      this.isShow = false;
      
    }
  },
};

</script>
<style scoped>
.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
 
  animation: bgAnimation 10s ease infinite; /* 添加背景动画 */
}
#background-video {
  position: absolute;
  right: 0;
  bottom: 0;
  min-width: 100%;
  min-height: 100%;
  z-index: -1; /* 确保视频在内容层之下 */
  object-fit: cover; /* 确保视频覆盖整个容器，且不失真 */
}
@keyframes bgAnimation {
  0%, 100% {
    background-position: 0% 50%;
  }
  50% {
    background-position: 100% 50%;
  }
}

.login-card {
  width: 400px;
  padding: 20px;
  border-radius: 20px; /* 更加圆润的圆角 */
  background: rgba(255, 255, 255, 0.8); /* 卡片背景透明度调整，增加层次感 */
  backdrop-filter: blur(10px); /* 背景模糊效果，增加炫酷感 */
  box-shadow: 0 8px 32px rgba(255, 105, 180, 0.4); /* 调整阴影颜色和大小，增加立体感和炫酷感 */
  border: 3px solid rgba(255, 255, 255, 0.18); /* 边框透明度调整，使边框更加柔和 */
}

/* 可选：为登录卡片添加悬浮效果，使其在鼠标悬停时稍微上升 */
.login-card:hover {
  transform: translateY(-10px);
  transition: transform 0.3s ease;
}
.form-container h1 {
  text-align: center;
  margin-bottom: 20px;
  color: #FF69B4; /* 标题颜色调整为温和的粉色 */
}

.el-input {
  border-radius: 20px; /* 输入框圆角 */
}

.login-button {
  background-color: #FF69B4; /* 按钮颜色 */
  border-color: #FF69B4; /* 按钮边框颜色 */
}

.login-button:hover {
  background-color: #FFB6C1; /* 按钮悬浮颜色 */
  border-color: #FFB6C1; /* 按钮悬浮边框颜色 */
}

.link-container {
  display: flex;
  justify-content: space-between;
  color: #FF69B4; /* 链接颜色调整为温和的粉色 */
}
.user .el-input {
  border: 2px solid #FFB6C1; /* 设置边框颜色为淡粉色 */
  background-color: #FFF0F5; /* 设置背景色为淡紫罗兰色，增加少女感 */
  border-radius: 25px; /* 增加边框圆角，使输入框更加柔和 */
  box-shadow: 0 4px 6px rgba(255, 105, 180, 0.3); /* 添加淡粉色阴影，增加立体感 */
}

.user .el-input:focus-within {
  border-color: #FF69B4; /* 当输入框被聚焦时，边框颜色变为鲜艳的粉色 */
  box-shadow: 0 0 8px rgba(255, 105, 180, 0.5); /* 聚焦时增加阴影的鲜艳度和范围，提升视觉效果 */
}

.user .el-input__inner {
  height: 40px; /* 确保内部输入框高度与样式中设置的高度一致 */
  border-color: transparent; /* 移除内部输入框的边框 */
}

.user .el-input__icon {
  color: #FF69B4; /* 设置输入框内图标的颜色 */
}
.passwd .el-input {
  border: 2px solid #FFB6C1; /* 设置边框颜色为淡粉色 */
  background-color: #FFF0F5; /* 设置背景色，增加少女感 */
  border-radius: 25px; /* 增加边框圆角，使输入框更加柔和 */
  box-shadow: 0 4px 6px rgba(255, 105, 180, 0.3); /* 添加淡粉色阴影，增加立体感 */
}

.passwd .el-input:focus-within {
  border-color: #FF69B4; /* 当输入框被聚焦时，边框颜色变为更明亮的粉色 */
  box-shadow: 0 0 8px rgba(255, 105, 180, 0.5); /* 聚焦时增加阴影的鲜艳度和范围 */
}

.passwd .el-input__inner {
  height: 40px; /* 确保内部输入框高度与外部设置一致 */
  border-color: transparent; /* 移除内部输入框的边框，以避免样式冲突 */
}

.passwd .el-input__icon {
  color: #FF69B4; /* 设置输入框内图标的颜色 */
}
.login-button {
  background-color: #FF69B4; /* 设置按钮背景色为粉色 */
  border-color: #FF69B4; /* 设置按钮边框颜色保持一致 */
  border-radius: 20px; /* 增加按钮的圆角，使其看起来更柔和 */
  font-weight: bold; /* 字体加粗，使文字更显眼 */
  transition: background-color 0.3s, border-color 0.3s, transform 0.2s; /* 平滑过渡效果 */
}

.login-button:hover {
  background-color: #FFB6C1; /* 按钮悬浮时的背景颜色变为浅粉色 */
  border-color: #FFB6C1; /* 按钮悬浮时的边框颜色也相应变化 */
  transform: translateY(-2px); /* 轻微上移，增加动态效果 */
}
.link-container a {
  color: #FF69B4; /* 设置链接文本颜色为粉色 */
  margin-right: 10px; /* 在链接之间添加一些右边距，避免它们紧挨在一起 */
  transition: color 0.3s; /* 颜色过渡效果，使悬浮效果更加平滑 */
}

.link-container a:hover {
  color: #FFB6C1; /* 鼠标悬浮时链接文本颜色变为浅粉色 */
  text-decoration: underline; /* 添加下划线，增强交互性 */
}

</style>
