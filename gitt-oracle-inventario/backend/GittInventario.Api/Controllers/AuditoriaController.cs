using GittInventario.Application.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GittInventario.Api.Controllers;

[ApiController]
[Authorize(Roles = "Administrador")]
[Route("api/auditoria")]
public class AuditoriaController(AuditoriaService service) : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> GetAll() => Ok(await service.GetAllAsync());
}
