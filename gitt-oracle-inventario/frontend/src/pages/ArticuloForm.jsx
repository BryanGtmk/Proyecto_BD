import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import api from '../api/client'
import { loadCatalogs } from '../services/catalogService'

const initial = { nombre: '', codigo: '', estado: 'DISPONIBLE', idCategoria: '', idUbicacion: '', idResponsable: '', valorEstimado: 0, urlImagen: '', descripcion: '' }

export default function ArticuloForm() {
  const { id } = useParams()
  const navigate = useNavigate()
  const [form, setForm] = useState(initial)
  const [catalogs, setCatalogs] = useState({ categorias: [], ubicaciones: [], usuarios: [] })

  useEffect(() => {
    loadCatalogs().then(setCatalogs)
    if (id) {
      api.get(`/articulos/${id}`).then(({ data }) =>
        setForm({
          nombre: data.nombre,
          codigo: data.codigo,
          estado: data.estado,
          idCategoria: data.idCategoria,
          idUbicacion: data.idUbicacion,
          idResponsable: data.idResponsable || '',
          valorEstimado: data.valorEstimado || 0,
          urlImagen: data.imagenes?.find((imagen) => imagen.esPrincipal === 'S')?.urlImagen || '',
          descripcion: data.descripcion || '',
        }),
      )
    }
  }, [id])

  const submit = async (event) => {
    event.preventDefault()
    const payload = {
      ...form,
      idCategoria: Number(form.idCategoria),
      idUbicacion: Number(form.idUbicacion),
      idResponsable: form.idResponsable ? Number(form.idResponsable) : null,
      valorEstimado: Number(form.valorEstimado || 0),
    }
    if (id) await api.put(`/articulos/${id}`, payload)
    else await api.post('/articulos', payload)
    navigate('/inventario')
  }

  return (
    <section className="max-w-3xl space-y-4">
      <h1 className="text-2xl font-semibold">{id ? 'Editar articulo' : 'Crear articulo'}</h1>
      <form onSubmit={submit} className="grid gap-4 rounded-lg bg-white p-5 shadow-sm sm:grid-cols-2">
        <input className="rounded-md border px-3 py-2" placeholder="Nombre" value={form.nombre} onChange={(e) => setForm({ ...form, nombre: e.target.value })} required />
        <input className="rounded-md border px-3 py-2" placeholder="Codigo" value={form.codigo} onChange={(e) => setForm({ ...form, codigo: e.target.value })} required />
        <select className="rounded-md border px-3 py-2" value={form.estado} onChange={(e) => setForm({ ...form, estado: e.target.value })}>
          {['DISPONIBLE', 'PRESTADO', 'MANTENIMIENTO', 'BAJA'].map((value) => <option key={value}>{value}</option>)}
        </select>
        <select className="rounded-md border px-3 py-2" value={form.idCategoria} onChange={(e) => setForm({ ...form, idCategoria: e.target.value })} required>
          <option value="">Categoria</option>
          {catalogs.categorias.map((item) => <option key={item.idCategoria} value={item.idCategoria}>{item.nombre}</option>)}
        </select>
        <select className="rounded-md border px-3 py-2" value={form.idUbicacion} onChange={(e) => setForm({ ...form, idUbicacion: e.target.value })} required>
          <option value="">Ubicacion</option>
          {catalogs.ubicaciones.map((item) => <option key={item.idUbicacion} value={item.idUbicacion}>{item.nombre}</option>)}
        </select>
        <select className="rounded-md border px-3 py-2" value={form.idResponsable} onChange={(e) => setForm({ ...form, idResponsable: e.target.value })}>
          <option value="">Sin responsable</option>
          {catalogs.usuarios.map((item) => <option key={item.idUsuario} value={item.idUsuario}>{item.nombre}</option>)}
        </select>
        <input className="rounded-md border px-3 py-2" type="number" min="0" step="0.01" placeholder="Valor estimado" value={form.valorEstimado} onChange={(e) => setForm({ ...form, valorEstimado: e.target.value })} />
        <input className="rounded-md border px-3 py-2" placeholder="URL de imagen" value={form.urlImagen} onChange={(e) => setForm({ ...form, urlImagen: e.target.value })} />
        <textarea className="rounded-md border px-3 py-2 sm:col-span-2" placeholder="Descripcion" value={form.descripcion} onChange={(e) => setForm({ ...form, descripcion: e.target.value })} />
        <button className="rounded-md bg-institutional-red px-4 py-2 font-medium text-white sm:col-span-2">Guardar</button>
      </form>
    </section>
  )
}
