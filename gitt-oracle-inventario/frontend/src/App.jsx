import { useMemo, useState } from 'react'
import {
  AlertTriangle,
  BarChart3,
  Boxes,
  Building2,
  CalendarClock,
  CheckCircle2,
  ClipboardList,
  Edit,
  Eye,
  FilePlus2,
  FolderTree,
  MapPin,
  Plus,
  RotateCcw,
  Save,
  Trash2,
  Wrench,
} from 'lucide-react'
import Sidebar from './components/Sidebar'
import Navbar from './components/Navbar'
import StatCard from './components/StatCard'
import DataTable from './components/DataTable'
import StatusBadge from './components/StatusBadge'
import PageHeader from './components/PageHeader'
import SearchFilterBar from './components/SearchFilterBar'
import ConfirmDialog from './components/ConfirmDialog'
import FormSection from './components/FormSection'
import SimpleChart from './components/SimpleChart'
import { Badge } from './components/ui/badge'
import { Button } from './components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from './components/ui/card'
import { Input } from './components/ui/input'
import { Select } from './components/ui/select'
import { Textarea } from './components/ui/textarea'
import {
  alertas,
  articulos,
  articulosPorEstado,
  auditoria,
  categorias,
  categoriasCatalogo,
  estadosArticulo,
  mantenimientos,
  movimientos,
  prestamos,
  responsables,
  resumen,
  ubicaciones,
  ubicacionesCatalogo,
  usuarioActual,
  usuarios,
} from './data/mockData'

function Login({ onLogin }) {
  return (
    <main className="relative flex min-h-screen items-center justify-center overflow-hidden bg-vino-950 px-4 py-8">
      <div className="absolute inset-0 bg-[linear-gradient(135deg,rgba(95,19,32,0.96),rgba(17,24,39,0.98)_52%,rgba(15,23,42,1))]" />
      <div className="absolute inset-0 opacity-20 [background-image:linear-gradient(rgba(255,255,255,.12)_1px,transparent_1px),linear-gradient(90deg,rgba(255,255,255,.12)_1px,transparent_1px)] [background-size:44px_44px]" />
      <div className="absolute left-0 top-0 h-full w-1/2 bg-[linear-gradient(120deg,rgba(255,255,255,.12),transparent_55%)]" />
      <div className="relative w-full max-w-6xl">
        <div className="mb-5 flex flex-col gap-2 text-white sm:flex-row sm:items-end sm:justify-between">
          <div>
            <p className="text-xs font-semibold uppercase tracking-[0.22em] text-white/55">Universidad Técnica de Ambato</p>
            <h1 className="mt-2 text-2xl font-semibold">GITT Oracle</h1>
          </div>
          <p className="text-sm text-white/65">Facultad de Ingeniería en Sistemas, Electrónica e Industrial</p>
        </div>

        <section className="grid w-full overflow-hidden rounded-2xl border border-white/15 bg-white/10 shadow-2xl shadow-black/35 backdrop-blur-xl lg:grid-cols-[1.15fr_430px]">
          <div className="relative hidden min-h-[560px] overflow-hidden bg-gradient-to-br from-vino-900 via-vino-800 to-gray-950 p-10 text-white lg:flex lg:flex-col lg:justify-between">
            <div className="absolute inset-x-0 bottom-0 h-32 bg-[linear-gradient(0deg,rgba(0,0,0,.35),transparent)]" />
            <div className="absolute right-0 top-0 h-full w-40 bg-white/5 [clip-path:polygon(35%_0,100%_0,100%_100%,0_100%)]" />
            <div className="relative">
              <div className="mb-10 inline-flex items-center gap-2 rounded-lg bg-white/10 px-4 py-2 text-sm font-semibold ring-1 ring-white/15">
                <Building2 className="h-4 w-4" />
                Universidad Técnica de Ambato
              </div>
              <h2 className="max-w-xl text-5xl font-semibold leading-tight">Sistema académico de inventario tecnológico</h2>
              <p className="mt-5 max-w-xl text-lg font-medium text-white/90">Gestión institucional para la FISEI</p>
              <p className="mt-5 max-w-lg text-sm leading-6 text-white/72">Control académico de artículos, préstamos, mantenimientos, movimientos, reportes y auditoría institucional.</p>
            </div>
            <div className="relative grid grid-cols-3 gap-3 text-sm">
              <div className="rounded-xl border border-white/10 bg-white/10 p-4">
                <p className="text-xs text-white/55">Base</p>
                <p className="mt-1 font-semibold">Oracle</p>
              </div>
              <div className="rounded-xl border border-white/10 bg-white/10 p-4">
                <p className="text-xs text-white/55">Frontend</p>
                <p className="mt-1 font-semibold">React</p>
              </div>
              <div className="rounded-xl border border-white/10 bg-white/10 p-4">
                <p className="text-xs text-white/55">Facultad</p>
                <p className="mt-1 font-semibold">FISEI</p>
              </div>
            </div>
          </div>

          <form
            className="flex min-h-[560px] flex-col justify-center bg-white/96 p-8 shadow-2xl lg:p-11"
            onSubmit={(event) => {
              event.preventDefault()
              onLogin()
            }}
          >
            <div className="mb-8">
              <div className="mb-5 flex h-12 w-12 items-center justify-center rounded-xl bg-vino-800 text-white shadow-lg shadow-vino-900/25">
                <Building2 className="h-6 w-6" />
              </div>
              <p className="text-3xl font-semibold text-gray-950">GITT Oracle</p>
              <p className="mt-2 text-sm text-gray-500">Gestión de Inventario Tecnológico FISEI</p>
            </div>
            <div className="space-y-4">
              <label className="block text-sm font-medium text-gray-700">
                Correo
                <Input className="mt-1 h-11 border-gray-300 bg-white" defaultValue="admin@fisei.edu.ec" type="email" />
              </label>
              <label className="block text-sm font-medium text-gray-700">
                Contraseña
                <Input className="mt-1 h-11 border-gray-300 bg-white" defaultValue="Admin123*" type="password" />
              </label>
              <Button className="h-11 w-full bg-vino-700 shadow-md shadow-vino-900/20 hover:bg-vino-800" type="submit">Iniciar sesión</Button>
            </div>
            <p className="mt-5 rounded-lg border border-vino-100 bg-vino-50 p-4 text-sm leading-6 text-vino-900">Use las credenciales de prueba del entorno académico. Esta pantalla es visual y posteriormente se conectará a la API REST.</p>
          </form>
        </section>
      </div>
    </main>
  )
}

function Layout({ active, setActive, children, onLogout }) {
  const [sidebarOpen, setSidebarOpen] = useState(false)
  return (
    <div className="min-h-screen bg-gray-100">
      <Sidebar active={active} onNavigate={setActive} open={sidebarOpen} onClose={() => setSidebarOpen(false)} />
      <div className="lg:pl-72">
        <Navbar usuario={usuarioActual} onMenu={() => setSidebarOpen(true)} onLogout={onLogout} />
        <main className="p-4 sm:p-6">{children}</main>
      </div>
    </div>
  )
}

function Dashboard({ setActive }) {
  return (
    <section className="space-y-6">
      <PageHeader title="Dashboard" description="Vista general del inventario tecnológico institucional." />
      <div className="overflow-hidden rounded-lg border border-vino-100 bg-white shadow-sm">
        <div className="grid gap-4 bg-gradient-to-r from-vino-900 to-vino-700 p-5 text-white lg:grid-cols-[1fr_320px] lg:items-center">
          <div>
            <p className="text-xs font-semibold uppercase tracking-wider text-white/65">Universidad Técnica de Ambato - FISEI</p>
            <h2 className="mt-2 text-2xl font-semibold">Control académico del inventario tecnológico</h2>
            <p className="mt-2 max-w-2xl text-sm leading-6 text-white/75">Panel visual con información simulada para validar experiencia de usuario antes de conectar la API REST de ASP.NET Core con Oracle.</p>
          </div>
          <div className="grid grid-cols-3 gap-2 text-center text-sm">
            <div className="rounded-lg bg-white/10 p-3 ring-1 ring-white/10">Oracle</div>
            <div className="rounded-lg bg-white/10 p-3 ring-1 ring-white/10">FISEI</div>
            <div className="rounded-lg bg-white/10 p-3 ring-1 ring-white/10">React</div>
          </div>
        </div>
      </div>
      <div className="grid gap-4 sm:grid-cols-2 xl:grid-cols-6">
        <StatCard label="Total de artículos" value={resumen.totalArticulos} icon={Boxes} />
        <StatCard label="Disponibles" value={resumen.disponibles} icon={CheckCircle2} tone="green" />
        <StatCard label="Prestados" value={resumen.prestados} icon={ClipboardList} />
        <StatCard label="En mantenimiento" value={resumen.mantenimiento} icon={Wrench} tone="amber" />
        <StatCard label="Préstamos vencidos" value={resumen.vencidos} icon={AlertTriangle} tone="red" />
        <StatCard label="Mant. pendientes" value={resumen.mantenimientosPendientes} icon={CalendarClock} tone="gray" />
      </div>

      <div className="grid gap-6 xl:grid-cols-[1.2fr_0.8fr]">
        <Card>
          <CardHeader>
            <CardTitle>Últimos préstamos</CardTitle>
            <CardDescription>Solicitudes recientes registradas en el sistema.</CardDescription>
          </CardHeader>
          <CardContent>
            <DataTable
              caption="Préstamos recientes"
              data={prestamos.slice(0, 4)}
              columns={[
                { key: 'id', label: 'ID' },
                { key: 'usuario', label: 'Usuario solicitante' },
                { key: 'fechaDevolucion', label: 'Devolución' },
                { key: 'estado', label: 'Estado', render: (row) => <StatusBadge estado={row.estado} /> },
              ]}
            />
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Artículos por estado</CardTitle>
            <CardDescription>Distribución operativa actual.</CardDescription>
          </CardHeader>
          <CardContent>
            <SimpleChart data={articulosPorEstado} />
          </CardContent>
        </Card>
      </div>

      <div className="grid gap-6 xl:grid-cols-[1fr_380px]">
        <Card>
          <CardHeader>
            <CardTitle>Artículos recientes</CardTitle>
            <CardDescription>Últimos bienes revisados por el responsable.</CardDescription>
          </CardHeader>
          <CardContent>
            <DataTable
              caption="Artículos revisados recientemente"
              data={articulos.slice(0, 4)}
              columns={[
                { key: 'codigo', label: 'Código' },
                { key: 'nombre', label: 'Nombre' },
                { key: 'categoria', label: 'Categoría' },
                { key: 'estado', label: 'Estado', render: (row) => <StatusBadge estado={row.estado} /> },
              ]}
            />
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Alertas institucionales</CardTitle>
            <CardDescription>Préstamos vencidos, mantenimientos pendientes y artículos prestados.</CardDescription>
          </CardHeader>
          <CardContent className="space-y-3">
            {alertas.map((alerta) => (
              <button key={alerta.mensaje} onClick={() => setActive(alerta.modulo)} className="w-full rounded-lg border border-gray-200 bg-white p-3 text-left shadow-sm transition hover:border-vino-200 hover:bg-vino-50">
                <div className="flex items-start gap-3">
                  <AlertTriangle className={`mt-0.5 h-4 w-4 ${alerta.severidad === 'alta' ? 'text-red-600' : alerta.severidad === 'media' ? 'text-amber-600' : 'text-vino-700'}`} />
                  <div>
                    <p className="text-sm font-semibold text-gray-900">{alerta.tipo}</p>
                    <p className="mt-1 text-sm leading-5 text-gray-600">{alerta.mensaje}</p>
                  </div>
                </div>
              </button>
            ))}
          </CardContent>
        </Card>
      </div>
    </section>
  )
}

function Inventario({ setActive }) {
  const [search, setSearch] = useState('')
  const [categoria, setCategoria] = useState('Todas')
  const [estado, setEstado] = useState('Todos')
  const [ubicacion, setUbicacion] = useState('Todas')
  const [responsable, setResponsable] = useState('Todos')
  const [confirmOpen, setConfirmOpen] = useState(false)

  const data = useMemo(() => {
    return articulos.filter((item) => {
      const text = `${item.codigo} ${item.nombre} ${item.serie}`.toLowerCase()
      return (
        text.includes(search.toLowerCase()) &&
        (categoria === 'Todas' || item.categoria === categoria) &&
        (estado === 'Todos' || item.estado === estado) &&
        (ubicacion === 'Todas' || item.ubicacion === ubicacion) &&
        (responsable === 'Todos' || item.responsable === responsable)
      )
    })
  }, [search, categoria, estado, ubicacion, responsable])

  return (
    <section className="space-y-4">
      <PageHeader title="Inventario" description="Gestión de artículos tecnológicos, estados, ubicaciones y responsables." actionLabel="Nuevo artículo" icon={Plus} onAction={() => setActive('nuevoArticulo')} />
      <SearchFilterBar
        search={search}
        onSearch={setSearch}
        filters={[
          { label: 'Categoría', value: categoria, onChange: setCategoria, options: categorias },
          { label: 'Estado', value: estado, onChange: setEstado, options: estadosArticulo },
          { label: 'Ubicación', value: ubicacion, onChange: setUbicacion, options: ubicaciones },
          { label: 'Responsable', value: responsable, onChange: setResponsable, options: responsables },
        ]}
      />
      <DataTable
        caption="Artículos tecnológicos registrados"
        data={data}
        columns={[
          { key: 'codigo', label: 'Código' },
          { key: 'nombre', label: 'Nombre' },
          { key: 'categoria', label: 'Categoría' },
          { key: 'estado', label: 'Estado', render: (row) => <StatusBadge estado={row.estado} /> },
          { key: 'ubicacion', label: 'Ubicación' },
          { key: 'responsable', label: 'Responsable' },
          {
            key: 'acciones',
            label: 'Acciones',
            render: () => (
              <ActionButtons
                onView={() => setActive('detalleArticulo')}
                onEdit={() => setActive('editarArticulo')}
                onDelete={() => setConfirmOpen(true)}
              />
            ),
          },
        ]}
      />
      <ConfirmDialog open={confirmOpen} onOpenChange={setConfirmOpen} title="Eliminar artículo" description="Esta acción es visual en el prototipo. En la API se validarán préstamos y auditoría antes de eliminar." confirmLabel="Eliminar" />
    </section>
  )
}

function FormularioArticulo({ setActive, modo = 'nuevo' }) {
  const esEdicion = modo === 'editar'
  return (
    <section className="space-y-4">
      <PageHeader title={esEdicion ? 'Editar artículo' : 'Nuevo artículo'} description="Registro y edición de un bien tecnológico institucional." />
      <FormSection title="Datos generales" description="Información principal para identificar y ubicar el artículo.">
        <Field label="Código institucional"><Input defaultValue="FISEI-LAP-001" /></Field>
        <Field label="Nombre"><Input defaultValue="Laptop Dell Latitude 5420" /></Field>
        <Field label="Categoría"><Select defaultValue="Computadores"><Options values={categorias.filter((item) => item !== 'Todas')} /></Select></Field>
        <Field label="Estado"><Select defaultValue="Disponible"><Options values={estadosArticulo.filter((item) => item !== 'Todos')} /></Select></Field>
        <Field label="Ubicación"><Select defaultValue="Laboratorio 1"><Options values={ubicaciones.filter((item) => item !== 'Todas')} /></Select></Field>
        <Field label="Responsable"><Select defaultValue="Responsable Laboratorio"><Options values={responsables.filter((item) => item !== 'Todos')} /></Select></Field>
        <Field label="Marca"><Input defaultValue="Dell" /></Field>
        <Field label="Modelo"><Input defaultValue="Latitude 5420" /></Field>
        <Field label="Número de serie"><Input defaultValue="DL5420-FS001" /></Field>
        <Field label="Descripción" className="sm:col-span-2"><Textarea defaultValue="Equipo portátil para docencia y prácticas de programación." /></Field>
      </FormSection>
      <div className="flex justify-end gap-2">
        <Button variant="outline" onClick={() => setActive('inventario')}>Cancelar</Button>
        <Button onClick={() => setActive('inventario')}><Save className="h-4 w-4" />Guardar</Button>
      </div>
    </section>
  )
}

function NuevoArticulo({ setActive }) {
  return <FormularioArticulo setActive={setActive} modo="nuevo" />
}

function EditarArticulo({ setActive }) {
  return <FormularioArticulo setActive={setActive} modo="editar" />
}

function Field({ label, className, children }) {
  return (
    <label className={`block text-sm font-medium text-gray-700 ${className || ''}`}>
      {label}
      <div className="mt-1">{children}</div>
    </label>
  )
}

function Options({ values }) {
  return values.map((value) => <option key={value} value={value}>{value}</option>)
}

function ActionButtons({ onView, onEdit, onDelete, extra }) {
  return (
    <div className="flex flex-wrap gap-1.5">
      {onView && (
        <Button variant="outline" size="sm" onClick={onView}>
          <Eye className="h-4 w-4" />
          Ver
        </Button>
      )}
      {onEdit && (
        <Button variant="outline" size="sm" onClick={onEdit}>
          <Edit className="h-4 w-4" />
          Editar
        </Button>
      )}
      {onDelete && (
        <Button variant="destructive" size="sm" onClick={onDelete}>
          <Trash2 className="h-4 w-4" />
          Eliminar
        </Button>
      )}
      {extra}
    </div>
  )
}

function DetalleArticulo() {
  const articulo = articulos[0]
  return (
    <section className="space-y-6">
      <PageHeader title="Detalle de artículo" description="Información, estado actual e historial operativo." />
      <div className="grid gap-6 xl:grid-cols-[380px_1fr]">
        <Card>
          <CardHeader>
            <CardTitle>{articulo.nombre}</CardTitle>
            <CardDescription>{articulo.codigo}</CardDescription>
          </CardHeader>
          <CardContent className="space-y-3">
            <div className="flex h-48 items-center justify-center rounded-lg bg-gray-100 text-sm text-gray-500">Fotografía del artículo</div>
            <Info label="Estado actual" value={<StatusBadge estado={articulo.estado} />} />
            <Info label="Ubicación actual" value={articulo.ubicacion} />
            <Info label="Responsable" value={articulo.responsable} />
            <Info label="Marca / Modelo" value={`${articulo.marca} ${articulo.modelo}`} />
            <Info label="Serie" value={articulo.serie} />
          </CardContent>
        </Card>
        <div className="space-y-6">
          <Historial title="Historial de préstamos" data={prestamos.slice(0, 3)} columns={[
            { key: 'id', label: 'ID' },
            { key: 'usuario', label: 'Usuario' },
            { key: 'fechaPrestamo', label: 'Préstamo' },
            { key: 'estado', label: 'Estado', render: (row) => <StatusBadge estado={row.estado} /> },
          ]} />
          <Historial title="Historial de mantenimientos" data={mantenimientos} columns={[
            { key: 'tipo', label: 'Tipo' },
            { key: 'fecha', label: 'Fecha' },
            { key: 'estado', label: 'Estado', render: (row) => <StatusBadge estado={row.estado} /> },
            { key: 'observacion', label: 'Observación' },
          ]} />
          <Historial title="Historial de movimientos" data={movimientos} columns={[
            { key: 'tipo', label: 'Tipo' },
            { key: 'fecha', label: 'Fecha' },
            { key: 'origen', label: 'Origen' },
            { key: 'destino', label: 'Destino' },
          ]} />
        </div>
      </div>
    </section>
  )
}

function Info({ label, value }) {
  return <div className="flex items-center justify-between gap-3 border-b border-gray-100 py-2 text-sm"><span className="text-gray-500">{label}</span><span className="font-medium text-gray-900">{value}</span></div>
}

function Historial({ title, data, columns }) {
  return (
    <Card>
      <CardHeader>
        <CardTitle>{title}</CardTitle>
      </CardHeader>
      <CardContent>
        <DataTable data={data} columns={columns} />
      </CardContent>
    </Card>
  )
}

function Prestamos({ setActive }) {
  const [search, setSearch] = useState('')
  const [estado, setEstado] = useState('Todos')
  const data = useMemo(() => {
    return prestamos.filter((item) => {
      const text = `${item.id} ${item.usuario}`.toLowerCase()
      return text.includes(search.toLowerCase()) && (estado === 'Todos' || item.estado === estado)
    })
  }, [search, estado])

  return (
    <section className="space-y-4">
      <PageHeader title="Préstamos" description="Registro, seguimiento y devolución de equipos tecnológicos." actionLabel="Nuevo préstamo" icon={Plus} onAction={() => setActive('nuevoPrestamo')} />
      <SearchFilterBar
        search={search}
        onSearch={setSearch}
        placeholder="Buscar por ID o usuario solicitante"
        filters={[
          { label: 'Estado', value: estado, onChange: setEstado, options: ['Todos', 'Activo', 'Devuelto', 'Vencido'] },
        ]}
      />
      <DataTable
        caption="Préstamos registrados"
        data={data}
        columns={[
          { key: 'id', label: 'ID' },
          { key: 'usuario', label: 'Usuario solicitante' },
          { key: 'fechaPrestamo', label: 'Fecha préstamo' },
          { key: 'fechaDevolucion', label: 'Fecha devolución' },
          { key: 'estado', label: 'Estado', render: (row) => <StatusBadge estado={row.estado} /> },
          {
            key: 'acciones',
            label: 'Acciones',
            render: (row) => (
              <ActionButtons
                onView={() => setActive('detalleArticulo')}
                extra={
                  <Button variant="outline" size="sm" disabled={row.estado === 'Devuelto'} onClick={() => setActive('registrarDevolucion')}>
                    <RotateCcw className="h-4 w-4" />
                    Registrar devolución
                  </Button>
                }
              />
            ),
          },
        ]}
      />
    </section>
  )
}

function FormularioPrestamo({ setActive }) {
  return (
    <section className="space-y-4">
      <PageHeader title="Nuevo préstamo" description="Solicitud y asignación temporal de artículos." />
      <FormSection title="Datos del préstamo">
        <Field label="Usuario"><Select defaultValue="Docente Sistemas"><Options values={usuarios.map((item) => item.nombre)} /></Select></Field>
        <Field label="Artículos"><Select multiple className="h-28"><Options values={articulos.filter((item) => item.estado === 'Disponible').map((item) => `${item.codigo} - ${item.nombre}`)} /></Select></Field>
        <Field label="Fecha de préstamo"><Input type="date" defaultValue="2026-05-05" /></Field>
        <Field label="Fecha prevista de devolución"><Input type="date" defaultValue="2026-05-12" /></Field>
        <Field label="Observación" className="sm:col-span-2"><Textarea defaultValue="Préstamo para clase práctica de laboratorio." /></Field>
      </FormSection>
      <div className="flex justify-end gap-2">
        <Button variant="outline" onClick={() => setActive('prestamos')}>Cancelar</Button>
        <Button onClick={() => setActive('prestamos')}><FilePlus2 className="h-4 w-4" />Registrar préstamo</Button>
      </div>
    </section>
  )
}

function RegistrarDevolucion({ setActive }) {
  return (
    <section className="space-y-4">
      <PageHeader title="Registrar devolución" description="Cierre visual de préstamo y revisión del estado del artículo." />
      <FormSection title="Datos de devolución" description="Formulario preparado para conectarse luego al endpoint de devoluciones.">
        <Field label="Préstamo"><Select defaultValue="PR-1001"><Options values={prestamos.filter((item) => item.estado !== 'Devuelto').map((item) => `${item.id} - ${item.usuario}`)} /></Select></Field>
        <Field label="Fecha de devolución"><Input type="date" defaultValue="2026-05-05" /></Field>
        <Field label="Estado del artículo"><Select defaultValue="Disponible"><Options values={['Disponible', 'Mantenimiento', 'Baja']} /></Select></Field>
        <Field label="Responsable que recibe"><Select defaultValue="Responsable Laboratorio"><Options values={responsables.filter((item) => item !== 'Todos')} /></Select></Field>
        <Field label="Observación" className="sm:col-span-2"><Textarea defaultValue="Artículo devuelto sin novedades visibles." /></Field>
      </FormSection>
      <div className="flex justify-end gap-2">
        <Button variant="outline" onClick={() => setActive('prestamos')}>Cancelar</Button>
        <Button onClick={() => setActive('prestamos')}><RotateCcw className="h-4 w-4" />Guardar devolución</Button>
      </div>
    </section>
  )
}

function Mantenimientos({ setActive }) {
  const [search, setSearch] = useState('')
  const [tipo, setTipo] = useState('Todos')
  const [estado, setEstado] = useState('Todos')
  const data = useMemo(() => {
    return mantenimientos.filter((item) => {
      const text = `${item.articulo} ${item.observacion}`.toLowerCase()
      return (
        text.includes(search.toLowerCase()) &&
        (tipo === 'Todos' || item.tipo === tipo) &&
        (estado === 'Todos' || item.estado === estado)
      )
    })
  }, [search, tipo, estado])

  return (
    <section className="space-y-4">
      <PageHeader title="Mantenimientos" description="Agenda y control técnico preventivo y correctivo." actionLabel="Nuevo mantenimiento" icon={Plus} />
      <SearchFilterBar
        search={search}
        onSearch={setSearch}
        placeholder="Buscar por artículo u observación"
        filters={[
          { label: 'Tipo', value: tipo, onChange: setTipo, options: ['Todos', 'Preventivo', 'Correctivo'] },
          { label: 'Estado', value: estado, onChange: setEstado, options: ['Todos', 'Pendiente', 'En proceso', 'Finalizado'] },
        ]}
      />
      <DataTable caption="Mantenimientos planificados" data={data} columns={[
        { key: 'articulo', label: 'Artículo' },
        { key: 'tipo', label: 'Tipo', render: (row) => <Badge variant="vino">{row.tipo}</Badge> },
        { key: 'fecha', label: 'Fecha' },
        { key: 'estado', label: 'Estado', render: (row) => <StatusBadge estado={row.estado} /> },
        { key: 'observacion', label: 'Observación' },
        { key: 'acciones', label: 'Acciones', render: () => <ActionButtons onView={() => setActive('detalleArticulo')} onEdit={() => setActive('mantenimientos')} onDelete={() => setActive('mantenimientos')} /> },
      ]} />
    </section>
  )
}

function Movimientos() {
  const [search, setSearch] = useState('')
  const [tipo, setTipo] = useState('Todos')
  const data = useMemo(() => {
    return movimientos.filter((item) => {
      const text = `${item.articulo} ${item.origen} ${item.destino} ${item.observacion}`.toLowerCase()
      return text.includes(search.toLowerCase()) && (tipo === 'Todos' || item.tipo === tipo)
    })
  }, [search, tipo])

  return (
    <section className="space-y-4">
      <PageHeader title="Movimientos" description="Trazabilidad de ubicaciones y situación de artículos." />
      <SearchFilterBar
        search={search}
        onSearch={setSearch}
        placeholder="Buscar por artículo, ubicación u observación"
        filters={[
          { label: 'Tipo', value: tipo, onChange: setTipo, options: ['Todos', 'Ingreso', 'Traslado', 'Préstamo', 'Devolución', 'Mantenimiento'] },
        ]}
      />
      <DataTable caption="Historial de movimientos" data={data} columns={[
        { key: 'articulo', label: 'Artículo' },
        { key: 'tipo', label: 'Tipo', render: (row) => <StatusBadge estado={row.tipo} /> },
        { key: 'fecha', label: 'Fecha' },
        { key: 'origen', label: 'Ubicación origen' },
        { key: 'destino', label: 'Ubicación destino' },
        { key: 'observacion', label: 'Observación' },
      ]} />
    </section>
  )
}

function Usuarios({ setActive }) {
  const [search, setSearch] = useState('')
  const [rol, setRol] = useState('Todos')
  const [estado, setEstado] = useState('Todos')
  const data = useMemo(() => {
    return usuarios.filter((item) => {
      const text = `${item.nombre} ${item.correo}`.toLowerCase()
      return (
        text.includes(search.toLowerCase()) &&
        (rol === 'Todos' || item.rol === rol) &&
        (estado === 'Todos' || item.estado === estado)
      )
    })
  }, [search, rol, estado])

  return (
    <section className="space-y-4">
      <PageHeader title="Usuarios" description="Usuarios académicos, roles y estado de acceso." actionLabel="Nuevo usuario" icon={Plus} />
      <SearchFilterBar
        search={search}
        onSearch={setSearch}
        placeholder="Buscar por nombre o correo"
        filters={[
          { label: 'Rol', value: rol, onChange: setRol, options: ['Todos', 'Administrador', 'Responsable', 'Docente', 'Estudiante'] },
          { label: 'Estado', value: estado, onChange: setEstado, options: ['Todos', 'Activo', 'Inactivo'] },
        ]}
      />
      <DataTable caption="Usuarios del sistema" data={data} columns={[
        { key: 'nombre', label: 'Nombre' },
        { key: 'correo', label: 'Correo' },
        { key: 'rol', label: 'Rol', render: (row) => <Badge variant="vino">{row.rol}</Badge> },
        { key: 'estado', label: 'Estado', render: (row) => <StatusBadge estado={row.estado} /> },
        { key: 'acciones', label: 'Acciones', render: () => <ActionButtons onView={() => setActive('usuarios')} onEdit={() => setActive('usuarios')} onDelete={() => setActive('usuarios')} /> },
      ]} />
    </section>
  )
}

function Ubicaciones({ setActive }) {
  const [search, setSearch] = useState('')
  const [estado, setEstado] = useState('Todos')
  const data = useMemo(() => {
    return ubicacionesCatalogo.filter((item) => {
      const text = `${item.nombre} ${item.departamento}`.toLowerCase()
      return text.includes(search.toLowerCase()) && (estado === 'Todos' || item.estado === estado)
    })
  }, [search, estado])

  return (
    <section className="space-y-4">
      <PageHeader title="Ubicaciones" description="Espacios académicos y administrativos donde se encuentran los artículos." actionLabel="Nueva ubicación" icon={MapPin} />
      <SearchFilterBar
        search={search}
        onSearch={setSearch}
        placeholder="Buscar por ubicación o departamento"
        filters={[
          { label: 'Estado', value: estado, onChange: setEstado, options: ['Todos', 'Activo', 'Inactivo'] },
        ]}
      />
      <DataTable caption="Ubicaciones institucionales" data={data} columns={[
        { key: 'nombre', label: 'Ubicación' },
        { key: 'departamento', label: 'Departamento' },
        { key: 'estado', label: 'Estado', render: (row) => <StatusBadge estado={row.estado} /> },
        { key: 'acciones', label: 'Acciones', render: () => <ActionButtons onView={() => setActive('ubicaciones')} onEdit={() => setActive('ubicaciones')} onDelete={() => setActive('ubicaciones')} /> },
      ]} />
    </section>
  )
}

function Categorias({ setActive }) {
  const [search, setSearch] = useState('')
  const [estado, setEstado] = useState('Todos')
  const data = useMemo(() => {
    return categoriasCatalogo.filter((item) => {
      const text = `${item.nombre} ${item.descripcion}`.toLowerCase()
      return text.includes(search.toLowerCase()) && (estado === 'Todos' || item.estado === estado)
    })
  }, [search, estado])

  return (
    <section className="space-y-4">
      <PageHeader title="Categorías" description="Clasificación académica de los artículos tecnológicos." actionLabel="Nueva categoría" icon={FolderTree} />
      <SearchFilterBar
        search={search}
        onSearch={setSearch}
        placeholder="Buscar por categoría o descripción"
        filters={[
          { label: 'Estado', value: estado, onChange: setEstado, options: ['Todos', 'Activo', 'Inactivo'] },
        ]}
      />
      <DataTable caption="Categorías del inventario" data={data} columns={[
        { key: 'nombre', label: 'Categoría' },
        { key: 'descripcion', label: 'Descripción' },
        { key: 'estado', label: 'Estado', render: (row) => <StatusBadge estado={row.estado} /> },
        { key: 'acciones', label: 'Acciones', render: () => <ActionButtons onView={() => setActive('categorias')} onEdit={() => setActive('categorias')} onDelete={() => setActive('categorias')} /> },
      ]} />
    </section>
  )
}

function Reportes() {
  const reportes = [
    ['Artículos disponibles', resumen.disponibles, CheckCircle2, 'green'],
    ['Préstamos activos', prestamos.filter((item) => item.estado === 'Activo').length, ClipboardList, 'vino'],
    ['Préstamos vencidos', resumen.vencidos, AlertTriangle, 'red'],
    ['Mantenimientos pendientes', resumen.mantenimientosPendientes, Wrench, 'amber'],
    ['Artículos por categoría', categorias.length - 1, BarChart3, 'gray'],
    ['Artículos por departamento', 4, Boxes, 'vino'],
  ]
  return (
    <section className="space-y-6">
      <PageHeader title="Reportes" description="Resúmenes operativos para seguimiento institucional." />
      <div className="grid gap-4 sm:grid-cols-2 xl:grid-cols-3">
        {reportes.map(([label, value, Icon, tone]) => <StatCard key={label} label={label} value={value} icon={Icon} tone={tone} />)}
      </div>
      <Card>
        <CardHeader>
          <CardTitle>Artículos por categoría</CardTitle>
          <CardDescription>Conteo simulado según catálogos del inventario.</CardDescription>
        </CardHeader>
        <CardContent>
          <DataTable caption="Resumen por categoría" data={[
            { categoria: 'Computadores', total: 52 },
            { categoria: 'Proyectores', total: 18 },
            { categoria: 'Redes', total: 31 },
            { categoria: 'Impresión', total: 12 },
          ]} columns={[{ key: 'categoria', label: 'Categoría' }, { key: 'total', label: 'Total' }]} />
        </CardContent>
      </Card>
    </section>
  )
}

function Auditoria() {
  const [search, setSearch] = useState('')
  const [usuario, setUsuario] = useState('Todos')
  const [accion, setAccion] = useState('Todas')
  const [fecha, setFecha] = useState('')
  const data = auditoria.filter((item) => {
    const text = `${item.usuario} ${item.accion} ${item.tabla} ${item.descripcion}`.toLowerCase()
    return (
      text.includes(search.toLowerCase()) &&
      (usuario === 'Todos' || item.usuario === usuario) &&
      (accion === 'Todas' || item.accion === accion) &&
      (!fecha || item.fecha.startsWith(fecha))
    )
  })
  return (
    <section className="space-y-4">
      <PageHeader title="Auditoría" description="Registro visual de acciones críticas del sistema." />
      <div className="grid gap-3 rounded-lg border border-gray-200 bg-white p-4 shadow-sm md:grid-cols-2 xl:grid-cols-4">
        <Input placeholder="Buscar en auditoría" value={search} onChange={(event) => setSearch(event.target.value)} />
        <Select value={usuario} onChange={(event) => setUsuario(event.target.value)}><Options values={['Todos', ...usuarios.map((item) => item.nombre)]} /></Select>
        <Select value={accion} onChange={(event) => setAccion(event.target.value)}><Options values={['Todas', 'INSERT', 'UPDATE', 'DELETE', 'LOGIN', 'PRESTAMO', 'DEVOLUCION']} /></Select>
        <Input type="date" value={fecha} onChange={(event) => setFecha(event.target.value)} />
      </div>
      <DataTable caption="Eventos auditados" data={data} columns={[
        { key: 'usuario', label: 'Usuario' },
        { key: 'accion', label: 'Acción', render: (row) => <Badge variant="vino">{row.accion}</Badge> },
        { key: 'tabla', label: 'Tabla afectada' },
        { key: 'fecha', label: 'Fecha' },
        { key: 'descripcion', label: 'Descripción' },
      ]} />
    </section>
  )
}

const views = {
  dashboard: Dashboard,
  inventario: Inventario,
  nuevoArticulo: NuevoArticulo,
  editarArticulo: EditarArticulo,
  detalleArticulo: DetalleArticulo,
  prestamos: Prestamos,
  nuevoPrestamo: FormularioPrestamo,
  registrarDevolucion: RegistrarDevolucion,
  mantenimientos: Mantenimientos,
  movimientos: Movimientos,
  usuarios: Usuarios,
  ubicaciones: Ubicaciones,
  categorias: Categorias,
  reportes: Reportes,
  auditoria: Auditoria,
}

export default function App() {
  const [logged, setLogged] = useState(false)
  const [active, setActive] = useState('dashboard')
  const View = views[active]

  if (!logged) {
    return <Login onLogin={() => setLogged(true)} />
  }

  return (
    <Layout active={active} setActive={setActive} onLogout={() => setLogged(false)}>
      <View setActive={setActive} />
    </Layout>
  )
}
