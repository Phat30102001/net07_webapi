namespace dotnet07_webapi.Controllers;

using dotnet07_webapi.Context;
using dotnet07_webapi.Models;

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
    [HttpPut("{id}")]
    // public async Task<IActionResult> UpdateById([FromBody] SinhVien model, [FromRoute] string id)
    public async Task<IActionResult> UpdateById([FromBody] SinhVienUpdate model, string id)
    {

        // upadte Snhvien set ... where
        // tim kiem xem cos du lieuj tuong ung tron db hay khong
        // context cuar EF traking lai noi cua svFind
        var svFind = await _dbcontext.SinhVien.FirstOrDefaultAsync(sv=> sv.MaSV == id);
        if(svFind == null)
        {
            //404
            return NotFound($"Khong tim thay sinh voen co ma {id}");
        }
        svFind.HoTen = model.HoTen;
        svFind.Lop = model.Lop;
        svFind.NgaySinh = model.NgaySinh;
        //
        await _dbcontext.SaveChangesAsync();

        return Ok(svFind);
    }
    // delete
    [HttpDelete("{id}")]
    // [Route("{id}")]
    public async Task<IActionResult> DeleteById(string id)
    {
        // tim sv vowis id tuong ung
        var svFind = await _dbcontext.SinhVien.FirstOrDefaultAsync(sv=> sv.MaSV == id);
        if(svFind == null)
        {
            //404
            return NotFound($"Khong tim thay sinh voen co ma {id}");
        }
        // xoa
        _dbcontext.SinhVien.Remove(svFind);
        // update vafo db
        await _dbcontext.SaveChangesAsync();
        return Ok(svFind);
    }

    // insert
    [HttpPost]
    public async Task<IActionResult> Post([FromBody] SinhVien model)
    {
        var svFind = await _dbcontext.SinhVien.FirstOrDefaultAsync(sv=> sv.MaSV == model.MaSV);
        if(svFind != null)
        {
            //400
            return BadRequest($"Trung ma {model.MaSV}. Them that bai");
        }
        _dbcontext.SinhVien.Add(model);

        // cap nhat db
        await _dbcontext.SaveChangesAsync();
        return Ok(model);
    }

    // tìm kiếm
    [HttpGet("search")]
    // ?keyword
    public  async Task<IActionResult> Search(string keyword)
    {
        // keyword se la ten
        var sinhViens = await _dbcontext.SinhVien.Where(sv => sv.HoTen.Contains(keyword)).ToListAsync();

        return Ok(sinhViens);
        // \%Nguyễn\% ESCSPE '\'
    }
}