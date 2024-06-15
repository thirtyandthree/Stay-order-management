<template>
  <div>
    <el-breadcrumb separator-custom-class="el-icon-pink-heart">
          <el-breadcrumb-item :to="{ path: '/home' }" class='bread'>
            <i class="el-icon-s-home" style='font-size: 18px;'></i>
            <span style='color:#FFC1C1;font-size:18px;'>首页</span>
          </el-breadcrumb-item>
          <el-breadcrumb-item>
            <i class="el-icon-s-goods" style='font-size: 18px;'></i>
            <span style='color:#FFC1C1;font-size:18px;'>用户管理</span>
          </el-breadcrumb-item>
          <el-breadcrumb-item>
            <i class="el-icon-user-solid" style='font-size: 18px;'></i>
           <span style='color:#FFC1C1;font-size:18px;'>用户列表</span>
          </el-breadcrumb-item>
    </el-breadcrumb>
    <!-- 用户列表卡片 -->
    <el-card class="box-card">
      <el-form :inline="true" :model="formInline" class="demo-form-inline">
        <el-form-item label="地址" label-width="70px">
          <el-cascader
        size="large"
        :options="pcaTextArr"
        v-model="selectedOptions">
      </el-cascader>
        </el-form-item>
         
        <el-form-item label="用户名" label-width="70px">
          <el-input clearable v-model="formInline.user" placeholder="请输入用户名"></el-input>
        </el-form-item>
        <el-form-item label="邮箱" label-width="70px">
          <el-input clearable v-model="formInline.email" placeholder="请输入用户名"></el-input>
        </el-form-item>
        <el-form-item label-width="70px">
          <el-radio v-model="formInline.radio" label="1">备选项</el-radio>
          <el-radio v-model="formInline.radio" label="2">备选项</el-radio>
          <el-radio v-model="formInline.radio" label="3">备选项</el-radio>
          <!--        <el-button type="primary" @click="onSubmit">查询</el-button>-->
        </el-form-item>
       <el-form-item label="性别" label-width="70px">
            <el-select v-model="formInline.gender" clearable placeholder="请选择性别">
              <el-option label="男" value="male">
                <i class="el-icon-male" style="color: #409EFF;font-size:21px;"></i> 男
              </el-option>
              <el-option label="女" value="female">
                <i class="el-icon-female" style="color: #FF69B4;font-size:19px;"></i> 女
              </el-option>
            </el-select>
          </el-form-item>

        <el-form-item label="联系号码" label-width="70px">
          <el-input clearable v-model="formInline.phone" placeholder="请输入昵称"></el-input>
        </el-form-item>
        <el-form-item style="margin-left: 10px">
          <el-button icon="el-icon-refresh" @click="reset">重置</el-button>
          <el-button type="primary" icon="el-icon-search" @click="query">查询</el-button>
          <el-button type="success" icon="el-icon-plus" @click="addUser">添加</el-button>
          <el-button type="warning" icon="el-icon-download" @click="exportData">导出</el-button>
        </el-form-item>
      </el-form>
      
      <div class="table-container">
      <!-- 表格内容显示区域   -->
      <el-table :data="paginatedData" border style="width: 100%; background-color:#FFF0F5;">
          <el-table-column prop="date" label="日期" width="180"></el-table-column>
          <el-table-column prop="name" label="用户名" width="180"></el-table-column>
          <el-table-column prop="address" label="地址" width="180"></el-table-column>
          <el-table-column prop="email" label="邮箱" width="200"></el-table-column>
          <el-table-column prop="gender" label="性别" width="100"></el-table-column>
          <el-table-column prop="phone" label="联系号码" width="200"></el-table-column>

          <!-- 新增操作列 -->
          <el-table-column label="操作" width="180">
            <template slot-scope="scope">
              <el-button size="mini" @click="editRow(scope.row)">编辑</el-button>
              <el-button size="mini" type="danger" @click="deleteRow(scope.$index, scope.row)">删除</el-button>
            </template>
          </el-table-column>
        </el-table>
      </div>
      <!--   分页 -->
     <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="currentPage"
          :page-sizes="[6, 8,12, 15, 20]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="tableData.length">
        </el-pagination>


    </el-card>
    <el-dialog :visible.sync="dialogVisible" title="编辑数据">
        <el-form :model="currentRow">
          <el-form-item label="日期" :label-width="'100px'">
          <el-date-picker
                v-model="currentRow.date"
                type="date"
                placeholder="选择日期"
                format="yyyy-MM-dd"
                value-format="yyyy-MM-dd"
                :picker-options="{firstDayOfWeek: 1}"
                autocomplete="off">
              </el-date-picker>
          </el-form-item>
          <el-form-item label="用户名" :label-width="formLabelWidth">
            <el-input v-model="currentRow.name" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="地址" :label-width="formLabelWidth">
            <el-input v-model="currentRow.address" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="邮箱" :label-width="formLabelWidth">
            <el-input v-model="currentRow.email" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="性别" :label-width="formLabelWidth">
            <el-select v-model="currentRow.gender" placeholder="请选择性别">
              <el-option label="男" value="male"></el-option>
              <el-option label="女" value="female"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="联系号码">
            <el-input v-model="currentRow.phone" autocomplete="off"></el-input>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="saveData">保存</el-button>
        </span>
      </el-dialog>

  </div>
</template>
<script>
import { pcaTextArr  } from 'element-china-area-data'
import axios from 'axios'
import store from '../store/index';
export default {
  name: 'Users',
  data () {
    return {
      pcaTextArr,
      formLabelWidth: '100px',
      selectedOptions: [],
      filteredTableData: [], // 新增：存储过滤后的结果
      isFiltered: false, // 新增：是否已过滤的标志
      dialogVisible: false,
      formInline: {
        user: '',
        email: '',
        city: '',
        gender: '',
        phone: '',
      },
      currentRow: {
            date: '',
            name: '',
            address: '',
            email: '',
            gender: '',
            phone: ''
          },
      currentPage: 1, // 当前页码初始化为 1
      pageSize: 6, // 每页显示的记录数初始化为 6
     
      cities: [{
        value: 'Beijing',
        label: '北京'
      }, {
        value: 'Shanghai',
        label: '上海'
      }, {
        value: 'Nanjing',
        label: '南京'
      }, {
        value: 'Chengdu',
        label: '成都'
      }, {
        value: 'Shenzhen',
        label: '深圳'
      }, {
        value: 'Guangzhou',
        label: '广州'
      }],
      value: '',
      tableData: [],
            
    }
  },
  computed: {
  // 计算当前页的数据
 paginatedData() {
    const start = (this.currentPage - 1) * this.pageSize;
    const end = start + this.pageSize;
    // 根据是否过滤了数据来决定使用哪个数据数组
    const data = this.isFiltered ? this.filteredTableData : this.tableData;
    return data.slice(start, end);
  }
},
mounted() {
  this.fetchUsers();
  console.log(store.state.name)
},

  methods: {
   async fetchUsers() {
    try {
      const response = await axios.post(`${process.env.VUE_APP_API_URL}/api/user`);
      // 假设后端返回的数据格式与 `tableData` 兼容
      this.tableData = response.data;

      // 根据日期降序排列，假设 `date` 属性是标准的日期格式
      this.tableData.sort((a, b) => new Date(b.date) - new Date(a.date));
    } catch (error) {
      console.error('There was an error fetching the users:', error);
    }
  },

  query() {
    // 先获取所有用户数据
    let results = [...this.tableData];

    // 根据用户输入条件过滤
    if (this.formInline.user) {
      results = results.filter(item => item.name.includes(this.formInline.user));
    }
    if (this.formInline.email) {
      results = results.filter(item => item.email.includes(this.formInline.email));
    }
    if (this.selectedOptions.length > 0) {
      const selectedAddress = this.selectedOptions.join('/');
      results = results.filter(item => item.address.includes(selectedAddress));
    }
    if (this.formInline.phone) {
      results = results.filter(item => item.phone.includes(this.formInline.phone));
    }

    // 确保过滤后的数据仍按日期降序排列
    results.sort((a, b) => new Date(b.date) - new Date(a.date));

    this.filteredTableData = results;
    this.isFiltered = true;
    this.currentPage = 1; // 重置分页到第一页
  },
    addUser() {
  let address = '';
  if (this.selectedOptions.length > 0) {
    address = this.selectedOptions.map(option => option).join('/');
  }

  // 创建一个新用户对象
  const newUser = {
    date: new Date().toISOString().slice(0, 10),
    name: this.formInline.user,
    address: address,
    email: this.formInline.email,
   // 假设 formInline 是一个包含表单数据的对象
    gender: this.formInline.gender === 'male' ? 'male' : 'female',
    phone: this.formInline.phone
  };

  // 使用Axios发送POST请求到后端
  axios.post(`${process.env.VUE_APP_API_URL}/api/user/add`, newUser)
    .then(response => {
      // 请求成功处理，例如可以将新用户添加到tableData中显示
      this.tableData.push(newUser);
      // 可能还需要处理来自后端的响应
      console.log('User added successfully:', response.data);
    })
    .catch(error => {
      // 请求失败处理
      console.error('There was an error adding the user:', error);
    });

  // 重置表单和选择的地址
  this.formInline = { user: '', email: '', gender: '', phone: '' };
  this.selectedOptions = []; // 重置地址选择
},

  exportData() {
    // 将数据数组转换为字符串
    const dataString = this.tableData.map(item => {
      // 假设item是一个对象，我们要将它的所有属性转换成一行字符串
      // 根据您的实际数据结构调整下面的代码
      return `${item.date}\t${item.name}\t${item.address}\t${item.email}\t${item.gender}\t${item.phone}`;
    }).join('\n');

    // 创建一个Blob对象，它可以将字符串数据转化为一个下载文件
    const blob = new Blob([dataString], { type: 'text/plain;charset=utf-8;' });

    // 创建一个临时的a标签用于下载文件
    let link = document.createElement('a');
    link.href = URL.createObjectURL(blob);
    link.download = 'exported-data.txt'; // 文件名

    // 模拟点击a标签，触发下载
    link.click();

    // 清理临时的下载链接
    URL.revokeObjectURL(link.href);
    document.body.removeChild(link);
  },
  editRow(row) {
  // 设置当前行为编辑状态
  this.currentRow = { ...row };
  this.dialogVisible = true;
},

saveData() {
  // 创建请求体，包含当前行的所有数据
  const requestBody = {
    date: this.currentRow.date,
    name: this.currentRow.name,
    address: this.currentRow.address,
    email: this.currentRow.email,
    gender: this.currentRow.gender,
    phone: this.currentRow.phone,
  };

  // 使用axios发送POST请求到后端API
  axios.post(`${process.env.VUE_APP_API_URL}/api/user`, requestBody)
    .then(response => {
      // 处理响应
      console.log(response.data);
      // 更新tableData中的数据
      const index = this.tableData.findIndex(item => item.id === this.currentRow.id);
      if (index !== -1) {
        this.$set(this.tableData, index, this.currentRow);
      }
      this.fetchUsers();
      // 显示成功消息或更新视图状态
    })
    .catch(error => {
      // 处理错误
      console.error('There was an error!', error);
      // 显示错误消息
    });

  // 关闭对话框
  this.dialogVisible = false;
},

  deleteRow(index, row) {
  // 步骤 1: 确认删除操作
  if (confirm(`Are you sure you want to delete the user ${row.name}?`)) {
    // 步骤 2: 发送删除请求到后端，使用Name作为标识
    axios.post(`${process.env.VUE_APP_API_URL}/api/user/delete`, { Name: row.name })
      .then(response => {
        // 步骤 3: 根据后端响应更新前端状态
        console.log('Delete response:', response.data);
        this.tableData.splice(index, 1); // 从tableData中删除该行
      })
      .catch(error => {
        console.error('There was an error!', error);
        alert('Failed to delete the item.'); // 显示删除失败消息
      });
  }
},
    reset(){
          this.formInline = { user: '', email: '', gender: '', phone: '' };
          this.selectedOptions = []; // 重置地址选择
          },
    onSubmit () {
      console.log('submit!')
    },
      handleSizeChange(newSize) {
    this.pageSize = newSize;
  },
  handleCurrentChange(newPage) {
    this.currentPage = newPage;
  },
  }
}

</script>
<style scoped>
/* 卡片样式 */
.el-card {
  background-color: #fce4ec; /* 淡粉背景 */
  box-shadow: 0 8px 16px 0 rgba(244,143,177,.2); /* 更柔和的阴影 */
}
.table-container {
  height: 400px; /* 或者任何你需要的高度 */
  overflow-y: auto; /* 添加垂直滚动条 */
}
/* 面包屑样式 */
.el-breadcrumb i{
   color: #f06292; /* 粉红色 */
  height:20px; /* 字体大小 */
}
/* 分页组件样式 */
.el-pagination .el-pager li:not(.active) {
  background-color: #f9dada;
}
.el-pagination .el-pager li.active {
  background-color: #f783ac;
  color: white;
}

.el-button {
  margin-top: 10px; /* 为按钮添加一点间距 */
  transition: all .3s ease; /* 平滑的过渡效果 */
}

/* 分页控件样式 */
.el-pagination .el-pager li:not(.active) {
  color: #ad1457; /* 非激活页码颜色 */
}

.el-pagination .el-pager li.active {
  background-color: #f48fb1; /* 激活页码背景色 */
}

/* 扩展：添加一些轻微的动画来增加互动性 */
.el-button,
.el-input__inner,
.el-select .el-input__inner {
  transition: transform .3s ease, box-shadow .3s ease; /* 平滑的变形和阴影效果 */
}

.el-button:hover,
.el-input__inner:hover,
.el-select .el-input__inner:hover {
  transform: translateY(-2px); /* 鼠标悬浮时轻微上浮 */
  box-shadow: 0 4px 6px rgba(0,0,0,0.1); /* 添加阴影 */
}
::v-deep .el-table,
::v-deep .el-table__expanded-cell {
  background-color: transparent;
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
/* 修改对话框的背景色、字体颜色、宽度和边框圆角 */
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
  color: #FF69B4; /* 输入文字颜色 */
  font-weight: bold;
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
  
  color: #FFDEAD; /* 按钮字体颜色 */
  border-radius: 20px; /* 圆润的按钮边框 */
  font-weight: bold; /* 字体加粗 */
}

/* 按钮hover和active状态样式 */
::v-deep .el-form .el-button:hover {
  background-color: #FF69B4;
  border-color: #EEC900;
}


</style>
