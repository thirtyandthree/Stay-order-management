import request from '@/request'

export function login(account, password) {
  const data = {
    account,
    password
  }
  return request({
    url: '/login',
    method: 'post',
    data
  })
}

export function logout(token) {
  return request({
    headers: {'Authorization': token},
    url: '/logout',
    method: 'get'
  })
}

export function getUserInfo(token) {
  return request({
    headers: {'Authorization': token},
    url: '/users/currentUser',
    method: 'get'
  })
}

export function register(account, nickname, password,code) {
  const data = {
    account,
    nickname,
    password,
    code
  }
  return request({
    url: '/register',
    method: 'post',
    data
  })
}

export function sendEmail(email) {
  return request({
    url: `/register/sendEmail?email=${email}`,
    method: 'post',
  })
}