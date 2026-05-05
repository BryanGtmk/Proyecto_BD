import {
  BarChart3,
  Boxes,
  Building2,
  FolderTree,
  ClipboardList,
  FileClock,
  History,
  LayoutDashboard,
  MapPin,
  MonitorCog,
  ShieldCheck,
  Users,
  Wrench,
  X,
} from 'lucide-react'
import { cn } from '../lib/utils'

const grupos = [
  {
    titulo: 'Operación',
    opciones: [
      { id: 'dashboard', label: 'Dashboard', icon: LayoutDashboard },
      { id: 'inventario', label: 'Inventario', icon: Boxes },
      { id: 'prestamos', label: 'Préstamos', icon: ClipboardList },
      { id: 'mantenimientos', label: 'Mantenimientos', icon: Wrench },
      { id: 'movimientos', label: 'Movimientos', icon: History },
    ],
  },
  {
    titulo: 'Gestión',
    opciones: [
      { id: 'nuevoArticulo', label: 'Nuevo artículo', icon: FileClock },
      { id: 'nuevoPrestamo', label: 'Nuevo préstamo', icon: ClipboardList },
      { id: 'detalleArticulo', label: 'Detalle artículo', icon: MonitorCog },
      { id: 'usuarios', label: 'Usuarios', icon: Users },
      { id: 'ubicaciones', label: 'Ubicaciones', icon: MapPin },
      { id: 'categorias', label: 'Categorías', icon: FolderTree },
    ],
  },
  {
    titulo: 'Reportes',
    opciones: [
      { id: 'reportes', label: 'Reportes', icon: BarChart3 },
      { id: 'auditoria', label: 'Auditoría', icon: ShieldCheck },
    ],
  },
]

export default function Sidebar({ active, onNavigate, open, onClose }) {
  return (
    <>
      <div className={cn('fixed inset-0 z-30 bg-gray-950/40 lg:hidden', open ? 'block' : 'hidden')} onClick={onClose} />
      <aside
        className={cn(
          'fixed inset-y-0 left-0 z-40 flex w-72 flex-col bg-gradient-to-b from-vino-950 via-vino-900 to-gray-950 text-white shadow-2xl transition-transform lg:translate-x-0',
          open ? 'translate-x-0' : '-translate-x-full',
        )}
      >
        <div className="border-b border-white/10 px-5 py-5">
          <div className="flex items-start justify-between gap-3">
            <div className="flex gap-3">
              <div className="flex h-11 w-11 shrink-0 items-center justify-center rounded-lg border border-white/15 bg-white/10">
                <Building2 className="h-6 w-6 text-white" />
              </div>
              <div>
                <p className="text-lg font-semibold leading-5">GITT Oracle</p>
                <p className="mt-1 text-xs leading-4 text-white/65">Universidad Técnica de Ambato</p>
              </div>
            </div>
            <button className="rounded-md p-2 hover:bg-white/10 lg:hidden" onClick={onClose}>
              <X className="h-4 w-4" />
            </button>
          </div>
          <div className="mt-5 rounded-lg border border-white/10 bg-white/10 p-3">
            <p className="text-xs font-semibold uppercase tracking-wide text-white/55">Facultad FISEI</p>
            <p className="mt-1 text-sm text-white/90">Inventario tecnológico académico</p>
          </div>
        </div>

        <nav className="flex-1 overflow-y-auto px-3 py-4">
          {grupos.map((grupo) => (
            <div key={grupo.titulo} className="mb-5">
              <p className="mb-2 px-3 text-[11px] font-semibold uppercase tracking-wider text-white/45">{grupo.titulo}</p>
              <div className="space-y-1">
                {grupo.opciones.map(({ id, label, icon: Icon }) => (
                  <button
                    key={id}
                    onClick={() => {
                      onNavigate(id)
                      onClose()
                    }}
                    className={cn(
                      'group flex w-full items-center gap-3 rounded-lg px-3 py-2.5 text-left text-sm transition-all',
                      active === id
                        ? 'bg-white text-vino-900 shadow-md'
                        : 'text-white/75 hover:bg-white/10 hover:text-white',
                    )}
                  >
                    <span
                      className={cn(
                        'flex h-8 w-8 items-center justify-center rounded-md',
                        active === id ? 'bg-vino-100 text-vino-800' : 'bg-white/10 text-white/80 group-hover:bg-white/15',
                      )}
                    >
                      <Icon className="h-4 w-4" />
                    </span>
                    <span className="truncate">{label}</span>
                  </button>
                ))}
              </div>
            </div>
          ))}
        </nav>

        <div className="border-t border-white/10 p-4">
          <div className="rounded-lg bg-black/20 p-3 text-xs text-white/65">
            <p className="font-semibold text-white">Ambiente académico</p>
            <p className="mt-1">Datos simulados listos para API REST.</p>
          </div>
        </div>
      </aside>
    </>
  )
}
