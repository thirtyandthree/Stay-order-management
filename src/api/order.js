// orders.js

import axios from 'axios';

export async function  getOrderList() {
    try {
      // 获取所有订单数据
      const response = await axios.get('http://localhost:8081/api/orders');
      // 假设后端直接返回了订单列表数据
      let allOrders = response.data;

      // 根据用户输入的订单编号进行过滤，如果用户没有输入，则显示全部订单
      if (this.queryInfo.query.trim()) {
        this.orderList = allOrders.filter(order => 
          order.order_number.includes(this.queryInfo.query.trim())
        );
      } else {
        this.orderList = allOrders;
      }
    } catch (error) {
      console.error("获取订单列表失败:", error);
    }
}

export const orderList = [];
