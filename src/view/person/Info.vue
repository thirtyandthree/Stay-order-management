<template>
  <div>
    <el-card>
      <el-descriptions class="margin-top" title="简介" :column="2"
       border labelStyle="color:#FF82AB;border:1px solid #f9dada;font-weight:bold;font-size:25px;backgroundColor:#fdf6f8;"
        contentStyle="backgroundColor:#fdf6f8; color:#da4a91; borderRadius:10px;
        boxShadow:0 2px 4px rgba(0, 0, 0, 0.1);font-weight:bold;font-size:18px;border: 1px solid #FFDAB9;">
        <template #extra>
          <el-button type="primary" @click="dialogVisible = true">编辑</el-button>
        </template>
        <el-descriptions-item label="头像">
          <img class="img" :src="avatar" alt="" />
        </el-descriptions-item>
        <el-descriptions-item label="账户名">
          {{ account }}
        </el-descriptions-item>
        <el-descriptions-item label="昵称">
          {{ nickname }}
        </el-descriptions-item>
        <el-descriptions-item label="年龄">
          {{ age }}
        </el-descriptions-item>
        <el-descriptions-item label="性别">
        <el-tag size="small">{{ sex === 1 ? '男' : '女' }} </el-tag>
      </el-descriptions-item>

        <el-descriptions-item label="邮箱Email">
          {{ email }}
        </el-descriptions-item>
        <el-descriptions-item label="手机号码">
          {{ mobilePhoneNumber }}
        </el-descriptions-item>
        <el-descriptions-item label="地区">
          {{ area }}
        </el-descriptions-item>
        <el-descriptions-item label="职业">
          {{ work }}
        </el-descriptions-item>
        <el-descriptions-item label="兴趣爱好">
          {{ hobby }}
        </el-descriptions-item>
        <el-descriptions-item label="个性签名">
          {{ design }}
        </el-descriptions-item>
        <el-descriptions-item label="注册日期">
          <!-- Assume formatDate is correctly implemented -->
          {{ createDate | formatDate }}
        </el-descriptions-item>
      </el-descriptions>
    </el-card>
   
    <el-dialog title="修改个人信息" :visible.sync="dialogVisible" width="60%" @before-close="handleClose">
      <el-form :model="form" ref="form" label-width="150px">
        <div class="updateinfo">
          <div class="left">
            <el-form-item label="头像" prop="avatar">
              <img style="width:150px;height:110px" :src="form.avatar">
            </el-form-item>
            <el-form-item label="昵称" prop="nickname">
              <el-input v-model="form.nickname"></el-input>
            </el-form-item>
            <el-form-item label="年龄" prop="age">
              <el-input v-model="form.age"></el-input>
            </el-form-item>
            <el-form-item label="性别" prop="sex">
              <el-switch
                v-model="form.sex"
                active-color="#13ce66"
                inactive-color="#ff4949"
                active-text="男"
                inactive-text="女"
                :active-value="1"
                :inactive-value="0">
              </el-switch>
            </el-form-item>
            <el-form-item label="邮箱" prop="email">
              <el-input v-model="form.email"></el-input>
            </el-form-item>
          </div>
          <div class="right">
            <el-form-item label="用户编号" prop="id">
              <el-input v-model="form.id" disabled></el-input>
            </el-form-item>
            <el-form-item label="账号" prop="account">
              <el-input v-model="form.account" disabled></el-input>
            </el-form-item>
            <el-form-item label="地区" prop="area">
              <el-input v-model="form.area"></el-input>
            </el-form-item>
            <el-form-item label="兴趣爱好" prop="hobby">
              <el-input v-model="form.hobby"></el-input>
            </el-form-item>
            <el-form-item label="职业" prop="work">
              <el-input v-model="form.work"></el-input>
            </el-form-item>
            <el-form-item label="个性签名" prop="design">
              <el-input v-model="form.design"></el-input>
            </el-form-item>
            <el-form-item label="手机号码" prop="mobilePhoneNumber">
              <el-input v-model="form.mobilePhoneNumber"></el-input>
            </el-form-item>
          </div>
        </div>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitForm">提交</el-button>
      </span>
    </el-dialog>
    <right-menu></right-menu>
  </div>
</template>

<script>
import axios from 'axios';
import RightMenu from '@/components/rightMenu.vue';
import rightMenu from '@/components/rightMenu.vue';
export default {
  components: { rightMenu },
  name: "Info",
  data() {
    return {
      avatar: '', 
      account: '',
      age: null,
      email: '',
      mobilePhoneNumber: '',
      area: '',
      createDate: '',
      nickname: '',
      sex: '',
      work: '',
      hobby: '',
      design: '',
      dialogVisible: false,
      form: {
        id: null,
        avatar: '',
        account: '',
        age: null,
        email: '',
        mobilePhoneNumber: '',
        area: '',
        createDate: '',
        nickname: '',
        sex: '',
        work: '',
        hobby: '',
        design: '',
      },
    };
  },
  async mounted() {
    this.fetchUserData();
  },
  computed:{
      RightMenu
  },
  methods: {
    async fetchUserData() {
      try {
        const response = await axios.get(`${process.env.VUE_APP_API_URL}/api/personInfo`);
        this.setUserData(response.data);
      } catch (error) {
        console.error("获取用户信息失败:", error);
      }
    },
    setUserData(userInfo) {
      for (const key in userInfo) {
        if (userInfo.hasOwnProperty(key)) {
          this[key] = userInfo[key];
          if (this.form.hasOwnProperty(key)) {
            this.form[key] = userInfo[key];
          }
        }
      }
    },
    handleClose() {
      this.dialogVisible = false;
    },
    async submitForm() {
      try {
        // 示例: 确保age是整数
        this.form.age = parseInt(this.form.age, 10);
        const response = await axios.post(`${process.env.VUE_APP_API_URL}/api/personUpdate`, this.form);
        this.$message.success('信息更新成功！');
        this.fetchUserData(); // Re-fetch user data after update
      } catch (error) {
        console.error("更新用户信息失败:", error);
        this.$message.error('信息更新失败！');
      } finally {
        this.dialogVisible = false;
      }
    }
  }
};
</script>



<style scoped>
.img {
  width: 300px;
  height: 300px;
}
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
  color: #FF1493; /* 标签字体颜色 */
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

::v-deep .el-card {
  border-radius: 16px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  border: 1px solid #f9d6e4;
  background-color: #fef0f3;
}
::v-deep .el-button--primary:hover{
  background-color: #FFD700;
  border-color:#FF69B4;
}
::v-deep .el-button--primary{
  background-color: #FFB5C5;
  border-color:#FF69B4;
}
</style>
