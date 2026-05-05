export const usuarioActual = {
  nombre: 'Ing. Daniela Salazar',
  rol: 'Administrador',
  correo: 'admin@fisei.edu.ec',
}

export const resumen = {
  totalArticulos: 148,
  disponibles: 96,
  prestados: 31,
  mantenimiento: 14,
  vencidos: 5,
  mantenimientosPendientes: 9,
}

export const articulos = [
  {
    id: 1,
    codigo: 'FISEI-LAP-001',
    nombre: 'Laptop Dell Latitude 5420',
    categoria: 'Computadores',
    estado: 'Disponible',
    ubicacion: 'Laboratorio 1',
    responsable: 'Responsable Laboratorio',
    marca: 'Dell',
    modelo: 'Latitude 5420',
    serie: 'DL5420-FS001',
    descripcion: 'Equipo portátil para docencia y prácticas de programación.',
  },
  {
    id: 2,
    codigo: 'FISEI-PRO-014',
    nombre: 'Proyector Epson X49',
    categoria: 'Proyectores',
    estado: 'Prestado',
    ubicacion: 'Aula 401',
    responsable: 'Docente Sistemas',
    marca: 'Epson',
    modelo: 'X49',
    serie: 'EPX49-8891',
    descripcion: 'Proyector multimedia para aulas teóricas.',
  },
  {
    id: 3,
    codigo: 'FISEI-RED-007',
    nombre: 'Switch Cisco 24 puertos',
    categoria: 'Redes',
    estado: 'Disponible',
    ubicacion: 'Laboratorio 2',
    responsable: 'Responsable Laboratorio',
    marca: 'Cisco',
    modelo: 'SG350',
    serie: 'CSG350-24P',
    descripcion: 'Switch administrable para prácticas de redes.',
  },
  {
    id: 4,
    codigo: 'FISEI-IMP-003',
    nombre: 'Impresora HP LaserJet',
    categoria: 'Impresión',
    estado: 'Mantenimiento',
    ubicacion: 'Bodega Tecnológica',
    responsable: 'Soporte Técnico',
    marca: 'HP',
    modelo: 'LaserJet Pro',
    serie: 'HPLJ-2026-03',
    descripcion: 'Impresora institucional en revisión preventiva.',
  },
  {
    id: 5,
    codigo: 'FISEI-TAB-010',
    nombre: 'Tablet Samsung Galaxy',
    categoria: 'Tablets',
    estado: 'Baja',
    ubicacion: 'Bodega Tecnológica',
    responsable: 'Sin asignar',
    marca: 'Samsung',
    modelo: 'Galaxy Tab A',
    serie: 'SM-T510-UTA',
    descripcion: 'Equipo retirado por fin de vida útil.',
  },
]

export const prestamos = [
  { id: 'PR-1001', usuario: 'Mg. Carlos Molina', fechaPrestamo: '2026-05-01', fechaDevolucion: '2026-05-08', estado: 'Activo' },
  { id: 'PR-1002', usuario: 'Karen Núñez', fechaPrestamo: '2026-04-27', fechaDevolucion: '2026-05-04', estado: 'Vencido' },
  { id: 'PR-1003', usuario: 'Camila Espín', fechaPrestamo: '2026-04-20', fechaDevolucion: '2026-04-25', estado: 'Devuelto' },
  { id: 'PR-1004', usuario: 'Bryan Guatemal', fechaPrestamo: '2026-05-03', fechaDevolucion: '2026-05-10', estado: 'Activo' },
]

export const mantenimientos = [
  { articulo: 'Impresora HP LaserJet', tipo: 'Preventivo', fecha: '2026-05-08', estado: 'Pendiente', observacion: 'Revisión de tóner y rodillos.' },
  { articulo: 'Switch Cisco 24 puertos', tipo: 'Correctivo', fecha: '2026-05-03', estado: 'Finalizado', observacion: 'Cambio de fuente de poder.' },
  { articulo: 'Laptop Dell Latitude 5420', tipo: 'Preventivo', fecha: '2026-05-12', estado: 'En proceso', observacion: 'Actualización de sistema operativo.' },
]

export const movimientos = [
  { articulo: 'Laptop Dell Latitude 5420', tipo: 'Traslado', fecha: '2026-05-02', origen: 'Bodega Tecnológica', destino: 'Laboratorio 1', observacion: 'Asignación a laboratorio.' },
  { articulo: 'Proyector Epson X49', tipo: 'Préstamo', fecha: '2026-05-01', origen: 'Aula 401', destino: 'Docente Sistemas', observacion: 'Clase práctica.' },
  { articulo: 'Switch Cisco 24 puertos', tipo: 'Ingreso', fecha: '2026-04-25', origen: 'Proveedor', destino: 'Laboratorio 2', observacion: 'Ingreso inicial.' },
  { articulo: 'Impresora HP LaserJet', tipo: 'Mantenimiento', fecha: '2026-05-04', origen: 'Administración', destino: 'Soporte Técnico', observacion: 'Revisión preventiva.' },
]

export const usuarios = [
  { nombre: 'Administrador FISEI', correo: 'admin@fisei.edu.ec', rol: 'Administrador', estado: 'Activo' },
  { nombre: 'Responsable Laboratorio', correo: 'responsable@fisei.edu.ec', rol: 'Responsable', estado: 'Activo' },
  { nombre: 'Docente Sistemas', correo: 'docente@fisei.edu.ec', rol: 'Docente', estado: 'Activo' },
  { nombre: 'Estudiante Software', correo: 'estudiante@fisei.edu.ec', rol: 'Estudiante', estado: 'Inactivo' },
]

export const auditoria = [
  { usuario: 'Administrador FISEI', accion: 'INSERT', tabla: 'ARTICULO', fecha: '2026-05-05 09:30', descripcion: 'Registro de nuevo artículo FISEI-LAP-001.' },
  { usuario: 'Responsable Laboratorio', accion: 'PRESTAMO', tabla: 'PRESTAMO', fecha: '2026-05-04 14:20', descripcion: 'Préstamo registrado para docente.' },
  { usuario: 'Administrador FISEI', accion: 'UPDATE', tabla: 'ARTICULO', fecha: '2026-05-03 11:10', descripcion: 'Cambio de estado a mantenimiento.' },
  { usuario: 'Responsable Laboratorio', accion: 'DEVOLUCION', tabla: 'PRESTAMO', fecha: '2026-05-02 16:45', descripcion: 'Devolución registrada sin novedades.' },
]

export const articulosPorEstado = [
  { estado: 'Disponible', total: 96, color: 'bg-emerald-500' },
  { estado: 'Prestado', total: 31, color: 'bg-vino-600' },
  { estado: 'Mantenimiento', total: 14, color: 'bg-amber-500' },
  { estado: 'Baja', total: 7, color: 'bg-gray-500' },
]

export const alertas = [
  {
    tipo: 'Préstamo vencido',
    mensaje: 'El préstamo PR-1002 está vencido desde el 04/05/2026.',
    modulo: 'prestamos',
    severidad: 'alta',
  },
  {
    tipo: 'Mantenimiento pendiente',
    mensaje: 'Hay nueve mantenimientos pendientes de planificación.',
    modulo: 'mantenimientos',
    severidad: 'media',
  },
  {
    tipo: 'Artículos prestados',
    mensaje: 'Treinta y un artículos se encuentran actualmente prestados.',
    modulo: 'inventario',
    severidad: 'info',
  },
  {
    tipo: 'Devolución próxima',
    mensaje: 'Tres préstamos vencen en las próximas 48 horas.',
    modulo: 'prestamos',
    severidad: 'media',
  },
]

export const categorias = ['Todas', 'Computadores', 'Proyectores', 'Redes', 'Impresión', 'Tablets']
export const estadosArticulo = ['Todos', 'Disponible', 'Prestado', 'Mantenimiento', 'Baja']
export const ubicaciones = ['Todas', 'Laboratorio 1', 'Laboratorio 2', 'Aula 401', 'Bodega Tecnológica']
export const responsables = ['Todos', 'Responsable Laboratorio', 'Docente Sistemas', 'Soporte Técnico', 'Sin asignar']

export const ubicacionesCatalogo = [
  { id: 1, nombre: 'Laboratorio 1', departamento: 'Ingeniería en Software', estado: 'Activo' },
  { id: 2, nombre: 'Laboratorio 2', departamento: 'Tecnologías de la Información', estado: 'Activo' },
  { id: 3, nombre: 'Aula 401', departamento: 'Docencia FISEI', estado: 'Activo' },
  { id: 4, nombre: 'Bodega Tecnológica', departamento: 'Administración', estado: 'Activo' },
]

export const categoriasCatalogo = [
  { id: 1, nombre: 'Computadores', descripcion: 'Equipos de escritorio y portátiles', estado: 'Activo' },
  { id: 2, nombre: 'Proyectores', descripcion: 'Equipos multimedia para docencia', estado: 'Activo' },
  { id: 3, nombre: 'Redes', descripcion: 'Switches, routers y equipos de conectividad', estado: 'Activo' },
  { id: 4, nombre: 'Impresión', descripcion: 'Impresoras y consumibles tecnológicos', estado: 'Activo' },
  { id: 5, nombre: 'Tablets', descripcion: 'Dispositivos móviles académicos', estado: 'Inactivo' },
]
