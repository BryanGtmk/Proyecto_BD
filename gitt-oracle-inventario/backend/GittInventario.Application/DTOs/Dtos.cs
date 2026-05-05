namespace GittInventario.Application.DTOs;

public record LoginDto(string Correo, string Contrasena);

public record LoginResponseDto(string Token, string Nombre, string Correo, string Rol);

public record UsuarioCreateDto(string Nombre, string Correo, string Contrasena, int IdRol);

public record ArticuloCreateDto(
    string Nombre,
    string Codigo,
    string Estado,
    int IdCategoria,
    int IdUbicacion,
    int? IdResponsable,
    decimal ValorEstimado,
    string? UrlImagen,
    string? Descripcion);

public record ArticuloUpdateDto(
    string Nombre,
    string Codigo,
    string Estado,
    int IdCategoria,
    int IdUbicacion,
    int? IdResponsable,
    decimal ValorEstimado,
    string? UrlImagen,
    string? Descripcion);

public record ArticuloListDto(
    int IdArticulo,
    string Nombre,
    string Codigo,
    string Estado,
    string Categoria,
    string Ubicacion,
    string Departamento,
    string? Responsable,
    decimal ValorEstimado,
    string? UrlImagen);

public record PrestamoCreateDto(int IdUsuario, DateTime FechaDevolucion, IEnumerable<int> Articulos, string? Observacion);

public record DevolucionDto(string? Observacion);

public record MantenimientoCreateDto(string Tipo, DateTime Fecha, int IdArticulo, string? Estado, string? Observacion);

public record MovimientoCreateDto(DateTime Fecha, string Tipo, int IdArticulo, string? Observacion);

public record DashboardDto(
    int TotalArticulos,
    int ArticulosDisponibles,
    int PrestamosActivos,
    int MantenimientosPendientes,
    int NotificacionesPendientes);
