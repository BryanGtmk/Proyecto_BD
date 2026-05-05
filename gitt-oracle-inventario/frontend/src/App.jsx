import { BrowserRouter, Navigate, Route, Routes } from 'react-router-dom'
import { AuthProvider } from './context/AuthContext'
import PrivateRoute from './routes/PrivateRoute'
import MainLayout from './layouts/MainLayout'
import Login from './pages/Login'
import Dashboard from './pages/Dashboard'
import Inventario from './pages/Inventario'
import ArticuloForm from './pages/ArticuloForm'
import ArticuloDetail from './pages/ArticuloDetail'
import Prestamos from './pages/Prestamos'
import PrestamoCreate from './pages/PrestamoCreate'
import Devolucion from './pages/Devolucion'
import { Auditoria, Mantenimientos, Movimientos, Reportes, Usuarios } from './pages/SimplePages'

export default function App() {
  return (
    <AuthProvider>
      <BrowserRouter>
        <Routes>
          <Route path="/login" element={<Login />} />
          <Route element={<PrivateRoute />}>
            <Route element={<MainLayout />}>
              <Route index element={<Dashboard />} />
              <Route path="inventario" element={<Inventario />} />
              <Route path="inventario/nuevo" element={<ArticuloForm />} />
              <Route path="inventario/:id" element={<ArticuloDetail />} />
              <Route path="inventario/:id/editar" element={<ArticuloForm />} />
              <Route path="prestamos" element={<Prestamos />} />
              <Route path="prestamos/nuevo" element={<PrestamoCreate />} />
              <Route path="devolucion" element={<Devolucion />} />
              <Route path="mantenimientos" element={<Mantenimientos />} />
              <Route path="movimientos" element={<Movimientos />} />
              <Route path="usuarios" element={<Usuarios />} />
              <Route path="reportes" element={<Reportes />} />
              <Route path="auditoria" element={<Auditoria />} />
            </Route>
          </Route>
          <Route path="*" element={<Navigate to="/" replace />} />
        </Routes>
      </BrowserRouter>
    </AuthProvider>
  )
}
