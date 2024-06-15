<template>
  <!-- 这是main内容 -->
  <div>
    <!-- 面包屑导航-->
    <el-breadcrumb separator-custom-class="el-icon-pink-heart">
      <el-breadcrumb-item :to="{ path: '/home' }" class="bread">
        <i class="el-icon-s-home" style="font-size: 18px"></i>
        <span style="color: #ffc1c1; font-size: 18px">首页</span>
      </el-breadcrumb-item>
      <el-breadcrumb-item>
        <i class="el-icon-s-goods" style="font-size: 18px"></i>
        <span style="color: #ffc1c1; font-size: 18px">订单管理</span>
      </el-breadcrumb-item>
      <el-breadcrumb-item>
        <i class="el-icon-user-solid" style="font-size: 18px"></i>
        <span style="color: #ffc1c1; font-size: 18px">订单列表</span>
      </el-breadcrumb-item>
    </el-breadcrumb>

    <el-card class="girl-style-card">
      <el-row :gutter="20">
        <el-col :span="8">
          <el-input
            placeholder="请输入订单编号"
            v-model="queryInfo.query"
            clearable
            @clear="getOrderList"
          >
            <template #append>
              <el-button
                icon="el-icon-search"
                @click="getOrderList"
                class="search-button"
              ></el-button>
            </template>
          </el-input>
        </el-col>
        <el-button
          type="danger"
          class="batch-delete-button"
          @click="handleBatchDelete"
          >批量删除</el-button
        >
      </el-row>

      <!--订单列表-->
      <el-table
        :data="displayedProducts"
        @selection-change="handleSelectionChange"
        border
        stripe
        @expand-change="getOrderDetail"
        style="margin-top: 10px"
      >
        <el-table-column type="selection" width="40"></el-table-column>
        <el-table-column label="明细" type="expand">
          <template slot-scope="scope">
            <!-- 订单下明细的商品列表-->
            <el-table :data="scope.row.detail" border stripe="">
              <el-table-column
                label="封面"
                width="100px"
                header-align="center"
                align="center"
              >
                <template slot-scope="sc">
                  <el-popover placement="top-start" trigger="hover">
                    <img
                      :src="sc.row.url"
                      style="width: 150px; height: 150px"
                    />
                    <img
                      :src="sc.row.url"
                      slot="reference"
                      style="width: 50px; height: 50px"
                    />
                  </el-popover>
                </template>
              </el-table-column>
              <el-table-column
                label="商品名称"
                prop="goods_name"
              ></el-table-column>
              <el-table-column
                label="商品重量"
                prop="goods_weight"
                width="100px"
              ></el-table-column>
              <el-table-column
                label="商品数量"
                prop="goods_number"
                width="100px"
              ></el-table-column>
              <el-table-column
                label="商品价格(元)"
                prop="goods_price"
                width="100px"
              ></el-table-column>
              <el-table-column
                label="总价"
                prop="goods_total_price"
                width="100px"
              ></el-table-column>
            </el-table>
          </template>
        </el-table-column>
        <el-table-column label="序号" type="index">
          <template slot-scope="scope">
            {{ (currentPage - 1) * pageSize + scope.$index + 1 }}
          </template>
        </el-table-column>
        <el-table-column label="点单用户" prop="order_user"></el-table-column>
        <el-table-column label="订单编号" prop="order_number"></el-table-column>
        <el-table-column
          label="订单价格(元)"
          prop="order_price"
          class="stay"
        ></el-table-column>
        <el-table-column label="是否付款">
          <template slot-scope="scope">
            <el-tag
              effect="dark"
              size="mini"
              type="success"
              v-if="scope.row.pay_status === '1'"
              >已付款</el-tag
            >
            <el-tag effect="dark" size="mini" type="danger" v-else
              >未付款</el-tag
            >
          </template>
        </el-table-column>
        <el-table-column label="是否发货" prop="is_send"></el-table-column>
        <el-table-column label="下单时间" prop="create_time"></el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-tooltip
              effect="dark"
              content="修改订单信息"
              placement="top"
              :enterable="false"
            >
              <el-button
                type="primary"
                size="mini"
                icon="el-icon-edit"
                @click="editOrder(scope.row.order_id)"
              ></el-button>
            </el-tooltip>
            <el-tooltip
              effect="dark"
              content="查看订单进度"
              placement="top"
              :enterable="false"
            >
              <el-button
                type="warning"
                size="mini"
                icon="el-icon-location"
                @click="showProgessDialog(scope.row.order_id)"
              ></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>
      <!-- 分页-->
      <el-pagination
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page="currentPage"
        :page-sizes="[6, 8, 12, 15, 20]"
        :page-size="pageSize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="total"
      >
      </el-pagination>
    </el-card>

    <el-dialog
      title="修改订单信息"
      :visible.sync="addresVisible"
      width="50%"
      @close="addressDialogClosed"
      v-if="currentOrder"
    >
      <el-form
        :model="currentOrder"
        :rules="addressFormRules"
        ref="addressFormRef"
        label-width="100px"
      >
        <el-form-item label="订单编号">
          <el-input v-model="currentOrder.order_number"></el-input>
        </el-form-item>

        <el-form-item label="订单价格(元)">
          <el-input v-model="currentOrder.order_price"></el-input>
        </el-form-item>

        <el-form-item label="是否付款">
          <el-switch
            v-model="currentOrder.pay_status"
            active-color="#13ce66"
            inactive-color="#ff4949"
          ></el-switch>
        </el-form-item>

        <el-form-item label="是否发货">
          <el-switch
            v-model="currentOrder.is_send"
            active-color="#13ce66"
            inactive-color="#ff4949"
          ></el-switch>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="addresVisible = false">取 消</el-button>
        <el-button type="primary" @click="editAddress">确 定</el-button>
      </span>
    </el-dialog>

    <!-- 查看物流进度的对话框-->
    <el-dialog title="物流进度" :visible.sync="progessVisible" width="50%">
      <el-table :data="selectedOrderDetails.detail" style="margin-top: 20px">
        <el-table-column prop="goods_name" label="商品名称"></el-table-column>
        <el-table-column prop="goods_weight" label="商品重量"></el-table-column>
        <el-table-column prop="goods_number" label="商品数量"></el-table-column>
        <el-table-column
          prop="goods_price"
          label="商品价格(元)"
        ></el-table-column>
        <el-table-column
          prop="goods_total_price"
          label="总价"
        ></el-table-column>
        <el-table-column label="状态">
          <template slot-scope="scope">
            <div
              :style="{
                backgroundColor: getStatusColor(scope.row.goods_status),
                padding: '5px',
                borderRadius: '5px',
              }"
            >
              <img
                :src="getStatusImage(scope.row.goods_status)"
                :alt="scope.row.goods_status"
                style="height: 20px; width: 20px"
              />
              {{ scope.row.goods_status }}
            </div>
            <el-tag type="success" v-if="scope.row.goods_status === '已完成'"
              >已完成</el-tag
            >
            <el-tag
              type="warning"
              v-else-if="scope.row.goods_status === '待取餐'"
              >待取餐</el-tag
            >
            <el-tag
              type="warning"
              v-else-if="scope.row.goods_status === '进行中'"
              >进行中</el-tag
            >
            <el-tag type="info" v-else>未付款</el-tag>
          </template>
        </el-table-column>
      </el-table>
    </el-dialog>
  </div>
</template>
<script>
import axios from "axios";
import { pcaTextArr } from "element-china-area-data";
export default {
  data() {
    return {
      pcaTextArr,
      apiUrl: process.env.VUE_APP_API_URL,
      selectedOrders: [], // 存放选中的订单ID
      selectedOptions: [],
      queryInfo: {
        query: "",
        pagenum: 1,
        pagesize: 10,
      },
      detail: {},
      selectedOrderDetails: { detail: [] },
      // 添加模拟的订单列表数据
      orderList: [],
      currentPage: 1,
      pageSize: 6,
      total: 0,
      filteredProducts: [],
      addresVisible: false,
      // 省市区数据保持不变
      currentOrder: null, // 当前正在编辑的订单
      addressForm: {
        address1: [],
        address2: "",
      },
      addressFormRules: {
        address1: [
          { required: true, message: "请选择省市区/县", trigger: "blur" },
        ],
        address2: [
          { required: true, message: "请输入详细地址", trigger: "blur" },
        ],
      },
      order_id: null,
      progessVisible: false,
      progressInfo: [],
    };
  },
  created() {
    this.getOrderList(); // 组件创建后立即获取订单列表
    console.log(process.env.VUE_APP_API_URL); // 输出：https://api.example.com
  },
  computed: {
    displayedProducts() {
      const start = (this.currentPage - 1) * this.pageSize;
      const end = start + this.pageSize;
      return this.filteredProducts.slice(start, end);
    },
  },
  mounted() {
    this.total = this.orderList.length;
    this.filteredProducts = this.orderList;
    this.getOrderList(); // 在组件挂载时调用fetchProducts方法
  },
  methods: {
    editOrder(orderId) {
      const order = this.orderList.find((order) => order.order_id === orderId);
      if (order) {
        this.currentOrder = JSON.parse(JSON.stringify(order)); // 深拷贝订单数据
        this.addresVisible = true; // 显示编辑对话框
      }
    },
    async editAddress() {
      if (!this.currentOrder) {
        console.error("没有当前订单信息");
        return;
      }

      try {
        // 直接传递布尔值，不进行字符串转换
        const updatedOrder = {
          order_number: this.currentOrder.order_number,
          order_price: this.currentOrder.order_price.toString(), // 转换为字符串
          pay_status: this.currentOrder.pay_status.toString(), // 将布尔值转换为字符串
          is_send: this.currentOrder.is_send.toString(), // 将布尔值转换为字符串
        };

        const orderId = this.currentOrder.order_id;
        const url = `${process.env.VUE_APP_API_URL}/api/orders/update/${orderId}`;
        await axios.put(url, updatedOrder);

        this.addresVisible = false;
        this.addressDialogClosed();
        this.getOrderList();
        this.$message.success("订单更新成功！");
      } catch (error) {
        console.error("更新订单失败:", error);
        this.$message.error("更新订单失败,无对应用户！");
      }
    },
    getStatusColor(status) {
      switch (status) {
        case "进行中":
          return "#007bff"; // 蓝色
        case "已完成":
          return "#28a745"; // 绿色
        case "待取餐":
          return "#ffc107"; // 黄色
        default:
          return "#FF6A6A"; // 未付款
      }
    },
    getStatusImage(status) {
      switch (status) {
        case "进行中":
          return "https://img.tukuppt.com/png_preview/00/21/98/iHZCxBFz4r.jpg!/fw/780";
        case "已完成":
          return "https://img.ixintu.com/download/jpg/20200814/db658ac370f4886f32474c5ffd22c743_512_362.jpg!ys";
        case "待取餐":
          return "https://tse3-mm.cn.bing.net/th/id/OIP-C.bm6j7XfidV4cWivlxhy9GgHaFO?w=236&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7";
        default:
          return "https://qiniu.staykoi.asia/%E6%94%AF%E4%BB%98%E5%AE%9D.svg";
      }
    },
    async getOrderList() {
      try {
        // 获取所有订单数据
        const response = await axios.get(
          `${process.env.VUE_APP_API_URL}/api/orders`
        );
        // 假设后端直接返回了订单列表数据
        let allOrders = response.data;

        // 按照你希望的顺序进行排序
        allOrders.sort((a, b) => a.order_id - b.order_id).reverse();

        // 根据用户输入的订单编号进行过滤，如果用户没有输入，则显示全部订单
        if (this.queryInfo.query.trim()) {
          this.orderList = allOrders.filter((order) =>
            order.order_number.includes(this.queryInfo.query.trim())
          );
          this.total = this.orderList.length;
          this.filteredProducts = this.orderList;
        } else {
          this.orderList = allOrders;
          this.total = this.orderList.length;
          this.filteredProducts = this.orderList;
        }
      } catch (error) {
        console.error("获取订单列表失败:", error);
      }
    },

    async getOrderDetail(row) {
      try {
        const response = await axios.get(
          `${process.env.VUE_APP_API_URL}/api/order/detail/${row.order_id}`
        );
        // 直接使用response.data更新detail属性
        row.detail = response.data; // 此处修改为直接赋值response.data
        console.log("获取订单详情成功:", response.data);
      } catch (error) {
        console.error("获取订单详情失败:", error);
      }
    },
    handleSizeChange(newSize) {
      this.pageSize = newSize;
    },
    handleCurrentChange(newPage) {
      this.currentPage = newPage;
    },
    addressDialogClosed() {
      this.$refs.addressFormRef.resetFields();
    },
    handleSelectionChange(val) {
      this.selectedOrders = val.map((item) => item.order_id); // 假设每个订单对象都有一个唯一的 order_id 字段
    },
    async handleBatchDelete() {
      if (this.selectedOrders.length === 0) {
        this.$message.error("请至少选择一个订单进行删除");
        return;
      }
      // 调用API进行批量删除，这里假设你的API需要一个包含订单ID的数组
      try {
        await axios.post(`${process.env.VUE_APP_API_URL}/api/orders/delete`, {
          orderIds: this.selectedOrders,
        });
        this.$message.success("订单删除成功");
        this.getOrderList(); // 组件创建后立即获取订单列表
        // 刷新订单列表或做其他操作
      } catch (error) {
        this.$message.error("删除失败，请稍后重试");
        console.error("Batch delete error:", error);
      }
    },
    async showProgessDialog(order_id) {
      // 根据order_id找到对应的订单
      const order = this.orderList.find((order) => order.order_id === order_id);
      this.selectedOrderDetails = order;

      // 显示物流进度对话框
      this.progessVisible = true;
    },
  },
};
</script>

<style scoped>
.el-card {
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  border-radius: 10px;
  border: 1px solid #f9dada;
}

/* 按钮样式调整，圆角和渐变色彩增加少女风 */
.el-button {
  border-radius: 20px;
  font-weight: bold;
  background-image: linear-gradient(120deg, #f6d365 0%, #fda085 100%);
  border: none;
  color: white;
}
/* 输入框样式调整，更加圆润和温柔 */
.el-input__inner {
  border-radius: 20px;
  border: 1px solid #f9dada;
  box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
}

/* 面包屑样式 */
.el-breadcrumb i {
  color: #f06292; /* 粉红色 */
  height: 20px; /* 字体大小 */
}
/* 分页组件样式 */
.el-pagination .el-pager li:not(.active) {
  background-color: #f9dada;
}
.el-pagination .el-pager li.active {
  background-color: #f783ac;
  color: white;
}
.batch-delete-button {
  position: absolute;
  right: 20px;
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

::v-deep .el-form .el-button:active {
  background-color: #ff1493;
  border-color: #ff1493;
}
</style>