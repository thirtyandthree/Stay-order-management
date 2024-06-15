<template>
  <el-container >
    <!-- 顶部导航栏 -->
    <Alert1></Alert1>
    <el-header class="header" style="height:50px;">
      <div class="title">
        <div class="title-left">
          <div class="title-left-image" ></div>
         <router-link to="/Home" style='display: flex;align-items: center;'>
            <img src="https://qiniu.staykoi.asia/%E7%AE%A1%E7%90%86/%E9%A6%96%E9%A1%B5.png" class='navImg' alt="Home" /> <!-- 图片路径替换为实际的图片路径 -->
            <span>首页</span>
          </router-link>
          <router-link to="/home/goodsManage" style='display: flex;align-items: center;'>
            <img src="https://qiniu.staykoi.asia/%E7%AE%A1%E7%90%86/%E5%95%86%E5%93%81-copy.png" class='navImg' alt="Goods" /> <!-- 图片路径替换为实际的图片路径 -->
            <span>商品</span>
          </router-link>
          <router-link to="/home/orderPage" style='display: flex;align-items: center;'>
            <img src="https://qiniu.staykoi.asia/%E7%AE%A1%E7%90%86/%E6%9F%A5%E7%9C%8B%E8%AE%A2%E5%8D%95.png" class='navImg' alt="Order" /> <!-- 图片路径替换为实际的图片路径 -->
            <span>订单</span>
          </router-link>
          <router-link to="/home/user" style='display: flex;align-items: center;'>
            <img src="https://qiniu.staykoi.asia/%E7%AE%A1%E7%90%86/25-%E7%94%A8%E6%88%B7%E7%AE%A1%E7%90%86.png" class='navImg' alt="User" /> <!-- 图片路径替换为实际的图片路径 -->
            <span>用户</span>
          </router-link>
          <router-link to="/home/personal" style='display: flex;align-items: center;'>
            <img src="https://qiniu.staykoi.asia/%E7%AE%A1%E7%90%86/%E4%B8%AA%E4%BA%BA%E4%B8%AD%E5%BF%83.png"  class='navImg' alt="Personal" /> <!-- 图片路径替换为实际的图片路径 -->
            <span>个人</span>
          </router-link>

        </div>
        <!-- <div class="search11">
          <div contenteditable class="inputType" placeholder="请输入文字"></div>
          <div class="button">搜索</div>
        </div> -->
        <div class="avatar-frame">
         <div class="title-right-image"></div>
        </div>
        <el-button class="girly-button" @click="logout">退出登录</el-button>
      </div>
    </el-header>
    <el-container>
      <!-- 侧边栏 -->
      <el-aside width="200px">
        <el-menu default-active="1-4-1" class="el-menu-vertical-demo" @open="handleOpen" @close="handleClose" :collapse="isCollapse">
          <el-button @click="toggleState" class="change">
            <i class="el-icon-switch-button" style="color:#00BFFF;"></i> 切换状态
          </el-button>
          <el-menu-item index="1" @click.native="goToHome">
            <i class="el-icon-s-home" style="color:#0000CD; font-size:25px;"></i>
            <span slot="title" class="nav-title">我的首页</span>
          </el-menu-item>
          <el-submenu index="2">
            <template v-slot:title>
              <div @click="goToPage('/home/goodsManage')">
                <i class="el-icon-menu" style="color:#BA55D3; font-size:25px;"></i>
                <span class="nav-title">商品管理</span>
              </div>
            </template>
            <el-menu-item index="2-1" @click.native="goToPage('/home/goodsManage')">
                <i class="el-icon-s-goods" style='color:#FFA500;'></i> 
                商品列表
              </el-menu-item>
              <el-menu-item index="2-2" @click.native="goToPage('/home/goodsAdd')">
                <i class="el-icon-s-claim" style='color:#1E90FF;'></i> 
                特惠商品
              </el-menu-item>

          </el-submenu>
          <el-menu-item index="3" @click.native="goToPage('/home/user')">
            <i class="el-icon-document" style="color:#FF1493; font-size:25px;"></i>
            <span slot="title" class="nav-title">用户管理</span>
          </el-menu-item>
          <el-menu-item index="4" @click.native="goToPage('/home/orderPage')">
            <i class="el-icon-setting" style="color:#AB82FF; font-size:25px;"></i>
            <span slot="title" class="nav-title">订单管理</span>
          </el-menu-item>
          <el-menu-item index="5" @click.native="goToPage('/home/userChart')">
            <i class="el-icon-trophy" style="color:#FF7F00; font-size:25px;"></i>
            <span slot="title" class="nav-title">用户排行</span>
          </el-menu-item>
          <el-menu-item index="5" @click.native="goToPage('/home/redeem')">
            <i class="el-icon-edit-outline" style="color:#BF3EFF; font-size:25px;"></i>
            <span slot="title" class="nav-title">兑换管理</span>
          </el-menu-item>
          <el-menu-item index="5" @click.native="goToPage('/home/annocement')">
            <i class="el-icon-postcard" style="color:#EEB4B4; font-size:25px;"></i>
            <span slot="title" class="nav-title">公告管理</span>
          </el-menu-item>
          <el-submenu index="6">
            <template v-slot:title>
              <div @click="goToPage('/home/deskInfo')">
                <i class="el-icon-s-management" style="color:#90EE90; font-size:25px;"></i>
                <span class="nav-title">餐桌管理</span>
              </div>
            </template>
            <el-menu-item index="6-1" @click.native="goToPage('/home/deskInfo')">
                    <i class="el-icon-s-order" style='color:#FA8072;'></i> <!-- Element UI 的菜单图标 -->
                    餐桌信息
                  </el-menu-item>

                  <el-menu-item index="6-2" @click.native="goToPage('/home/deskOrder')">
                    <i class="el-icon-date" style='color:#DA70D6;'></i> <!-- Element UI 的菜单图标 -->
                    餐桌预订
                  </el-menu-item>

          </el-submenu>
          <el-submenu index="7">
            <template v-slot:title>
              <div @click="goToPage('/home/info')">
                <i class="el-icon-s-custom" style="color:#FF69B4; font-size:25px;"></i>
                <span class="nav-title">个人主页</span>
              </div>
            </template>
            <el-menu-item index="7-1" @click.native="goToPage('/home/info')">
              <img src="https://qiniu.staykoi.asia/%E7%AE%A1%E7%90%86/%E4%B8%AA%E4%BA%BA%E7%AE%80%E4%BB%8B.png" alt="Profile" style="vertical-align: middle; margin-right: 8px; width: 25px; height: 25px;">个人简介
            </el-menu-item>
            <el-menu-item index="7-2" @click.native="goToPage('/home/headImg')">
              <img src="https://qiniu.staykoi.asia/%E7%AE%A1%E7%90%86/%E5%9B%BE%E7%89%87-copy.png" alt="Upload" style="vertical-align: middle; margin-right: 8px; width: 25px; height: 25px;">上传图片
            </el-menu-item>
            <el-menu-item index="7-3" @click.native="goToPage('/home/ChangeInfo')">
              <img src="https://qiniu.staykoi.asia/%E7%AE%A1%E7%90%86/%E4%BF%AE%E6%94%B9%E5%AF%86%E7%A0%81.png" alt="Change Password" style="vertical-align: middle; margin-right: 8px; width: 25px; height: 25px;">修改密码
            </el-menu-item>
            <el-menu-item index="7-4" @click.native="goToPage('/home/Pay')">
              <img src="https://qiniu.staykoi.asia/%E7%AE%A1%E7%90%86/%E6%94%AF%E4%BB%98%E9%85%8D%E7%BD%AE.png" alt="Payment" style="vertical-align: middle; margin-right: 8px; width: 25px; height: 25px;">支付选择
            </el-menu-item>
            <el-menu-item index="7-4" @click.native="goToPage('/home/email')">
              <img src="https://qiniu.staykoi.asia/%E7%AE%A1%E7%90%86/%E9%82%AE%E7%AE%B1.png" alt="Payment" style="vertical-align: middle; margin-right: 8px; width: 25px; height: 25px;">邮箱配置
            </el-menu-item>
          </el-submenu>
          <el-menu-item index="5" @click.native="goToPage('/home/news')">
             <img src="https://qiniu.staykoi.asia/%E7%AE%A1%E7%90%86/%E6%96%B0%E9%97%BB%E8%B5%84%E8%AE%AF.png" alt="Payment" style="vertical-align: middle; margin-right: 8px; width: 25px; height: 25px;">
            <span slot="title" class="nav-title">热点新闻</span>
          </el-menu-item>
        </el-menu>
      </el-aside>
      <!-- 主内容区 -->
      <el-main style="background-color:#FFF0F5;">
        <router-view></router-view>
        <girl></girl>
       <go-top></go-top>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
import control from './control.vue'
import Alert1 from './Alert.vue'
import GoTop from './goTop.vue'
import girl from './girl.vue'
  export default {
    data() {
      return {
        isCollapse: true
      };
    },
    components: {
    'control':control,
      Alert1,
      GoTop,
      girl,
    },
    methods: {
      handleOpen(key, keyPath) {
        console.log(key, keyPath);
      },
      handleClose(key, keyPath) {
        console.log(key, keyPath);
      },
      toggleState() {
      // 切换isCollapse的值
      this.isCollapse = !this.isCollapse;
    },
    goToHome() {
    // 检查当前路由是否已经是目标路由 '/home'
    if (this.$router.currentRoute.path !== '/home') {
      this.$router.push('/home').catch(err => {
        // 捕获并忽略重复导航产生的错误
        if (err.name !== 'NavigationDuplicated') {
          // 如果错误不是重复导航错误，再抛出以便可以处理
          throw err;
        }
      });
    }
  },
  goToPage(path) {
    this.$router.push(path).catch(err => {
      // 检查错误是否是 'NavigationDuplicated' 错误
      if (err.name !== 'NavigationDuplicated') {
        // 如果错误不是 'NavigationDuplicated'，则重新抛出以便可以处理
        throw err;
      }
      // 如果是 'NavigationDuplicated' 错误，可以选择在这里记录或者完全忽略
    });
  },
    logout() {
            // 移除 token
            window.sessionStorage.removeItem('token');
            // 导航到登录页面
            this.$router.push('/');
        }
    },
  }
</script>
<style scoped>
.header{
    background-color: #FFE4E1;
    position: absolute;
    top:0;
    width: 100%;
}
.nav-title{
    font-weight: bold;
    color:#CD6090;
    font-size:20px;
}
.el-container {
  height: 100vh; /* 设置外层容器的高度为视窗的高度 */
}

.el-aside {
  height: 100%; /* 使侧边栏占据全部可用高度 */
}

.el-menu-vertical-demo:not(.el-menu--collapse) {
  width: 200px;
  min-height: 100%; /* 可以移除这个最小高度设置，或调整为100% */
}

/* 你之前的样式 */
.el-menu {
  background-color: #FFF0F5; /* 深色背景 */
}

.el-menu-item {
  color: #A020F0; /* 白色文本 */
  font-weight: bold;
  font-size: 15px;
  background-color: #FFF0F5;
}

.el-menu-item:hover {
  background-color: #FFE4E1;
}
.el-submenu__title {
  color: #ffd700; /* 金色文本 */
}
.change {
  background-color: #ffd700;
  border-radius: 25px;
  font-weight: bold;
  color:#CD6090;
}

.title {
    margin-left: 0;
    height: 60px;
    width: 100%;
    background-color: #F8F8FF; /* 浅灰蓝色背景 */
    border-bottom: 2px solid #E6E6FA; /* 浅紫色边框 */
    display: flex;
    justify-content: space-between;
    align-items: center; /* 垂直居中 */
}

.title-left {
    width: 580px;
    height: 48px;
    margin-left: 20px;
    background: #F8F8FF;
    display: flex;
    align-items: center; /* 垂直居中 */
}

.title-left-image {
    height: 70px;
    width: 160px;
    background-image: url('https://www.freeimg.cn/i/2024/03/07/65e9d94e112c6.png'); /* 请替换为您的图标或logo */
    background-size: contain;
    background-repeat: no-repeat;
    margin-right: 20px;
}

span {
    font-size: 16px;
    color: #8470FF; /* 浅紫色文字 */
    font-weight: bold;
    margin-right: 10px;
}

a {
    width: 80px;
    height: 48px;
    color: #8470FF; /* 浅紫色链接 */
    margin: 0 10px;
    text-decoration: none;
    line-height: 48px;
    text-align: center;
    font-weight: bold;
}
.girly-button {
  background-color: #FFB6C1; /* 浅粉色，给人一种温柔的感觉 */
  color: white; /* 白色文字 */
  border: none; /* 去掉边框 */
  border-radius: 20px; /* 圆角边框 */
  box-shadow: 0 4px 10px rgba(255, 182, 193, .5); /* 添加细腻的阴影 */
  font-weight: bold; /* 加粗字体 */
  transition: all .3s; /* 过渡动画使得点击和鼠标悬浮的响应更加平滑 */
}

.girly-button:hover {
  background-color: #FFC0CB; /* 鼠标悬浮时颜色稍微亮一点 */
  color:#FF1493;
  box-shadow: 0 6px 12px rgba(255, 182, 193, .8); /* 阴影更明显，增加立体感 */
  transform: translateY(-2px); /* 轻微上浮效果 */
}

.girly-button:active {
  background-color: #FF69B4; /* 按下时颜色更深，增加反馈感 */
  box-shadow: 0 2px 8px rgba(255, 182, 193, .6); /* 按下时阴影更接近按钮，增加按压感 */
  transform: translateY(1px); /* 假按压效果 */
}
a:hover {
    background-color: #E6E6FA; /* 浅紫色背景 */
}

.serch11 {
    height: 40px;
    width: 500px;
    background-color: #F8F8FF;
    margin: auto;
    display: flex;
    border: 2px solid #E6E6FA; /* 浅紫色边框 */
    border-radius: 20px; /* 圆角设计 */
}

.inputType {
    width: 400px;
    height: 36px;
    text-indent: 1em;
    line-height: 36px;
    background-color: #F8F8FF;
    border: none;
    color: #8470FF; /* 浅紫色输入文字 */
    font-size: 14px;
}

.inputType:focus {
    outline: none;
    border: 2px solid #D8BFD8; /* 深紫色边框 */
}

.button {
    color: #FFF;
    text-align: center;
    background: #8470FF; /* 浅紫色按钮背景 */
    border-left: 1px solid rgba(132, 112, 255, 0.5);
    width: 100px;
    height: 40px;
    line-height: 40px;
    border-top-right-radius: 18px;
    border-bottom-right-radius: 18px;
    font-size: 14px;
    font-weight: bold;
}

.title-right {
    width: 380px;
    height: 48px;
    display: flex;
    align-items: center; /* 垂直居中 */
    margin-right: 20px;
}
.avatar-frame {
  margin-left: 850px;
  width: 120px; /* 外部头像框的宽度，确保比内部div稍大 */
  height: 120px; /* 外部头像框的高度，确保比内部div稍大 */
  display: flex; /* 使用Flex布局确保内容居中 */
  justify-content: center; /* 水平居中 */
  align-items: center; /* 垂直居中 */
  background-image: url('https://qiniu.staykoi.asia/%E7%AE%A1%E7%90%86/newPreview2.avif'); /* 使用PNG图片作为背景 */
  background-size: cover; /* 确保背景图片覆盖整个div且不失真 */
 
}


.title-right-image {
    width: 80px;
    height: 80px;
    border: 1px solid #D8BFD8; /* 深紫色边框 */
    border-radius: 20px;
    background-image: url('https://qiniu.staykoi.asia/%E7%AE%A1%E7%90%86/new2.avif'); /* 请替换为您的头像图像 */
    background-size: cover;
}
.router-link {
  display: flex; /* 启用Flex布局 */
  align-items: center; /* 垂直居中对齐Flex项 */
  text-decoration: none; /* 可选：去掉链接的下划线 */
}
.navImg{
  height:20px;
  width:20px;
  margin-right:3px;
}

</style>