using GittInventario.Application.DTOs;
using GittInventario.Application.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GittInventario.Api.Controllers;

[ApiController]
[Authorize(Roles = "Administrador,Responsable")]
[Route("api/usuarios")]
public class UsuariosController(UsuarioService service) : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> GetAll() => Ok(await service.GetAllAsync());

    [HttpPost]
    [Authorize(Roles = "Administrador")]
    public async Task<IActionResult> Create(UsuarioCreateDto dto) => Created("", await service.CreateAsync(dto));
}
