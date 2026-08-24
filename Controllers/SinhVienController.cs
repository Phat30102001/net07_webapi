namespace dotnet07_webapi.Controllers;

using dotnet07_webapi.Context;

// api_controller 
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Route("api/[controller]")]
[ApiController]
public class SinhVienController : ControllerBase
{
    private readonly AppDbContext _dbcontext;

    public SinhVienController(AppDbContext dbContext)
    {
        _dbcontext = dbContext;
    }

    // METHOD GET : 
    [HttpGet]
    public async Task<IActionResult> Get()
    {
        // Sử dụng EF để lấy ds SinhVien
        // 
        var sinhViens = await _dbcontext.SinhVien.ToListAsync();
        return Ok(sinhViens);
    }

    // GET by ID
    // WHERE 
    [HttpGet("{id}")]
    // api/SinhVien/SV001
    public async Task<IActionResult> GetById([FromRoute]string id)
    {
        // Sử dụng EF để lấy ds SinhVien
        // 
        var sinhVien = await _dbcontext.SinhVien.FirstOrDefaultAsync(sv => sv.MaSV == id);
        return Ok(sinhVien);
    }
    // Update
    // delete
    // tìm kiếm
}