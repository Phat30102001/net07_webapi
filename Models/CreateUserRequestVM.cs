using System.ComponentModel.DataAnnotations;

namespace dotnet07_webapi.Models;

public class CreateUserRequestVM
{
    public string? Name { get; set; }

    [Required]
    [StringLength(50, MinimumLength = 3, ErrorMessage = "Độ dài email phải từ 3 - 50 ký tự")]
    public required string Email { get; set; }


    [Required]
    [StringLength(12, MinimumLength = 10, ErrorMessage = "Độ dài SDT phải từ 10 - 12 ký tự")]
    public required string Phone { get; set; }
}