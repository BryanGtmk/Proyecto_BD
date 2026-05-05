export function formatDate(value) {
  if (!value) return ''
  return new Intl.DateTimeFormat('es-EC', { dateStyle: 'medium' }).format(new Date(value))
}

export function badgeClass(value) {
  const map = {
    DISPONIBLE: 'bg-green-50 text-green-700 ring-green-200',
    PRESTADO: 'bg-red-50 text-red-700 ring-red-200',
    MANTENIMIENTO: 'bg-yellow-50 text-yellow-700 ring-yellow-200',
    BAJA: 'bg-gray-100 text-gray-700 ring-gray-200',
    ACTIVO: 'bg-red-50 text-red-700 ring-red-200',
    DEVUELTO: 'bg-green-50 text-green-700 ring-green-200',
    PENDIENTE: 'bg-yellow-50 text-yellow-700 ring-yellow-200',
  }
  return `inline-flex rounded-full px-2 py-1 text-xs font-medium ring-1 ${map[value] || 'bg-gray-50 text-gray-700 ring-gray-200'}`
}
