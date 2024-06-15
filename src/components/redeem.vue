<template>
  <div>
   <el-button type="primary" icon="el-icon-plus" class="stay" @click="showCreateForm" >添加兑换码</el-button>

    <!-- 创建兑换码表单 -->
    <el-dialog
      title="创建兑换码"
      :visible.sync="createFormVisible"
      width="30%"
      @close="resetForm"
    >
      <el-form :model="formData" label-width="100px" >
        <el-form-item label="商品名称" @click.native="showProductSelection = true">
          <el-input v-model="formData.productName" readonly></el-input>
        </el-form-item>
        <el-form-item label="兑换码数量">
          <el-input-number v-model="formData.count" :min="1" ></el-input-number>
        </el-form-item>
       <el-form-item label="兑换价值">
        <el-tag :type="tag.type">
          <span>{{ formData.price }}￥（元）</span>
        </el-tag>
      </el-form-item>
        <el-form-item label="过期时间">
         <el-date-picker v-model="formData.endTime" type="datetime" placeholder="选择日期时间"></el-date-picker>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="createFormVisible = false">取消</el-button>
        <el-button type="primary" @click="createRedemptionCode">创建兑换码</el-button>
      </div>
    </el-dialog>
    <!-- 商品选择兑换框 -->
    <el-dialog title="选择商品" :visible.sync="showProductSelection" width="60%">
      <el-table :data="products" @row-click="selectProduct">
        <el-table-column prop="name" label="商品名称"></el-table-column>
        <el-table-column prop="imageUrl" label="图片">
          <template slot-scope="scope">
            <img :src="scope.row.imageUrl" style="height: 100px; width: auto;">
          </template>
        </el-table-column>
      </el-table>
      <div slot="footer" class="dialog-footer">
        <el-button @click="showProductSelection = false">关闭</el-button>
      </div>
    </el-dialog>
    <!-- 兑换码列表 -->
    <el-table :data="pagedData" border style="width: 100%">
      <el-table-column label="ID" >
        
        <template slot-scope="scope">
      {{ (currentPage - 1) * pageSize + scope.$index + 1 }}
    </template>
      </el-table-column>
      <el-table-column label="兑换码" prop="code"></el-table-column>
      <el-table-column label="商品名称" prop="productName"></el-table-column>
      <el-table-column label="兑换数量" >1</el-table-column>
      <el-table-column label="兑换价值" prop="price"></el-table-column>
      <el-table-column label="生成时间" prop="startTime"></el-table-column>
      <el-table-column label="过期时间" prop="endTime"></el-table-column>
      <el-table-column label="兑换状态">
        <template v-slot="{ row }">
          <el-tag :type="getRowTagType(row.codeTtatus)">
            {{ row.codeTtatus }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button type="text" @click="editRedemptionCode(scope.row)">编辑</el-button>
          <el-button type="text" @click="deleteRedemptionCode(scope.row)">删除</el-button>
         <el-dropdown @command="command => changeRedemptionStatus(scope.row, command)">
          <el-button type="text">
            改变状态<i class="el-icon-arrow-down el-icon--right"></i>
          </el-button>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item command="待兑换">待兑换</el-dropdown-item>
            <el-dropdown-item command="已兑换">已兑换</el-dropdown-item>
            <el-dropdown-item command="已过期">已过期</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="currentPage"
          :page-sizes="[2, 5, 10, 20]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="redemptionCodes.length">
        </el-pagination>
     <!-- 编辑兑换码对话框 -->
    <el-dialog
        title="编辑兑换码"
        :visible.sync="editDialogVisible"
        width="30%"
        @close="resetForm">
          <el-form :model="formData" label-width="100px">
            <el-form-item label="兑换码">
              <el-input v-model="formData.code"></el-input>
            </el-form-item>
            <el-form-item label="商品名称" @click.native="showProductSelection = true">
          <el-input v-model="formData.productName" readonly></el-input>
        </el-form-item>
            <el-form-item label="兑换数量">
              <el-tag :type="tag.type">
          <span>1</span>
        </el-tag>
            </el-form-item>
           <el-form-item label="兑换价值">
              <el-tag :type="tag.type">
                <span>{{ formData.price }}￥（元）</span>
              </el-tag>
            </el-form-item>
            <el-form-item label="过期时间">
              <el-date-picker v-model="formData.endTime" type="datetime" placeholder="选择日期时间"></el-date-picker>
            </el-form-item>
          </el-form>
          <div slot="footer" class="dialog-footer">
            <el-button @click="editDialogVisible = false">取 消</el-button>
            <el-button type="primary" @click="submitForm">确 定</el-button>
          </div>
        </el-dialog>
  </div>
</template>

<script>
import axios from'axios'
export default {
  data() {
     return {
       tag:{
            type: 'warning'
              },
      formData: {
        code: '',
        productName: '',
        count: 1,
        startTime: '',
        price:null,
      },
      
      products: [],
      createFormVisible: false,
      showProductSelection: false,
      currentPage: 1,
      pageSize: 10,
      redemptionCodes: [], // 这里是从后端获取的全部数据
      pagedData: [],
      editDialogVisible: false
    };
  },
  mounted(){
      this.fetchProducts();
      this.fetchRedeem();
  },
  methods: {
    fetchProducts() {
        axios.post(`${process.env.VUE_APP_API_URL}/api/products`)
          .then(response => {
            this.products = response.data;
            console.log(this.products)
          })
          .catch(error => console.error('There was an error fetching the products:', error));
      },
          showCreateForm() {
            this.createFormVisible = true; // 显示弹出框
          },
    fetchRedeem(){
         axios.post(`${process.env.VUE_APP_API_URL}/api/redeem`)
            .then(response => {
              // this.redemptionCodes = response.data;
              this.redemptionCodes = response.data.reverse();
              this.updatePagedData();
            })
            .catch(error => console.error('There was an error fetching the products:', error));
        },
    createRedemptionCode() {
      // 获取当前时间并格式化为符合服务器期望格式的字符串
      let now = new Date();
      let formattedEndTime = now.getFullYear() + '-' +
                            ('0' + (now.getMonth() + 1)).slice(-2) + '-' +
                            ('0' + now.getDate()).slice(-2) + 'T' +
                            ('0' + now.getHours()).slice(-2) + ':' +
                            ('0' + now.getMinutes()).slice(-2) + ':' +
                            ('0' + now.getSeconds()).slice(-2) + 'Z'; // 添加 'Z' 表示UTC时区
      let newCode = {
        price:this.formData.price,
        productName:this.formData.productName,
        codeCount:this.formData.count,
        startTime:formattedEndTime,
        endTime:this.formData.endTime,
        codeTtatus: '待兑换'
      };
      console.log(newCode)
       axios.post(`${process.env.VUE_APP_API_URL}/api/redeem/add`, newCode)
          .then(response => {
            // 成功后的处理，例如更新界面显示的兑换码列表
            this.fetchRedeem();
            this.editDialogVisible = false; // 关闭编辑对话框
          })
          .catch(error => {
            // 处理错误情况，例如显示错误消息给用户
            console.error('Error editing redemption code:', error);
          });
      this.createFormVisible = false;
      this.resetForm();
    },
    selectProduct(row) {
      this.formData.productName = row.name;
      this.formData.price=row.price;
      this.showProductSelection = false;
    },
    editRedemptionCode(code) {
      // 将编辑兑换码对话框设置为可见状态
      this.editDialogVisible = true;
      // 将表单数据设置为要编辑的兑换码数据
      this.formData = { ...code,
      codeCount:1, 
      };
    },
    submitForm() {
        console.log(this.formData);  // 直接使用 this.formData 来记录或处理表单数据
        axios.post(`${process.env.VUE_APP_API_URL}/api/redeem/update`, this.formData)
            .then(response => {
              this.fetchRedeem();  // 成功后更新数据
              this.editDialogVisible = false; // 关闭编辑对话框
            })
            .catch(error => {
              console.error('Error editing redemption code:', error);
            });
        this.resetForm();  // 重置表单
      },
    resetForm() {
      // 重置表单数据
      this.formData = {
        code: '',
        productName: '',
        count: 1,
        startTime: '',
        price:null,
        endTime:'',
      };
    },
     getRowTagType(status) {
    if (status === '待兑换') {
      return 'success';
    } else if (status === '已兑换') {
      return 'danger';
    } else if (status === '已过期') {
      return 'warning';
    } else {
      return 'info';
    }
  },
    deleteRedemptionCode(code) {
      // 实现删除兑换码的逻辑
      this.formData = { ...code,
      codeCount:1, 
      };
      console.log(this.formData);
      axios.post(`${process.env.VUE_APP_API_URL}/api/redeem/delete`, this.formData)
            .then(response => {
              this.fetchRedeem();  // 成功后更新数据
            })
            .catch(error => {
              console.error('Error editing redemption code:', error);
            });
        this.resetForm();
    },
    updatePagedData() {
      const start = (this.currentPage - 1) * this.pageSize;
      const end = start + this.pageSize;
      this.pagedData = this.redemptionCodes.slice(start, end);
    },
    handleCurrentChange(newPage) {
      this.currentPage = newPage;
      this.updatePagedData();
    },
    handleSizeChange(newSize) {
      this.pageSize = newSize;
      this.updatePagedData();
    },
    changeRedemptionStatus(code, selectedStatus) {
    // 更新兑换码的状态
    this.formData = { ...code, codeTtatus: selectedStatus };
    console.log('Updated status:', this.formData);
     axios.post(`${process.env.VUE_APP_API_URL}/api/redeem/update`, this.formData)
            .then(response => {
              this.fetchRedeem();  // 成功后更新数据
              this.editDialogVisible = false; // 关闭编辑对话框
              this.resetForm()
            })
            .catch(error => {
              console.error('Error editing redemption code:', error);
            });
    // 这里可以添加发送请求到服务器的代码，更新状态
}
  }
};
</script>
<style scoped>
.stay{
  float: left;
  margin-right: 10px;
  margin-bottom: 10px;
}
::v-deep .el-table,
::v-deep .el-table__expanded-cell {
  background-color: #FFF0F5;
  color: #F78FB3; /* 柔和的粉色 */
  font-size: 12px; /* 稍微减小字体大小以适应更柔和的风格 */
}

::v-deep .el-table th,
::v-deep .el-table tr,
::v-deep .el-table td {
  background-color: #FFF0F5;
  border: solid 1px #FFFFE0; 
  color: #F78FB3;
  font-size: 16px;
  height: 5px;
  font-weight: bold;
}
::v-deep .el-table tbody tr:hover > td {
  background: #F0F8FF !important; /* 淡粉色的悬浮效果 */
}
::v-deep .el-table__header-wrapper {
  border: solid 2px #EEDC82; /* 浅粉色边框 */
  box-sizing: border-box;
}
/* 修改el-form的整体背景色和内边距 */
::v-deep .el-form {
  background-color: #FFF0F5; /* 淡粉红背景色 */
  padding: 20px;
  border-radius: 8px; /* 轻微的圆角边框 */
  box-shadow: 0 2px 12px 0 rgba(0,0,0,0.1); /* 细微的阴影增添层次感 */
}

/* 自定义输入框样式 */
::v-deep .el-form .el-input__inner,
::v-deep .el-form .el-select .el-input__inner {
  border-color: #FFC0CB; /* 边框颜色 */
  background-color: #FFFFFF; /* 背景色 */
  font-weight: bold;
  color: #FF69B4; /* 输入文字颜色 */
}

/* 当输入框获得焦点时的样式 */
::v-deep .el-form .el-input__inner:focus,
::v-deep .el-form .el-select .el-input__inner:focus {
  border-color: #FF69B4; /* 焦点状态下的边框颜色 */
  box-shadow: 0 0 5px #FF69B4; /* 添加细微的发光效果 */
}

/* 修改标签（label）的样式 */
::v-deep .el-form label {
  color: #FF1493; /* 标签字体颜色 */
  font-weight: bold; /* 加粗字体 */
}

/* 自定义按钮样式 */
::v-deep .el-form .el-button {
  background-color: #FFB6C1; /* 按钮背景色 */
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
.el-button {
  border-radius: 20px;
  font-weight: bold;
  background-image: linear-gradient(120deg, #f6d365 0%, #fda085 100%);
  border: none;
  color: white;
}
::v-deep .el-button:active {
  background-color: #EE1289;
  color:white;
}
::v-deep .el-button:hover {
  border-radius: 20px;
  font-weight: bold;
  color:yellow;
  /* background-image: linear-gradient(120deg, #f6d365 0%, #fda085 100%); */
  background-color: #EE1289;
  border: none;
}
::v-deep .el-form .el-button:active {
  background-color: #FF1493;
  border-color: #FF1493;
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
 
}

/* 调整遮罩层的背景颜色和透明度 */
::v-deep .el-overlay {
  background-color: rgba(255, 182, 193, 0.5); /* 使用半透明的粉红色作为遮罩层颜色 */
}

/* 自定义对话框中标签(label)的样式 */
::v-deep .el-dialog label {
  color: #FF69B4; /* 使用亮粉色调的字体颜色 */
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