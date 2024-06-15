<template>
  <!-- 曲线图 -->
  <div>
    <div class="dashboard">
      <div class="dashboard-item" v-for="item in stats" :key="item.title">
        <div class="item-layout">
          <div class="icon">
            <img :src="item.icon" :alt="item.title" />
          </div>
          <div class="content">
            <div class="number">
              {{ item.number }}
              <i :class="item.icon2" :style="{ color: item.color }"></i>
            </div>
            <div class="title">{{ item.title }}</div>
          </div>
        </div>
      </div>
    </div>
    <div class="echarts-container" ref="echartsContainer"></div>
    <!-- 年度数据统计 -->
    <div>
      <chart style="margin-top: 12px"></chart>
    </div>
    <div>
      <order style="margin-top: 12px"></order>
    </div>
  </div>
</template>

<script>
import * as echarts from "echarts/core";
import { LineChart } from "echarts/charts";
import {
  GridComponent,
  TooltipComponent,
  TitleComponent,
} from "echarts/components";
import { CanvasRenderer } from "echarts/renderers";
import chart from "./chart.vue";
import order from "./order.vue";
import axios from "axios";
[LineChart, GridComponent, TooltipComponent, TitleComponent, CanvasRenderer];

export default {
  name: "DashboardWithChart",
  data() {
    return {
      stats: [
        {
          title: "Visits",
          color: "#FF82AB",
          number: "102,4",
          icon2: "el-icon-user-solid",
          icon: require("@/assets/展示.svg"),
        },
        {
          title: "Messages",
          color: "#FFD700",
          number: "81,212",
          icon2: "el-icon-message-solid",
          icon: require("@/assets/信息消息评论.svg"),
        },
        {
          title: "Purchases",
          color: "#EEAEEE",
          number: "9,280",
          icon2: "el-icon-s-order",
          icon: require("@/assets/购物车购物.svg"),
        },
        {
          title: "Shoppings",
          color: "#FF6EB4",
          number: "13,600",
          icon2: "",
          icon: require("@/assets/收藏喜爱喜欢.svg"),
        },
      ],
    };
  },
  components: {
    chart: chart,
    order: order,
  },
  mounted() {
    this.initChart();
    this.fetchInfo();
    this.fetchInfo1();
  },
  methods: {
    fetchInfo() {
      axios
        .post(`${process.env.VUE_APP_API_URL}/api/order/check`)
        .then((response) => {
          this.stats[2].number = response.data.order_count;
          this.stats[3].number = response.data.total_price + "￥";
          // Handle the successful response here
          console.log("Total Number of user:", response.data.order_count);
          console.log("Total Price of 公告:", response.data.total_price);
          // Optionally update your Vue data properties
        })
        .catch((error) => {
          // Handle any errors here
          console.error("Error fetching data:", error);
        });
    },
    fetchInfo1() {
      axios
        .post(`${process.env.VUE_APP_API_URL}/api/user/countUser`)
        .then((response) => {
          this.stats[0].number = response.data.userCount;
          this.stats[1].number = response.data.totalAnnouncements;
          // Handle the successful response here
          console.log("Total Number of Orders:", response.data.userCount);
          console.log(
            "Total Price of Orders:",
            response.data.totalAnnouncements
          );
          // Optionally update your Vue data properties
        })
        .catch((error) => {
          // Handle any errors here
          console.error("Error fetching data:", error);
        });
    },
    initChart() {
      var chartDom = this.$refs.echartsContainer;
      var myChart = echarts.init(chartDom);
      var option = {
        tooltip: {
          trigger: "axis",
          axisPointer: {
            type: "cross",
            label: {
              backgroundColor: "#6a7985",
            },
          },
        },
        title: {
          text: "年度数据统计",
          left: "center",
          textStyle: {
            color: "#FF6A6A",
            fontStyle: "normal",
            fontWeight: "bold",
            fontSize: 28,
          },
        },
        grid: {
          left: "3%",
          right: "4%",
          bottom: "3%",
          containLabel: true,
        },
        xAxis: [
          {
            type: "category",
            boundaryGap: false,
            data: [
              "Jan",
              "Feb",
              "Mar",
              "Apr",
              "May",
              "Jun",
              "Jul",
              "Aug",
              "Sep",
              "Oct",
              "Nov",
              "Dec",
            ],
          },
        ],
        yAxis: [
          {
            type: "value",
          },
        ],
        series: [
          {
            name: "Series 1",
            type: "line",
            stack: "Total",
            areaStyle: {},
            emphasis: {
              focus: "series",
            },
            data: [
              1250, 1234, 1201, 1324, 1200, 1320, 1330, 1290, 934, 901, 932,
              820,
            ],
            lineStyle: {
              color: "#FF1493",
            },
          },
          {
            name: "Series 2",
            type: "line",
            stack: "Total",
            areaStyle: {},
            emphasis: {
              focus: "series",
            },
            data: [
              620, 732, 701, 734, 1090, 1130, 1120, 1000, 1124, 1001, 1034,
              1050,
            ],
            lineStyle: {
              color: "#87CEFA",
            },
          },
          {
            name: "Series 3",
            type: "line",
            stack: "Total",
            areaStyle: {},
            emphasis: {
              focus: "series",
            },
            data: [520, 632, 601, 634, 890, 930, 920, 800, 924, 901, 934, 950],
            lineStyle: {
              color: "#FFD700",
            },
          },
        ],
      };

      myChart.setOption(option);
    },
  },
};
</script>

<style scoped>
.dashboard {
  display: flex;
  flex-wrap: nowrap;
  justify-content: space-between;
  width: 100%;
}

.dashboard-item {
  flex: 1;
  padding: 20px;
  text-align: left;
  background-color: #fff0f5;
  box-shadow: 0 4px 8px rgba(255, 105, 180, 0.4),
    0 6px 20px rgba(238, 130, 238, 0.4);
  border-radius: 10px;
  margin: 10px;
  display: flex;
  align-items: center;
}

.item-layout {
  display: flex;
  justify-content: start;
  width: 100%;
}

.icon img {
  width: 70px;
  height: auto;
  margin-left: 20px;
  margin-right: 120px;
}

.content .number {
  font-size: 25px;
  font-weight: bold;
  color: #cd5c5c;
}

.content .title {
  font-size: 19px;
  color: #ffd39b;
}

.echarts-container {
  width: 96%;
  height: 400px;
  margin: 0 auto;
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.19), 0 6px 6px rgba(0, 0, 0, 0.23);
  border-radius: 10px;
  padding: 20px;
  background-color: #fff0f5;
  margin-top: 12px;
}
</style>
