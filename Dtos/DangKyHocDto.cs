using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace dotnet07_webapi.Dtos;

public class DangKyHocDto
{
    // thông tin sinh viên
    public string MaSV { get; set; }

    public string HoTen { get; set; }

    // thông tin môn học
    public string MaMonHoc { get; set; }

    public string TenMonHoc { get; set; }

    // thông tin đăng ký
    public DateTime? NgayDangKy { get; set; }

    public bool? ThanhToan { get; set; }
}
