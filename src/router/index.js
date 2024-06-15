import Vue from 'vue';
import VueRouter from 'vue-router';
import Login from '../components/Login.vue';
import Register from '../components/Register.vue';
import Home from '../components/Home.vue';
import orderPage from '../components/orderPage';
import user from '../view/user.vue';
import control from '../components/control.vue'; // 确保路径正确
import userChart from '../components/userChart'; // 确保路径正确
import Info from '../view/person/Info.vue';
import headImg from '../view/person/headIMg.vue';
import ChangeInfo from '../view/person/ChangeInfo.vue'
import goodsAdd from '../view/goods/goodsAdd.vue';
import goodsManage from '../components/goodsManage.vue';
import forgetPasswd from '../components/forgetPasswd.vue';
import deskOrder from '../view/desk/deskOrder.vue';
import deskInfo from '../view/desk/deskInfo.vue';
import Pay from '../view/person/Pay.vue';
import email from '../view/person/email.vue';
import NotFound from '../view/NotFound.vue';
import news from '../components/news.vue'
import redeem from '../components/redeem.vue'
import annocement from '../components/annocement.vue'
Vue.use(VueRouter);

const routes = [
    {
        path: '/',
        name: 'Login',
        component: Login
    },
    {
        path: '/register',
        name: 'Register',
        component: Register
    },
    {
        path:'/forgetPasswd',
        name: 'forgetPasswd',
        component: forgetPasswd
    },
    {
        path: '/home',
        component: Home,
        children: [
            {
                path: '', // 空路径代表 /home 的默认子路由
                name: 'control',
                component: control
            },
            {
                path: 'orderPage',
                name: 'orderPage',
                component: orderPage
            },
            {
                path: 'user',
                name: 'user',
                component: user
            },
            {
                path: 'redeem',
                name: 'redeem',
                component: redeem
            },
            // 下面是新添加的个人信息相关的子路由
            {
                path: 'Info',
                name: 'Info',
                component: Info
            },
            {
                path: 'email',
                name: 'email',
                component: email
            },
            {
                path: 'news',
                name: 'news',
                component: news
            },
            {
                path: 'headImg',
                name: 'headImg',
                component: headImg
            },
            {
                path: 'ChangeInfo',
                name: 'ChangeInfo',
                component: ChangeInfo
            },
            {
                path: 'Pay',
                name: 'Pay',
                component: Pay
            },
            {
                path: 'goodsAdd',
                name: 'goodsAdd',
                component: goodsAdd
            },
            {
                path: 'goodsManage',
                name: 'goodsManage',
                component: goodsManage
            },
            {
                path: 'deskInfo',
                name: 'deskInfo',
                component: deskInfo
            },
            {
                path: 'deskOrder',
                name: 'deskOrder',
                component: deskOrder
            },
            {
                path: 'userChart',
                name: 'userChart',
                component: userChart
            },
            {
                path:'annocement',
                name: 'annocement',
                component:annocement
            },
            {
                path: '*',
                name: 'NotFound',
                component: NotFound
            },   
        ]
    }
];

const router = new VueRouter({
    mode: 'history',
    routes
});

// 挂载路由导航守卫
// to 代表将要访问的页面路径，from 代表从哪个页面路径跳转而来，next 代表一个放行的函数
import { MessageBox } from 'element-ui';

router.beforeEach((to, from, next) => {
    if (to.path === '/' || to.path === '/register' || to.path === '/forgetPasswd') {
        return next();
    }

    const tokenStr = window.sessionStorage.getItem('token');

    if (!tokenStr) {
        // 使用 Element UI 的 MessageBox 显示提示
        MessageBox.alert('请登录账号', '提示', {
            confirmButtonText: '确定',
            callback: action => {
                next('/'); // 用户点击确定后重定向到首页
            }
        });
    } else {
        next();
    }
});

export default router;
