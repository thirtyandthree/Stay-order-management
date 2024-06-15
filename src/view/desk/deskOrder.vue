<template>
  <div class="table-reservation">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>餐桌预订</span>
      </div>
      <el-form :model="reservationForm" ref="reservationForm" label-width="80px">
        <el-form-item label="姓名" prop="name">
          <el-input v-model="reservationForm.name" placeholder="请输入姓名"></el-input>
        </el-form-item>
        <el-form-item label="预订人数" prop="numOfPeople">
          <el-input-number v-model="reservationForm.numOfPeople" :min="1" :max="20" :precision="0"></el-input-number>
        </el-form-item>
         <el-form-item label="预订桌号" prop="tableId">
          <el-input-number v-model="reservationForm.tableId" :min="1" :max="20" :precision="0"></el-input-number>
        </el-form-item>
        <el-form-item label="预订时间" prop="reservationTime">
          <el-date-picker
            v-model="reservationForm.reservationTime"
            type="datetime"
            placeholder="选择日期时间"
            :picker-options="pickerOptions">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input type="textarea" v-model="reservationForm.remarks" placeholder="请输入备注"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="submitReservationForm">预订</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <!-- 预订状态显示 -->
   <div class="reservation-status">
  <el-card class="box-card">
    <div slot="header" class="clearfix">
      <span>预订状态</span>
    </div>
   <el-table :data="paginatedData" style="width: 100%">
      <el-table-column prop="name" label="姓名"></el-table-column>
      <el-table-column prop="numOfPeople" label="预订人数"></el-table-column>
      <el-table-column prop="reservationTime" label="预订时间"></el-table-column>
      <el-table-column prop="remarks" label="备注" width="180"></el-table-column>
      <el-table-column prop="tableId" label="桌子号" width="180"></el-table-column>
      <el-table-column prop="status" label="状态" width="180">
        <template slot-scope="scope">
          <el-tag :type="scope.row.status === '已预订' ? 'warning' : 'success'">{{ scope.row.status }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="100">
              <template slot-scope="scope">
                <el-button type="danger" size="mini" @click="deleteReservation(scope.row)">删除</el-button>
              </template>
            </el-table-column>

    </el-table>
    <!-- 添加翻页组件 -->
    <el-pagination
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="currentPage"
      :page-sizes="[6,10, 20, 30, 50]"
      :page-size="pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      :total="total">
    </el-pagination>
  </el-card>
</div>

  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'TableReservation',
  data() {
    return {
      reservationForm: {
        name: '',
        numOfPeople: 1,
        reservationTime: '',
        remarks: '',
        tableId: ''
      },
      // 假设初始加载时没有过滤
      isFiltered: false,
      filteredTableData: [], // 如果有过滤功能，过滤后的数据将存储在这里
      tableData: [], // 从后端获取的完整数据列表
      currentPage: 1,
      pageSize: 6,
      pickerOptions: {
        disabledDate(time) {
          return time.getTime() < Date.now() - 8.64e7; // 禁止选择今天之前的日期
        }
      }
    };
  },
  computed: {
    // 计算当前页的数据
    paginatedData() {
      const start = (this.currentPage - 1) * this.pageSize;
      const end = start + this.pageSize;
      // 根据是否过滤了数据来决定使用哪个数据数组
      const data = this.isFiltered ? this.filteredTableData : this.tableData;
      return data.slice(start, end);
    },
    // 总数据条目数，根据是否过滤数据来决定
    total() {
      return this.isFiltered ? this.filteredTableData.length : this.tableData.length;
    }
  },
  methods: {
    async submitReservationForm() {
  if (this.$refs.reservationForm.validate()) {
    const reservation = {
      name: this.reservationForm.name,
      numOfPeople: this.reservationForm.numOfPeople,
      reservationTime: this.reservationForm.reservationTime,
      remarks: this.reservationForm.remarks,
      tableId: this.reservationForm.tableId, // 添加预订桌号
      status: '已预订'
    };

    try {
      // 发送 POST 请求将预订信息发送给后端
      await axios.post(`${process.env.VUE_APP_API_URL}/api/reservation/add`, reservation);
      // 在添加到列表之前确保列表已经被正确初始化
      if (!this.reservationList) {
        this.reservationList = []; // 如果未初始化，将其初始化为空数组
      }
      this.reservationList.push(reservation); // 将新的预订信息添加到前端列表
      this.resetForm();
      this.fetchReservationList();
      this.$message.success('预订成功');
    } catch (error) {
      console.error('预订失败:', error);
      this.$message.error('预订失败，请稍后重试');
    }
  }
},

    resetForm() {
      this.$refs.reservationForm.resetFields();
    },
    async fetchReservationList() {
      try {
        const response = await axios.get(`${process.env.VUE_APP_API_URL}/api/reservation`);
         this.tableData = response.data.reverse(); // 假设后端直接返回整个列表数据
        // 当数据更新时，重置当前页为1
        this.currentPage = 1;
      } catch (error) {
        console.error('获取预订列表失败:', error);
        this.$message.error('获取预订列表失败，请稍后重试');
      }
    },
    handleSizeChange(val) {
      this.pageSize = val;
    },
    handleCurrentChange(val) {
      this.currentPage = val;
    },
    async deleteReservation(row) {
    try {
      // 发送 POST 请求将预订记录信息发送给后端进行删除
      await axios.post(`${process.env.VUE_APP_API_URL}/api/reservation/delete`, { reservationId: row.id });
      this.fetchReservationList(); // 重新获取预订列表数据
      this.$message.success('预订记录删除成功');
    } catch (error) {
      console.error('删除失败:', error);
      this.$message.error('删除失败，请稍后重试');
    }
  }
  },
  created() {
    // 组件创建时立即获取预订列表数据
    this.fetchReservationList();
  }
};
</script>


<style scoped>
.table-reservation .reservation-status {
  margin-top: 20px;
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
