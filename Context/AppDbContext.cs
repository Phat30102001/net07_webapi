using dotnet07_webapi.Models;
using Microsoft.EntityFrameworkCore;

namespace dotnet07_webapi.Context;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
    {

    }
    // kết nối class trong model với table trong sql
    public DbSet<SinhVien> SinhVien { get; set; }
}