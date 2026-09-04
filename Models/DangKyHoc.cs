using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;
using Microsoft.EntityFrameworkCore;

namespace dotnet07_webapi.Models;

[Table("DangKyHoc")]
[PrimaryKey(nameof(MaSV), nameof(MaMonHoc))]
public class DangKyHoc
{
    public string MaMonHoc { get; set; }

    public string MaSV { get; set; }
    public DateTime NgayDangKy { get; set; }
    public bool ThanhToan { get; set; }
    // 
    [JsonIgnore]
    [ForeignKey(nameof(MaMonHoc))]
    public MonHoc MonHoc { get; set; }
    [ForeignKey(nameof(MaSV))]
    public SinhVien SinhVien { get; set; }
}