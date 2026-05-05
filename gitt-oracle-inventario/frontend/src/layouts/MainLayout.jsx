import { NavLink, Outlet, useNavigate } from 'react-router-dom'
import {
  BarChart3,
  Bell,
  Boxes,
  ClipboardList,
  History,
  LayoutDashboard,
  LogOut,
  Menu,
  Settings,
  ShieldCheck,
  Users,
  Wrench,
} from 'lucide-react'
import { useAuth } from '../context/AuthContext'

const links = [
  { to: '/', label: 'Dashboard', icon: LayoutDashboard },
  { to: '/inventario', label: 'Inventario', icon: Boxes },
  { to: '/prestamos', label: 'Prestamos', icon: ClipboardList },
  { to: '/devolucion', label: 'Devolucion', icon: History },
  { to: '/mantenimientos', label: 'Mantenimientos', icon: Wrench },
  { to: '/movimientos', label: 'Movimientos', icon: Settings },
  { to: '/usuarios', label: 'Usuarios', icon: Users },
  { to: '/reportes', label: 'Reportes', icon: BarChart3 },
  { to: '/auditoria', label: 'Auditoria', icon: ShieldCheck },
]

export default function MainLayout() {
  const { user, logout } = useAuth()
  const navigate = useNavigate()

  const handleLogout = () => {
    logout()
    navigate('/login')
  }

  return (
    <div className="min-h-screen bg-gray-100 lg:flex">
      <aside className="bg-institutional-dark text-white lg:fixed lg:inset-y-0 lg:w-72">
        <div className="flex h-16 items-center gap-3 border-b border-white/10 px-5">
          <Menu className="h-5 w-5" />
          <div>
            <p className="text-sm font-semibold uppercase tracking-wide">FISEI</p>
            <p className="text-xs text-white/70">Inventario tecnologico</p>
          </div>
        </div>
        <nav className="space-y-1 px-3 py-4">
          {links.map(({ to, label, icon: Icon }) => (
            <NavLink
              key={to}
              to={to}
              className={({ isActive }) =>
                `flex items-center gap-3 rounded-md px-3 py-2 text-sm ${isActive ? 'bg-white text-institutional-dark' : 'text-white/80 hover:bg-white/10'}`
              }
            >
              <Icon className="h-4 w-4" />
              {label}
            </NavLink>
          ))}
        </nav>
      </aside>

      <div className="min-w-0 flex-1 lg:pl-72">
        <header className="sticky top-0 z-10 flex h-16 items-center justify-between border-b bg-white px-4 shadow-sm sm:px-6">
          <div>
            <p className="text-sm font-semibold text-institutional-red">Sistema Web GITT</p>
            <p className="text-xs text-gray-500">Oracle Database + ASP.NET Core + React</p>
          </div>
          <div className="flex items-center gap-4">
            <Bell className="h-5 w-5 text-gray-500" />
            <div className="hidden text-right sm:block">
              <p className="text-sm font-medium">{user?.nombre || 'Usuario'}</p>
              <p className="text-xs text-gray-500">{user?.rol || 'Rol'}</p>
            </div>
            <button onClick={handleLogout} className="rounded-md border px-3 py-2 text-sm hover:bg-gray-50" title="Cerrar sesion">
              <LogOut className="h-4 w-4" />
            </button>
          </div>
        </header>
        <main className="p-4 sm:p-6">
          <Outlet />
        </main>
      </div>
    </div>
  )
}
