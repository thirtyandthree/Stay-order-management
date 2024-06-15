<template>
  <div class="forget-password-container">
    <video autoplay muted loop id="background-video">
      <source
        src="https://qiniu.staykoi.asia/a134f3dfc44fa7e54671dffb5b298cde_preview.mp4"
        type="video/mp4"
      />
      Your browser does not support the video tag.
    </video>
    <el-card class="forget-password-card">
      <div class="form-container">
        <h1>Forget Password</h1>
        <el-form @submit.prevent="onSubmit" ref="forgetForm">
          <!-- Email Input -->
          <el-form-item prop="email" label="Email" required>
            <el-input v-model="forgetForm.email" placeholder="Email" clearable>
              <template #prefix>
                <i
                  class="el-icon-s-promotion"
                  style="margin-right: 0.5em; font-size: 20px; color: #00eeee"
                ></i>
              </template>
            </el-input>
          </el-form-item>

          <!-- New Password Input -->
          <el-form-item prop="password" label="New Password" required>
            <el-input
              type="password"
              v-model="forgetForm.password"
              placeholder="New Password"
              clearable
              show-password
            >
              <template #prefix>
                <i
                  class="el-icon-lock"
                  style="margin-right: 0.5em; font-size: 20px; color: #9400d3"
                ></i>
              </template>
            </el-input>
          </el-form-item>

          <!-- Confirm New Password Input -->
          <el-form-item
            prop="confirmPassword"
            label="Confirm Password"
            required
          >
            <el-input
              type="password"
              v-model="forgetForm.confirmPassword"
              placeholder="Confirm New Password"
              clearable
              show-password
            >
              <template #prefix>
                <i
                  class="el-icon-lock"
                  style="margin-right: 0.5em; font-size: 20px; color: #9400d3"
                ></i>
              </template>
            </el-input>
          </el-form-item>

          <el-form-item>
            <el-button
              type="primary"
              long
              @click="handleSubmit"
              class="submit-button"
              >Submit</el-button
            >
          </el-form-item>
        </el-form>
        <div class="link-container">
          <el-link
            @click.prevent="onLogin"
            style="color: #ffa500; font-size: bold"
            >Back to login</el-link
          >
        </div>
      </div>
    </el-card>
  </div>
</template>

<script>
import { sendResetEmail } from "@/api/user"; // 假设你有这个API

export default {
  data() {
    return {
      forgetForm: {
        email: "",
      },
    };
  },
  methods: {
    handleSubmit() {
      // Here, you should include validations such as password matching,
      // and make sure all required fields are filled.
      if (this.forgetForm.password !== this.forgetForm.confirmPassword) {
        this.$message.error("Passwords do not match!");
        return;
      }
      // Assuming resetPassword is your API call
      resetPassword(this.forgetForm)
        .then((response) => {
          // Handle success, perhaps navigate the user to the login page
          this.$message.success(
            "Password has been reset. Please login with your new password."
          );
          this.$router.push("/");
        })
        .catch((error) => {
          // Handle error
          this.$message.error(
            "An error occurred while resetting the password."
          );
        });
    },
    onLogin() {
      this.$router.push("/");
    },
  },
};
</script>

<style scoped>
.forget-password-container {
  position: relative;
  width: 100%;
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
}

#background-video {
  position: absolute;
  right: 0;
  bottom: 0;
  min-width: 100%;
  min-height: 100%;
  z-index: -1;
}

.forget-password-card {
  width: 400px;
  box-shadow: 0 4px 6px 0 rgba(0, 0, 0, 0.1); /* 轻微阴影效果 */
  border-radius: 10px; /* 圆角边框 */
  overflow: hidden; /* 隐藏溢出的背景视频 */
}

.form-container {
  padding: 20px;
  text-align: center;
}

.form-container h1 {
  margin-bottom: 30px;
  color: #7048e8; /* 标题颜色 */
  font-family: "Comic Sans MS", "Arial", sans-serif; /* 使用更具趣味性的字体 */
}

.el-form-item {
  margin-bottom: 20px;
}

.el-input {
  border-radius: 20px; /* 输入框圆角 */
  background-color: #ffffff; /* 输入框背景颜色 */
  border: 1px solid #e9ecef; /* 输入框边框颜色 */
}

.el-input__inner {
  height: 40px;
  border-radius: 20px; /* 保持输入内容区域也是圆角 */
}

.el-button {
  width: 100%;
  border-radius: 20px; /* 按钮圆角 */
  background-color: #ffadd2; /* 按钮背景颜色，淡粉色 */
  border-color: #ffadd2; /* 按钮边框颜色 */
  color: white; /* 按钮文字颜色 */
  font-weight: bold; /* 加粗按钮文字 */
  height: 40px;
}

.el-button:hover {
  background-color: #f759ab; /* 鼠标悬浮时按钮颜色 */
  border-color: #f759ab;
}

.link-container {
  margin-top: 20px;
  display: flex;
  justify-content: space-between; /* 两个链接分布在容器两侧 */
  color: #7048e8; /* 链接颜色 */
}

.el-link {
  color: #7048e8; /* 统一设置链接颜色 */
  cursor: pointer;
}
</style>
