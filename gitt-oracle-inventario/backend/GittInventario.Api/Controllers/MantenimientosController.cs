using GittInventario.Application.DTOs;
using GittInventario.Application.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GittInventario.Api.Controllers;

[ApiController]
[Authorize]
[Route("api/mantenimientos")]
public class MantenimientosController(MantenimientoService service) : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> GetAll() => Ok(await service.GetAllAsync());

    [HttpPost]
    [Authorize(Roles = "Administrador,Responsable")]
    public async Task<IActionResult> Create(MantenimientoCreateDto dto) => Created("", await service.CreateAsync(dto));

    [HttpPut("{id:int}")]
    [Authorize(Roles = "Administrador,Responsable")]
    public async Task<IActionResult> Update(int id, MantenimientoCreateDto dto) => await service.UpdateAsync(id, dto) ? NoContent() : NotFound();
}
