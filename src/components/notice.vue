<template>
  <div class="marquee-banner">
    <transition name="fade" mode="out-in">
      <div class="user-info" :key="currentOrderIndex">
        <span class="badge-danger" style="display: flex; align-items: center;"><i class="el-icon-message-solid" style="color:#EE6363; font-size:22px;"></i> 订单动态</span>
        <span class="user-info-item" style="display: flex; align-items: center;margin-left: 25px;color:#FFC1C1;">
            <img src="https://qiniu.staykoi.asia/2024-2-20/%E8%B4%A2%E7%A5%9E.svg" alt="男" style="width: 30px; height: 30px;">
            {{ userName }}
          </span>
        <span class="user-info-item" style='color:#8FBC8F;'>购买花费</span>
        <span class="user-info-item" style='color:#EE2C2C;display: flex; align-items: center;'>
          <img src="https://qiniu.staykoi.asia/2024-2-20/%E9%92%B1%E5%B8%81.svg" alt="男" style="width: 30px; height: 30px;">
          {{ orderPrice }} 元
          </span>
          <span class='pay' :style="{ color: this.isPaid=='1' ? 'green' : 'red' }">
            <img src="https://qiniu.staykoi.asia/2024-2-20/%E6%94%AF%E4%BB%98.svg" alt="男" style="width: 30px; height: 30px;">
          {{this.isPaid=='1' ? '已支付' : '未付款'}}
      </span>
      <span class='pay' style='color:#1E90FF;display: flex; align-items: center;margin-left: 25px;'>
        <img src="https://qiniu.staykoi.asia/2024-2-20/%E8%AE%A2%E5%8D%95.svg" alt="男" style="width: 30px; height: 30px;">
        订单总数:</span>
      <span class='pay' style='color:#FFA500;font-size:25px;display: flex; align-items: center;'>
        {{ userOrder }}</span>
      </div>
    </transition>
    <div class="marquee-content">
      <marquee >
        <b class="marquee-text">{{ marqueeContent }}</b>
      </marquee>
    </div>
    <div class="order-info">
      
    </div>
  </div>
</template>


<script>
import axios from 'axios';

export default {
  name: 'MarqueeBanner',
  data() {
    return {
      currentOrderIndex: 0, // 当前显示的订单索引
      marqueeContent: '欢迎来到STAY管理，花开再美，怎如相遇，人生若只如初见',
      orderList: [],
      userName: '',
      userOrder: '',
      orderPrice: '',
      isPaid: ''
    };
  },
  mounted() {
    this.getOrderList();
    this.startRotation();
  },
  methods: {
    async getOrderList() {
      try {
        const response = await axios.get(`${process.env.VUE_APP_API_URL}/api/orders`);
        this.orderList = response.data;
        this.setOrderInfo(0); // 初始化显示第一个订单的信息
      } catch (error) {
        console.error("获取订单列表失败:", error);
      }
    },
    startRotation() {
      setInterval(() => {
        this.currentOrderIndex = (this.currentOrderIndex + 1) % Math.min(6, this.orderList.length);
        this.setOrderInfo(this.currentOrderIndex);
      }, 5000); // 每5秒更换一次订单信息
    },
    setOrderInfo(index) {
      const order = this.orderList[index];
      this.userName = order.order_user;
      this.userOrder = this.orderList.length;
      this.orderPrice = order.order_price;
      this.isPaid = order.pay_status;
    }
  }
};

</script>

<style scoped>
.marquee-banner {
  display: flex;
  background-color: #FFF0F5;
  justify-content: space-between;
  align-items: center;
  position: relative;
  background-repeat: no-repeat;
  background-size: cover;
  border-radius: 25px;
  border: 5px solid #ffccd5;
  /* 添加边界阴影效果 */
  box-shadow: 0 4px 30px rgba(255, 182, 193, 0.5);
}

.fade-enter-active, .fade-leave-active {
  transition: opacity 0.5s;
}
.fade-enter, .fade-leave-to /* .fade-leave-active in <2.1.8 */ {
  opacity: 0;
}

.user-info, .order-info {
  padding: 0 10px;
}

.marquee-content {
  flex-grow: 1;
  position: relative;
  z-index: 1;
  padding: 5px;
  margin-top: 10px;
  border-radius: 25px;
}
.marquee-text {
  font-size: 20px;
  margin: 0;
  background: -webkit-linear-gradient(left, #ffffff, #ff0000 6.25%, #ff7d00 12.5%, #ffff00 18.75%, #00ff00 25%, #00ffff 31.25%, #0000ff 37.5%, #ff00ff 43.75%, #ffff00 50%, #ff0000 56.25%, #ff7d00 62.5%, #ffff00 68.75%, #00ff00 75%, #00ffff 81.25%, #0000ff 87.5%, #ff00ff 93.75%, #ffff00 100%);
  background-size: 200% 100%;
  animation: masked-animation 2s infinite linear;
}
@keyframes masked-animation {
  0% {
    background-position: 0 0;
  }
  100% {
    background-position: -100%, 0;
  }
}
.badge-danger {
    margin-right: 0;
    padding: 0 5px;
    height: 40px;
    min-width: 90px;
    font-size: 19px;
    border-radius: 5px;
    background-color: #FFC1C1;
    color: #FF6A6A;
    line-height: 25px;
}
.user-info {
  display: flex;
  align-items: center; 
  
}

.user-info-item {
  margin-right: 10px; /* 添加间隔 */
  font-weight: bold;
  font-size: 19px;
}
.pay{
  font-weight: bold;
  font-size: 19px;
  display: flex; align-items: center;
  margin-left: 18px;
}
</style>