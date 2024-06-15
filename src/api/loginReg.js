// authService.js
import request from '@/request'
import axios from 'axios' // 确保安装了axios

export async function login(username, password) {
  try {
    const response = await axios.post(`${process.env.VUE_APP_API_URL}/api/login`, {
      username,
      password
    }, {
      withCredentials: true
    });

    if (response.status === 200 && response.data.status === "success") {
      // 可以在这里直接处理登录成功的情况，或者返回response给调用者进一步处理
      return response.data;
    } else {
      throw new Error('登录失败');
    }
  } catch (error) {
    throw error; // 将错误抛出给调用者
  }
}

// 其他API服务如logout, getUserInfo等可以类似地实现
// 注册插入用户
export async function register(registerForm) {
  try {
    const response = await axios.post(`${process.env.VUE_APP_API_URL}/api/register`, {
      username: registerForm.username,
      email: registerForm.email,
      password: registerForm.password,
      // 其他需要的数据
    }, {
      withCredentials: true
    });

    // 处理响应
    if (response.data.status === 'success') {
      // 注册成功的逻辑
      return { success: true, message: '注册成功！' };
    } else {
      // 注册失败的逻辑
      return { success: false, message: response.data.message || '注册失败' };
    }
  } catch (error) {
    // 错误处理
    return { success: false, message: error.message || '注册请求失败' };
  }
}