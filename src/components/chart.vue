<template>
  <!-- 三个图 -->
  <div class="chart-container">
    <div ref="roseChart" class="rose-chart"></div>
    <div ref="barChart" class="bar-chart"></div>
    <div ref="radarChart" class="radar-chart" style="width: 32%"></div>
  </div>
</template>

<script>
import * as echarts from "echarts";

export default {
  name: "ChartComponent",
  mounted() {
    this.createRoseChart();
    this.createBarChart();
    this.createRadarChart();
  },
  methods: {
    createRoseChart() {
      const myChart = echarts.init(this.$refs.roseChart, null, {
        renderer: "canvas",
      });
      const option = {
        backgroundColor: "#FEF6FB",
        title: {
          text: "Nightingale Rose Chart",
          subtext: "Mocking Data",
          left: "center",
          textStyle: {
            color: "#D94F70",
            fontFamily: "Comic Sans MS",
            fontSize: 20,
          },
          subtextStyle: {
            color: "#AB6C82",
            fontSize: 14,
          },
        },
        tooltip: {
          trigger: "item",
          formatter: "{a} <br/>{b} : {c} ({d}%)",
          backgroundColor: "rgba(255, 229, 240, 0.9)",
          borderColor: "#FFAEC9",
          borderWidth: 1,
          textStyle: {
            color: "#5C1A3C",
          },
        },
        legend: {
          left: "center",
          top: "bottom",
          textStyle: {
            color: "#D94F70",
          },
          data: [
            "rose1",
            "rose2",
            "rose3",
            "rose4",
            "rose5",
            "rose6",
            "rose7",
            "rose8",
          ],
        },
        toolbox: {
          show: true,
          feature: {
            saveAsImage: { show: true, title: "Save" },
          },
        },
        series: [
          {
            name: "Radius Mode",
            type: "pie",
            radius: [20, 140],
            center: ["50%", "50%"],
            roseType: "radius",
            itemStyle: {
              borderRadius: 8,
              borderColor: "rgba(0, 0, 0, 0.3)",
              borderWidth: 2,
            },
            label: {
              show: true,
              color: "#5C1A3C",
              fontFamily: "Arial",
            },
            emphasis: {
              label: {
                show: true,
              },
            },
            data: [
              { value: 40, name: "rose1" },
              { value: 33, name: "rose2" },
              { value: 28, name: "rose3" },
              { value: 22, name: "rose4" },
              { value: 20, name: "rose5" },
              { value: 15, name: "rose6" },
              { value: 12, name: "rose7" },
              { value: 10, name: "rose8" },
            ],
          },
        ],
      };
      myChart.setOption(option);
    },
    createBarChart() {
      var myChart = echarts.init(this.$refs.barChart);
      var option = {
        title: {
          text: "ECharts 示例",
          textStyle: {
            color: "#f06292", // 鲜艳的粉色
            fontFamily: "Comic Sans MS", // 可爱的字体
            fontSize: 24, // 增大字号
          },
        },
        tooltip: {},
        legend: {
          data: ["销量"],
        },
        xAxis: {
          data: ["衬衫", "羊毛衫", "雪纺衫", "裤子", "高跟鞋", "袜子"],
        },
        yAxis: {},
        series: [
          {
            name: "销量",
            type: "bar",
            data: [5, 20, 36, 10, 10, 20],
          },
        ],
      };
      myChart.setOption(option);
    },
    createRadarChart() {
      const myChart = echarts.init(this.$refs.radarChart);

      const option = {
        title: {
          text: "",
          left: "center",
          textStyle: {
            color: "#666",
            fontWeight: "normal",
          },
        },
        radar: {
          indicator: [
            { name: "Administration", max: 6500 },
            { name: "mation Technology", max: 16000 },
            { name: "Customer Support", max: 30000 },
            { name: "Development", max: 38000 },
            { name: "Marketing", max: 52000 },
            { name: "Sales", max: 25000 },
          ],
          shape: "polygon",
          splitNumber: 5,
          splitArea: {
            areaStyle: {
              color: [
                "rgba(114, 172, 209, 0.2)",
                "rgba(114, 172, 209, 0.4)",
                "rgba(114, 172, 209, 0.6)",
                "rgba(114, 172, 209, 0.8)",
                "rgba(114, 172, 209, 1)",
              ],
              shadowColor: "rgba(0, 0, 0, 0.3)",
              shadowBlur: 10,
            },
          },
          axisLine: {
            lineStyle: {
              color: "rgba(114, 172, 209, 0.5)",
            },
          },
          splitLine: {
            lineStyle: {
              color: "rgba(114, 172, 209, 0.5)",
            },
          },
        },
        series: [
          {
            name: "Budget vs Spending",
            type: "radar",
            data: [
              {
                value: [4200, 3000, 20000, 35000, 50000, 18000],
                name: "Allocated Budget",
                areaStyle: {
                  color: "rgba(114, 172, 209, 0.6)",
                },
              },
              {
                value: [5000, 14000, 28000, 26000, 42000, 21000],
                name: "Actual Spending",
                areaStyle: {
                  color: "rgba(255, 159, 64, 0.6)",
                },
              },
              {
                value: [6500, 16000, 30000, 38000, 52000, 25000],
                name: "Expected Spending",
                areaStyle: {
                  color: "rgba(75, 192, 192, 0.6)",
                },
              },
            ],
          },
        ],
      };

      myChart.setOption(option);
    },
  },
};
</script>

<style>
.chart-container {
  display: flex;
  justify-content: space-between;
  width: 100%;
}

.rose-chart,
.bar-chart,
.radar-chart {
  width: 32%;
  height: 500px;
  background-color: #fef6fb;
}

.rose-chart .echarts-title,
.rose-chart .echarts-legend,
.rose-chart .echarts-tooltip {
  color: #333;
}

.bar-chart .echarts-title,
.bar-chart .echarts-legend,
.bar-chart .echarts-tooltip {
  color: #333;
}

.radar-chart .echarts-title,
.radar-chart .echarts-legend,
.radar-chart .echarts-tooltip {
  color: #333;
}
</style>