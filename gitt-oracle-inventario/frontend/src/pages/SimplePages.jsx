import { useEffect, useState } from 'react'
import api from '../api/client'
import DataTable from '../components/DataTable'
import { badgeClass, formatDate } from '../utils/formatters'

function useData(path) {
  const [rows, setRows] = useState([])
  useEffect(() => {
    api.get(path).then((response) => setRows(response.data))
  }, [path])
  return rows
}

export function Mantenimientos() {
  const rows = useData('/mantenimientos')
  return (
    <section className="space-y-4">
      <h1 className="text-2xl font-semibold">Mantenimientos</h1>
      <DataTable rows={rows} columns={[
        { key: 'articulo', label: 'Articulo', render: (row) => row.articulo?.nombre },
        { key: 'tipo', label: 'Tipo' },
        { key: 'fecha', label: 'Fecha', render: (row) => formatDate(row.fecha) },
        { key: 'estado', label: 'Estado', render: (row) => <span className={badgeClass(row.estado)}>{row.estado}</span> },
        { key: 'observacion', label: 'Observacion' },
      ]} />
    </section>
  )
}

export function Movimientos() {
  const rows = useData('/movimientos')
  return (
    <section className="space-y-4">
      <h1 className="text-2xl font-semibold">Movimientos</h1>
      <DataTable rows={rows} columns={[
        { key: 'articulo', label: 'Articulo', render: (row) => row.articulo?.nombre },
        { key: 'tipo', label: 'Tipo' },
        { key: 'fecha', label: 'Fecha', render: (row) => formatDate(row.fecha) },
        { key: 'observacion', label: 'Observacion' },
      ]} />
    </section>
  )
}

export function Usuarios() {
  const rows = useData('/usuarios')
  return (
    <section className="space-y-4">
      <h1 className="text-2xl font-semibold">Usuarios</h1>
      <DataTable rows={rows} columns={[
        { key: 'nombre', label: 'Nombre' },
        { key: 'correo', label: 'Correo' },
        { key: 'rol', label: 'Rol', render: (row) => row.rol?.nombreRol },
      ]} />
    </section>
  )
}

export function Reportes() {
  const disponibles = useData('/reportes/articulos-disponibles')
  const vencidos = useData('/reportes/prestamos-activos')
  const valorDepartamento = useData('/reportes/valor-inventario-por-departamento')
  const movimientos = useData('/reportes/movimientos-rango')
  return (
    <section className="space-y-6">
      <h1 className="text-2xl font-semibold">Reportes</h1>
      <div>
        <h2 className="mb-2 font-semibold">Articulos disponibles</h2>
        <DataTable rows={disponibles} columns={[
          { key: 'codigo', label: 'Codigo' },
          { key: 'nombre', label: 'Articulo' },
          { key: 'ubicacion', label: 'Ubicacion' },
          { key: 'responsable', label: 'Responsable' },
        ]} />
      </div>
      <div>
        <h2 className="mb-2 font-semibold">Prestamos activos</h2>
        <DataTable rows={vencidos} columns={[
          { key: 'idPrestamo', label: 'Prestamo' },
          { key: 'usuario', label: 'Usuario', render: (row) => row.usuario?.nombre },
          { key: 'fechaDevolucion', label: 'Devolucion', render: (row) => formatDate(row.fechaDevolucion) },
        ]} />
      </div>
      <div>
        <h2 className="mb-2 font-semibold">Valor por departamento</h2>
        <DataTable rows={valorDepartamento} columns={[
          { key: 'departamento', label: 'Departamento' },
          { key: 'totalArticulos', label: 'Articulos' },
          { key: 'valorTotal', label: 'Valor total', render: (row) => `$${Number(row.valorTotal || 0).toFixed(2)}` },
        ]} />
      </div>
      <div>
        <h2 className="mb-2 font-semibold">Movimientos recientes</h2>
        <DataTable rows={movimientos} columns={[
          { key: 'articulo', label: 'Articulo', render: (row) => row.articulo?.nombre },
          { key: 'tipo', label: 'Tipo' },
          { key: 'fecha', label: 'Fecha', render: (row) => formatDate(row.fecha) },
          { key: 'observacion', label: 'Observacion' },
        ]} />
      </div>
    </section>
  )
}

export function Auditoria() {
  const rows = useData('/auditoria')
  return (
    <section className="space-y-4">
      <h1 className="text-2xl font-semibold">Auditoria</h1>
      <DataTable rows={rows} columns={[
        { key: 'accion', label: 'Accion' },
        { key: 'fecha', label: 'Fecha', render: (row) => formatDate(row.fecha) },
        { key: 'usuario', label: 'Usuario', render: (row) => row.usuario?.nombre },
        { key: 'tabla', label: 'Tabla' },
        { key: 'descripcion', label: 'Descripcion' },
      ]} />
    </section>
  )
}
