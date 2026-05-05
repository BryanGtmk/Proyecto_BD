using GittInventario.Application.DTOs;
using GittInventario.Application.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GittInventario.Api.Controllers;

[ApiController]
[Authorize]
[Route("api/articulos")]
public class ArticulosController(ArticuloService service) : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> GetAll() => Ok(await service.GetAllAsync());

    [HttpGet("{id:int}")]
    public async Task<IActionResult> GetById(int id)
    {
        var articulo = await service.GetByIdAsync(id);
        return articulo is null ? NotFound() : Ok(articulo);
    }

    [HttpPost]
    [Authorize(Roles = "Administrador,Responsable")]
    public async Task<IActionResult> Create(ArticuloCreateDto dto) => Created("", await service.CreateAsync(dto));

    [HttpPut("{id:int}")]
    [Authorize(Roles = "Administrador,Responsable")]
    public async Task<IActionResult> Update(int id, ArticuloUpdateDto dto) => await service.UpdateAsync(id, dto) ? NoContent() : NotFound();

    [HttpDelete("{id:int}")]
    [Authorize(Roles = "Administrador")]
    public async Task<IActionResult> Delete(int id) => await service.DeleteAsync(id) ? NoContent() : NotFound();
}
