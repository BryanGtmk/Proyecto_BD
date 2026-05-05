using GittInventario.Application.DTOs;
using GittInventario.Application.Services;
using Microsoft.AspNetCore.Mvc;

namespace GittInventario.Api.Controllers;

[ApiController]
[Route("api/auth")]
public class AuthController(AuthService service) : ControllerBase
{
    [HttpPost("login")]
    public async Task<ActionResult<LoginResponseDto>> Login(LoginDto dto)
    {
        var response = await service.LoginAsync(dto);
        return response is null ? Unauthorized(new { message = "Credenciales invalidas" }) : Ok(response);
    }
}
