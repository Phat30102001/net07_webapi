namespace dotnet07_webapi.Controllers;

using dotnet07_webapi.Context;
using dotnet07_webapi.Models.Base;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Route("api/[controller]")]
[ApiController]
public class MonHocController(AppDbContext _dbcontext) : ControllerBase
{
    [HttpGet("{id}")]
    public async Task<IActionResult> GetById(string id)
    {
        var res = await _dbcontext.MonHoc
        .Include(x => x.DangKyHocs)
        // ThenInclude chạy sau incluce
        .ThenInclude(x => x.SinhVien)
        .FirstOrDefaultAsync(mh => mh.MaMonHoc == id);
        // check null => 404
        if(res == null) return new ResponseEntity(404,"",$"Not found {id}");

        return new ResponseEntity(200,res,"");
    }
}
