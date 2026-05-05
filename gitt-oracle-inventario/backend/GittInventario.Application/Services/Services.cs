using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using GittInventario.Application.DTOs;
using GittInventario.Domain.Entities;
using GittInventario.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;

namespace GittInventario.Application.Services;

public class AuthService(GittInventarioDbContext db, IConfiguration configuration)
{
    public async Task<LoginResponseDto?> LoginAsync(LoginDto dto)
    {
        var usuario = await db.Usuarios.Include(u => u.Rol).FirstOrDefaultAsync(u => u.Correo == dto.Correo);
        if (usuario is null || usuario.Contrasena != dto.Contrasena)
        {
            return null;
        }

        db.Auditorias.Add(new Auditoria
        {
            Accion = "LOGIN",
            Fecha = DateTime.Now,
            IdUsuario = usuario.IdUsuario,
            Tabla = "USUARIO",
            Descripcion = $"Inicio de sesion de {usuario.Correo}"
        });
        await db.SaveChangesAsync();

        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(configuration["Jwt:Key"]!));
        var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
        var claims = new[]
        {
            new Claim(JwtRegisteredClaimNames.Sub, usuario.IdUsuario.ToString()),
            new Claim(ClaimTypes.NameIdentifier, usuario.IdUsuario.ToString()),
            new Claim(ClaimTypes.Name, usuario.Nombre),
            new Claim(ClaimTypes.Email, usuario.Correo),
            new Claim(ClaimTypes.Role, usuario.Rol?.NombreRol ?? "Estudiante")
        };
        var token = new JwtSecurityToken(
            issuer: configuration["Jwt:Issuer"],
            audience: configuration["Jwt:Audience"],
            claims: claims,
            expires: DateTime.UtcNow.AddHours(8),
            signingCredentials: credentials);

        return new LoginResponseDto(new JwtSecurityTokenHandler().WriteToken(token), usuario.Nombre, usuario.Correo, usuario.Rol?.NombreRol ?? string.Empty);
    }
}

public class UsuarioService(GittInventarioDbContext db)
{
    public Task<List<Usuario>> GetAllAsync() => db.Usuarios.Include(u => u.Rol).OrderBy(u => u.Nombre).ToListAsync();

    public async Task<Usuario> CreateAsync(UsuarioCreateDto dto)
    {
        var usuario = new Usuario { Nombre = dto.Nombre, Correo = dto.Correo, Contrasena = dto.Contrasena, IdRol = dto.IdRol, FechaCreacion = DateTime.Now };
        db.Usuarios.Add(usuario);
        await db.SaveChangesAsync();
        return usuario;
    }
}

public class ArticuloService(GittInventarioDbContext db)
{
    public Task<List<ArticuloListDto>> GetAllAsync() =>
        db.Articulos
            .Include(a => a.Categoria)
            .Include(a => a.Ubicacion)!.ThenInclude(u => u!.Departamento)
            .Include(a => a.Responsable)
            .Include(a => a.Imagenes)
            .OrderBy(a => a.Nombre)
            .Select(a => new ArticuloListDto(
                a.IdArticulo,
                a.Nombre,
                a.Codigo,
                a.Estado,
                a.Categoria!.Nombre,
                a.Ubicacion!.Nombre,
                a.Ubicacion.Departamento!.Nombre,
                a.Responsable != null ? a.Responsable.Nombre : null,
                a.ValorEstimado,
                a.Imagenes.Where(i => i.EsPrincipal == "S").Select(i => i.UrlImagen).FirstOrDefault()))
            .ToListAsync();

    public Task<Articulo?> GetByIdAsync(int id) =>
        db.Articulos.Include(a => a.Categoria).Include(a => a.Ubicacion).Include(a => a.Responsable).Include(a => a.Imagenes).FirstOrDefaultAsync(a => a.IdArticulo == id);

    public async Task<Articulo> CreateAsync(ArticuloCreateDto dto)
    {
        var articulo = new Articulo
        {
            Nombre = dto.Nombre,
            Codigo = dto.Codigo,
            Estado = dto.Estado,
            IdCategoria = dto.IdCategoria,
            IdUbicacion = dto.IdUbicacion,
            IdResponsable = dto.IdResponsable,
            ValorEstimado = dto.ValorEstimado,
            Descripcion = dto.Descripcion,
            FechaCreacion = DateTime.Now
        };
        if (!string.IsNullOrWhiteSpace(dto.UrlImagen))
        {
            articulo.Imagenes.Add(new ImagenArticulo { UrlImagen = dto.UrlImagen, EsPrincipal = "S", FechaCreacion = DateTime.Now, Descripcion = "Imagen principal del articulo" });
        }
        db.Articulos.Add(articulo);
        await db.SaveChangesAsync();
        return articulo;
    }

    public async Task<bool> UpdateAsync(int id, ArticuloUpdateDto dto)
    {
        var articulo = await db.Articulos.FindAsync(id);
        if (articulo is null) return false;
        articulo.Nombre = dto.Nombre;
        articulo.Codigo = dto.Codigo;
        articulo.Estado = dto.Estado;
        articulo.IdCategoria = dto.IdCategoria;
        articulo.IdUbicacion = dto.IdUbicacion;
        articulo.IdResponsable = dto.IdResponsable;
        articulo.ValorEstimado = dto.ValorEstimado;
        articulo.Descripcion = dto.Descripcion;
        articulo.FechaActualizacion = DateTime.Now;
        if (!string.IsNullOrWhiteSpace(dto.UrlImagen))
        {
            var imagen = await db.ImagenesArticulo.FirstOrDefaultAsync(i => i.IdArticulo == id && i.EsPrincipal == "S");
            if (imagen is null)
            {
                db.ImagenesArticulo.Add(new ImagenArticulo { IdArticulo = id, UrlImagen = dto.UrlImagen, EsPrincipal = "S", FechaCreacion = DateTime.Now, Descripcion = "Imagen principal del articulo" });
            }
            else
            {
                imagen.UrlImagen = dto.UrlImagen;
            }
        }
        await db.SaveChangesAsync();
        return true;
    }

    public async Task<bool> DeleteAsync(int id)
    {
        var articulo = await db.Articulos.FindAsync(id);
        if (articulo is null) return false;
        db.Articulos.Remove(articulo);
        await db.SaveChangesAsync();
        return true;
    }
}

public class PrestamoService(GittInventarioDbContext db)
{
    public Task<List<Prestamo>> GetAllAsync() =>
        db.Prestamos.Include(p => p.Usuario).Include(p => p.Detalles).ThenInclude(d => d.Articulo).OrderByDescending(p => p.FechaPrestamo).ToListAsync();

    public Task<Prestamo?> GetByIdAsync(int id) =>
        db.Prestamos.Include(p => p.Usuario).Include(p => p.Detalles).ThenInclude(d => d.Articulo).Include(p => p.Notificaciones).FirstOrDefaultAsync(p => p.IdPrestamo == id);

    public async Task<(bool Ok, string? Error, Prestamo? Prestamo)> CreateAsync(PrestamoCreateDto dto)
    {
        var articulos = dto.Articulos.Distinct().ToList();
        var ocupados = await db.Articulos.Where(a => articulos.Contains(a.IdArticulo) && a.Estado != "DISPONIBLE").Select(a => a.Codigo).ToListAsync();
        if (ocupados.Count > 0) return (false, "Articulos no disponibles: " + string.Join(", ", ocupados), null);

        var prestamo = new Prestamo
        {
            FechaPrestamo = DateTime.Now,
            FechaDevolucion = dto.FechaDevolucion,
            IdUsuario = dto.IdUsuario,
            Estado = "ACTIVO",
            Observacion = dto.Observacion
        };
        foreach (var idArticulo in articulos)
        {
            prestamo.Detalles.Add(new DetallePrestamo { IdArticulo = idArticulo });
        }
        db.Prestamos.Add(prestamo);
        await db.SaveChangesAsync();
        return (true, null, prestamo);
    }

    public async Task<bool> DevolverAsync(int id, DevolucionDto dto)
    {
        var prestamo = await db.Prestamos.FirstOrDefaultAsync(p => p.IdPrestamo == id);
        if (prestamo is null) return false;
        prestamo.Estado = "DEVUELTO";
        prestamo.FechaDevolucion = DateTime.Now;
        prestamo.Observacion = dto.Observacion ?? prestamo.Observacion;
        await db.SaveChangesAsync();
        return true;
    }
}

public class MantenimientoService(GittInventarioDbContext db)
{
    public Task<List<Mantenimiento>> GetAllAsync() => db.Mantenimientos.Include(m => m.Articulo).OrderByDescending(m => m.Fecha).ToListAsync();

    public async Task<Mantenimiento> CreateAsync(MantenimientoCreateDto dto)
    {
        var mantenimiento = new Mantenimiento { Tipo = dto.Tipo, Fecha = dto.Fecha, IdArticulo = dto.IdArticulo, Estado = dto.Estado ?? "PENDIENTE", Observacion = dto.Observacion };
        db.Mantenimientos.Add(mantenimiento);
        await db.SaveChangesAsync();
        return mantenimiento;
    }

    public async Task<bool> UpdateAsync(int id, MantenimientoCreateDto dto)
    {
        var mantenimiento = await db.Mantenimientos.FindAsync(id);
        if (mantenimiento is null) return false;
        mantenimiento.Tipo = dto.Tipo;
        mantenimiento.Fecha = dto.Fecha;
        mantenimiento.IdArticulo = dto.IdArticulo;
        mantenimiento.Estado = dto.Estado ?? mantenimiento.Estado;
        mantenimiento.Observacion = dto.Observacion;
        await db.SaveChangesAsync();
        return true;
    }
}

public class MovimientoService(GittInventarioDbContext db)
{
    public Task<List<Movimiento>> GetAllAsync() => db.Movimientos.Include(m => m.Articulo).OrderByDescending(m => m.Fecha).ToListAsync();

    public async Task<Movimiento> CreateAsync(MovimientoCreateDto dto)
    {
        var movimiento = new Movimiento { Fecha = dto.Fecha, Tipo = dto.Tipo, IdArticulo = dto.IdArticulo, Observacion = dto.Observacion };
        db.Movimientos.Add(movimiento);
        await db.SaveChangesAsync();
        return movimiento;
    }
}

public class ReporteService(GittInventarioDbContext db)
{
    public async Task<DashboardDto> DashboardAsync() => new(
        await db.Articulos.CountAsync(),
        await db.Articulos.CountAsync(a => a.Estado == "DISPONIBLE"),
        await db.Prestamos.CountAsync(p => p.Estado == "ACTIVO"),
        await db.Mantenimientos.CountAsync(m => m.Estado == "PENDIENTE"),
        await db.Notificaciones.CountAsync(n => n.Estado == "PENDIENTE"));

    public Task<List<ArticuloListDto>> ArticulosDisponiblesAsync() =>
        db.Articulos.Where(a => a.Estado == "DISPONIBLE")
            .Include(a => a.Categoria).Include(a => a.Ubicacion)!.ThenInclude(u => u!.Departamento).Include(a => a.Responsable)
            .Include(a => a.Imagenes)
            .Select(a => new ArticuloListDto(a.IdArticulo, a.Nombre, a.Codigo, a.Estado, a.Categoria!.Nombre, a.Ubicacion!.Nombre, a.Ubicacion.Departamento!.Nombre, a.Responsable != null ? a.Responsable.Nombre : null, a.ValorEstimado, a.Imagenes.Where(i => i.EsPrincipal == "S").Select(i => i.UrlImagen).FirstOrDefault()))
            .ToListAsync();

    public Task<List<Prestamo>> PrestamosActivosAsync() => db.Prestamos.Include(p => p.Usuario).Where(p => p.Estado == "ACTIVO").ToListAsync();
    public Task<List<Mantenimiento>> MantenimientosPendientesAsync() => db.Mantenimientos.Include(m => m.Articulo).Where(m => m.Estado == "PENDIENTE").ToListAsync();

    public Task<List<object>> ArticulosPorCategoriaAsync() =>
        db.Articulos.GroupBy(a => a.Categoria!.Nombre).Select(g => new { Categoria = g.Key, Total = g.Count() }).Cast<object>().ToListAsync();

    public Task<List<object>> ArticulosPorDepartamentoAsync() =>
        db.Articulos.GroupBy(a => a.Ubicacion!.Departamento!.Nombre).Select(g => new { Departamento = g.Key, Total = g.Count() }).Cast<object>().ToListAsync();

    public Task<List<object>> ValorInventarioPorDepartamentoAsync() =>
        db.Articulos
            .GroupBy(a => a.Ubicacion!.Departamento!.Nombre)
            .Select(g => new { Departamento = g.Key, TotalArticulos = g.Count(), ValorTotal = g.Sum(a => a.ValorEstimado) })
            .Cast<object>()
            .ToListAsync();

    public Task<List<Movimiento>> MovimientosPorRangoAsync(DateTime desde, DateTime hasta) =>
        db.Movimientos.Include(m => m.Articulo).Where(m => m.Fecha >= desde && m.Fecha <= hasta).OrderByDescending(m => m.Fecha).ToListAsync();
}

public class AuditoriaService(GittInventarioDbContext db)
{
    public Task<List<Auditoria>> GetAllAsync() => db.Auditorias.Include(a => a.Usuario).OrderByDescending(a => a.Fecha).ToListAsync();
}
