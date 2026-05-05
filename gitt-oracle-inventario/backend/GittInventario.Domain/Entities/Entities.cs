namespace GittInventario.Domain.Entities;

public class Rol
{
    public int IdRol { get; set; }
    public string NombreRol { get; set; } = string.Empty;
    public ICollection<Usuario> Usuarios { get; set; } = new List<Usuario>();
}

public class Usuario
{
    public int IdUsuario { get; set; }
    public string Nombre { get; set; } = string.Empty;
    public string Correo { get; set; } = string.Empty;
    public string Contrasena { get; set; } = string.Empty;
    public int IdRol { get; set; }
    public DateTime FechaCreacion { get; set; }
    public Rol? Rol { get; set; }
    public ICollection<Articulo> ArticulosResponsable { get; set; } = new List<Articulo>();
    public ICollection<Prestamo> Prestamos { get; set; } = new List<Prestamo>();
    public ICollection<Auditoria> Auditorias { get; set; } = new List<Auditoria>();
}

public class Departamento
{
    public int IdDepartamento { get; set; }
    public string Nombre { get; set; } = string.Empty;
    public ICollection<Ubicacion> Ubicaciones { get; set; } = new List<Ubicacion>();
}

public class Ubicacion
{
    public int IdUbicacion { get; set; }
    public string Nombre { get; set; } = string.Empty;
    public int IdDepartamento { get; set; }
    public Departamento? Departamento { get; set; }
    public ICollection<Articulo> Articulos { get; set; } = new List<Articulo>();
}

public class Categoria
{
    public int IdCategoria { get; set; }
    public string Nombre { get; set; } = string.Empty;
    public ICollection<Articulo> Articulos { get; set; } = new List<Articulo>();
}

public class Articulo
{
    public int IdArticulo { get; set; }
    public string Nombre { get; set; } = string.Empty;
    public string Estado { get; set; } = "DISPONIBLE";
    public string Codigo { get; set; } = string.Empty;
    public int IdCategoria { get; set; }
    public int IdUbicacion { get; set; }
    public int? IdResponsable { get; set; }
    public decimal ValorEstimado { get; set; }
    public string? Descripcion { get; set; }
    public DateTime FechaCreacion { get; set; }
    public DateTime? FechaActualizacion { get; set; }
    public Categoria? Categoria { get; set; }
    public Ubicacion? Ubicacion { get; set; }
    public Usuario? Responsable { get; set; }
    public ICollection<DetallePrestamo> DetallesPrestamo { get; set; } = new List<DetallePrestamo>();
    public ICollection<ImagenArticulo> Imagenes { get; set; } = new List<ImagenArticulo>();
    public ICollection<Mantenimiento> Mantenimientos { get; set; } = new List<Mantenimiento>();
    public ICollection<Movimiento> Movimientos { get; set; } = new List<Movimiento>();
}

public class ImagenArticulo
{
    public int IdImagen { get; set; }
    public int IdArticulo { get; set; }
    public string UrlImagen { get; set; } = string.Empty;
    public string? Descripcion { get; set; }
    public string EsPrincipal { get; set; } = "S";
    public DateTime FechaCreacion { get; set; }
    public Articulo? Articulo { get; set; }
}

public class Prestamo
{
    public int IdPrestamo { get; set; }
    public DateTime FechaPrestamo { get; set; }
    public DateTime FechaDevolucion { get; set; }
    public int IdUsuario { get; set; }
    public string Estado { get; set; } = "ACTIVO";
    public string? Observacion { get; set; }
    public Usuario? Usuario { get; set; }
    public ICollection<DetallePrestamo> Detalles { get; set; } = new List<DetallePrestamo>();
    public ICollection<Notificacion> Notificaciones { get; set; } = new List<Notificacion>();
}

public class DetallePrestamo
{
    public int IdDetalle { get; set; }
    public int IdPrestamo { get; set; }
    public int IdArticulo { get; set; }
    public Prestamo? Prestamo { get; set; }
    public Articulo? Articulo { get; set; }
}

public class Mantenimiento
{
    public int IdMantenimiento { get; set; }
    public string Tipo { get; set; } = string.Empty;
    public DateTime Fecha { get; set; }
    public int IdArticulo { get; set; }
    public string Estado { get; set; } = "PENDIENTE";
    public string? Observacion { get; set; }
    public Articulo? Articulo { get; set; }
}

public class Movimiento
{
    public int IdMovimiento { get; set; }
    public DateTime Fecha { get; set; }
    public string Tipo { get; set; } = string.Empty;
    public int IdArticulo { get; set; }
    public string? Observacion { get; set; }
    public Articulo? Articulo { get; set; }
}

public class Notificacion
{
    public int IdNotificacion { get; set; }
    public string Mensaje { get; set; } = string.Empty;
    public string Estado { get; set; } = "PENDIENTE";
    public int IdPrestamo { get; set; }
    public DateTime FechaCreacion { get; set; }
    public Prestamo? Prestamo { get; set; }
}

public class Auditoria
{
    public int IdAuditoria { get; set; }
    public string Accion { get; set; } = string.Empty;
    public DateTime Fecha { get; set; }
    public int IdUsuario { get; set; }
    public string? Tabla { get; set; }
    public string? Descripcion { get; set; }
    public Usuario? Usuario { get; set; }
}
