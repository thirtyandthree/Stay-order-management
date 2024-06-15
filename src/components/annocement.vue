<template>
  <div class="announcement-manage">
    <el-button type="primary" @click="showAddDialog" class="stay"
      >添加公告</el-button
    >
    <el-table :data="currentPageAnnouncements" style="width: 100%">
      <el-table-column label="序号" width="100">
        <template slot-scope="scope">
          {{ (currentPage - 1) * pageSize + scope.$index + 1 }}
        </template>
      </el-table-column>

      <el-table-column prop="title" label="标题"></el-table-column>
      <el-table-column prop="date" label="日期"></el-table-column>
      <el-table-column label="封面" width="180">
        <template slot-scope="scope">
          <img :src="scope.row.coverImg" style="width: 100px; height: 100px" />
        </template>
      </el-table-column>
      <el-table-column prop="content" label="内容"></el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button type="text" @click="showEditDialog(scope.row)"
            >编辑</el-button
          >
          <el-button type="text" @click="showViewDialog(scope.row)"
            >查看</el-button
          >
          <el-button
            type="text"
            @click="showDeleteDialog(scope.$index, scope.row)"
            >删除</el-button
          >
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
      @current-change="handlePageChange"
      :current-page="currentPage"
      :page-size="pageSize"
      layout="total, prev, pager, next"
      :total="totalAnnouncements"
    >
    </el-pagination>
    <!-- 添加公告对话框 -->
    <el-dialog title="添加公告" :visible.sync="addDialogVisible">
      <el-form :model="newAnnouncementForm" label-width="80px">
        <el-form-item label="标题" prop="title">
          <el-input v-model="newAnnouncementForm.title"></el-input>
        </el-form-item>
        <el-form-item label="日期" prop="title">
          <el-input
            v-model="newAnnouncementForm.date"
            placeholder="yyyy-mm-dd"
          ></el-input>
        </el-form-item>
        <el-form-item label="封面" prop="coverImg">
          <el-input v-model="newAnnouncementForm.coverImg"></el-input>
        </el-form-item>
        <el-form-item label="内容" prop="content">
          <el-input v-model="newAnnouncementForm.content"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="addDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="addAnnouncement">确定</el-button>
      </div>
    </el-dialog>

    <!-- 编辑公告对话框 -->
    <el-dialog title="编辑公告" :visible.sync="editDialogVisible">
      <el-form :model="editAnnouncementForm" label-width="80px">
        <el-form-item label="标题" prop="title">
          <el-input v-model="editAnnouncementForm.title"></el-input>
        </el-form-item>
        <el-form-item label="日期" prop="title">
          <el-input
            v-model="editAnnouncementForm.date"
            placeholder="yyyy-mm-dd"
          ></el-input>
        </el-form-item>
        <el-form-item label="封面" prop="coverImg">
          <el-input
            v-model="editAnnouncementForm.coverImg"
            placeholder="请填入图片链接"
          ></el-input>
        </el-form-item>
        <el-form-item label="内容" prop="content">
          <el-input v-model="editAnnouncementForm.content"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="editAnnouncement">确定</el-button>
      </div>
    </el-dialog>

    <!-- 删除确认对话框 -->
    <el-dialog title="警告" :visible.sync="deleteDialogVisible">
      <span>确定删除此公告吗?</span>
      <div slot="footer" class="dialog-footer">
        <el-button @click="deleteDialogVisible = false">取消</el-button>
        <el-button type="danger" @click="deleteAnnouncement">确定</el-button>
      </div>
    </el-dialog>

    <!-- 查看公告详情对话框 -->
    <!-- 查看公告详情对话框 -->
    <el-dialog
      title="公告详情"
      :visible.sync="viewDialogVisible"
      v-if="selectedAnnouncement"
    >
      <div class="announcement-detail">
        <h2 class="title">{{ selectedAnnouncement.title }}</h2>
        <div class="cover-container">
          <img :src="selectedAnnouncement.coverImg" class="cover-img" />
        </div>
        <p class="content">{{ selectedAnnouncement.content }}</p>
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button @click="viewDialogVisible = false">关闭</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      announcements: [],
      allAnnouncements: [], // 用于存储从后端获取的所有公告数据
      currentPageAnnouncements: [], // 当前页显示的公告
      currentPage: 1,
      pageSize: 6,
      totalAnnouncements: 0,
      addDialogVisible: false,
      editDialogVisible: false,
      deleteDialogVisible: false,
      viewDialogVisible: false,
      newAnnouncementForm: {
        title: "",
        coverImg: "",
        content: "",
        date: "",
      },
      editAnnouncementForm: {
        title: "",
        coverImg: "",
        content: "",
        date: "",
      },
      selectedAnnouncement: null,
    };
  },
  mounted() {
    this.fetchAnnouncements();
  },
  methods: {
    fetchAnnouncements() {
      axios
        .post(`${process.env.VUE_APP_API_URL}/api/announcement`) // 假设后端接口为 /api/announcements
        .then((response) => {
          this.announcements = response.data;
          // this.$message.success('成功获取公告数据');
          this.allAnnouncements = response.data; // 假设后端直接返回一个数组
          this.totalAnnouncements = response.data.length;
          this.updatePageAnnouncements();
          console.log(response.data);
        })
        .catch((error) => {
          console.error("获取公告数据失败", error);
          this.$message.error("获取公告数据失败");
        });
    },
    showAddDialog() {
      this.addDialogVisible = true;
    },
    updatePageAnnouncements() {
      const start = (this.currentPage - 1) * this.pageSize;
      const end = start + this.pageSize;
      this.currentPageAnnouncements = this.allAnnouncements.slice(start, end);
    },
    handlePageChange(newPage) {
      this.currentPage = newPage;
      this.updatePageAnnouncements();
    },
    addAnnouncement() {
      // 构建要发送的数据对象
      const newAnnouncement = {
        title: this.newAnnouncementForm.title,
        coverImg: this.newAnnouncementForm.coverImg,
        content: this.newAnnouncementForm.content,
        date: this.newAnnouncementForm.date,
      };

      // 发送 POST 请求到后端接口
      axios
        .post(
          `${process.env.VUE_APP_API_URL}/api/announcement/add`,
          newAnnouncement
        )
        .then((response) => {
          // 请求成功后的操作
          this.$message.success("公告添加成功");
          this.addDialogVisible = false;

          // 可能需要更新前端的公告列表
          this.fetchAnnouncements(); // 假设你有一个方法来刷新公告列表
        })
        .catch((error) => {
          // 请求失败后的操作
          this.$message.error("添加公告失败");
          console.error("添加公告失败:", error);
        });
    },
    showEditDialog(announcement) {
      this.selectedAnnouncement = announcement;
      this.editAnnouncementForm = Object.assign({}, announcement);
      this.editDialogVisible = true;
    },
    editAnnouncement() {
      // 找到当前公告在数组中的索引
      const index = this.announcements.findIndex(
        (item) => item.id === this.selectedAnnouncement.id
      );

      // 准备要发送到后端的更新数据
      const updatedAnnouncement = {
        id: this.selectedAnnouncement.id,
        title: this.editAnnouncementForm.title,
        coverImg: this.editAnnouncementForm.coverImg,
        content: this.editAnnouncementForm.content,
        date: this.editAnnouncementForm.date,
      };
      console.log(updatedAnnouncement);
      // 发送 PUT 请求到后端接口进行更新
      axios
        .post(
          `${process.env.VUE_APP_API_URL}/api/announcement/update`,
          updatedAnnouncement
        )
        .then((response) => {
          // 更新本地的公告数组以反映更改
          this.announcements[index] = updatedAnnouncement;

          // 请求成功后的操作
          this.$message.success("公告编辑成功");
          this.editDialogVisible = false;

          // 可能需要重新获取最新的公告列表
          this.fetchAnnouncements(); // 假设你有一个方法来刷新公告列表
        })
        .catch((error) => {
          // 请求失败后的操作
          this.$message.error("编辑公告失败");
          console.error("编辑公告失败:", error);
        });
    },
    showDeleteDialog(index, announcement) {
      this.selectedAnnouncement = announcement;
      this.deleteDialogVisible = true;
    },
    deleteAnnouncement() {
      const deleteAnnouncement = {
        id: this.selectedAnnouncement.id,
      };
      // 发送 DELETE 请求到后端接口进行删除
      axios
        .post(
          `${process.env.VUE_APP_API_URL}/api/announcement/delete`,
          deleteAnnouncement
        )
        .then((response) => {
          // 请求成功后的操作
          this.deleteDialogVisible = false;
          this.$message.success("公告删除成功");
          this.fetchAnnouncements();
        })
        .catch((error) => {
          // 请求失败后的操作
          this.$message.error("删除公告失败");
          console.error("删除公告失败:", error);
        });
    },
    showViewDialog(announcement) {
      this.selectedAnnouncement = announcement;
      this.viewDialogVisible = true;
    },
  },
};
</script>

<style scoped>
.stay {
  float: left;
  margin-right: 10px;
  margin-bottom: 10px;
}
::v-deep .el-table,
::v-deep .el-table__expanded-cell {
  background-color: #fff0f5;
  color: #f78fb3; /* 柔和的粉色 */
  font-size: 12px; /* 稍微减小字体大小以适应更柔和的风格 */
}

::v-deep .el-table th,
::v-deep .el-table tr,
::v-deep .el-table td {
  background-color: #fff0f5;
  border: solid 1px #ffffe0;
  color: #f78fb3;
  font-size: 16px;
  height: 5px;
  font-weight: bold;
}
::v-deep .el-table tbody tr:hover > td {
  background: #f0f8ff !important; /* 淡粉色的悬浮效果 */
}
::v-deep .el-table__header-wrapper {
  border: solid 2px #eedc82; /* 浅粉色边框 */
  box-sizing: border-box;
}
/* 修改el-form的整体背景色和内边距 */
::v-deep .el-form {
  background-color: #fff0f5; /* 淡粉红背景色 */
  padding: 20px;
  border-radius: 8px; /* 轻微的圆角边框 */
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1); /* 细微的阴影增添层次感 */
}

/* 自定义输入框样式 */
::v-deep .el-form .el-input__inner,
::v-deep .el-form .el-select .el-input__inner {
  border-color: #ffc0cb; /* 边框颜色 */
  background-color: #ffffff; /* 背景色 */
  font-weight: bold;
  color: #ff69b4; /* 输入文字颜色 */
}

/* 当输入框获得焦点时的样式 */
::v-deep .el-form .el-input__inner:focus,
::v-deep .el-form .el-select .el-input__inner:focus {
  border-color: #ff69b4; /* 焦点状态下的边框颜色 */
  box-shadow: 0 0 5px #ff69b4; /* 添加细微的发光效果 */
}

/* 修改标签（label）的样式 */
::v-deep .el-form label {
  color: #ff1493; /* 标签字体颜色 */
  font-weight: bold; /* 加粗字体 */
}

/* 自定义按钮样式 */
::v-deep .el-form .el-button {
  background-color: #ffb6c1; /* 按钮背景色 */
  border-color: #ffb6c1; /* 按钮边框颜色 */
  color: #ffffff; /* 按钮字体颜色 */
  border-radius: 20px; /* 圆润的按钮边框 */
  font-weight: bold; /* 字体加粗 */
}

/* 按钮hover和active状态样式 */
::v-deep .el-form .el-button:hover {
  background-color: #ff69b4;
  border-color: #ff69b4;
}
.el-button {
  border-radius: 20px;
  font-weight: bold;
  background-image: linear-gradient(120deg, #f6d365 0%, #fda085 100%);
  border: none;
  color: white;
}
::v-deep .el-button:active {
  background-color: #ee1289;
  color: white;
}
::v-deep .el-button:hover {
  border-radius: 20px;
  font-weight: bold;
  color: yellow;
  /* background-image: linear-gradient(120deg, #f6d365 0%, #fda085 100%); */
  background-color: #ee1289;
  border: none;
}
::v-deep .el-form .el-button:active {
  background-color: #ff1493;
  border-color: #ff1493;
}
::v-deep .el-dialog {
  background-color: #fff0f5; /* 更改背景颜色为柔和的灰色 */
  width: 600px; /* 调整对话框宽度 */
  font-weight: bold;
  border-radius: 20px; /* 添加圆角边框，让外观更柔和 */
}

/* 自定义对话框头部的背景和字体颜色 */
::v-deep .el-dialog__header {
  background-color: #ffb6c1; /* 使用柔和的粉红色作为标题栏背景 */
  color: #f06292;
  font-weight: bold;
}

/* 自定义对话框底部按钮的样式 */
::v-deep .el-dialog__footer .el-button {
  background-color: #ffc0cb; /* 按钮背景色为淡粉色 */
}

/* 调整遮罩层的背景颜色和透明度 */
::v-deep .el-overlay {
  background-color: rgba(
    255,
    182,
    193,
    0.5
  ); /* 使用半透明的粉红色作为遮罩层颜色 */
}

/* 自定义对话框中标签(label)的样式 */
::v-deep .el-dialog label {
  color: #ff69b4; /* 使用亮粉色调的字体颜色 */
  font-weight: bold; /* 加粗字体增加强调 */
}
.announcement-detail {
  background-color: #fff0f5;
  padding: 20px;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.title {
  color: #ff69b4;
  font-size: 24px;
  margin-bottom: 10px;
}

.cover-container {
  display: flex;
  justify-content: center;
  margin-bottom: 20px;
}

.cover-img {
  width: 150px;
  height: 200px;
  border-radius: 5px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.content {
  color: #8b4513;
  font-size: 16px;
  line-height: 1.5;
}
</style>