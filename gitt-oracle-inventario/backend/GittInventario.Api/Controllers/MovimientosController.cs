using GittInventario.Application.DTOs;
using GittInventario.Application.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GittInventario.Api.Controllers;

[ApiController]
[Authorize]
[Route("api/movimientos")]
public class MovimientosController(MovimientoService service) : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> GetAll() => Ok(await service.GetAllAsync());

    [HttpPost]
    [Authorize(Roles = "Administrador,Responsable")]
    public async Task<IActionResult> Create(MovimientoCreateDto dto) => Created("", await service.CreateAsync(dto));
}
