<template>
  <div>
    <div class="show">
      <div class="show1" >
        <img ref="showing" src="" id="showimg" style="margin-left: 1px;margin-top: 3px">
      </div>
      <div class="upload">图片选择
      <input multiple="multiple" id="file" ref="file"
             accept=".jpg,.png"
             @click="changepic(this)" type="file" name="userpic"
             style="
              position: absolute;
              overflow: hidden;
              right: 0;
              top: 0;
              opacity: 0;
             width: 100%;
             height: 32px;
             "
      >
      </div>
      <button @click="subchangepic()" style="height: 40px;position: relative; margin-left:35%;">确定</button>
    </div>
    <div class="gallery">
    <div v-for="image in galleryImages" :key="image" class="gallery-image">
        <img :src="image" alt="Gallery image">
      </div>
    </div>
    <right-menu></right-menu>
  </div>
</template>
 
<script>
import axios from 'axios'; // 引入axios
import RightMenu from '@/components/rightMenu.vue';
import rightMenu from '@/components/rightMenu.vue';
export default {
  components: { rightMenu },
  name: "imageUp",
  data() {
    return {
      filename: null,
      f64: null,
      loadImage: "",
      galleryImages: [],
    }
  },
  mounted() {
  // this.getGalleryImages();
},
computed:{
  RightMenu
},
  methods: {
    changepic() {
      document.getElementById('file').onchange = function() {
        var imgFile = this.files[0];
        var fr = new FileReader();

       fr.onload = () => { // 使用箭头函数
        let showing = document.getElementById('showimg');
        let img = fr.result;
        this.f64 = img; // 现在`this`正确地指向Vue实例
        this.filename = imgFile.name;
        showing.src = img;
        showing.style.height = "220px";
        showing.style.width = "220px";
        showing.style.borderRadius = "200px";
      };

        fr.readAsDataURL(imgFile);
      }
    },
    getGalleryImages() {
  axios.get(`${process.env.VUE_APP_API_URL}/api/images`)
    .then(response => {
      this.galleryImages = response.data; // 假设API返回的是图片URL数组
    })
    .catch(error => {
      console.error("Error fetching images:", error);
    });
},
    subchangepic() {
      // 选择图片文件
      let imgFile = this.$refs.file.files[0];
      let formData = new FormData();
      formData.append("image", imgFile); // 'image'是后端接收文件的key

      // 使用Axios发送POST请求
      axios.post(`${process.env.VUE_APP_API_URL}/api/UploadFile`, formData, {
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      })
      .then(response => {
        // 处理成功的情况
        console.log("Image uploaded successfully:", response);
        this.$message.success('上传图片成功');
      })
      .catch(error => {
        // 处理错误的情况
        console.error("Error uploading image:", error);
      });
    },
  }
}
</script>

 
<style scoped>
 
.upload{
  margin-left: 20%;
  width: 12%;
  text-align: center;
  color: white;
  height: 32px;
  border-radius: 3px;
  background: #1E90FF;
  cursor: pointer;
  outline: none;
  border-width: 0px;
  font-size: 17px;
  display:inline-block;
  padding: 4px 10px;
  line-height:30px;
  position: relative;
  text-decoration: none;
}
 
button {
  margin-left: 70%;
  width: 15%;
  height: 35px;
  border-width: 0px;
  border-radius: 3px;
  background: #1E90FF;
  cursor: pointer;
  outline: none;
  color: white;
  font-size: 17px;
}
.show{
  margin: 100px auto;
  width: 80%;
  height: 450px;
  border: 5px solid #18a0ec;
  transition: all 0.9s;
  border-radius: 10px;
}
.show1{
  margin: 50px auto;
  width: 222px;
  height: 226px;
  border: 5px solid #18a0ec;
  transition: all 0.9s;
  border-radius: 150px;
}
 
.show1:hover{
  box-shadow: 0px 15px 30px rgba(0, 0, 0, 0.4);
  margin-top: 45px;
}
 
.show:hover{
  box-shadow: 0px 15px 30px rgba(0, 0, 0, 0.4);
  margin-top: 45px;
}
 
.texti{
  border: 1px solid #ccc;
  padding: 13px 14px;
  width: 30%;
 
  font-size: 14px;
  font-weight: 300;
 
  border-radius: 5px; /* 边框半径 */
  background: white; /* 背景颜色 */
  cursor: pointer; /* 鼠标移入按钮范围时出现手势 */
  outline: none; /* 不显示轮廓线 */
}
.texti:focus{
  border-color: #1e88e1;
  outline: 0;
  -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6);
  box-shadow: inset 0 1px 1px rgba(0,0,0,.075),0 0 8px rgba(102,175,233,.6)
}
textarea {
  resize: none;
 
}
</style>