import axios from 'axios'

export const restClient = axios.create({
  baseURL: import.meta.env.VITE_API_URL || 'http://localhost:5000/api',
  headers: {
    'Content-Type': 'application/json',
  },
})

restClient.interceptors.request.use((config) => {
  const token = localStorage.getItem('gitt_token')
  if (token) {
    config.headers.Authorization = `Bearer ${token}`
  }
  return config
})

export const endpoints = {
  articulos: '/articulos',
  prestamos: '/prestamos',
  mantenimientos: '/mantenimientos',
  movimientos: '/movimientos',
  usuarios: '/usuarios',
  reportes: '/reportes',
  auditoria: '/auditoria',
}
