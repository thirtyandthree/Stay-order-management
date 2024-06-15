const { defineConfig } = require('@vue/cli-service');

module.exports = defineConfig({
  transpileDependencies: true,
  lintOnSave: false,
  devServer: {
    client: {
      overlay: false,
    },
    proxy: {
      '/api': {
        target: 'https://www.history33stay.asia',  // 你要代理的服务器地址
        changeOrigin: true,               // 是否改变源地址，对于虚拟托管的站点，需要这么做
        pathRewrite: {
          '^/api': ''  // 重写路径：去掉路径中的 `/api`
        }
      }
    }
  },
});
