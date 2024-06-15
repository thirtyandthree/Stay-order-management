<template>
  <div>
    <el-tabs type="border-card" :stretch="false">
      <el-tab-pane label="用户排行">
          <notice></notice>
        <div style="margin: 10px 0;">
          <el-select v-model="time" placeholder="请选择时间" style="width: 200px;" :popper-append-to-body="false">
            <el-option v-for="item in timeType" :key="item" :label="item" :value="item" />
          </el-select>
          <el-select v-model="program" placeholder="请选择节目类型" style="width: 200px; margin-left: 20px;" :popper-append-to-body="false">
            <el-option v-for="item in programType" :key="item" :label="item" :value="item" />
          </el-select>
          <el-select v-model="topRank" placeholder="请选择Top" style="width: 200px; margin-left: 20px;" :popper-append-to-body="false">
            <el-option v-for="item in TopSelect" :key="item" :label="item" :value="item" />
          </el-select>
        </div>
       <el-table :data="pagedTableList"  style="width: 100%;height:500px;margin-top:10px;" :cell-style="{ textAlign: 'center' }" align="center">
         <el-table-column label="排名" width="240" :align="'center'">
              <template v-slot:default="{ $index }">
                <div>
                  {{ $index + 1+pagination.pageSize*(pagination.currentPage-1)*pagination.pageSize }}
                  <img v-if="pagination.currentPage === 1 && $index === 0" src="https://qiniu.staykoi.asia/2024-2-20/%E5%A5%96%E6%9D%AF%20%283%29.svg" alt="第一名图标" style="width: 110px; height: 110px;">
                  <img v-if="pagination.currentPage === 1 && $index === 1" src="https://qiniu.staykoi.asia/2024-2-20/%E5%A5%96%E6%9D%AF%20%281%29.svg" alt="第二名图标" style="width: 80px; height: 80px;">
                  <img v-if="pagination.currentPage === 1 && $index === 2" src="https://qiniu.staykoi.asia/2024-2-20/%E5%A5%96%E6%9D%AF%20%282%29.svg" alt="第三名图标" style="width: 70px; height: 70px;">
                </div>
              </template>
            </el-table-column>
          <el-table-column label="用户名" width="240" :align="'center'">
            <template #default="{ row }">
              <div>{{ row.userName }}</div>
            </template>
          </el-table-column>
          <el-table-column label="用户名" width="240" :align="'center'">
              <template #default="{ row }">
                <div>{{ row.gender === 'male' ? '男' : '女' }}
                      <img v-if="row.gender === 'male'" src="https://qiniu.staykoi.asia/2024-2-20/%E7%99%BD%E9%A2%86%E7%94%B7%E5%A3%AB%E7%94%B7%E4%BA%BA.svg" alt="男" style="width: 70px; height: 70px;">
                      <img v-else-if="row.gender === 'female'" src="https://qiniu.staykoi.asia/2024-2-20/%E5%A5%B3%E8%80%81%E5%B8%88.svg" alt="女" style="width: 70px; height: 70px;">
                </div>
              </template>
            </el-table-column>
          <el-table-column label="消费金额" width="240" :align="'center'">
            <template #default="{ row }">
              <div>{{ row.totalSpending }}</div>
            </template>
          </el-table-column>
           <el-table-column label="最近日期" width="240" :align="'center'">
            <template #default="{ row }">
              <div>{{ row.date }}</div>
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
      </el-tab-pane>
    </el-tabs>
    
  </div>
</template>

<script>
import axios from 'axios';
import notice from '@/components/notice.vue'
export default {
  components: { notice },
  name: 'vuetest',
  data() {
    return {
      time: '',
      program: '',
      topRank: '',
      timeType: ['日','周','月'],
      programType: ['全部','电影','电视剧','综艺'],
      TopSelect: ['Top10','Top100'],
      columnDate: [],
      columnDateType: [],
      emptyData: [''],
      tableList: [],
      pagination: {
        currentPage: 1,
        pageSize: 3,
      },
    }
  },
   mounted() {
    this.fetchData();},
    computed: {
    notice,
    pagedTableList() {
      const start = (this.pagination.currentPage - 1) * this.pagination.pageSize;
      const end = start + this.pagination.pageSize;
      return this.tableList.slice(start, end);
    }
  },
  methods: {
      // fetchData() {
      //       axios.get('http://localhost:8081/api/userChart') // Assuming the API endpoint is '/api/get_user_chart_data'
      //         .then(response => {
      //           // Assuming the response data structure is like { columnDate: [], columnDateType: [] }
      //           this.columnDate = response.data.columnDate;
      //           this.columnDateType = response.data.columnDateType;
      //           console.log('kkk')
      //         })
      //         .catch(error => {
      //           console.error('Error fetching data:', error);
      //         });
      //     },
      fetchData() {
      axios.get(`${process.env.VUE_APP_API_URL}/api/userChart/info`) // 使用你的实际请求URL
        .then(response => {
          this.tableList = response.data;
          console.log(this.tableData)
          // 如果需要对数据进行进一步处理，可以在这里添加代码
        })
        .catch(error => {
          console.error("There was an error fetching the user records:", error);
        });
    },
       handlePageChange(newPage) {
      this.pagination.currentPage = newPage;
    },   
  }
}
</script>
<style scoped>
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
/* 使用温柔的背景图，提供了一个动态的GIF背景 */
::v-deep .el-input__wrapper {
  background: url('https://www.freeimg.cn/i/2024/02/09/65c642654f372.gif') 50% center / cover no-repeat;
}

/* 占位符使用柔和的粉色，增加字体大小并居中对齐 */
::v-deep .el-input__inner::placeholder {
  color: #F78FB3;
  font-size: 14px;
  text-align: center;
}

/* 隐藏所有可能分散注意力的边框线 */
::v-deep .el-select {
  --el-select-input-focus-border-color: transparent !important;
}

::v-deep .el-input__wrapper {
  box-shadow: none !important;
  background-color: #FFF0F5;
}
::v-deep .el-select  .el-input__inner {
    font-weight: bold;
    background-color: #FFF0F5;
}
::v-deep .el-select-dropdown__item  {
  background-color: #F78FB3;
  border: 1px solid #FFEC8B !important;
}
::v-deep .el-select-dropdown__item.hover{
    background-color: #EEDC82;
}
::v-deep el-tab-pane {
    color: #FFDEAD;  
    cursor: pointer;

}  
::v-deep .el-tabs__content {
    overflow: visible;
    background-color: #F78FB3;
  }  
  ::v-deep .el-table__body-wrapper {
  background-color:#EEE9BF !important;
}
</style>