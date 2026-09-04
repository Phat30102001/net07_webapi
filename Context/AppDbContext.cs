using dotnet07_webapi.Models;
using Microsoft.EntityFrameworkCore;
// EF ORM 
// linQ => sql => db chayj => nhan lai du lieu
namespace dotnet07_webapi.Context;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
    {

    }
    // kết nối class trong model với table trong sql
    public DbSet<SinhVien> SinhVien { get; set; }
    public DbSet<LopHoc> LopHoc { get; set; }
    public DbSet<MonHoc> MonHoc { get; set; }
    public DbSet<DangKyHoc> DangKyHoc { get; set; }
}