using GittInventario.Application.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GittInventario.Api.Controllers;

[ApiController]
[Authorize]
[Route("api/reportes")]
public class ReportesController(ReporteService service) : ControllerBase
{
    [HttpGet("dashboard")]
    public async Task<IActionResult> Dashboard() => Ok(await service.DashboardAsync());

    [HttpGet("articulos-disponibles")]
    public async Task<IActionResult> ArticulosDisponibles() => Ok(await service.ArticulosDisponiblesAsync());

    [HttpGet("prestamos-activos")]
    public async Task<IActionResult> PrestamosActivos() => Ok(await service.PrestamosActivosAsync());

    [HttpGet("mantenimientos-pendientes")]
    public async Task<IActionResult> MantenimientosPendientes() => Ok(await service.MantenimientosPendientesAsync());

    [HttpGet("articulos-por-categoria")]
    public async Task<IActionResult> ArticulosPorCategoria() => Ok(await service.ArticulosPorCategoriaAsync());

    [HttpGet("articulos-por-departamento")]
    public async Task<IActionResult> ArticulosPorDepartamento() => Ok(await service.ArticulosPorDepartamentoAsync());

    [HttpGet("valor-inventario-por-departamento")]
    public async Task<IActionResult> ValorInventarioPorDepartamento() => Ok(await service.ValorInventarioPorDepartamentoAsync());

    [HttpGet("movimientos-rango")]
    public async Task<IActionResult> MovimientosPorRango([FromQuery] DateTime? desde, [FromQuery] DateTime? hasta)
    {
        var fechaHasta = hasta ?? DateTime.Today.AddDays(1);
        var fechaDesde = desde ?? DateTime.Today.AddDays(-30);
        return Ok(await service.MovimientosPorRangoAsync(fechaDesde, fechaHasta));
    }
}
