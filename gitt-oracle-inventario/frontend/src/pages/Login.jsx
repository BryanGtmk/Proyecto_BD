import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { LockKeyhole } from 'lucide-react'
import { useAuth } from '../context/AuthContext'

export default function Login() {
  const { login } = useAuth()
  const navigate = useNavigate()
  const [form, setForm] = useState({ correo: 'admin@fisei.edu.ec', contrasena: 'Admin123*' })
  const [error, setError] = useState('')

  const submit = async (event) => {
    event.preventDefault()
    setError('')
    try {
      await login(form.correo, form.contrasena)
      navigate('/')
    } catch {
      setError('Credenciales invalidas o API no disponible.')
    }
  }

  return (
    <div className="flex min-h-screen items-center justify-center bg-gray-100 px-4">
      <form onSubmit={submit} className="w-full max-w-md rounded-lg bg-white p-8 shadow-sm">
        <div className="mb-6 flex items-center gap-3">
          <div className="rounded-md bg-institutional-red p-3 text-white">
            <LockKeyhole className="h-6 w-6" />
          </div>
          <div>
            <h1 className="text-xl font-semibold text-gray-900">Acceso FISEI</h1>
            <p className="text-sm text-gray-500">Sistema de inventario tecnologico</p>
          </div>
        </div>
        <label className="mb-4 block text-sm font-medium">
          Correo
          <input className="mt-1 w-full rounded-md border px-3 py-2" value={form.correo} onChange={(e) => setForm({ ...form, correo: e.target.value })} />
        </label>
        <label className="mb-4 block text-sm font-medium">
          Contrasena
          <input className="mt-1 w-full rounded-md border px-3 py-2" type="password" value={form.contrasena} onChange={(e) => setForm({ ...form, contrasena: e.target.value })} />
        </label>
        {error && <p className="mb-4 rounded-md bg-red-50 px-3 py-2 text-sm text-red-700">{error}</p>}
        <button className="w-full rounded-md bg-institutional-red px-4 py-2 font-medium text-white hover:bg-institutional-dark">Ingresar</button>
      </form>
    </div>
  )
}
