import { createContext, useContext, useMemo, useState } from 'react'
import api from '../api/client'

const AuthContext = createContext(null)

export function AuthProvider({ children }) {
  const [token, setToken] = useState(localStorage.getItem('gitt_token'))
  const [user, setUser] = useState(() => {
    const stored = localStorage.getItem('gitt_user')
    return stored ? JSON.parse(stored) : null
  })

  const login = async (correo, contrasena) => {
    const { data } = await api.post('/auth/login', { correo, contrasena })
    localStorage.setItem('gitt_token', data.token)
    localStorage.setItem('gitt_user', JSON.stringify(data))
    setToken(data.token)
    setUser(data)
    return data
  }

  const logout = () => {
    localStorage.removeItem('gitt_token')
    localStorage.removeItem('gitt_user')
    setToken(null)
    setUser(null)
  }

  const value = useMemo(() => ({ token, user, isAuthenticated: Boolean(token), login, logout }), [token, user])
  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>
}

export function useAuth() {
  return useContext(AuthContext)
}
