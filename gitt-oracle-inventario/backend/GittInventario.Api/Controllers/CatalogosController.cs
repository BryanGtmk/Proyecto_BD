using GittInventario.Infrastructure.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace GittInventario.Api.Controllers;

[ApiController]
[Authorize]
[Route("api/roles")]
public class RolesController(GittInventarioDbContext db) : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> GetAll() => Ok(await db.Roles.OrderBy(r => r.NombreRol).ToListAsync());
}

[ApiController]
[Authorize]
[Route("api/categorias")]
public class CategoriasController(GittInventarioDbContext db) : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> GetAll() => Ok(await db.Categorias.OrderBy(c => c.Nombre).ToListAsync());
}

[ApiController]
[Authorize]
[Route("api/departamentos")]
public class DepartamentosController(GittInventarioDbContext db) : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> GetAll() => Ok(await db.Departamentos.OrderBy(d => d.Nombre).ToListAsync());
}

[ApiController]
[Authorize]
[Route("api/ubicaciones")]
public class UbicacionesController(GittInventarioDbContext db) : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> GetAll() => Ok(await db.Ubicaciones.Include(u => u.Departamento).OrderBy(u => u.Nombre).ToListAsync());
}

[ApiController]
[Authorize]
[Route("api/notificaciones")]
public class NotificacionesController(GittInventarioDbContext db) : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> GetAll() => Ok(await db.Notificaciones.Include(n => n.Prestamo).OrderByDescending(n => n.FechaCreacion).ToListAsync());
}
