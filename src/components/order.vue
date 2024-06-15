<template>
  <div class="table-wrapper">
    <h1 class="table-title">Stay订单数据表</h1>
    <el-table
      :data="currentPageData"
      style="width: 100%;"
      :row-class-name="tableRowClassName"
      @sort-change="handleSortChange"
      @filter-change="handleFilterChange">
      <el-table-column
        prop="date"
        label="日期"
        width="180"
        sortable>
      </el-table-column>
      <el-table-column
        prop="name"
        label="姓名"
        width="180"
        sortable>
      </el-table-column>
      <el-table-column
        prop="address"
        label="地址"
        filters="['上海', '北京', '深圳']"
        filter-method="filterAddress">
      </el-table-column>
      <el-table-column
        prop="gender"
        label="性别"
        width="100"
        :filters="[{ text: '男', value: 'male' }, { text: '女', value: 'female' }]"
        filter-method="filterGender">
      </el-table-column>
      <el-table-column
        prop="age"
        label="年龄"
        width="100"
        sortable>
      </el-table-column>
      <el-table-column
        prop="email"
        label="Email"
        min-width="200">
      </el-table-column>
      <el-table-column
        prop="status"
        label="状态"
        width="100">
        <template slot-scope="scope">
          <span v-if="scope.row.status === 'ordered'" class="status-ordered">已下单</span>
          <span v-else-if="scope.row.status === 'paid'" class="status-paid">已付款</span>
          <span v-else-if="scope.row.status === 'completed'" class="status-completed">已完成</span>
          <span v-else>未知</span>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
      @current-change="handleCurrentChange"
      :current-page.sync="currentPage"
      :page-size="pageSize"
      layout="prev, pager, next"
      :total="tableData.length">
    </el-pagination>
  </div>
</template>

<style scoped>
.table-wrapper {
  padding: 20px;
  background-color: #fce4ec; /* 淡粉色背景 */
  border-radius: 16px;
  box-shadow: 0 2px 5px 0 rgba(244, 143, 177, 0.5); /* 粉色阴影 */
}

.table-title {
  text-align: center;
  font-size: 28px;
  color: #f06292; /* 鲜艳粉色 */
  font-family: 'Comic Sans MS', 'Marker Felt', sans-serif;
  margin-bottom: 20px;
}

.el-table {
  border: 1px solid #f8bbd0; /* 粉色边框 */
  background-color: #f06292;
  color:burlywood ;/* 黑色文字颜色 */
  font-family: 'Microsoft YaHei', sans-serif; /* 使用更少女的字体 */
}

.el-table-column {
  text-align: center;
}

.el-table th,
.el-table td {
  padding: 12px 0; /* 增加单元格内边距 */
}

.el-table th {
  background-color: #f8bbd0; /* 粉红色表头背景 */
  color: #f06292; /* 鲜艳粉色表头文字 */
  font-weight: bold; /* 表头文字加粗 */
}

.el-table .cell {
  padding-left: 10px; /* 增加单元格左内边距 */
  padding-right: 10px; /* 增加单元格右内边距 */
}

.el-pagination {
  margin-top: 20px;
  text-align: center;
}

.status-ordered {
  color: #827717;
  font-weight: bold;
}

.status-paid {
  color: #c62828;
  font-weight: bold;
}

.status-completed {
  color: #1b5e20;
  font-weight: bold;
}
</style>

<script>
export default {
  data() {
    return {
      tableData: [
        {
          date: '2016-05-02',
          name: '王小虎',
          address: '上海市普陀区金沙江路 1518 弄',
          gender: 'male',
          age: 24,
          email: 'xiaohuwang@example.com',
          status: 'ordered'
        },
        {
          date: '2016-05-04',
          name: '李小妹',
          address: '北京市海淀区苏州街 1 号院',
          gender: 'female',
          age: 19,
          email: 'xiaomeiliu@example.com',
          status: 'paid'
        },
        {
          date: '2016-05-01',
          name: '张大力',
          address: '深圳市福田区车公庙社区',
          gender: 'male',
          age: 45,
          email: 'dailizhang@example.com',
          status: 'completed'
        },
        {
          date: '2016-05-03',
          name: '陈小花',
          address: '上海市普陀区金沙江路 1518 弄',
          gender: 'female',
          age: 32,
          email: 'xiaohuachen@example.com',
          status: 'ordered'
        },
        {
          date: '2016-05-05',
          name: '王小明',
          address: '北京市朝阳区望京街道',
          gender: 'male',
          age: 28,
          email: 'xiaomingwang@example.com',
          status: 'paid'
        },
        {
          date: '2016-05-06',
          name: '李小兰',
          address: '深圳市福田区车公庙社区',
          gender: 'female',
          age: 22,
          email: 'xiaolanli@example.com',
          status: 'completed'
        },
        {
          date: '2016-05-07',
          name: '张小红',
          address: '上海市普陀区金沙江路 1518 弄',
          gender: 'female',
          age: 35,
          email: 'xiaohongzhang@example.com',
          status: 'ordered'
        },
        {
          date: '2016-05-08',
          name: '陈小涛',
          address: '北京市海淀区苏州街 1 号院',
          gender: 'male',
          age: 41,
          email: 'xiaotaochen@example.com',
          status: 'completed'
        }
      ],
      currentPage: 1,
      pageSize: 6
    }
  },
  computed: {
    currentPageData() {
      const start = (this.currentPage - 1) * this.pageSize;
      const end = start + this.pageSize;
      return this.tableData.slice(start, end);
    }
  },
  methods: {
    tableRowClassName({ row, rowIndex }) {
      if (row.age < 18) {
        return 'danger-row';
      } else if (row.age < 30) {
        return 'warning-row';
      } else if (row.status === 'ordered') {
        return 'ordered-row';
      } else if (row.status === 'paid') {
        return 'paid-row';
      } else if (row.status === 'completed') {
        return 'completed-row';
      } else {
        return 'success-row';
      }
    },
    handleSortChange(column) {
      console.log('排序', column.prop, column.order);
    },
    handleFilterChange(filters) {
      console.log('筛选', filters);
    },
    filterAddress(value, row) {
      return row.address.includes(value);
    },
    filterGender(value, row) {
      return row.gender === value;
    },
    handleCurrentChange(val) {
      this.currentPage = val;
    }
  }
}
</script>