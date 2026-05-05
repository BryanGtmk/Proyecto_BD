import { useEffect, useState } from 'react'
import api from '../api/client'
import StatCard from '../components/StatCard'

export default function Dashboard() {
  const [dashboard, setDashboard] = useState(null)

  useEffect(() => {
    api.get('/reportes/dashboard').then((response) => setDashboard(response.data))
  }, [])

  return (
    <section className="space-y-6">
      <div>
        <h1 className="text-2xl font-semibold text-gray-900">Dashboard</h1>
        <p className="text-sm text-gray-500">Indicadores principales del inventario tecnologico.</p>
      </div>
      <div className="grid gap-4 sm:grid-cols-2 xl:grid-cols-5">
        <StatCard label="Articulos" value={dashboard?.totalArticulos} />
        <StatCard label="Disponibles" value={dashboard?.articulosDisponibles} tone="dark" />
        <StatCard label="Prestamos activos" value={dashboard?.prestamosActivos} />
        <StatCard label="Mant. pendientes" value={dashboard?.mantenimientosPendientes} tone="gray" />
        <StatCard label="Notificaciones" value={dashboard?.notificacionesPendientes} tone="dark" />
      </div>
    </section>
  )
}
