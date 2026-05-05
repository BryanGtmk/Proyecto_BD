import { useEffect, useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import api from '../api/client'
import DataTable from '../components/DataTable'
import { badgeClass } from '../utils/formatters'

export default function Inventario() {
  const [rows, setRows] = useState([])
  const [filter, setFilter] = useState('')

  useEffect(() => {
    api.get('/articulos').then((response) => setRows(response.data))
  }, [])

  const filtered = useMemo(
    () => rows.filter((item) => `${item.codigo} ${item.nombre} ${item.estado}`.toLowerCase().includes(filter.toLowerCase())),
    [rows, filter],
  )

  return (
    <section className="space-y-4">
      <div className="flex flex-col justify-between gap-3 sm:flex-row sm:items-end">
        <div>
          <h1 className="text-2xl font-semibold">Inventario</h1>
          <p className="text-sm text-gray-500">Articulos, ubicaciones, categorias y responsables.</p>
        </div>
        <Link to="/inventario/nuevo" className="rounded-md bg-institutional-red px-4 py-2 text-sm font-medium text-white">
          Crear articulo
        </Link>
      </div>
      <input className="w-full rounded-md border bg-white px-3 py-2 sm:max-w-sm" placeholder="Filtrar por codigo, nombre o estado" value={filter} onChange={(e) => setFilter(e.target.value)} />
      <DataTable
        rows={filtered}
        columns={[
          { key: 'codigo', label: 'Codigo' },
          { key: 'nombre', label: 'Articulo', render: (row) => <Link className="font-medium text-institutional-red" to={`/inventario/${row.idArticulo}`}>{row.nombre}</Link> },
          { key: 'estado', label: 'Estado', render: (row) => <span className={badgeClass(row.estado)}>{row.estado}</span> },
          { key: 'categoria', label: 'Categoria' },
          { key: 'ubicacion', label: 'Ubicacion' },
          { key: 'responsable', label: 'Responsable' },
          { key: 'valorEstimado', label: 'Valor', render: (row) => `$${Number(row.valorEstimado || 0).toFixed(2)}` },
        ]}
      />
    </section>
  )
}
