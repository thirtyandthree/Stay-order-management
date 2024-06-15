import request from '@/request'

export function allUser(page) {
  return request({
    url: '/users/alluser',
    method: 'post',
    data: page
  })
}

export function userInfo(id) {
  return request({
    url: `/users/userInfo/${id}`,
    method: 'post'
  })
}

export function myArticle(authorId) {
  return request({
    url: `/articles/view1/${authorId}`,
    method: 'post'
  })
}

export function updateUser(user) {
  return request({
    url: '/users/update',
    method: 'post',
    data: user
  })
}

export function selectUser(user) {
  return request({
    url: '/users/select',
    method: 'post',
    data: user
  })
}