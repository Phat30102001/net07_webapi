using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace dotnet07_webapi.Models;

[Table("MonHoc")]
public class MonHoc
{
    [Key]
    public string MaMonHoc { get; set; }
    public string TenMonHoc { get; set; }
    public string? TKB { get; set; }
    public DateTime? NgayBatDau { get; set; }
    public DateTime? NgayKetThuc { get; set; }

    public List<DangKyHoc>? DangKyHocs { get; set; }
}