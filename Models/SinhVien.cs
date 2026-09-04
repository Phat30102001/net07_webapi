using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace dotnet07_webapi.Models;

[Table("SinhVien")]
public class SinhVien
{
    // field nào là PK thì thêm [Key]
    [Key]
    public string MaSV { get; set; }
    public string HoTen { get; set;}
    public DateTime NgaySinh { get; set;}
    // lop là khoá ngoại liên kết đến PK bảng LopHoc
    [ForeignKey("LopHoc")]
    public string Lop { get; set;}

    public LopHoc? LopHoc{ get; set;}
    [JsonIgnore]
    public List<DangKyHoc>? DangKyHocs { get; set; }
}

public class SinhVienUpdate
{
     public string HoTen { get; set;}
    public DateTime NgaySinh { get; set;}
    public string Lop { get; set;}
}