using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace dotnet07_webapi.Models;

[Table("LopHoc")]
public class LopHoc
{
    [Key] // khoá chính
    [Required]
    [MaxLength(6)]
    public string MaLop {get;set;}
    [Required]
    [MaxLength(100)]
    public string TenLop {get;set;}
}