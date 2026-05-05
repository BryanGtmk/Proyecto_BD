import { Badge } from './ui/badge'

const variants = {
  Disponible: 'success',
  Activo: 'success',
  Prestado: 'vino',
  Devuelto: 'info',
  Vencido: 'danger',
  Mantenimiento: 'warning',
  Pendiente: 'warning',
  'En proceso': 'info',
  Finalizado: 'success',
  Baja: 'dark',
  ActivoUsuario: 'success',
  Inactivo: 'default',
  Ingreso: 'success',
  Traslado: 'info',
  Prestamo: 'vino',
  Devolucion: 'success',
  Préstamo: 'vino',
  Devolución: 'success',
}

export default function StatusBadge({ estado }) {
  const key = estado === 'Activo' ? 'Activo' : estado
  return <Badge variant={variants[key] || variants[estado] || 'default'}>{estado}</Badge>
}
