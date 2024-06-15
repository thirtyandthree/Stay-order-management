<template>
  <div>
    <ul class="navigation">
      <li class="navigation__item">
        <a
          href="https://github.com/thirtyandthree"
          title="Github"
          target="_blank"
        >
          <img
            src="https://qiniu.staykoi.asia/%E7%99%BB%E5%BD%95/githubb.png"
            alt="Github"
          />
          <span class="label">Github</span>
        </a>
      </li>
      <li class="navigation__item">
        <a href="https://t.me/staykoi" title="Telegram" target="_blank">
          <img
            src="https://qiniu.staykoi.asia/%E7%99%BB%E5%BD%95/telegram.png"
            alt="Telegram"
          />
          <span class="label">Telegram</span>
        </a>
      </li>
      <li class="navigation__item">
        <a
          href="https://twitter.com/pangdapang1"
          title="Twitter"
          target="_blank"
        >
          <img
            src="https://qiniu.staykoi.asia/%E7%99%BB%E5%BD%95/%E6%8E%A8%E7%89%B9.png"
            alt="Twitter"
          />
          <span class="label">Twitter</span>
        </a>
      </li>
      <li class="navigation__item">
        <a
          href="https://wpa.qq.com/msgrd?v=3&uin=2580996608&site=qq&menu=yes"
          title="QQ"
          target="_blank"
        >
          <img
            src="https://qiniu.staykoi.asia/%E7%99%BB%E5%BD%95/qq.png"
            alt="QQ"
          />
          <span class="label">QQ</span>
        </a>
      </li>
      <li class="navigation__item">
        <a class="wechat-link" title="微信" @click="dialogVisible = true">
          <img
            src="https://qiniu.staykoi.asia/%E7%99%BB%E5%BD%95/%E5%BE%AE%E4%BF%A1.png"
            alt="微信"
          />
          <span class="label">微信</span>
        </a>
      </li>
      <li class="navigation__item">
        <a href="mailto:2580996608@qq.com" title="Email">
          <img
            src="https://qiniu.staykoi.asia/%E7%99%BB%E5%BD%95/mail%E9%82%AE%E4%BB%B6.png"
            alt="Email"
          />
          <span class="label">Email</span>
        </a>
      </li>
    </ul>
    <!-- Element UI弹窗 -->
    <el-dialog :visible.sync="dialogVisible" title="扫一扫加微信">
      <div style="display: flex; justify-content: center; align-items: center">
        <div class="bar-item-desc">
          <img
            src="https://qiniu.staykoi.asia/2024-2-10/%E5%8A%A8%E6%BC%AB/%E5%BE%AE%E4%BF%A1%E5%9B%BE%E7%89%87_20240410214252.png"
            alt="微信二维码"
            style="width: 100%; max-width: 300px"
          />
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "SocialLinks",
  data() {
    return {
      dialogVisible: false, // 控制弹窗显示
      showQRCode: false,
    };
  },
};
</script>

<style scoped>
.bar-item-desc {
  margin-bottom: 10px;
  border: none;
  box-sizing: border-box;
  padding: 24px 12px 14px;
  border-radius: 8px;
  background: url(https://www.sluyu.com/wp-content/themes/b2Jitheme/images/bg-cat-main-code.png)
    no-repeat 50%;
  -webkit-background-size: 100% 100%;
  -moz-background-size: 100% 100%;
  background-size: 100% 100%;
  width: 42%;
}
.navigation {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-wrap: wrap;
}

.navigation__item {
  display: flex;
  align-items: center;
  margin: 0 10px; /* Adjust spacing between items */
}

.navigation__item a {
  display: flex;
  align-items: center;
  text-decoration: none;
  color: black;
}

.navigation__item img {
  width: 24px;
  height: 24px;
  margin-right: 8px;
}
</style>
