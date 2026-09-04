namespace dotnet07_webapi.Controllers;

using dotnet07_webapi.Context;
using dotnet07_webapi.Models;
using dotnet07_webapi.Models.Base;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Route("api/[controller]")]
[ApiController]
public class LopHocController(AppDbContext _dbcontext) : ControllerBase
{

    [HttpGet]
    public async Task<IActionResult> Get()
    {
        var res = await _dbcontext.LopHoc.ToListAsync();
        return new ResponseEntity(200, res,"Lấy danh sách lớp học thành công");
    }
    // getById
    [HttpGet("{id}")]
    public async Task<IActionResult> GetById(string id)
    {
        var res = await _dbcontext.LopHoc.FirstOrDefaultAsync(x => x.MaLop == id);
        if (res == null)
        {
            return new ResponseEntity(404,res,$"Khong tim thay lop hoc co id : {id}");
        }
        return new ResponseEntity(200, res,"Lấy dự liệu thành công");
    }
    // post
    [HttpPost()]
    public async Task<IActionResult> Post([FromBody] LopHoc model)
    {
        var res = await _dbcontext.LopHoc.FirstOrDefaultAsync(x => x.MaLop == model.MaLop);
        // trung id dax cos
        if (res != null)
        {
            return new ResponseEntity(409, null, $"MaLop {model.MaLop} da ton tai ");
        }

        _dbcontext.LopHoc.Add(model);

        await _dbcontext.SaveChangesAsync();
        return new ResponseEntity(201, res,"Thêm mới thành công");
    }
    // put
    [HttpPut("{id}")]
    public async Task<IActionResult> Put(string id, [FromBody] LopHoc model)
    {
        var res = await _dbcontext.LopHoc.FirstOrDefaultAsync(x => x.MaLop == id);

        if (res == null)
        {
            return new ResponseEntity(404, null,$"Khong tim thay lop hoc co id : {id}");
        }

        res.TenLop = model.TenLop;
        await _dbcontext.SaveChangesAsync();
        return new ResponseEntity(200,res,"Cập nhật dữ liệu thành công");
    }
    // delete
    // search
}
