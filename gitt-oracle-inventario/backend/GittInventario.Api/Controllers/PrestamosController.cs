using GittInventario.Application.DTOs;
using GittInventario.Application.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GittInventario.Api.Controllers;

[ApiController]
[Authorize]
[Route("api/prestamos")]
public class PrestamosController(PrestamoService service) : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> GetAll() => Ok(await service.GetAllAsync());

    [HttpGet("{id:int}")]
    public async Task<IActionResult> GetById(int id)
    {
        var prestamo = await service.GetByIdAsync(id);
        return prestamo is null ? NotFound() : Ok(prestamo);
    }

    [HttpPost]
    [Authorize(Roles = "Administrador,Responsable,Docente")]
    public async Task<IActionResult> Create(PrestamoCreateDto dto)
    {
        var result = await service.CreateAsync(dto);
        return result.Ok ? Created("", result.Prestamo) : Conflict(new { message = result.Error });
    }

    [HttpPut("{id:int}/devolver")]
    [Authorize(Roles = "Administrador,Responsable")]
    public async Task<IActionResult> Devolver(int id, DevolucionDto dto) => await service.DevolverAsync(id, dto) ? NoContent() : NotFound();
}
