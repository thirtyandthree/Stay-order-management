<template>
  <div class="payment-test">
    <!-- 支付宝支付部分 -->
    <div @click="toggleAlipayExpand" style="cursor: pointer;" class='pay'>
       <img src="https://qiniu.staykoi.asia/%E7%AE%A1%E7%90%86/%E6%94%AF%E4%BB%98%E5%AE%9D.svg" alt="男" style="width: 30px; height: 30px;">
      <span :class="{'is-expanded': isAlipayExpanded}" style='font-weight:bold;font-size:24px;color:#00BFFF;'>> </span>
      <span style='font-weight:bold;font-size:24px;color:#00BFFF;'>支付宝</span>
    </div>
    <div v-if="isAlipayExpanded">
      <el-form ref="form" :model="form" label-width="120px">
        <el-form-item label="App ID">
          <el-input v-model="form.appId"></el-input>
        </el-form-item>
        <el-form-item label="Private Key">
          <el-input type="textarea" v-model="form.privateKey"></el-input>
        </el-form-item>
        <el-form-item label="Alipay Public Key">
          <el-input type="textarea" v-model="form.alipayPublicKey"></el-input>
        </el-form-item>
        <el-form-item label="测试金额">
         <el-select v-model="form.amount" placeholder="请选择或输入">
            <el-option label="5元" value="5"></el-option>
            <el-option label="10元" value="10"></el-option>
            <el-option label="30元" value="30"></el-option>
            <el-option label="自定义" value="custom"></el-option>
          </el-select>
          <el-input style='margin-top:20px;' v-model="customAmount" v-if="form.amount === 'custom'" placeholder="请输入自定义金额   (单位:￥元)"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="saveConfig">保存</el-button>
          <el-button type="success" @click="testPayment">测试</el-button>
        </el-form-item>
      </el-form>
    </div>

    <!-- 微信支付部分 -->
    <div @click="toggleWechatExpand" style="cursor: pointer;" class='pay'>
       <img src="https://qiniu.staykoi.asia/%E7%AE%A1%E7%90%86/%E5%BE%AE%E4%BF%A1.svg" alt="男" style="width: 30px; height: 30px;">
      <span :class="{'is-expanded': isWechatExpanded}" style='font-weight:bold;font-size:24px;color:#32CD32;'>></span>
      <span style='font-weight:bold;font-size:24px;color:#32CD32;'>微信</span>
    </div>
    <div v-if="isWechatExpanded">
      <el-form ref="wechatForm" :model="wechatForm" label-width="120px">
        <el-form-item label="App ID">
          <el-input v-model="wechatForm.appId"></el-input>
        </el-form-item>
        <el-form-item label="商户号">
          <el-input v-model="wechatForm.mchId"></el-input>
        </el-form-item>
        <el-form-item label="APPSercet 密钥">
          <el-input  v-model="wechatForm.appSecret"></el-input>
        </el-form-item>
         <el-form-item label="apiV3 密钥">
          <el-input v-model="wechatForm.mchKey"></el-input>
        </el-form-item>
         <el-form-item label="证书序列号">
          <el-input v-model="wechatForm.mchNumber"></el-input>
        </el-form-item>
         <el-form-item label="apiclient_key.pem数据">
          <el-input type="textarea" v-model="wechatForm.privateKey"></el-input>
        </el-form-item>
        <el-form-item label="测试金额">
         <el-select v-model="wechatForm.amount" placeholder="请选择或输入">
            <el-option label="5元" value="5"></el-option>
            <el-option label="10元" value="10"></el-option>
            <el-option label="30元" value="30"></el-option>
            <el-option label="自定义" value="custom"></el-option>
          </el-select>
          <el-input style='margin-top:20px;' v-model="customAmount" v-if="wechatForm.amount === 'custom'" placeholder="请输入自定义金额   (单位:￥元)"></el-input>
        </el-form-item>

        <el-form-item>
          <el-button type="primary" @click="saveWConfig">保存</el-button>

        </el-form-item>
      </el-form>
    </div>
<img src='https://qiniu.staykoi.asia/%E7%99%BB%E5%BD%95/2024022710060870.gif' alt="Stay">
    <!-- 支付二维码对话框，共用 -->
 <el-dialog :visible.sync="dialogVisible" :center="true" :width="'40%'">
    <h3 style='color:#FFB5C5; font-weight:bold; text-align: center; font-size:28px;'>支付二维码</h3>
    <div class="center-container" style="display: flex; flex-direction: column; align-items: center;">
        <div style='border: solid 2px #EEDC82; padding: 20px; width: fit-content; margin: auto; text-align: center;'>
            <!-- 使用 vue-qrcode 组件显示二维码 -->
            <try1 :url="qrCode"></try1>
            <div class='money'> ￥{{ this.form.amount }} 元</div>
            <span>{{this.outTradeNo}}</span>
        </div>
        <div style="margin-top: 20px;">
            <el-button type="danger" @click="cancelPayment">取消支付</el-button>
            <el-button type="success" @click="confirmPayment">确认支付</el-button>
        </div>
    </div>
</el-dialog>
<right-menu></right-menu>
  </div>
</template>

<script>
import axios from 'axios';
import try1 from '@/components/code.vue'
import rightMenu from '@/components/rightMenu.vue'
import RightMenu from '@/components/rightMenu.vue';
export default {
   components: {
    try1,
      RightMenu
  },
  data() {
    return {
      isAlipayExpanded: false,
      isWechatExpanded: false,
      outTradeNo: '',  // 添加这行来存储订单号
      form: {
        appId: '',
        privateKey: '',
        alipayPublicKey: '',
        amount: '',
      },
      wechatForm: {
        appId: '',
        mchId: '',
        appSecret: '',
        mchKey: '',
        mchNumber: '',
        privateKey: '',
        amount: '',
      },
      customAmount: '', // 用于保存自定义金额
      qrCode: '',
      dialogVisible: false,
      isDataLoaded: false, // 标记数据是否加载完成
    };
  },
  computed:{
  rightMenu
  },
  created() {
  this.fetchAlipayConfig();
  this.fetchWpayConfig();
},
  methods: {
    fetchAlipayConfig() {
  axios.get(`${process.env.VUE_APP_API_URL}/api/pay`)
    .then(response => {
      const config = response.data;
      this.form.appId = config.appId;
      this.form.privateKey = config.privateKey;
      this.form.alipayPublicKey = config.alipayPublicKey;
      // this.$message.success('支付宝配置加载成功');
    })
    .catch(error => {
      console.error('加载支付宝配置失败', error);
      this.$message.error('加载支付宝配置失败');
    });
}, 
  fetchWpayConfig(){
   axios.get(`${process.env.VUE_APP_API_URL}/api/wpay`)
   .then(response =>{
     const wconfig=response.data;
     console.log(wconfig)
     this.wechatForm.appId=wconfig.appId;
     this.wechatForm.appSecret=wconfig.appSecret;
     this.wechatForm.mchId=wconfig.mchId;
     this.wechatForm.mchNumber=wconfig.mchNumber,
     this.wechatForm.mchKey=wconfig.mchKey;
     this.wechatForm.privateKey=wconfig.privateKey
   })
   .catch(error => {
      console.error('加载微信配置失败', error);
      this.$message.error('加载微信配置失败');
    });
        },
    toggleAlipayExpand() {
      this.isAlipayExpanded = !this.isAlipayExpanded;
    },
    saveConfig() {
      axios.post(`${process.env.VUE_APP_API_URL}/api/pay`, {
        appId: this.form.appId,
        privateKey: this.form.privateKey,
        alipayPublicKey: this.form.alipayPublicKey,
      }).then(response => {
        console.log('支付宝配置保存成功', response);
        this.$message.success('支付宝配置保存成功');
      }).catch(error => {
        console.error('保存支付宝配置失败', error);
        this.$message.error('保存支付宝配置失败');
      });

    },
    saveWConfig() {
      axios.post(`${process.env.VUE_APP_API_URL}/api/wpay`, {
        appId: this.wechatForm.appId,
        appSecret:this.wechatForm.appSecret,
        mchId:this.wechatForm.mchId,
        mchNumber:this.wechatForm.mchNumber,
        mchKey:this.wechatForm.mchKey,
        privateKey: this.wechatForm.privateKey,
      }).then(response => {
        console.log('微信配置保存成功', response);
        this.$message.success('微信配置保存成功');
      }).catch(error => {
        console.error('保存微信配置失败', error);
        this.$message.error('保存微信配置失败');
      });

    },
    testPayment() {
      if (this.form.amount === 'custom') {
    // 当选择自定义金额时，使用输入的自定义金额
    const parsedAmount = parseFloat(this.customAmount);
    if (!isNaN(parsedAmount)) {
      this.form.amount = parsedAmount;
    } else {
      this.$message.error('请输入有效的金额');
      return;
    }
  } else {
    // 当选择预定义金额时，也将其转换为浮点数
    this.form.amount = parseFloat(this.form.amount);
  }

  console.log('测试支付宝支付', this.form.amount);
  // Assuming '/api/test_payment' is your backend endpoint for processing payment requests
   axios.post(`${process.env.VUE_APP_API_URL}/api/pay/test`, {
      appId: this.form.appId,
      privateKey: this.form.privateKey,
      alipayPublicKey: this.form.alipayPublicKey,
      amount: this.form.amount,
    }).then(response => {
      this.qrCode = response.data.qrCode; // 从响应中更新二维码 URL
      this.dialogVisible = true; // 显示包含二维码的对话框
      this.isDataLoaded = true;
      this.outTradeNo = response.data.outTradeNo;
      console.log(response);
    }).catch(error => {
      console.error('测试支付宝支付失败', error);
      this.$message.error('测试支付宝支付失败');
    });
  },

    toggleWechatExpand() {
      this.isWechatExpanded = !this.isWechatExpanded;
    },
    saveWechatConfig() {
      console.log('保存微信配置', this.wechatForm);
      // 这里保存微信配置到你的后端或localStorage
    },
    testWechatPayment() {
      console.log('测试微信支付', this.wechatForm.amount);
      // 调用后端接口测试微信支付，并展示二维码
      this.$axios.post('/api/test_wechat_payment', {
        appId: this.wechatForm.appId,
        mchId: this.wechatForm.mchId,
        apiKey: this.wechatForm.apiKey,
        amount: this.wechatForm.amount,
      }).then(response => {
        this.qrCode = response.data.qrCode;
        this.dialogVisible = true; // 显示对话框
        console.log(this.qrCode);
      }).catch(error => {
        console.error('测试微信支付失败', error);
        this.$message.error('测试微信支付失败');
      });
    },
   confirmPayment() {
        axios.get(`${process.env.VUE_APP_API_URL}/api/payment-status`)
        .then((response) => { // 使用箭头函数
        const data = response.data;
        if (data.paymentSuccessful) {
          this.$message.success('付款成功');
          this.dialogVisible = false;
        } else {
           this.$message.error('未成功付款!!!');
        }
    })
    .catch((error) => { // 使用箭头函数
        console.error('Error fetching payment status:', error);
    });
},
   cancelPayment() {
  axios.post(`${process.env.VUE_APP_API_URL}/api/pay/cancel`, {
      appId: this.form.appId,
      privateKey: this.form.privateKey,
      alipayPublicKey: this.form.alipayPublicKey,
      outTradeNo: this.outTradeNo,
    }).then(response => {
      console.log(response);
      this.dialogVisible = false;
    }).catch(error => {
      console.error('测试支付宝支付失败', error);
      this.$message.error('测试支付宝支付失败');
    });
   }
  }
}
</script>
<style scoped>
::v-deep .el-dialog {
  background-color: #FFF0F5; /* 淡蓝色背景 */
}
.money{
  font-weight: bold;
  margin-top:20px;
  font-size:25px;
  color:#FF6A6A;
}
::v-deep .el-dialog__header {
   color:#FF1493;
   background-color: #FFB6C1;
}
.pay{
    display: flex;
    align-items: center;
    margin-top: 20px; /* 距离顶部的距离，根据需要调整 */
}
.is-expanded {
  display: inline-block;
  transform: rotate(90deg);
}
.center-container {
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: 	#FFF8DC;
}

.center-content {
  text-align: center;
}
/* 修改el-form的整体背景色和内边距 */
::v-deep .el-form {
  border: solid 3px #EEA2AD;
  background-color: #FFF0F5; /* 淡粉红背景色 */
  padding: 20px;
  border-radius: 8px; /* 轻微的圆角边框 */
  box-shadow: 0 2px 12px 0 rgba(0,0,0,0.1); /* 细微的阴影增添层次感 */
}

/* 自定义输入框样式 */
::v-deep .el-form .el-input__inner,
::v-deep .el-form .el-select .el-input__inner {
  border: solid 2px #EEDC82; /* 边框颜色 */
  background-color: #FFFFFF; /* 背景色 */
  font-weight: bold;
  color: #FF69B4; /* 输入文字颜色 */
}

/* 当输入框获得焦点时的样式 */
::v-deep .el-form .el-input__inner:focus,
::v-deep .el-form .el-select .el-input__inner:focus {
  border: solid 2px #FFC1C1; /* 焦点状态下的边框颜色 */
  box-shadow: 0 0 5px #FF69B4; /* 添加细微的发光效果 */
}

/* 修改标签（label）的样式 */
::v-deep .el-form label {
  color: #FFC1C1; /* 标签字体颜色 */
  font-weight: bold; /* 加粗字体 */
  font-size:20px;
}
::v-deep .el-textarea__inner {
   border: solid 2px #EEDC82;
}
::v-deep .el-textarea__inner:focus {
   border: solid 2px #FFC1C1;
   box-shadow: 0 0 5px #FF69B4;
}
/* 自定义按钮样式 */
::v-deep .el-form .el-button {
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
