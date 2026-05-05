using GittInventario.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace GittInventario.Infrastructure.Data;

public class GittInventarioDbContext(DbContextOptions<GittInventarioDbContext> options) : DbContext(options)
{
    public DbSet<Rol> Roles => Set<Rol>();
    public DbSet<Usuario> Usuarios => Set<Usuario>();
    public DbSet<Departamento> Departamentos => Set<Departamento>();
    public DbSet<Ubicacion> Ubicaciones => Set<Ubicacion>();
    public DbSet<Categoria> Categorias => Set<Categoria>();
    public DbSet<Articulo> Articulos => Set<Articulo>();
    public DbSet<ImagenArticulo> ImagenesArticulo => Set<ImagenArticulo>();
    public DbSet<Prestamo> Prestamos => Set<Prestamo>();
    public DbSet<DetallePrestamo> DetallePrestamos => Set<DetallePrestamo>();
    public DbSet<Mantenimiento> Mantenimientos => Set<Mantenimiento>();
    public DbSet<Movimiento> Movimientos => Set<Movimiento>();
    public DbSet<Notificacion> Notificaciones => Set<Notificacion>();
    public DbSet<Auditoria> Auditorias => Set<Auditoria>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Rol>(entity =>
        {
            entity.ToTable("ROL");
            entity.HasKey(e => e.IdRol).HasName("PK_ROL");
            entity.Property(e => e.IdRol).HasColumnName("ID_ROL").ValueGeneratedOnAdd();
            entity.Property(e => e.NombreRol).HasColumnName("NOMBRE_ROL").HasMaxLength(50).IsRequired();
            entity.HasIndex(e => e.NombreRol).IsUnique().HasDatabaseName("UK_ROL_NOMBRE");
        });

        modelBuilder.Entity<Usuario>(entity =>
        {
            entity.ToTable("USUARIO");
            entity.HasKey(e => e.IdUsuario).HasName("PK_USUARIO");
            entity.Property(e => e.IdUsuario).HasColumnName("ID_USUARIO").ValueGeneratedOnAdd();
            entity.Property(e => e.Nombre).HasColumnName("NOMBRE").HasMaxLength(120).IsRequired();
            entity.Property(e => e.Correo).HasColumnName("CORREO").HasMaxLength(150).IsRequired();
            entity.Property(e => e.Contrasena).HasColumnName("CONTRASENA").HasMaxLength(255).IsRequired();
            entity.Property(e => e.IdRol).HasColumnName("ID_ROL").IsRequired();
            entity.Property(e => e.FechaCreacion).HasColumnName("FECHA_CREACION").HasDefaultValueSql("SYSDATE");
            entity.HasIndex(e => e.Correo).IsUnique().HasDatabaseName("IX_USUARIO_CORREO");
            entity.HasOne(e => e.Rol).WithMany(e => e.Usuarios).HasForeignKey(e => e.IdRol).OnDelete(DeleteBehavior.Restrict).HasConstraintName("FK_USUARIO_ROL");
        });

        modelBuilder.Entity<Departamento>(entity =>
        {
            entity.ToTable("DEPARTAMENTO");
            entity.HasKey(e => e.IdDepartamento).HasName("PK_DEPARTAMENTO");
            entity.Property(e => e.IdDepartamento).HasColumnName("ID_DEPARTAMENTO").ValueGeneratedOnAdd();
            entity.Property(e => e.Nombre).HasColumnName("NOMBRE").HasMaxLength(100).IsRequired();
            entity.HasIndex(e => e.Nombre).IsUnique().HasDatabaseName("UK_DEPARTAMENTO_NOMBRE");
        });

        modelBuilder.Entity<Ubicacion>(entity =>
        {
            entity.ToTable("UBICACION");
            entity.HasKey(e => e.IdUbicacion).HasName("PK_UBICACION");
            entity.Property(e => e.IdUbicacion).HasColumnName("ID_UBICACION").ValueGeneratedOnAdd();
            entity.Property(e => e.Nombre).HasColumnName("NOMBRE").HasMaxLength(120).IsRequired();
            entity.Property(e => e.IdDepartamento).HasColumnName("ID_DEPARTAMENTO").IsRequired();
            entity.HasOne(e => e.Departamento).WithMany(e => e.Ubicaciones).HasForeignKey(e => e.IdDepartamento).OnDelete(DeleteBehavior.Restrict).HasConstraintName("FK_UBICACION_DEPARTAMENTO");
        });

        modelBuilder.Entity<Categoria>(entity =>
        {
            entity.ToTable("CATEGORIA");
            entity.HasKey(e => e.IdCategoria).HasName("PK_CATEGORIA");
            entity.Property(e => e.IdCategoria).HasColumnName("ID_CATEGORIA").ValueGeneratedOnAdd();
            entity.Property(e => e.Nombre).HasColumnName("NOMBRE").HasMaxLength(100).IsRequired();
            entity.HasIndex(e => e.Nombre).IsUnique().HasDatabaseName("UK_CATEGORIA_NOMBRE");
        });

        modelBuilder.Entity<Articulo>(entity =>
        {
            entity.ToTable("ARTICULO", t => t.HasCheckConstraint("CK_ARTICULO_ESTADO", "ESTADO IN ('DISPONIBLE','PRESTADO','MANTENIMIENTO','BAJA')"));
            entity.HasKey(e => e.IdArticulo).HasName("PK_ARTICULO");
            entity.Property(e => e.IdArticulo).HasColumnName("ID_ARTICULO").ValueGeneratedOnAdd();
            entity.Property(e => e.Nombre).HasColumnName("NOMBRE").HasMaxLength(120).IsRequired();
            entity.Property(e => e.Estado).HasColumnName("ESTADO").HasMaxLength(20).IsRequired();
            entity.Property(e => e.Codigo).HasColumnName("CODIGO").HasMaxLength(50).IsRequired();
            entity.Property(e => e.IdCategoria).HasColumnName("ID_CATEGORIA").IsRequired();
            entity.Property(e => e.IdUbicacion).HasColumnName("ID_UBICACION").IsRequired();
            entity.Property(e => e.IdResponsable).HasColumnName("ID_RESPONSABLE");
            entity.Property(e => e.ValorEstimado).HasColumnName("VALOR_ESTIMADO").HasColumnType("NUMBER(10,2)").IsRequired();
            entity.Property(e => e.Descripcion).HasColumnName("DESCRIPCION").HasMaxLength(500);
            entity.Property(e => e.FechaCreacion).HasColumnName("FECHA_CREACION").HasDefaultValueSql("SYSDATE");
            entity.Property(e => e.FechaActualizacion).HasColumnName("FECHA_ACTUALIZACION");
            entity.HasIndex(e => e.Codigo).IsUnique().HasDatabaseName("IX_ARTICULO_CODIGO");
            entity.HasIndex(e => e.Estado).HasDatabaseName("IX_ARTICULO_ESTADO");
            entity.HasOne(e => e.Categoria).WithMany(e => e.Articulos).HasForeignKey(e => e.IdCategoria).OnDelete(DeleteBehavior.Restrict).HasConstraintName("FK_ARTICULO_CATEGORIA");
            entity.HasOne(e => e.Ubicacion).WithMany(e => e.Articulos).HasForeignKey(e => e.IdUbicacion).OnDelete(DeleteBehavior.Restrict).HasConstraintName("FK_ARTICULO_UBICACION");
            entity.HasOne(e => e.Responsable).WithMany(e => e.ArticulosResponsable).HasForeignKey(e => e.IdResponsable).OnDelete(DeleteBehavior.SetNull).HasConstraintName("FK_ARTICULO_RESPONSABLE");
        });

        modelBuilder.Entity<ImagenArticulo>(entity =>
        {
            entity.ToTable("IMAGEN_ARTICULO", t => t.HasCheckConstraint("CK_IMAGEN_ARTICULO_PRINCIPAL", "ES_PRINCIPAL IN ('S','N')"));
            entity.HasKey(e => e.IdImagen).HasName("PK_IMAGEN_ARTICULO");
            entity.Property(e => e.IdImagen).HasColumnName("ID_IMAGEN").ValueGeneratedOnAdd();
            entity.Property(e => e.IdArticulo).HasColumnName("ID_ARTICULO").IsRequired();
            entity.Property(e => e.UrlImagen).HasColumnName("URL_IMAGEN").HasMaxLength(500).IsRequired();
            entity.Property(e => e.Descripcion).HasColumnName("DESCRIPCION").HasMaxLength(250);
            entity.Property(e => e.EsPrincipal).HasColumnName("ES_PRINCIPAL").HasMaxLength(1).IsRequired();
            entity.Property(e => e.FechaCreacion).HasColumnName("FECHA_CREACION").HasDefaultValueSql("SYSDATE");
            entity.HasIndex(e => e.IdArticulo).HasDatabaseName("IX_IMAGEN_ARTICULO");
            entity.HasOne(e => e.Articulo).WithMany(e => e.Imagenes).HasForeignKey(e => e.IdArticulo).OnDelete(DeleteBehavior.Cascade).HasConstraintName("FK_IMAGEN_ARTICULO");
        });

        modelBuilder.Entity<Prestamo>(entity =>
        {
            entity.ToTable("PRESTAMO", t => t.HasCheckConstraint("CK_PRESTAMO_ESTADO", "ESTADO IN ('ACTIVO','DEVUELTO','VENCIDO')"));
            entity.HasKey(e => e.IdPrestamo).HasName("PK_PRESTAMO");
            entity.Property(e => e.IdPrestamo).HasColumnName("ID_PRESTAMO").ValueGeneratedOnAdd();
            entity.Property(e => e.FechaPrestamo).HasColumnName("FECHA_PRESTAMO").HasDefaultValueSql("SYSDATE");
            entity.Property(e => e.FechaDevolucion).HasColumnName("FECHA_DEVOLUCION").IsRequired();
            entity.Property(e => e.IdUsuario).HasColumnName("ID_USUARIO").IsRequired();
            entity.Property(e => e.Estado).HasColumnName("ESTADO").HasMaxLength(20).IsRequired();
            entity.Property(e => e.Observacion).HasColumnName("OBSERVACION").HasMaxLength(500);
            entity.HasIndex(e => e.FechaPrestamo).HasDatabaseName("IX_PRESTAMO_FECHA_PRESTAMO");
            entity.HasIndex(e => e.FechaDevolucion).HasDatabaseName("IX_PRESTAMO_FECHA_DEVOLUCION");
            entity.HasOne(e => e.Usuario).WithMany(e => e.Prestamos).HasForeignKey(e => e.IdUsuario).OnDelete(DeleteBehavior.Restrict).HasConstraintName("FK_PRESTAMO_USUARIO");
        });

        modelBuilder.Entity<DetallePrestamo>(entity =>
        {
            entity.ToTable("DETALLE_PRESTAMO");
            entity.HasKey(e => e.IdDetalle).HasName("PK_DETALLE_PRESTAMO");
            entity.Property(e => e.IdDetalle).HasColumnName("ID_DETALLE").ValueGeneratedOnAdd();
            entity.Property(e => e.IdPrestamo).HasColumnName("ID_PRESTAMO").IsRequired();
            entity.Property(e => e.IdArticulo).HasColumnName("ID_ARTICULO").IsRequired();
            entity.HasIndex(e => new { e.IdPrestamo, e.IdArticulo }).IsUnique().HasDatabaseName("UK_DETALLE_PRESTAMO_ARTICULO");
            entity.HasOne(e => e.Prestamo).WithMany(e => e.Detalles).HasForeignKey(e => e.IdPrestamo).OnDelete(DeleteBehavior.Cascade).HasConstraintName("FK_DETALLE_PRESTAMO");
            entity.HasOne(e => e.Articulo).WithMany(e => e.DetallesPrestamo).HasForeignKey(e => e.IdArticulo).OnDelete(DeleteBehavior.Restrict).HasConstraintName("FK_DETALLE_ARTICULO");
        });

        modelBuilder.Entity<Mantenimiento>(entity =>
        {
            entity.ToTable("MANTENIMIENTO", t => t.HasCheckConstraint("CK_MANTENIMIENTO_TIPO", "TIPO IN ('PREVENTIVO','CORRECTIVO')"));
            entity.HasKey(e => e.IdMantenimiento).HasName("PK_MANTENIMIENTO");
            entity.Property(e => e.IdMantenimiento).HasColumnName("ID_MANTENIMIENTO").ValueGeneratedOnAdd();
            entity.Property(e => e.Tipo).HasColumnName("TIPO").HasMaxLength(20).IsRequired();
            entity.Property(e => e.Fecha).HasColumnName("FECHA").IsRequired();
            entity.Property(e => e.IdArticulo).HasColumnName("ID_ARTICULO").IsRequired();
            entity.Property(e => e.Estado).HasColumnName("ESTADO").HasMaxLength(20).IsRequired();
            entity.Property(e => e.Observacion).HasColumnName("OBSERVACION").HasMaxLength(500);
            entity.HasIndex(e => e.Fecha).HasDatabaseName("IX_MANTENIMIENTO_FECHA");
            entity.HasOne(e => e.Articulo).WithMany(e => e.Mantenimientos).HasForeignKey(e => e.IdArticulo).OnDelete(DeleteBehavior.Restrict).HasConstraintName("FK_MANTENIMIENTO_ARTICULO");
        });

        modelBuilder.Entity<Movimiento>(entity =>
        {
            entity.ToTable("MOVIMIENTO", t => t.HasCheckConstraint("CK_MOVIMIENTO_TIPO", "TIPO IN ('INGRESO','TRASLADO','PRESTAMO','DEVOLUCION','MANTENIMIENTO')"));
            entity.HasKey(e => e.IdMovimiento).HasName("PK_MOVIMIENTO");
            entity.Property(e => e.IdMovimiento).HasColumnName("ID_MOVIMIENTO").ValueGeneratedOnAdd();
            entity.Property(e => e.Fecha).HasColumnName("FECHA").IsRequired();
            entity.Property(e => e.Tipo).HasColumnName("TIPO").HasMaxLength(20).IsRequired();
            entity.Property(e => e.IdArticulo).HasColumnName("ID_ARTICULO").IsRequired();
            entity.Property(e => e.Observacion).HasColumnName("OBSERVACION").HasMaxLength(500);
            entity.HasOne(e => e.Articulo).WithMany(e => e.Movimientos).HasForeignKey(e => e.IdArticulo).OnDelete(DeleteBehavior.Restrict).HasConstraintName("FK_MOVIMIENTO_ARTICULO");
        });

        modelBuilder.Entity<Notificacion>(entity =>
        {
            entity.ToTable("NOTIFICACION", t => t.HasCheckConstraint("CK_NOTIFICACION_ESTADO", "ESTADO IN ('PENDIENTE','ENVIADA','LEIDA')"));
            entity.HasKey(e => e.IdNotificacion).HasName("PK_NOTIFICACION");
            entity.Property(e => e.IdNotificacion).HasColumnName("ID_NOTIFICACION").ValueGeneratedOnAdd();
            entity.Property(e => e.Mensaje).HasColumnName("MENSAJE").HasMaxLength(500).IsRequired();
            entity.Property(e => e.Estado).HasColumnName("ESTADO").HasMaxLength(20).IsRequired();
            entity.Property(e => e.IdPrestamo).HasColumnName("ID_PRESTAMO").IsRequired();
            entity.Property(e => e.FechaCreacion).HasColumnName("FECHA_CREACION").HasDefaultValueSql("SYSDATE");
            entity.HasOne(e => e.Prestamo).WithMany(e => e.Notificaciones).HasForeignKey(e => e.IdPrestamo).OnDelete(DeleteBehavior.Cascade).HasConstraintName("FK_NOTIFICACION_PRESTAMO");
        });

        modelBuilder.Entity<Auditoria>(entity =>
        {
            entity.ToTable("AUDITORIA", t => t.HasCheckConstraint("CK_AUDITORIA_ACCION", "ACCION IN ('INSERT','UPDATE','DELETE','LOGIN','PRESTAMO','DEVOLUCION')"));
            entity.HasKey(e => e.IdAuditoria).HasName("PK_AUDITORIA");
            entity.Property(e => e.IdAuditoria).HasColumnName("ID_AUDITORIA").ValueGeneratedOnAdd();
            entity.Property(e => e.Accion).HasColumnName("ACCION").HasMaxLength(20).IsRequired();
            entity.Property(e => e.Fecha).HasColumnName("FECHA").HasDefaultValueSql("SYSDATE");
            entity.Property(e => e.IdUsuario).HasColumnName("ID_USUARIO").IsRequired();
            entity.Property(e => e.Tabla).HasColumnName("TABLA").HasMaxLength(50);
            entity.Property(e => e.Descripcion).HasColumnName("DESCRIPCION").HasMaxLength(500);
            entity.HasOne(e => e.Usuario).WithMany(e => e.Auditorias).HasForeignKey(e => e.IdUsuario).OnDelete(DeleteBehavior.Restrict).HasConstraintName("FK_AUDITORIA_USUARIO");
        });
    }
}
