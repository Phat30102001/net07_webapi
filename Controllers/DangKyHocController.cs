using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using dotnet07_webapi.Context;
using dotnet07_webapi.Dtos;
using dotnet07_webapi.Models.Base;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace dotnet07_webapi.Controllers;

[ApiController]
[Route("api/[controller]")]
public class DangKyHocController(AppDbContext _dbcontext) : ControllerBase
{
    // api get DangKyHoc ttSV, tt MH, ngay dk , thanh toan
    [HttpGet]
    public async Task<IActionResult> Get()
    {
        // var res = await _dbcontext.DangKyHoc
        // .Include(dk=> dk.MonHoc)
        // .ToListAsync();
        var res = await _dbcontext.DangKyHoc
        .Include(d => d.SinhVien)
        .Include(d => d.MonHoc)
        .Select(dk => new DangKyHocDto
        {
            MaSV = dk.MaSV,
            HoTen = dk.SinhVien.HoTen,

            MaMonHoc = dk.MaMonHoc,
            TenMonHoc = dk.MonHoc.TenMonHoc,

            NgayDangKy = dk.NgayDangKy,
            ThanhToan = dk.ThanhToan
        }).ToListAsync();
        return new ResponseEntity(200,res,"Lấy dự liệu thành công");
    }
    // post => nhận model => ktra sinhvien, ktra monhoc , => lưu
}
