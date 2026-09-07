-- Bai tap Salesdb
create database SalesDB;

use SalesDB;

-- ================================
-- Tao bang
-- ================================
-- generic type 
-- LIST<T> 
-- them , xoa , sua, 
-- xoa -> tim kiem de co 
-- Customers
-- int identity(1,1)
-- GUID
-- SP26001
-- SP27
create table Customers(
	Id int identity(1,1) PRIMARY key,
	Name NVARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address NVARCHAR(200)
)

-- Bảng sản phẩm
CREATE TABLE Products
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(150) NOT NULL,
    Price DECIMAL(18,2) NOT NULL,
    Stock INT NOT NULL DEFAULT 0
);
-- Bang Order
CREATE TABLE Orders
(
    Id INT IDENTITY(1, 1) PRIMARY KEY,
    CustomerId int,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(18, 2) DEFAULT 0,
    CONSTRAINT FK_Orders_Customer FOREIGN KEY (CustomerId) REFERENCES  Customers(Id)
);
-- Bảng chi tiết đơn hàng
CREATE TABLE OrderDetails
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(18,2) NOT NULL,

    CONSTRAINT FK_OrderDetails_Orders
        FOREIGN KEY (OrderID)
        REFERENCES Orders(Id),

    CONSTRAINT FK_OrderDetails_Products
        FOREIGN KEY (ProductID)
        REFERENCES Products(Id)
);
-- inssert
INSERT INTO Customers (Name, Email, Phone, Address)
VALUES
('Nguyễn Văn A', 'nva@example.com', '0901123456', 'Hà Nội'),
('Trần Thị B', 'ttb@example.com', '0912233445', 'Hồ Chí Minh'),
('Lê Văn C', 'lvc@example.com', '0987654321', 'Đà Nẵng');
-- product
INSERT INTO Products (ProductName, Price, Stock)
VALUES
('Laptop Dell XPS 15', 35000000, 10),
('iPhone 14 Pro Max', 29000000, 20),
('Chuột Logitech MX Master 3', 2500000, 30),
('Bàn phím cơ Keychron K2', 1800000, 25);
-- Order
INSERT INTO Orders (CustomerID, TotalAmount)
VALUES
(1, 63000000), -- Khách hàng Nguyễn Văn A
(2, 29000000), -- Khách hàng Trần Thị B
(3, 1800000); -- Khách hàng Lê Văn C

-- orrder detail
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES
(1, 1, 1, 35000000), -- Nguyễn Văn A mua 1 Laptop Dell XPS 15
(1, 2, 1, 29000000), -- Nguyễn Văn A mua 1 iPhone 14 Pro Max
(2, 2, 1, 29000000), -- Trần Thị B mua 1 iPhone 14 Pro Max
(3, 4, 1, 1800000); -- Lê Văn C mua 1 bàn phím Keychron K2

-- 1. laasy taast ca kahch hang
select * from SalesDB.dbo.Customers c 
--2.Lấy sản phẩm có giá trên 5 triệu.
select  * from SalesDB.dbo.Products p where price > 5000000
--3.Hiển thị đơn hàng kèm tên khách hàng, ngày đặt, tổng tiền.
Select o.Id, o.OrderDate, c.Name, o.TotalAmount from Orders o 
inner join Customers c 
on o.CustomerID = c.Id
--4.Hiển thị chi tiết đơn hàng kèm tên sản phẩm, số lượng, giá.
Select d.OrderId,d.Id, p.ProductName, d.Quantity, d.Price from OrderDetails d 
inner join Products p 
on d.ProductId = p.Id
Where d.OrderId = 2

--5.Tính tổng tiền mỗi khách hàng đã chi tiêu.
Select CustomerId, c.Name, SUM(TotalAmount) from ORDERS o
inner join Customers c 
on o.CustomerId = c.Id
group by o.CustomerId,  c.Name
-- 6.Tính tổng số lượng sản phẩm đã bán ra.
Select p.Id, p.ProductName, Sum(Quantity) from OrderDetails o 
inner join Products p
on o.ProductId = p.Id
Group By p.Id, p.ProductName
-- 7.Lấy khách hàng chi tiêu nhiều nhất.
Select TOP 1 CustomerId, c.Name, SUM(TotalAmount) from ORDERS o
inner join Customers c 
on o.CustomerId = c.Id
group by o.CustomerId,  c.Name
Order by SUM(TotalAmount) DESC
/*
5. Bài tập mở rộng
	1.Thêm bảng Employees(EmployeeID, Name, Role, Phone) – Quản lý nhân viên xử lý đơn hàng.
	2.Thêm cột Status vào Orders để theo dõi trạng thái đơn hàng (Chờ duyệt, Đã duyệt, Đang giao, Hoàn thành).
	3.Truy vấn tất cả đơn hàng có trạng thái "Đang giao".
	4.Cập nhật lại Stock trong Products sau khi có đơn hàng mới.
	5.Viết Stored Procedure để tự động cập nhật TotalAmount trong Orders khi có sản phẩm mới trong OrderDetails.
Yêu cầu :
	Viết code SQL để tạo bảng, thêm dữ liệu và thực hiện truy vấn.
	Kiểm tra kết quả sau mỗi truy vấn.
	Thực hiện các bài tập mở rộng để nâng cao kỹ năng SQL.
	Nộp script sql truy vấn
	Nộp script tạo bảng hoặc file bacpac
	Kiến thức áp dụng:
	Làm quen với SQL Server.
	Hiểu cách sử dụng Primary Key, Foreign Key.
	Thực hành với JOIN, GROUP BY, WHERE, ORDER BY, SUM.
 Gợi ý: Nếu gặp lỗi, kiểm tra cú pháp SQL và đảm bảo dữ liệu hợp lệ!
 * */