<template>
  <div style='background-image: url(https://qiniu.staykoi.asia/2024-4-16/wallhaven-d6qvxm.jpg);
  background-repeat: no-repeat;
  background-size:cover;'>
    <div class="buttons" style='padding-top:10px;'>
      <el-button type="primary" @click="fetchNewsItems('douyin')">
        <img src="@/assets/logo/douyin.png" alt="Douyin" style="height: 20px; vertical-align: middle; margin-right: 5px;">
       <span class='tag-new'>热榜</span>
       抖音
      </el-button>
      <el-button type="primary" @click="fetchNewsItems('weibo')">
        <img src="@/assets/logo/weibo.png" alt="Weibo" style="height: 20px; vertical-align: middle; margin-right: 5px;">
        <span class='tag-new' style='background-color:#FFEC8B;'>圈子</span>
        微博
      </el-button>
      <el-button type="primary" @click="fetchNewsItems('zhihu')">
        <img src="@/assets/logo/zhihu.png" alt="Zhihu" style="height: 20px; vertical-align: middle; margin-right: 5px;">
         <span class='tag-new' style='background-color:#87CEFF;'>学术</span>
        知乎
      </el-button>
      <el-button type="primary" @click="fetchNewsItems('36kr')">
        <img src="@/assets/logo/36kr.png" alt="Zhihu" style="height: 20px; vertical-align: middle; margin-right: 5px;">
        <span class='tag-new' style='background-color:#836FFF;'>资讯</span>
        36氪
      </el-button>
      <el-button type="primary" @click="fetchNewsItems('acfun')">
        <img src="@/assets/logo/acfun.png" alt="Zhihu" style="height: 20px; vertical-align: middle; margin-right: 5px;">
        <span class='tag-new' style='background-color:#FF8C69;'>娱乐</span>
        A站
      </el-button>
      <el-button type="primary" @click="fetchNewsItems('baidu')">
        <img src="@/assets/logo/baidu.png" alt="Zhihu" style="height: 20px; vertical-align: middle; margin-right: 5px;">
        <span class='tag-new' style='background-color:#C6E2FF;'>搜索</span>
        百度
      </el-button>
       <el-button type="primary" @click="fetchNewsItems('bilibili')">
        <img src="@/assets/logo/bilibili.png" alt="Zhihu" style="height: 20px; vertical-align: middle; margin-right: 5px;">
        <span class='tag-new' style='background-color:#FFB5C5;'>B站</span>
        哔哩哔哩
      </el-button>
       <el-button type="primary" @click="fetchNewsItems('douban-movie')">
        <img src="@/assets/logo/douban-movie.png" alt="Zhihu" style="height: 20px; vertical-align: middle; margin-right: 5px;">
        <span class='tag-new' style='background-color:#3CB371;'>观看</span>
        豆瓣
      </el-button>
      <el-button type="primary" @click="fetchNewsItems('genshin')">
        <img src="@/assets/logo/genshin.png" alt="Zhihu" style="height: 20px; vertical-align: middle; margin-right: 5px;">
        <span class='tag-new' style='background-color:#FFE1FF;'>可莉</span>
        原神
      </el-button>
      <el-button type="primary" @click="fetchNewsItems('hellogithub')">
        <img src="@/assets/logo/hellogithub.png" alt="Zhihu" style="height: 20px; vertical-align: middle; margin-right: 5px;">
         <span class='tag-new' style='background-color:#1E90FF;'>开源</span>
        Github
      </el-button>
      <el-button type="primary" @click="fetchNewsItems('honkai')">
        <img src="@/assets/logo/honkai.png" alt="Zhihu" style="height: 20px; vertical-align: middle; margin-right: 5px;">
       <span class='tag-new' style='background-color:#FF3E96;'>抽卡</span>
       崩坏
      </el-button>
      <el-button type="primary" @click="fetchNewsItems('ithome')">
        <img src="@/assets/logo/ithome.png" alt="Zhihu" style="height: 20px; vertical-align: middle; margin-right: 5px;">
       <span class='tag-new' style='background-color:#EE00EE;'>IT</span>
       IT之家
      </el-button>
      <el-button type="primary" @click="fetchNewsItems('jianshu')">
        <img src="@/assets/logo/jianshu.png" alt="Zhihu" style="height: 20px; vertical-align: middle; margin-right: 5px;">
       <span class='tag-new' style='background-color:#FA8072;'>生活</span>
       简书
      </el-button>
      <el-button type="primary" @click="fetchNewsItems('juejin')">
        <img src="@/assets/logo/juejin.png" alt="Zhihu" style="height: 20px; vertical-align: middle; margin-right: 5px;">
       <span class='tag-new' style='background-color:#8DEEEE;'>程序</span>
       稀土掘金
      </el-button>
      <el-button type="primary" @click="fetchNewsItems('lol')">
        <img src="@/assets/logo/lol.png" alt="Zhihu" style="height: 20px; vertical-align: middle; margin-right: 5px;">
       <span class='tag-new' style='background-color:#483D8B;'>5V5</span>
       LOL
      </el-button>
       <el-button type="primary" @click="fetchNewsItems('netease-news')">
        <img src="@/assets/logo/netease-news.png" alt="Zhihu" style="height: 20px; vertical-align: middle; margin-right: 5px;">
        <span class='tag-new' style='background-color:#FFDAB9;'>新闻</span>
       网易新闻
      </el-button>
      <el-button type="primary" @click="fetchNewsItems('ngabbs')">
        <img src="@/assets/logo/ngabbs.png" alt="Zhihu" style="height: 20px; vertical-align: middle; margin-right: 5px;">
       <span class='tag-new' style='background-color:#9370DB;'>趣事</span>
       NGA
      </el-button>
      <el-button type="primary" @click="fetchNewsItems('qq-news')">
        <img src="@/assets/logo/qq-news.png" alt="Zhihu" style="height: 20px; vertical-align: middle; margin-right: 5px;">
       <span class='tag-new' style='background-color:#EE9A00;'>新奇</span>
       QQ新闻
      </el-button>
      <el-button type="primary" @click="fetchNewsItems('sspai')">
        <img src="@/assets/logo/sspai.png" alt="Zhihu" style="height: 20px; vertical-align: middle; margin-right: 5px;">
       <span class='tag-new' style='background-color:#FF4500;'>应用</span>
       少数派
      </el-button>
       <el-button type="primary" @click="fetchNewsItems('starrail')">
        <img src="@/assets/logo/starrail.png" alt="Zhihu" style="height: 20px; vertical-align: middle; margin-right: 5px;">
       <span class='tag-new' style='background-color:#FF82AB;'>少女</span>
       星穹铁道
      </el-button>
       <el-button type="primary" @click="fetchNewsItems('thepaper')">
        <img src="@/assets/logo/thepaper.png" alt="Zhihu" style="height: 20px; vertical-align: middle; margin-right: 5px;">
       <span class='tag-new' style='background-color:#FF83FA;'>震惊</span>
       澎湃新闻
      </el-button>
      <el-button type="primary" @click="fetchNewsItems('tieba')">
        <img src="@/assets/logo/tieba.png" alt="Zhihu" style="height: 20px; vertical-align: middle; margin-right: 5px;">
       <span class='tag-new' style='background-color:#0000CD;'>吐槽</span>
       百度贴吧
      </el-button>
       <el-button type="primary" @click="fetchNewsItems('weread')">
        <img src="@/assets/logo/weread.png" alt="Zhihu" style="height: 20px; vertical-align: middle; margin-right: 5px;">
        <span class='tag-new' style='background-color:	#00B2EE;'>书籍</span>
       微信读书
      </el-button>
      <el-button type="primary" @click="fetchNewsItems('zhihu-daily')">
        <img src="@/assets/logo/zhihu-daily.png" alt="Zhihu" style="height: 20px; vertical-align: middle; margin-right: 5px;">
       <span class='tag-new' style='background-color:	#FFE1FF;'>报道</span>
       知乎日报
      </el-button>
    </div>
    <div class="news-container">
   <!-- 确保卡片有相对定位 -->
    <el-card v-for="(news, index) in paginatedNews" :key="index" class="news-item" :style="{ backgroundImage: 'url(' + getRandomBgImage() + ')' }" style="position: relative;">
  <div class='stay' @mouseenter="handleMouseEnter(news, $event)"
      @mouseleave="handleMouseLeave" >
            <el-popover 
              popper-class="monitor-yt-popover"
              placement="top" 
              width="200" 
              trigger="hover" 
              :content="news.desc ? news.desc : news.title"
              ref="popover">
              <template slot="reference">
                <h2 class="news-title">
                  <a :href="news.url" target="_blank">{{ news.title }}</a>
                </h2>
                <!-- el-tag 绝对定位于左上角 -->
                <el-tag :type="getTagType(index)" style="position: absolute; top: 10px; left: 10px;">
                  <span style="font-weight: bold;font-size:29px;">
                    {{ index + 1 }}
                  </span>
                </el-tag>
                <!-- 图标显示，仅对前7个新闻显示不同图标 -->
                <img v-if="index < 7" :src="icons[index]" alt="News Icon" style="width: 100px;height:30px; position: absolute; top: 20px; right: 20px;">
              </template>
            </el-popover>
            <div class="image-container">
              <img :src="getRandomImage(news.cover, name)" alt="" style="width: 86%;margin-top:10px;">
            </div>
              <div style="padding: 14px;">
                <img src="@/assets/logo/favicon.png" alt="Hot" style="width: 20px; vertical-align: middle;">
                <span style="font-size:20px; margin-left: 2px; color: #6f42c1; background-color: #fde4ff; padding: 3px 8px; border-radius: 5px; font-weight: bold; box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);">
                  {{ news.hot }} 浏览量
                </span>
              </div>
        </div>
      </el-card>
    </div>
    <el-pagination
      @current-change="handlePageChange"
      :current-page="currentPage"
      :page-size="pageSize"
      layout="prev, pager, next"
      :total="newsList.length">
    </el-pagination>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      newsList: [],
      currentPage: 1,
      pageSize: 9,
      name:'',
       icons: [
      'https://qiniu.staykoi.asia/2024-2-20/lv7.png', // 对应第1个新闻项
      'https://qiniu.staykoi.asia/2024-2-20/lv6.png',
      'https://qiniu.staykoi.asia/2024-2-20/lv5.png',
      'https://qiniu.staykoi.asia/2024-2-20/lv4.png',
      'https://qiniu.staykoi.asia/2024-2-20/lv3.png',
      'https://qiniu.staykoi.asia/2024-2-20/lv2.png',
      'https://qiniu.staykoi.asia/2024-2-20/lv1.png'  // 对应第7个新闻项
    ]
    };
  },
  computed: {
    paginatedNews() {
      const start = (this.currentPage - 1) * this.pageSize;
      const end = start + this.pageSize;
      return this.newsList.slice(start, end);
    }
  },
  methods: {
    fetchNewsItems(source) {
      const url = `/api/${source}`;
      axios({
        method: 'get',
        url: url,
        withCredentials: true
      })
      .then(response => {
        this.newsList = response.data.data;
        this.name=response.data.name;
        console.log(this.name)
        this.currentPage = 1; // Reset to first page on new data
      })
      .catch(error => {
        console.error('Error fetching news:', error);
      });
    },
    getTagType(index) {
      if (index === 0) return 'success';
      if (index === 1) return 'warning';
      if (index === 2) return 'danger';
      return 'info';
    },
   handleMouseEnter(news, event) {
  // 创建一个新的 div 元素来显示图片
  const imgDiv = document.createElement('div');
  imgDiv.style.position = 'absolute';
  imgDiv.style.top = (event.target.getBoundingClientRect().top-88) + 'px';
  imgDiv.style.left = (event.target.getBoundingClientRect().left-30) + 'px';
  imgDiv.style.width = '100px'; // 设置宽度为 100% 或根据需要调整
  imgDiv.style.height = '80px'; // 设置高度为 100% 或根据需要调整
  imgDiv.style.zIndex = '1000'; // 确保它位于其他元素之上
  imgDiv.style.opacity = '0'; // 初始化为透明
  imgDiv.style.transition = 'opacity 0.5s ease-in-out'; // 设置淡入淡出效果
  imgDiv.innerHTML = `<img src="https://qiniu.staykoi.asia/2024-4-16/6538701dc458853aefd76df5.png" alt="新闻图片" style="width: 100%; height: auto;">`;

  // 将 div 添加到 body 中
  document.body.appendChild(imgDiv);

  // 淡入效果
  setTimeout(() => {
    imgDiv.style.opacity = '1';
  }, 10); // 延迟以确保元素已经被添加到DOM中

  // 保存 imgDiv 以便之后移除
  this.imgDiv = imgDiv;
},

handleMouseLeave() {
  // 移除之前添加的图片 div
  if (this.imgDiv) {
    this.imgDiv.style.opacity = '0'; // 开始淡出
    setTimeout(() => {
      document.body.removeChild(this.imgDiv); // 完全透明后移除
      this.imgDiv = null;
    }, 500); // 等待淡出完成
  }
},

    handlePageChange(newPage) {
      this.currentPage = newPage;
    },
    // getRandomImage(newsImage) {
    //   const defaultImages = ['https://www.freeimg.cn/thumbnails/50f56fbf7888e6c90a8181609928a2c6.png',
    //    'https://www.freeimg.cn/thumbnails/08b6537feea4fe4f1c0358d7b1ee7abd.png',
    //     'https://www.freeimg.cn/thumbnails/e1d7d35c179f6e3e5e89548e99108ad0.png',
    //     'https://www.freeimg.cn/thumbnails/724c4c1ecb4e13310d669df0c2356d16.png',
    //     'https://www.freeimg.cn/thumbnails/7f5f87995a9a87bbb89f76333ceaad3b.png',
    //     'https://www.freeimg.cn/thumbnails/2920b5a9e9ece2267c77c56ff2b4b5c9.png',
    //     'https://www.freeimg.cn/thumbnails/3f6d481a74f68088dfc1afb304d2d72e.png',
    //     'https://www.freeimg.cn/thumbnails/9538137c276924efe11483380d21206f.png',
    //     'https://www.freeimg.cn/thumbnails/34a99dc9443ae1bda0c68f1a2ccea21b.png',
    //     'https://www.freeimg.cn/thumbnails/0ca70265acc85857aac39a463f74709a.png',
    //     'https://qiniu.staykoi.asia/2024-2-11/%E5%8A%A8%E6%BC%AB/100167743_p0_master1200.jpg',
    //     'https://qiniu.staykoi.asia/2024-2-11/%E5%8A%A8%E6%BC%AB/100517257_p0_master1200.jpg',
    //     'https://qiniu.staykoi.asia/2024-2-11/%E5%8A%A8%E6%BC%AB/101553600_p0_master1200.jpg',
    //     'https://qiniu.staykoi.asia/2024-2-11/%E5%8A%A8%E6%BC%AB/102307569_p0_master1200.jpg',
    //     'https://qiniu.staykoi.asia/2024-2-11/%E5%8A%A8%E6%BC%AB/102407641_p0_master1200.jpg',
    //     'https://qiniu.staykoi.asia/2024-2-11/%E5%8A%A8%E6%BC%AB/102933256_p0_master1200.jpg',
    //     'https://qiniu.staykoi.asia/2024-2-11/%E5%8A%A8%E6%BC%AB/103537512_p0_master1200.jpg',
    //     ];
    //   if (newsImage) {
    //     return newsImage;
    //   } else {
    //     return defaultImages[Math.floor(Math.random() * defaultImages.length)];
    //   }
    // },
    getRandomImage(newsImage, sourceName) {
    const defaultImages = ['https://www.freeimg.cn/thumbnails/50f56fbf7888e6c90a8181609928a2c6.png',
       'https://www.freeimg.cn/thumbnails/08b6537feea4fe4f1c0358d7b1ee7abd.png',
        'https://www.freeimg.cn/thumbnails/e1d7d35c179f6e3e5e89548e99108ad0.png',
        'https://www.freeimg.cn/thumbnails/724c4c1ecb4e13310d669df0c2356d16.png',
        'https://www.freeimg.cn/thumbnails/7f5f87995a9a87bbb89f76333ceaad3b.png',
        'https://www.freeimg.cn/thumbnails/2920b5a9e9ece2267c77c56ff2b4b5c9.png',
        'https://www.freeimg.cn/thumbnails/3f6d481a74f68088dfc1afb304d2d72e.png',
        'https://www.freeimg.cn/thumbnails/9538137c276924efe11483380d21206f.png',
        'https://www.freeimg.cn/thumbnails/34a99dc9443ae1bda0c68f1a2ccea21b.png',
        'https://www.freeimg.cn/thumbnails/0ca70265acc85857aac39a463f74709a.png',
        'https://qiniu.staykoi.asia/2024-2-11/%E5%8A%A8%E6%BC%AB/100167743_p0_master1200.jpg',
        'https://qiniu.staykoi.asia/2024-2-11/%E5%8A%A8%E6%BC%AB/100517257_p0_master1200.jpg',
        'https://qiniu.staykoi.asia/2024-2-11/%E5%8A%A8%E6%BC%AB/101553600_p0_master1200.jpg',
        'https://qiniu.staykoi.asia/2024-2-11/%E5%8A%A8%E6%BC%AB/102307569_p0_master1200.jpg',
        'https://qiniu.staykoi.asia/2024-2-11/%E5%8A%A8%E6%BC%AB/102407641_p0_master1200.jpg',
        'https://qiniu.staykoi.asia/2024-2-11/%E5%8A%A8%E6%BC%AB/102933256_p0_master1200.jpg',
        'https://qiniu.staykoi.asia/2024-2-11/%E5%8A%A8%E6%BC%AB/103537512_p0_master1200.jpg',
        ];

    // 指定当 sourceName 符合某些条件时使用随机图片
    const sourcesUsingRandomImages = ['douyin','bilibili','douban-movie','weibo','hellogithub','ithome'
    ,'jianshu','juejin','ngabbs','sspai','tieba','thepaper','starrail']; // 替换这里的值为实际的名称判断

    if (sourcesUsingRandomImages.includes(sourceName)) {
        return defaultImages[Math.floor(Math.random() * defaultImages.length)];
    } else {
        return newsImage || defaultImages[0]; // 如果 newsImage 为空，则使用默认图片中的第一张
    }
},
    getRandomBgImage() {
      const backgroundImages = ['/path/to/bg1.png', '/path/to/bg2.png', '/path/to/bg3.png'];
      return backgroundImages[Math.floor(Math.random() * backgroundImages.length)];
    }
  },
  created() {
    this.fetchNewsItems('douyin');
  },
}
</script>

<style scoped>
.el-button img, .news-item img {
  vertical-align: middle; /* 垂直居中图标 */
  margin-right: 5px; /* 文字和图标之间的间隔 */
  height: 20px; /* 图标的大小，可根据需要调整 */
}
/* 使用 ::v-deep 透穿 scoped 样式，适用于 Vue 单文件组件 */
::v-deep .el-button {
  border-radius: 25px;
  background-color: #d9b8ff; /* 浅紫色背景 */
  border: 5px solid #E6E6FA; /* 透明边框，为渐变做准备 */
  color: white; /* 白色文字，提升对比度和可读性 */
  font-weight: bold; /* 加粗字体 */
  text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2); /* 文字阴影，增加深度 */
  transition: transform 0.3s, box-shadow 0.3s; /* 平滑的变换和阴影过渡效果 */
  background-clip: padding-box; /* 让背景跟随边框的形状 */
}


::v-deep .el-button:hover {
  transform: translateY(-2px); /* 悬浮时轻微上移 */
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15); /* 悬浮时添加阴影，增加浮动感 */
  background-color: #FF6EB4;
}
/* 使用 ::v-deep 深入作用域 */
::v-deep .el-card__body {
    padding: 20px;
    border: 3px solid #FF69B4; /* 保持使用亮粉色边框 */
    background-color: #FFF0F5; /* 浅粉色背景 */
    box-shadow: 0 4px 10px rgba(255, 105, 180, 0.5); /* 柔和且更明显的阴影效果 */
    transition: transform 0.3s ease-in-out;
    border-radius: 12px; /* 添加圆角边框 */
    font-family: 'Cursive', Arial, sans-serif; /* 使用手写体系列的字体 */
    color: #FF69B4; /* 文字颜色与边框颜色一致，增强整体风格协调性 */
    text-shadow: 1px 1px 2px pink; /* 文字阴影，增加文字的立体感和柔美感 */
}
::v-deep .el-card__body:hover {
    transform: translateY(-5px); /* 鼠标悬停时轻微上升 */
}

::v-deep .el-main {
    padding: 20px;
    border: 3px solid #FFB6C1; /* 使用淡粉色边框 */
    background-color: #FFF5EE; /* 肤色背景 */
    box-shadow: 0 4px 10px rgba(255, 182, 193, 0.3); /* 添加柔和的阴影 */
}

.buttons {
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
  gap: 10px; /* 设置按钮之间的间隔 */
  margin-bottom: 20px;
}

.news-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
}
.news-item {
  width: 30%;
  margin: 10px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}
.image-container img {
  height: 200px;
  object-fit: cover;
}
.tag-container {
  margin-bottom: 10px; /* 略微增加底部间隔 */
}
.el-tag {
  font-size: 1.2em; /* 增加标签的字体大小 */
  padding: 6px 12px; /* 增加内边距以扩大标签 */
  border-radius: 4px; /* 圆润边角 */
}
.el-progress {
  margin-top: 10px; /* 增加进度条与文字的间隔 */
}
.header-container {
  display: flex;
  align-items: center; /* 垂直居中对齐 */
}
.stay{
  background-image: url(https://www.sluyu.com/wp-content/themes/b2Jitheme/images/bg-cat-main-code.png);
  background-repeat: no-repeat;
  background-size: cover;
}
.news-tag {
  margin-right: 10px; /* 标签和标题之间的间距 */
}

/* 定义基本的字体样式和颜色 */
.news-title a {
  font-family: 'Cursive', Arial, sans-serif; /* 使用手写体系列字体 */
  color: #FF69B4; /* 亮粉色 */
  font-weight: bold;
  text-decoration: none; /* 去除下划线 */
  font-size: 28px; /* 字体大小 */
  transition: all 0.3s ease; /* 平滑过渡效果 */
}

/* 添加文字阴影，提升文字的立体感 */
.news-title a {
  text-shadow: 1px 1px 2px rgba(255, 105, 180, 0.5); /* 降低阴影的不透明度提高文字清晰度 */
}

/* 悬停效果，改变颜色和添加下划线 */
.news-title a:hover {
  color: #FFC0CB; /* 使用更亮的粉色以增加对比，改善可读性 */
  text-decoration: underline; /* 添加下划线 */
  transform: scale(1.05); /* 轻微放大 */
}

/* 添加悬停时的文字阴影增强效果 */
.news-title a:hover {
  text-shadow: 1px 1px 2px #FFB5C5; /* 减少阴影模糊度并调整不透明度 */
}



.el-popover.monitor-yt-popover {
  background-color: #f8eaff; /* 浅紫色背景，给人温柔感觉 */
  border: 1px solid #d9b8ff; /* 搭配的边框颜色 */
  box-shadow: 0 8px 16px 0 rgba(217, 184, 255, 0.5); /* 添加柔和的阴影，增加浮动效果 */
  border-radius: 10px; /* 圆润的边角 */
}
.monitor-yt-popover .el-popover__title {
  color: red; /* 内容部分使用深紫色变体 */
  font-size: 14px; /* 设置字体大小 */
  padding: 10px 15px; /* 内容的内边距 */
}

.monitor-yt-popover .popper__arrow::after {
  border-top-color: #f8eaff !important; /* 将箭头颜色设置为背景色，以便它融入整体设计 */
}
.tag-new {
    box-shadow: 0 4px 4px -2px rgba(255,0,122,.3);
    background: #ff71aa;
    display: inline-block;
    transform: translateY(-12px);
    font-size: 14px;
    letter-spacing: 0.05em;
    color: #ffffff!important;
    border-radius: 1rem;
    padding: .15rem .275rem;
    line-height: 1;
}
</style>
