import api from '../api/client'

export async function loadCatalogs() {
  const [categorias, ubicaciones, usuarios, roles] = await Promise.all([
    api.get('/categorias'),
    api.get('/ubicaciones'),
    api.get('/usuarios').catch(() => ({ data: [] })),
    api.get('/roles'),
  ])
  return {
    categorias: categorias.data,
    ubicaciones: ubicaciones.data,
    usuarios: usuarios.data,
    roles: roles.data,
  }
}
