<template>
  <div class="table-management">
    <el-card class="box-card">
      <div slot="header" class="clearfix" style=" background-color:#FAD2E6;">
        <span class="girly-title">餐桌信息管理</span>
        <el-button style="float: right; padding: 3px 0" type="primary" @click="editDialogVisible = true">添加餐桌</el-button>
      </div>
      <el-table :header-cell-style="{
            color: '#fff',              // 白色字体
            background: '#FAD2E6',      // 淡粉色背景
            fontWeight: '600',          // 适度加粗的字体
            fontSize: '16px',           // 适中的字体大小
            fontFamily: 'Arial, sans-serif', // 使用更细腻的字体
                  // 文本居中
            padding: '10px 0'           // 适当的内边距
            }"
            :data="pagedTableList" style="width: 100%" :row-class-name="tableRowClassName">
        <el-table-column prop="id" label="编号" width="280"></el-table-column>
        <el-table-column prop="name" label="名称" width="280"></el-table-column>
        <el-table-column prop="capacity" label="容纳人数"></el-table-column>
        <el-table-column prop="status" label="状态" width="220">
          <template slot-scope="scope">
            <el-tag :type="scope.row.status === '空闲' ? 'success' : 'danger'">{{ scope.row.status }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="图片" width="220">
          <template slot-scope="scope">
            <img :src="scope.row.image" alt="餐桌图片" style="width: 80px; height: 80px;">
          </template>
        </el-table-column>
        <el-table-column label="操作" width="220">
          <template slot-scope="scope">
            <el-button size="mini" @click="handleEditTable(scope.row)">编辑</el-button>
            <el-button size="mini" type="danger" @click="handleDeleteTable(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
       <el-pagination
        @current-change="handlePageChange"
        :current-page="pagination.currentPage"
        :page-size="pagination.pageSize"
        layout="prev, pager, next"
        :total="tableList.length"
      >
      </el-pagination>
    </el-card>

    <!-- 添加/编辑餐桌的模态框 -->
    <el-dialog :title="editDialogTitle" :visible.sync="editDialogVisible">
      <el-form :model="editForm" ref="editForm" label-width="80px">
        <el-form-item label="名称" prop="name">
          <el-input v-model="editForm.name" placeholder="请输入餐桌名称"></el-input>
        </el-form-item>
        <el-form-item label="容纳人数" prop="capacity">
          <el-input-number v-model="editForm.capacity" :min="1" :max="20" :precision="0"></el-input-number>
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="editForm.status">
            <el-radio label="空闲">空闲</el-radio>
            <el-radio label="使用中">使用中</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="图片" prop="image">
             <el-input v-model="editForm.image" placeholder="请输入图片链接"></el-input>
         </el-form-item>

      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitEditForm">确定</el-button>
        <el-button type="primary" @click="handleAddTable">添加</el-button>
      </span>
    </el-dialog>
  </div>
  
</template>

<script>
import axios from 'axios';
export default {
  name: 'TableManagement',
  data() {
    return {
      tableList: [],
      pagination: {
        currentPage: 1,
        pageSize: 6,
      },
      editDialogVisible: false,
      editDialogType: 'add', // 'add' or 'edit'
      editDialogIndex: -1,
      editDialogId: '',
      editDialogTitle: '',
      editForm: {
          id: null, // 确保有一个 id 字段
          name: '',
          capacity: 1,
          status: '',
          image: ''
    }
    };
  },
  created() {
  this.fetchTableData();
},
computed: {
    pagedTableList() {
      const start = (this.pagination.currentPage - 1) * this.pagination.pageSize;
      const end = start + this.pagination.pageSize;
      return this.tableList.slice(start, end);
    }
  },
  methods: {
    fetchTableData() {
        axios.post(`${process.env.VUE_APP_API_URL}/api/desk`)
          .then(response => {
            this.tableList = response.data;
            
          })
          .catch(error => {
            console.error('Error fetching table data:', error);
          });
      },
      tableRowClassName({ row }) {
          if (row.status === '空闲') {
            return 'success-row'; // 空闲状态显示为成功样式
          } else {
            return 'danger-row'; // 使用中状态显示为危险样式
          }
        },
     handleAddTable() {
          axios.post(`${process.env.VUE_APP_API_URL}/api/desk/add`, this.editForm)
            .then(response => {
              // 请求成功后的逻辑，例如刷新餐桌列表
              this.fetchTableData();
              // 可能还需要关闭对话框或清空表单
              this.editDialogVisible = false;
              this.resetEditForm();
            })
            .catch(error => {
              // 请求失败后的逻辑，例如显示错误信息
              console.error('There was a problem with adding the table:', error);
            });
        },
          // 重置编辑表单
          resetEditForm() {
            this.editForm = {
              id: null,
              name: '',
              capacity: 1,
              status: '',
              image: ''
            };
         },
        handleEditTable(row) {
        // 设置编辑对话框的标题
        // 将编辑表单的模型设置为选中行的数据
        this.editForm = Object.assign({}, row);
        // 显示编辑对话框
        this.editDialogVisible = true;
      },
handlePageChange(newPage) {
      this.pagination.currentPage = newPage;
    },
      handleDeleteTable(row) {
        const tableName = row.name; // 获取餐桌名称
        console.log(tableName);
        axios.post(`${process.env.VUE_APP_API_URL}/api/desk/delete`, {
            tableName: tableName // 通过正确的键名发送表格名称
          })
          .then(response => {
            console.log(response.data);
            this.$message.success('删除成功');
            this.fetchTableData();
          })
          .catch(error => {
            console.error('Error deleting table:', error);
            this.$message.error('餐桌正在使用，无法删除');
            // 在这里处理错误，例如显示错误消息给用户
          });
      }
      ,async submitEditForm() {
          try {
            const response = await axios.post(`${process.env.VUE_APP_API_URL}/api/desk/update`, this.editForm);
            
            // 处理成功响应
            if (response.status === 200) {
              this.editDialogVisible = false;
              this.$message.success('更新成功');
              this.fetchTableData();
              // 可以根据后端返回的数据进行其他操作
            } else {
              throw new Error('Network response was not ok');
            }
          } catch (error) {
            console.error('There was a problem with your Axios request:', error);
            // 处理错误
          }
        },
          handleUploadSuccess(response, file, fileList) {
            // 图片上传成功后的处理逻辑
            // 可以将图片的URL保存到editForm的image字段中
            this.editForm.image = response.url;
          }
        }
      };
</script>

<style scoped>
::v-deep .el-table,
::v-deep .el-table__expanded-cell {
  background-color: transparent;
  color: #F78FB3; /* 柔和的粉色 */
  font-size: 18px; /* 稍微减小字体大小以适应更柔和的风格 */
}

::v-deep .el-table th,
::v-deep .el-table tr,
::v-deep .el-table td {
  background-color: #FFF0F5;
  border: 0px;
  color: #F78FB3;
  font-size: 18px;
  height: 5px;
  /* font-family: "Comic Sans MS", cursive, sans-serif; 使用更圆润、更少女风格的字体 */
  font-weight: bold;
}

.el-table::before {
  height: 0px;
}

::v-deep .el-table__body tr,
::v-deep .el-table__body td {
  padding: 0;
  height: 54px;
}

::v-deep .el-table tbody tr:hover > td {
  background: #FFC0CB !important; /* 淡粉色的悬浮效果 */
}


::v-deep .el-table__header-wrapper {
  border: solid 1px #FAD1E8; /* 浅粉色边框 */
  box-sizing: border-box;
}

/* 表格斑马自定义颜色 */
::v-deep .el-table__row.warning-row {
  background: #FAD1E8; /* 淡粉色背景 */
}

/* 滚动条样式 */
::v-deep .el-table__body-wrapper::-webkit-scrollbar-track {
  background-color: #FAD1E8; /* 滚动条轨迹采用淡粉色 */
}

::v-deep .el-table__body-wrapper::-webkit-scrollbar {
  width: 10px;
  opacity: 0.5;
}

::v-deep .el-table__body-wrapper::-webkit-scrollbar-thumb {
  border-radius: 15px;
  background-color: #F78FB3; /* 滚动条使用较深的粉色 */
}
.girly-title {
  font-family: 'Comic Sans MS', cursive, sans-serif; /* 使用更为圆润的字体 */
  color: #FA7298; /* 柔和的粉红色 */
  background-color: #FFF0F5; /* 淡粉红背景色 */
  padding: 5px 10px; /* 添加一些内边距 */
  border-radius: 15px; /* 圆角边框 */
  box-shadow: 0 4px 6px 0 rgba(254, 121, 199, 0.3); /* 添加柔和的阴影 */
  display: inline-block;
  margin-bottom: 10px; /* 如果需要，添加一些外边距 */
}
/* 修改主要按钮的样式 */
::v-deep .el-button--primary {
  background-color: #FFB6C1; /* 少女风格的背景色 */
  border-color: #FFB6C1; /* 边框颜色与背景色相同 */
  color: #FFFFFF; /* 文字颜色为白色 */
  border-radius: 20px; /* 圆角边框 */
  height: 40px;
  box-shadow: 0 4px 6px rgba(255, 105, 135, .3); /* 添加轻微的阴影以增加深度感 */
}

/* 针对hover状态的样式修改 */
::v-deep .el-button--primary:hover {
  background-color: #FF69B4; /* 鼠标悬停时的背景色变暗 */
  border-color: #FF69B4; /* 鼠标悬停时的边框色 */
}

/* 针对active（点击）状态的样式修改 */
::v-deep .el-button--primary:active {
  background-color: #FF1493; /* 点击时的背景色更暗 */
  border-color: #FF1493; /* 点击时的边框色 */
}
::v-deep .el-dialog {
  background-color: #FFF0F5; /* 更改背景颜色为柔和的灰色 */
  width: 600px; /* 调整对话框宽度 */
  font-weight: bold;
  border-radius: 20px; /* 添加圆角边框，让外观更柔和 */
}

/* 自定义对话框头部的背景和字体颜色 */
::v-deep .el-dialog__header {
  background-color: #FFB6C1; /* 使用柔和的粉红色作为标题栏背景 */
  color:#f06292;
  font-weight: bold;
}

/* 自定义对话框底部按钮的样式 */
::v-deep .el-dialog__footer .el-button {
  background-color: #FFC0CB; /* 按钮背景色为淡粉色 */
 
}/* 修改对话框的背景色、字体颜色、宽度和边框圆角 */


/* 调整遮罩层的背景颜色和透明度 */
::v-deep .el-overlay {
  background-color: rgba(255, 182, 193, 0.5); /* 使用半透明的粉红色作为遮罩层颜色 */
}

/* 自定义对话框中标签(label)的样式 */
::v-deep .el-dialog label {
  color: #FF69B4; /* 使用亮粉色调的字体颜色 */
  font-weight: bold; /* 加粗字体增加强调 */
}
</style>
