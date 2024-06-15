<template>
<div style="width: 70%;margin-top:0;">
  <el-form :model="ruleForm" status-icon :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
    <el-form-item label="注册邮箱" prop="email">
      <el-input type="email" v-model="ruleForm.email" autocomplete="off"></el-input>
    </el-form-item>
    <el-form-item label="修改密码" prop="pass">
      <el-input type="password" v-model="ruleForm.pass" autocomplete="off"></el-input>
    </el-form-item>
    <el-form-item label="确认修改" prop="checkPass">
      <el-input type="password" v-model="ruleForm.checkPass" autocomplete="off"></el-input>
    </el-form-item>
    <el-form-item label="校验码：" prop="verify">
      <el-input placeholder="请输入校验码:stay33" v-model.number="ruleForm.verify"></el-input>
    </el-form-item>
    <el-form-item>
      <el-button type="primary" @click="submitForm('ruleForm')">提交</el-button>
      <el-button @click="resetForm('ruleForm')">重置</el-button>
    </el-form-item>
    <call></call>
  </el-form>
  <img src="https://qiniu.staykoi.asia/%E7%99%BB%E5%BD%95/2023063015521993.png" alt="Stay">
    <weather style='position:absolute;top:80px;right:5px;'></weather>
    <right-menu></right-menu>
</div>
</template>
 
<script>
import axios from 'axios';
import weather from '@/components/weather.vue'
import call from '@/components/call.vue'
import RightMenu from '@/components/rightMenu.vue';
export default {
  name: "countcontrol",
  data() {
    var checkAge = (rule, value, callback) => {
      if (!value) {
        return callback(new Error('校验码不能为空'));
      }
      setTimeout(() => {
        if ((value)!=="stay33") {
          callback(new Error('校验码错误'));
        } else {
 
            callback();
 
        }
      }, 1000);
    };
    var validatePass = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请输入密码'));
      } else {
        if(value.length<=6){
          callback(new Error("密码长度不能低于6"))
        }
        if (this.ruleForm.checkPass !== '' ) {
          this.$refs.ruleForm.validateField('checkPass');
        }
        callback();
      }
    };
    var validateEmail = (rule, value, callback) => {
      const mailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/; // 简单的邮箱正则表达式
      if (!value) {
        return callback(new Error('邮箱不能为空'));
      } else if (!mailRegex.test(value)) {
        return callback(new Error('请输入有效的邮箱地址'));
      } else {
        callback();
      }
    };
    var validatePass2 = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请再次输入密码'));
      } else if (value !== this.ruleForm.pass) {
        callback(new Error('两次输入密码不一致!'));
      } else {
        callback();
      }
    };
    return {
      ruleForm: {
        pass: '',
        checkPass: '',
        verify: ''
      },
      rules: {
        email: [
          { validator: validateEmail, trigger: 'blur' }
        ],
        pass: [
          { validator: validatePass, trigger: 'blur' }
        ],
        checkPass: [
          { validator: validatePass2, trigger: 'blur' }
        ],
        verify: [
          { validator: checkAge, trigger: 'blur' }
        ]
      }
    };
  },
  components:{
    call,
    weather,
    RightMenu
  },
  methods: {
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          if (this.ruleForm.pass === this.ruleForm.checkPass) {
            // 密码验证通过，向后端发送请求
            axios.post(`${process.env.VUE_APP_API_URL}/api/update-password`, {
              email: this.ruleForm.email,
              pass: this.ruleForm.pass,
              // 注意，我们不发送verify字段
            })
            .then(response => {
              // 处理响应
              console.log(response);
              this.$message.success('修改成功');
            })
            .catch(error => {
              // 处理错误
              console.error("Error:", error);
              this.$message.error('修改密码失败');
            });
          } else {
            // 不应该发生，因为前端验证已确保密码一致，但以防万一可以在这里处理
             this.$message.error('密码不一致，请检查');
          }
        } else {
          console.log('error submit!!');
          return false;
        }
      });
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
    }
  }
}
</script>
 
<style scoped>
/* 修改el-form的整体背景色和内边距 */
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
  color: #FF69B4; /* 输入文字颜色 */
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