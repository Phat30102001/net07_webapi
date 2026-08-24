using dotnet07_webapi.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace dotnet07_webapi.Controllers;

[ApiController]
[Route("api/[controller]")]
// tự map đúng tên của class controller tương ứng
public class UserController : ControllerBase
{
    private static List<User> users = new List<User>
    {
        new User() { Name = "admin", Email = "admin@mail.com", Phone = "0388963345"},
        new User() { Name = "user01", Email = "user01@mail.com", Phone = "0388963001"},
    };

    // Lấy tất cả users 
    // [HttpGet] // Phương thức HTTP GET
    // [Route("GetAllUsersAsync")] // Đường dẫn API
     
     [HttpGet("GetAllUsersAsync")] // api/[controller]/GetAllUsersAsync
    public async Task<List<User>> GetAllUsersAsync()
    {
        // Lấy ra danh sách users từ DB

        // Response về cho FE
        return users;
    }

    // Lấy 1 user dựa vào ID
     [HttpGet] // Phương thức HTTP GET
    [Route("GetUserByIdAsync/{userId}")] // Đường dẫn API
    public async Task<ActionResult<List<User>>> GetUserByIdAsync(Guid userId)
    {
        var user = users.FirstOrDefault(x => x.Id == userId);

        if (user == null)
        {
            return NotFound();
        }

        return Ok(user);
    }


    // Tìm kiếm users

    // Cập nhật SDT
    [HttpPatch] // dùng HTTP PUT để cập nhật 1 field dữ liệu
    [Route("UpdatePhoneAsync/{userId}")]
    public async Task<ActionResult<User>> UpdatePhoneAsync(Guid userId, string newPhone)
    {
        // Kiểm tra dữ liệu
        if (!newPhone.StartsWith("0"))
        {
            // throw new Exception("SDT không hợp lệ, vui lòng nhập lại");
            return BadRequest("SDT không hợp lệ, vui lòng nhập lại");
        }

        // lấy user có id = userId
        var user = users.FirstOrDefault(x => x.Id == userId);

        // Cập nhật SDT
        user.Phone = newPhone;

        return Ok(user);
    }

    // tạo mới 1 user
    [HttpPost] // Tạo mới dữ liệu
    [Route("CreateUserAsync")]
    public async Task<ActionResult<User>> CreateUserAsync(CreateUserRequestVM newUser)
    {
        // // Kiểm tra dữ liệu đầu vào
        // if (!newUser.Phone.StartsWith("0"))
        // {
        //     // throw new Exception("SDT không hợp lệ, vui lòng nhập lại");
        //     return BadRequest("SDT không hợp lệ, vui lòng nhập lại");
        // }

        // if (!string.IsNullOrWhiteSpace(newUser.Email))
        // {
        //     return BadRequest("Email không hợp lệ, vui lòng nhập lại");
        // }

        // Tạo mới user
        var createdNewUser = new User()
        {
            Name = newUser.Name,
            Phone = newUser.Phone,
            Email = newUser.Email
        };
        users.Add(createdNewUser);

        // Response về user vừa tạo
        return Ok(createdNewUser);
    }


    // Cập nhật đầy đủ thông tin User
    [HttpPut] // Dùng HTTP POST để cập nhật tất cả các field (full-field)
    [Route("UpdateUserAsync/{userId}")]
    public async Task<ActionResult<User>> UpdateUserAsync(Guid userId, UpdateUserRequestVM request)
    {
        // Lấy user có id = userId
        var user = users.FirstOrDefault(x => x.Id == userId);

        // Cập nhật giá trị tất cả các thuộc tính của user
        user.Phone = request.Phone;
        user.Email = request.Email;
        user.Name = request.Name;

        // Response về user vừa tạo
        return Ok(user);
    }

    // Xóa 1 user
    [HttpDelete]
    [Route("DeleteAsync")]
    public async Task<ActionResult> DeleteAsync(Guid userId)
    {
        // Lấy user có id = userId
        var user = users.FirstOrDefault(x => x.Id == userId);
        if (user == null)
        {
            return NotFound("User với id không tồn tại");
        }

        users.Remove(user);
        return Ok("Đã xóa thành công");
    }
}