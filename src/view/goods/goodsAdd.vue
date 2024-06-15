<template>
  <div class="goods-manage">
      <div class='button-container'>
        <el-input v-model="searchText" placeholder="搜索商品..." class="search-bar"></el-input>
        <!-- 添加搜索按钮 -->
        <el-button @click="searchProducts">搜索</el-button>
       <el-button type="primary" class="left-aligned-button" @click="showAddProductDialog">添加商品</el-button>
      </div>
    <!-- 添加商品的对话框 -->
    <el-dialog title="添加商品" :visible.sync="showAddDialog" style="border-radius: 8px;">
  <el-form :model="newProduct">
    <el-form-item label="商品名称">
      <el-input v-model="newProduct.name" autocomplete="off" style="border: 1px solid #FFC0CB; border-radius: 4px;"></el-input>
    </el-form-item>
    <el-form-item label="商品价格">
      <el-input v-model.number="newProduct.price" type="number" autocomplete="off" style="border: 1px solid #FFC0CB; border-radius: 4px;"></el-input>
    </el-form-item>
    <el-form-item label="分类">
      <el-input v-model="newProduct.category" autocomplete="off" style="border: 1px solid #FFC0CB; border-radius: 4px;"></el-input>
    </el-form-item>
    <el-form-item label="规格类型">
      <el-checkbox-group v-model="newProduct.sizes">
        <el-checkbox label="大杯" name="size" style="margin-right: 10px;color:#FFAEB9;font-weight:bold;"></el-checkbox>
        <el-checkbox label="中杯" name="size" style="margin-right: 10px;color:#FFAEB9;font-weight:bold;"></el-checkbox>
        <el-checkbox label="小杯" name="size" style="margin-right: 10px;color:#FFAEB9;font-weight:bold;"></el-checkbox>
      </el-checkbox-group>
    </el-form-item>
    <el-form-item label="商品温度">
      <el-checkbox-group v-model="newProduct.temperatures" >
        <el-checkbox label="常温" name="temperature" style="margin-right: 10px;color:#FFAEB9;font-weight:bold;"></el-checkbox>
        <el-checkbox label="加冰" name="temperature" style="margin-right: 10px;color:#FFAEB9;font-weight:bold;"></el-checkbox>
        <el-checkbox label="少冰" name="temperature" style="margin-right: 10px;color:#FFAEB9;font-weight:bold;"></el-checkbox>
      </el-checkbox-group>
    </el-form-item>
    <el-form-item label="商品配品">
      <el-checkbox-group v-model="newProduct.addons">
        <el-checkbox label="珍珠" name="addon" style="margin-right: 10px;color:#FFAEB9;font-weight:bold;"></el-checkbox>
        <el-checkbox label="椰果" name="addon" style="margin-right: 10px;color:#FFAEB9;font-weight:bold;"></el-checkbox>
        <el-checkbox label="红豆" name="addon" style="margin-right: 10px;color:#FFAEB9;font-weight:bold;"></el-checkbox>
      </el-checkbox-group>
    </el-form-item>
    <el-form-item label="库存数量">
      <el-input v-model.number="newProduct.stock" type="number" autocomplete="off" style="border: 1px solid #FFC0CB; border-radius: 4px;"></el-input>
    </el-form-item>
    <el-form-item label="商品图片地址">
  <el-input v-model="newProduct.imageUrl" type="text" autocomplete="off" style="border: 1px solid #FFC0CB; border-radius: 4px;"></el-input>
      </el-form-item>
      <div style="margin-top: 20px; text-align: center;">
        <img v-if="newProduct.imageUrl" :src="newProduct.imageUrl" alt="商品图片预览" style="max-width: 100%; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,.1);">
      </div>

  </el-form>
  <div slot="footer" class="dialog-footer">
    <el-button @click="showAddDialog = false" style="border-radius: 20px; background-color: #FFDAB9; color: black;">取消</el-button>
    <el-button type="primary" @click="addProduct" style="border-radius: 20px; background-color: #FF69B4; color: white;">确定</el-button>
  </div>
</el-dialog>


    <!-- 商品列表 -->
    <el-table :data="displayedProducts" style="width: 100%" stripe border>
  <el-table-column label="商品图片" style="height:20px;">
    <template slot-scope="scope">
      <el-image style="width: 50px; height: 50px" :src="scope.row.imageUrl" fit="cover" :alt="scope.row.name"></el-image>
    </template>
  </el-table-column>

  <el-table-column prop="name" label="商品名称">
  <template slot-scope="scope">
    <span style="font-family: 'Comic Sans MS', cursive, sans-serif; color: #FF69B4; background-color: #FFF0F5; padding: 2px 5px; border-radius: 5px;">
      {{ scope.row.name }}
    </span>
  </template>
</el-table-column>

 <el-table-column prop="price" label="商品价格">
  <template slot-scope="scope">
    <span style="font-family: 'Arial', sans-serif; color: #FF1493; font-weight: bold;">
      ¥{{ scope.row.price }}
    </span>
  </template>
</el-table-column>

  <el-table-column prop="category" label="分类" style="width:10px;">
   <template slot-scope="scope">
    <span style="font-family: 'Arial', sans-serif; color: #FF1493; font-weight: bold;width:10px;">
      {{ scope.row.category }}
    </span>
  </template>
  </el-table-column>
  <el-table-column label="规格">
    <template slot-scope="scope">
      <el-tag size="mini" v-for="size in scope.row.sizes" :key="size" style="margin-right: 5px;background-color:#FFC1C1;color:#FFE7BA;font-weight:bold;">{{ size }}</el-tag>
    </template>
  </el-table-column>

  <el-table-column label="温度">
    <template slot-scope="scope">
      <el-tag size="mini" v-for="temp in scope.row.temperatures" :key="temp" style="margin-right: 5px;background-color:#FFC1C1;color:#FFE7BA;font-weight:bold;">{{ temp }}</el-tag>
    </template>
  </el-table-column>

  <el-table-column label="配品">
    <template slot-scope="scope">
      <el-tag size="mini" v-for="addon in scope.row.addons" :key="addon" style="margin-right: 5px;background-color:#FFC1C1;color:#FFE7BA;font-weight:bold;">{{ addon }}</el-tag>
    </template>
  </el-table-column>

  <el-table-column label="库存数量">
    <template slot-scope="scope">
      <el-progress :percentage="scope.row.stock" show-text color="#EEA2AD"></el-progress>
    </template>
  </el-table-column>

  <el-table-column label="操作">
    <template slot-scope="scope">
      <el-button size="mini" @click="editProduct(scope.$index)" type="primary" circle style='color:#FFDEAD'>
        <i class="el-icon-edit"></i>Edit
      </el-button>
      <el-button size="mini" @click="() => showDetails(scope.row)" type="success" circle style='color:#3A5FCD'>
        <i class="el-icon-view"></i>Content
      </el-button>
      <el-button size="mini" @click="() => resetNewProduct(scope.row)" type="warning" circle style='color:#CD00CD'>
        <i class="el-icon-refresh"></i>Reset
      </el-button>
      <el-button size="mini" @click="deleteProduct(scope.row.name)" type="danger" circle style='color:#FFD700'>
    <i class="el-icon-delete"></i>Delete
</el-button>
    </template>
  </el-table-column>
</el-table>

    <!-- 分页 -->
    <el-pagination
      @size-change="handleSizeChange"
      @current-change="handleCurrentChange"
      :current-page="currentPage"
      :page-sizes="[6, 12, 18, 24]"
      :page-size="pageSize"
      layout="total, sizes, prev, pager, next, jumper"
      :total="total">
    </el-pagination>
     <!-- 商品详情对话框 -->
  <el-dialog :visible.sync="showDetailsDialog" title="商品详情" width="30%" class="details-dialog">
  <div v-if="detailProduct" class="product-details">
    <p><span class="details-label">商品名称:</span> {{ detailProduct.name }}</p>
    <p><span class="details-label">商品价格:</span> {{ detailProduct.price }}</p>
    <p><span class="details-label">商品库存:</span> {{ detailProduct.stock }}</p>
     <p><span class="details-label">商品库存:</span> {{ detailProduct.category }}</p>
    <p><span class="details-label">商品规格:</span> {{ detailProduct.sizes.join(', ') }}</p>
    <p><span class="details-label">商品温度:</span> {{ detailProduct.temperatures.join(', ') }}</p>
    <p><span class="details-label">商品配品:</span> {{ detailProduct.addons.join(', ') }}</p>
    <p><span class="details-label">商品图片:</span> <img :src="detailProduct.imageUrl" class="product-image"></p>
  </div>
</el-dialog>

  </div>
  
</template>

<script>
import axios from 'axios'
import { Notification } from 'element-ui';
export default {
  data() {
    return {
      products: [],
      newProduct: { name: '', price: 0, category: '', sizes: [], temperatures: [], addons: [], stock: 0, imageUrl: '' },
      searchText: '',
      showAddDialog: false,
      currentPage: 1,
      pageSize: 6,
      total: 0,
      filteredProducts: [], // 用于存储过滤后的商品列表
      showDetailsDialog: false,
      detailProduct: null,
    };
  },
  computed: {
   displayedProducts() {
    const start = (this.currentPage - 1) * this.pageSize;
    const end = start + this.pageSize;
    return this.filteredProducts.slice(start, end);
  },
    searchFilteredProducts() {
      return this.products.filter(product => product.name.toLowerCase().includes(this.searchText.toLowerCase()));
    }
  },
  mounted() {
    this.total = this.products.length;
    this.filteredProducts = this.products;
    this.fetchProducts(); // 在组件挂载时调用fetchProducts方法
  },
  methods: {
    fetchProducts() {
  axios.post(`${process.env.VUE_APP_API_URL}/api/cheapgoods`)
    .then(response => {
      this.products = response.data;
      this.total = this.products.length;
      this.filteredProducts = this.products;
    })
    .catch(error => console.error('There was an error fetching the products:', error));
},

  addProduct() {
            console.log("addProduct method called"); // 在方法开始时打印

            // 设置请求的 URL，根据你的实际后端服务地址修改
            const apiUrl = `${process.env.VUE_APP_API_URL}/api/cheapgoods`;
            console.log("Request URL:", apiUrl); // 检查请求的URL
            
            // 检查是否有商品 ID，以确定是添加新商品还是更新现有商品
            const requestType = this.newProduct.id ? 'update' : 'add';
            console.log("Request Type:", requestType); // 打印请求类型（添加或更新）
            console.log("Product Data being sent:", this.newProduct); // 打印发送的产品数据

            // 发送 POST 请求
            axios.post(apiUrl, {
              ...this.newProduct,
              requestType: requestType,
              imageUrl: this.newProduct.imageUrl || 'https://example.com/newproduct.jpg' // 默认图片URL
            })
            .then(response => {
              console.log("Product added/updated successfully:", response); // 请求成功后打印响应
              this.fetchProducts(); // 假设你有一个方法是用来获取最新的商品列表
            })
            .catch(error => {
              console.error('There was an error in the add/update product request:', error);
              this.$message.error('不能使用相同名称商品'); // 错误处理时打印错误
            })
            .finally(() => {
              this.showAddDialog = false; // 不管请求成功还是失败，都会执行这里的代码
              console.log("Dialog closed"); // 在对话框关闭后打印
            });
          },


showAddProductDialog() {
    // 重置 newProduct 对象为默认值，确保没有 id 属性
    this.newProduct = { name: '', price: 0, category: '', sizes: [], temperatures: [], addons: [], stock: 0, imageUrl: '' };
    this.showAddDialog = true; // 显示添加商品对话框
},
    editProduct(index) {
            const product = this.products[index];
            this.newProduct = { ...product };
            this.showAddDialog = true; // 显示对话框以编辑商品
        },
    resetNewProduct(row) {
        console.log('Resetting product with:', row); // 确认方法调用和row内容
        // 先设置newProduct对象
        this.newProduct = {
            name: row.name,
            price: row.price,
            sizes: [],
            temperatures: [],
            addons: [],
            stock: 0,
            category: '',
            imageUrl: ''
        };

    // 使用axios发送newProduct到后端
    axios({
        method: 'post', // 或 'put' 如果你是在更新一个产品
        url: `${process.env.VUE_APP_API_URL}/api/cheapgoods/reset`,
        headers: {
            'Content-Type': 'application/json',
        },
        data: this.newProduct
    })
    .then((response) => {
        console.log('Success:', response.data);
         // 显示成功的通知
        Notification.success({
          title: 'Success',
          message: '重置成功',
          duration: 1200 // 设置显示时长，单位毫秒
        });
        this.fetchProducts(); 
        // 这里可以添加一些UI反馈，比如通知用户产品已更新
    })
    .catch((error) => {
        console.error('Error:', error);
        // 这里可以处理错误，比如通知用户更新失败
    });
},
deleteProduct(productName) {
    this.$confirm('确定要删除这个商品吗?', '警告', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
    }).then(() => {
        axios.post(`${process.env.VUE_APP_API_URL}/api/cheapgoods/delete`, { name: productName })
        .then(response => {
            console.log('Delete response:', response);
            this.$message({
                type: 'success',
                message: '删除成功!'
            });
            this.fetchProducts(); 
            this.products = this.products.filter(product => product.name !== productName);
        })
        .catch(error => {
            console.error('Delete error:', error);
            this.$message({
                type: 'error',
                message: '删除失败，请稍后再试'
            });
        });
    }).catch(() => {
        this.$message({
            type: 'info',
            message: '已取消删除'
        });
    });
},



    handleSizeChange(newSize) {
      this.pageSize = newSize;
    },
    handleCurrentChange(newPage) {
      this.currentPage = newPage;
    },
    showDetails(product) {
      this.detailProduct = product;
      this.showDetailsDialog = true;
    },
     searchProducts() {
    if (this.searchText.trim() === '') {
      this.filteredProducts = this.products;
    } else {
      this.filteredProducts = this.products.filter(product =>
        product.name.toLowerCase().includes(this.searchText.toLowerCase())
      );
    }
  }
  },
};
</script>

<style scoped>
.goods-manage {
  padding: 20px;
  background-color: #fff0f6; /* 柔和的粉红色背景 */
  border-radius: 8px;
}
.button-container { /* 假设 .el-button 的父元素有这个类名 */
  display: flex;
  align-items: center; /* 垂直居中，如果需要的话 */
  justify-content: flex-start; /* 让子元素靠近起始边（左边） */
}
.el-button {
  margin: 5px;
  border-color: #f783ac;
  color: #f783ac;
}

.el-button--primary {
  background-color: #f783ac;
  border-color: #f783ac;
  color: #FFE4C4;
  font-weight: bold;
}

.el-button:focus, .el-button:hover {
  border-color: #f06eaa;
  background-color: #f06eaa;
  color: #fff;
}

.el-table .el-button {
  border-color: #f783ac;
  color: #f783ac;
}

.el-table .el-button--danger {
  color: #FFFACD;
}

/* 商品图片的样式 */
.el-image {
  border-radius: 20%; 
  border: 2px solid #f783ac; /* 添加边框 */
}

/* 自定义滚动条样式 */
::-webkit-scrollbar {
  width: 8px;
}
.details-dialog .el-dialog {
  border-radius: 8px;
  box-shadow: 0 4px 6px 0 rgba(0, 0, 0, 0.1);
  border: 3px solid #ffe0f0;
}
.details-label {
  font-weight: bold;
  color: #FF69B4; /* 柔和的粉红色 */
}

.product-image {
  border-radius: 4px;
  margin-top: 10px;
  max-width: 100%;
  height: 140px;
  box-shadow: 0 2px 4px 0 #ffe0f0;
}
::-webkit-scrollbar-thumb {
  background: #f783ac;
}

::-webkit-scrollbar-thumb:hover {
  background: #f06eaa;
}
::v-deep .el-table,
::v-deep .el-table__expanded-cell {
  background-color: transparent;
  color: #F78FB3; /* 柔和的粉色 */
  font-size: 18px; /* 稍微减小字体大小以适应更柔和的风格 */
}
::v-deep .el-table th,
::v-deep .el-table tr,
::v-deep .el-table td {
  background-color: #FFF5EE;
  border: solid 1.5px #fff; 
  color: #F78FB3;
  font-size: 18px;
  height: 5px;
  /* font-family: "Comic Sans MS", cursive, sans-serif; 使用更圆润、更少女风格的字体 */
  font-weight: bold;
}
/* 修改el-form的整体背景色和内边距 */
::v-deep .el-form {
  background-color: #FFF0F5; /* 淡粉红背景色 */
  padding: 20px;
  border-radius: 8px; /* 轻微的圆角边框 */
  box-shadow: 0 2px 12px 0 rgba(0,0,0,0.1); /* 细微的阴影增添层次感 */
}
::v-deep .el-table .cell{
  width:200px;
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

::v-deep .el-form .el-button:active {
  background-color: #FF1493;
  border-color: #FF1493;
}

</style>

