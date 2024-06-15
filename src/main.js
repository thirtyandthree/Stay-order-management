import Vue from 'vue';
import App from './App.vue';
import router from './router';
import store from './store';
// 引入 Element UI
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
// 引入 Axios
import axios from 'axios';
// 引入 vue-puzzle-vcode
import VuePuzzleVcode from 'vue-puzzle-vcode';
// 使用 ElementUI
Vue.use(ElementUI);
// 将 Axios 添加到 Vue 的原型链上，使其在全局可用
Vue.prototype.$http = axios;

// 注册 vue-puzzle-vcode 组件
Vue.component('vue-puzzle-vcode', VuePuzzleVcode);

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app');
