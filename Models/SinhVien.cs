using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace dotnet07_webapi.Models;

[Table("SinhVien")]
public class SinhVien
{
    // field nào là PK thì thêm [Key]
    [Key]
    public string MaSV { get; set; }
    public string HoTen { get; set;}
    public DateTime NgaySinh { get; set;}
    public string Lop { get; set;}
}
public class SinhVienUpdate
{
     public string HoTen { get; set;}
    public DateTime NgaySinh { get; set;}
    public string Lop { get; set;}
}