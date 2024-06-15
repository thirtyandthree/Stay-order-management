<template>
<div>
  <el-form ref="emailConfigForm" :model="emailConfig" label-width="120px">
    <el-form-item label="邮箱Logo">
    <!-- 使用el-input让用户输入图片URL -->
        <el-input v-model="emailConfig.logo_url" placeholder="请输入图片URL"></el-input>
    </el-form-item>
  <!-- 在适当的位置展示图片 -->
    <div v-if="emailConfig.logo_url" style="margin-bottom: 20px;">
        <img :src="emailConfig.logo_url" class="logo" alt="邮箱Logo">
    </div>
    <el-form-item label="SMTP服务器" required>
      <el-input v-model="emailConfig.smtp"></el-input>
    </el-form-item>
    <el-form-item label="端口" required>
      <el-input v-model.number="emailConfig.port" type="number"></el-input>
    </el-form-item>
    <el-form-item label="发信人账号" required>
      <el-input v-model="emailConfig.sender"></el-input>
    </el-form-item>
    <el-form-item label="服务邮箱密码" required>
      <el-input v-model="emailConfig.password" type="password"></el-input>
    </el-form-item>
    <el-form-item label="邮件服务器地址" required>
      <el-input v-model="emailConfig.server_address"></el-input>
    </el-form-item>
    <el-form-item>
      <el-button type="primary" @click="submitForm">保存配置</el-button>
       <el-button type="warning" @click="showTestDialog = true">测试发送</el-button>
    </el-form-item>
  </el-form>
    <!-- 测试发送的对话框 -->
    <el-dialog
      title="测试发送邮件"
      :visible.sync="showTestDialog"
      width="30%">
      <el-form ref="testForm">
        <el-form-item label="测试邮箱" required>
          <el-input v-model="testEmail" placeholder="请输入测试邮箱"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="showTestDialog = false">取 消</el-button>
        <el-button type="primary" @click="sendTestEmail">发 送</el-button>
      </span>
    </el-dialog>
    <right-menu></right-menu>
  </div>
</template>

<script>
import axios from 'axios';
import rightMenu from '@/components/rightMenu.vue';
export default {
  components: { rightMenu },
  data() {
    return {
      emailConfig: {
        logo_url: '',
        smtp: '',
        port: null,
        sender: '2580996608@qq.com',
        password: '',
        server_address: ''
      },
      showTestDialog: false, // 控制测试对话框显示的标志
      testEmail: '', // 用户输入的测试邮箱地址
    };
  },
  created() {
    this.fetchEmailConfig();
  },
  computed:{
      rightMenu
  },
  methods: {
      fetchEmailConfig() {
          axios.get(`${process.env.VUE_APP_API_URL}/api/getEmail`) // 确保这是正确的API端点
            .then(response => {
              this.emailConfig = response.data; 
              console.log(response.data)// 假设后端返回的数据结构与emailConfig一致
            })
            .catch(error => {
              console.error('获取邮件配置失败:', error);
            });
        },
       sendTestEmail() {
        // 这里编写发送测试邮件的逻辑
        axios.post(`${process.env.VUE_APP_API_URL}/api/sendEmail`, { email: this.testEmail }) // 使用你的实际API端点
          .then(() => {
            this.$message.success('测试邮件发送成功');
            this.showTestDialog = false; // 关闭对话框
          })
          .catch(error => {
            console.error('测试邮件发送失败:', error);
            this.$message.error('测试邮件发送失败');
          });
      },
      submitForm() {
          axios.post(`${process.env.VUE_APP_API_URL}/api/updateEmail`, this.emailConfig) // 使用你的实际API端点
            .then(() => {
              console.log('配置信息已更新');
              this.fetchEmailConfig();
              this.$message.success('更新成功');
              // 这里可以添加一些成功更新后的逻辑，比如提示用户
            })
            .catch(error => {
              console.error('更新配置失败:', error);
              this.$message.error('更新配置失败');
            });
        },
    handleLogoSuccess(response, file) {
      this.emailConfig.logoUrl = response.url; // 确保这里的属性名与数据模型一致
    },
  }
};
</script>

<style scoped>
.logo {
  width: 200px; /* 或其他合适的尺寸 */
  height: 200px;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  line-height: 100px;
  text-align: center;
}
.avatar-uploader {
  display: block;
  width: 100px;
  height: 100px;
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
}
::v-deep .el-form {
  background-color: #FFF0F5; /* 淡粉红背景色 */
  padding: 20px;
  border-radius: 8px; /* 轻微的圆角边框 */
  box-shadow: 0 2px 12px 0 rgba(0,0,0,0.1); /* 细微的阴影增添层次感 */
}

/* 自定义输入框样式 */
::v-deep .el-form .el-input__inner,
::v-deep .el-form .el-select .el-input__inner {
  border-color: #FFC0CB; /* 边框颜色 */
  background-color: #FFFFFF; /* 背景色 */
  font-weight: bold;
  color: #AB82FF; /* 输入文字颜色 */
}

/* 当输入框获得焦点时的样式 */
::v-deep .el-form .el-input__inner:focus,
::v-deep .el-form .el-select .el-input__inner:focus {
  border-color: #FF69B4; /* 焦点状态下的边框颜色 */
  box-shadow: 0 0 5px #FF69B4; /* 添加细微的发光效果 */
}

/* 修改标签（label）的样式 */
::v-deep .el-form label {
  color: #FF82AB; /* 标签字体颜色 */
  font-weight: bold; /* 加粗字体 */
  font-size:14px;
}

/* 自定义按钮样式 */
::v-deep .el-form .el-button {
  background-color: #FFB6C1; /* 按钮背景色 */
  border-color: #FFB6C1; /* 按钮边框颜色 */
  color: #FFFFFF; /* 按钮字体颜色 */
  border-radius: 20px; /* 圆润的按钮边框 */
  font-weight: bold; /* 字体加粗 */
}

/* 按钮hover和active状态样式 */
::v-deep .el-form .el-button:hover {
  background-color: #FF69B4;
  border-color: #FF69B4;
}

::v-deep .el-form .el-button:active {
  background-color: #FF1493;
  border-color: #FF1493;
}
</style>
