using Microsoft.AspNetCore.Mvc;
using SkiCommander.Dto;
using SkiCommander.Repositories;

namespace SkiCommander.Controllers
{
    [ApiController]
    [Route("/auth")]
    public class AuthController : ControllerBase
    {
        ILogger<AuthController> logger;
        BaseRepository baseRepository;

        public AuthController(ILogger<AuthController> logger, BaseRepository baseRepository)
        {
            this.logger = logger;
            this.baseRepository = baseRepository;
        }

        [HttpPost]
        [Route("register")]
        [ProducesResponseType(StatusCodes.Status201Created, Type = typeof(Guid))]
        public async Task<ActionResult<Guid>> Register([FromBody] RegistrationDto registration)
        {
            logger.LogInformation("Registering user: {}", registration.Id);
            await baseRepository.Add();
            return registration.Id;
        }

    }
}
