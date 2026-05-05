import { useEffect, useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import api from '../api/client'
import { badgeClass } from '../utils/formatters'

export default function ArticuloDetail() {
  const { id } = useParams()
  const [item, setItem] = useState(null)

  useEffect(() => {
    api.get(`/articulos/${id}`).then((response) => setItem(response.data))
  }, [id])

  if (!item) return <p>Cargando...</p>

  return (
    <section className="max-w-3xl space-y-4">
      <div className="flex justify-between gap-3">
        <div>
          <h1 className="text-2xl font-semibold">{item.nombre}</h1>
          <p className="text-sm text-gray-500">{item.codigo}</p>
        </div>
        <Link className="rounded-md border px-4 py-2 text-sm" to={`/inventario/${id}/editar`}>Editar</Link>
      </div>
      <div className="grid gap-4 rounded-lg bg-white p-5 shadow-sm sm:grid-cols-2">
        {item.imagenes?.[0]?.urlImagen && (
          <img className="h-56 w-full rounded-md object-cover sm:col-span-2" src={item.imagenes[0].urlImagen} alt={item.nombre} />
        )}
        <p><span className="font-medium">Estado:</span> <span className={badgeClass(item.estado)}>{item.estado}</span></p>
        <p><span className="font-medium">Categoria:</span> {item.categoria?.nombre}</p>
        <p><span className="font-medium">Ubicacion:</span> {item.ubicacion?.nombre}</p>
        <p><span className="font-medium">Responsable:</span> {item.responsable?.nombre || 'No asignado'}</p>
        <p><span className="font-medium">Valor estimado:</span> ${Number(item.valorEstimado || 0).toFixed(2)}</p>
        <p className="sm:col-span-2"><span className="font-medium">Descripcion:</span> {item.descripcion || 'Sin descripcion'}</p>
      </div>
    </section>
  )
}
