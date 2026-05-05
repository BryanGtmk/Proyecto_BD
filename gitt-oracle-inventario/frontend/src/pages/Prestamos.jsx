import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import api from '../api/client'
import DataTable from '../components/DataTable'
import { badgeClass, formatDate } from '../utils/formatters'

export default function Prestamos() {
  const [rows, setRows] = useState([])

  useEffect(() => {
    api.get('/prestamos').then((response) => setRows(response.data))
  }, [])

  return (
    <section className="space-y-4">
      <div className="flex justify-between gap-3">
        <div>
          <h1 className="text-2xl font-semibold">Prestamos</h1>
          <p className="text-sm text-gray-500">Registro de prestamos activos e historicos.</p>
        </div>
        <Link to="/prestamos/nuevo" className="rounded-md bg-institutional-red px-4 py-2 text-sm font-medium text-white">Crear prestamo</Link>
      </div>
      <DataTable
        rows={rows}
        columns={[
          { key: 'idPrestamo', label: 'ID' },
          { key: 'usuario', label: 'Usuario', render: (row) => row.usuario?.nombre },
          { key: 'fechaPrestamo', label: 'Prestamo', render: (row) => formatDate(row.fechaPrestamo) },
          { key: 'fechaDevolucion', label: 'Devolucion', render: (row) => formatDate(row.fechaDevolucion) },
          { key: 'estado', label: 'Estado', render: (row) => <span className={badgeClass(row.estado)}>{row.estado}</span> },
        ]}
      />
    </section>
  )
}
