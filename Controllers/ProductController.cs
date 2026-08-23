using dotnet07_webapi.Models;
using Microsoft.AspNetCore.Mvc;

namespace dotnet07_webapi.Controllers;

[ApiController]
[Route("api/Product")]
public class ProductController : ControllerBase
{
    private static List<Product> Products = new List<Product>
    {
        new Product() { Name = "admin", Email = "admin@mail.com", Phone = "0388963345"},
        new Product() { Name = "Product01", Email = "Product01@mail.com", Phone = "0388963001"}
    };

    // Lấy tất cả Products 
    [HttpGet] // Phương thức HTTP GET
    [Route("GetAllProductsAsync")] // Đường dẫn API
    public async Task<List<Product>> GetAllProductsAsync()
    {
        // Lấy ra danh sách Products từ DB

        // Response về cho FE
        return Products;
    }

    // Lấy 1 Product dựa vào ID
     [HttpGet] // Phương thức HTTP GET
    [Route("GetProductByIdAsync")] // Đường dẫn API
    public async Task<ActionResult<List<Product>>> GetProductByIdAsync([FromQuery] Guid ProductId)
    {
        var Product = Products.FirstOrDefault(x => x.Id == ProductId);

        if (Product == null)
        {
            return NotFound();
        }

        return Ok(Product);
    }
}