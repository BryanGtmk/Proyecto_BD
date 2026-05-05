import { Bell, LogOut, Menu, Search } from 'lucide-react'
import { Input } from './ui/input'
import { Button } from './ui/button'

export default function Navbar({ usuario, onMenu, onLogout }) {
  return (
    <header className="sticky top-0 z-20 flex h-16 items-center justify-between border-b border-gray-200 bg-white/95 px-4 shadow-sm backdrop-blur lg:px-6">
      <div className="flex min-w-0 items-center gap-3">
        <Button variant="ghost" size="icon" onClick={onMenu} className="lg:hidden">
          <Menu className="h-5 w-5" />
        </Button>
        <div className="hidden min-w-0 lg:block">
          <p className="text-sm font-semibold text-gray-950">Sistema Web de Gestión de Inventario Tecnológico</p>
          <p className="text-xs text-gray-500">Universidad Técnica de Ambato - FISEI</p>
        </div>
        <div className="hidden w-72 xl:block">
          <div className="relative">
            <Search className="pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-gray-400" />
            <Input className="h-9 pl-9" placeholder="Búsqueda rápida visual" />
          </div>
        </div>
      </div>

      <div className="flex items-center gap-3">
        <button className="relative rounded-md p-2 text-gray-600 hover:bg-gray-100 hover:text-gray-950">
          <Bell className="h-5 w-5" />
          <span className="absolute right-1.5 top-1.5 h-2.5 w-2.5 rounded-full border-2 border-white bg-vino-700" />
        </button>
        <div className="hidden text-right sm:block">
          <p className="text-sm font-semibold text-gray-900">{usuario.nombre}</p>
          <p className="text-xs text-gray-500">{usuario.rol}</p>
        </div>
        <div className="flex h-9 w-9 items-center justify-center rounded-full bg-vino-800 text-sm font-semibold text-white shadow-sm">
          {usuario.nombre.slice(0, 1)}
        </div>
        <Button variant="outline" size="icon" onClick={onLogout} title="Cerrar sesión">
          <LogOut className="h-4 w-4" />
        </Button>
      </div>
    </header>
  )
}
