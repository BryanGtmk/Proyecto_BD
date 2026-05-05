import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import api from '../api/client'

export default function PrestamoCreate() {
  const navigate = useNavigate()
  const [usuarios, setUsuarios] = useState([])
  const [articulos, setArticulos] = useState([])
  const [form, setForm] = useState({ idUsuario: '', fechaDevolucion: '', articulos: [], observacion: '' })

  useEffect(() => {
    api.get('/usuarios').then((response) => setUsuarios(response.data)).catch(() => setUsuarios([]))
    api.get('/reportes/articulos-disponibles').then((response) => setArticulos(response.data))
  }, [])

  const toggleArticulo = (idArticulo) => {
    setForm((current) => ({
      ...current,
      articulos: current.articulos.includes(idArticulo)
        ? current.articulos.filter((id) => id !== idArticulo)
        : [...current.articulos, idArticulo],
    }))
  }

  const submit = async (event) => {
    event.preventDefault()
    await api.post('/prestamos', { ...form, idUsuario: Number(form.idUsuario) })
    navigate('/prestamos')
  }

  return (
    <section className="max-w-3xl space-y-4">
      <h1 className="text-2xl font-semibold">Crear prestamo</h1>
      <form onSubmit={submit} className="space-y-4 rounded-lg bg-white p-5 shadow-sm">
        <select className="w-full rounded-md border px-3 py-2" value={form.idUsuario} onChange={(e) => setForm({ ...form, idUsuario: e.target.value })} required>
          <option value="">Usuario solicitante</option>
          {usuarios.map((item) => <option key={item.idUsuario} value={item.idUsuario}>{item.nombre}</option>)}
        </select>
        <input className="w-full rounded-md border px-3 py-2" type="date" value={form.fechaDevolucion} onChange={(e) => setForm({ ...form, fechaDevolucion: e.target.value })} required />
        <div className="grid gap-2 sm:grid-cols-2">
          {articulos.map((item) => (
            <label key={item.idArticulo} className="flex items-center gap-2 rounded-md border px-3 py-2 text-sm">
              <input type="checkbox" checked={form.articulos.includes(item.idArticulo)} onChange={() => toggleArticulo(item.idArticulo)} />
              {item.codigo} - {item.nombre}
            </label>
          ))}
        </div>
        <textarea className="w-full rounded-md border px-3 py-2" placeholder="Observacion" value={form.observacion} onChange={(e) => setForm({ ...form, observacion: e.target.value })} />
        <button className="rounded-md bg-institutional-red px-4 py-2 font-medium text-white">Guardar prestamo</button>
      </form>
    </section>
  )
}
