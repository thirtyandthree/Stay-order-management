<template>
  <el-card class="me-area" :body-style="{ padding: '16px' }">
    <div class="me-article-header">
      <a @click="view(id)" class="me-article-title">{{ title }}</a>
      <el-button v-if="weight > 0" class="me-article-icon" type="text"
        >置顶</el-button
      >
      <span class="me-pull-right me-article-count">
        <i class="el-icon-star-off"></i>&nbsp;{{ collectCounts }}
      </span>
      <span class="me-pull-right me-article-count">
        <i class="el-icon-chat-dot-round"></i>&nbsp;{{ commentCounts }}
      </span>
      <span class="me-pull-right me-article-count">
        <img
          style="height: 13px; width: 13px"
          src="@/assets/购物车购物.svg"
        />&nbsp;{{ goodCounts }}
      </span>
      <span class="me-pull-right me-article-count">
        <i class="el-icon-view"></i>&nbsp;{{ viewCounts }}
      </span>
    </div>

    <div class="me-artile-description">
      {{ summary }}
    </div>
    <div class="preimg" v-if="preimg">
      <div
        style="margin-right: 30px; width: 120px"
        v-for="(item, index) in imgList"
        :key="index"
      >
        <img v-image-preview style="cursor: pointer" :src="item" />
      </div>
    </div>
    <div class="me-article-footer">
      <span class="me-article-author" @click="personal(authorId)">
        <img
          v-if="v === 3"
          src="@/assets/购物车购物.svg"
          class="me-article-author-img"
        />
        <i class="me-icon-author"></i>&nbsp;{{ author }}
        <img v-if="avatar" :src="avatar" class="me-article-author-avatar" />
      </span>

      <el-tag v-for="t in tags" :key="t.tagName" size="mini" type="warning">{{
        t.tagName
      }}</el-tag>
      <div class="me-pull-right me-article-time">
        <span class="me-pull-right me-article-count">
          <i class="el-icon-time"></i>&nbsp;{{ createDate | format }}
        </span>
      </div>
    </div>
  </el-card>
</template>

<script>
export default {
  name: "ArticleItem",
  props: {
    id: String,
    weight: Number,
    title: String,
    commentCounts: Number,
    viewCounts: Number,
    summary: String,
    author: String,
    authorId: String,
    avatar: String,
    v: Number,
    tags: Array,
    createDate: String,
    preimg: String,
    goodCounts: Number,
    collectCounts: Number,
  },

  data() {
    return {
      imgList: [],
    };
  },
  mounted() {
    if (this.preimg) {
      if (this.preimg.indexOf(",") != -1) {
        this.imgList = this.preimg.split(",");
      } else {
        this.imgList.push(this.preimg);
      }
    }
  },
  methods: {
    view(id) {
      this.$router.push({ path: `/view/${id}` });
    },
    personal(authorId) {
      this.$router.push({ path: `/newsuser/personal/${authorId}` });
    },
  },
};
</script>

<style scoped >
.me-article-header {
  /*padding: 10px 18px;*/
  padding-bottom: 10px;
}

.me-article-title {
  font-weight: 600;
}

.me-article-icon {
  padding: 3px 8px;
}

.me-article-count {
  color: #a6a6a6;
  padding-left: 20px;
  font-size: 13px;
}

.me-pull-right {
  float: right;
}

.me-artile-description {
  font-size: 13px;
  line-height: 24px;
  margin-bottom: 10px;
}
.me-article-author {
  color: #a6a6a6;
  padding-right: 18px;
  font-size: 13px;
  cursor: pointer;
}
.me-article-author-img {
  width: 15px;
  height: 15px;
}
.me-article-author-avatar {
  width: 30px;
  height: 30px;
  vertical-align: text-bottom;
  border-radius: 50%;
}
.el-tag {
  margin-left: 6px;
}
.me-article-time {
  margin-top: 20px;
}
.leftimg {
  /* width:11%;
  height:11%; */
  width: 100px;
  height: 90px;
  float: left;
  margin-right: 20px;
}
img {
  width: 100%;
  height: 100%;
}
.preimg {
  width: 700px;
  height: 90px;
  margin-bottom: 10px;
  display: flex;
}
</style>
