import { useEffect, useState } from 'react'
import api from '../api/client'

export default function Devolucion() {
  const [prestamos, setPrestamos] = useState([])
  const [form, setForm] = useState({ idPrestamo: '', observacion: '' })

  const load = () => api.get('/reportes/prestamos-activos').then((response) => setPrestamos(response.data))

  useEffect(() => {
    load()
  }, [])

  const submit = async (event) => {
    event.preventDefault()
    await api.put(`/prestamos/${form.idPrestamo}/devolver`, { observacion: form.observacion })
    setForm({ idPrestamo: '', observacion: '' })
    load()
  }

  return (
    <section className="max-w-xl space-y-4">
      <h1 className="text-2xl font-semibold">Devolucion</h1>
      <form onSubmit={submit} className="space-y-4 rounded-lg bg-white p-5 shadow-sm">
        <select className="w-full rounded-md border px-3 py-2" value={form.idPrestamo} onChange={(e) => setForm({ ...form, idPrestamo: e.target.value })} required>
          <option value="">Prestamo activo</option>
          {prestamos.map((item) => <option key={item.idPrestamo} value={item.idPrestamo}>Prestamo #{item.idPrestamo} - {item.usuario?.nombre}</option>)}
        </select>
        <textarea className="w-full rounded-md border px-3 py-2" placeholder="Observacion de devolucion" value={form.observacion} onChange={(e) => setForm({ ...form, observacion: e.target.value })} />
        <button className="rounded-md bg-institutional-red px-4 py-2 font-medium text-white">Registrar devolucion</button>
      </form>
    </section>
  )
}
