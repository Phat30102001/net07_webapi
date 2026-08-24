-- comment code trong file .
/*
 * comment nhieu dong 
 * 
 * 
 * 
 */
-- Database  QuanLySinhVien , thong tin ve SinhVien, LopHoc, MonHoc, DiemThi,...
CREATE DATABASE QuanLySinhVien; -- query de tao database

-- Tao table de luu tru thong tin SinhVien
-- su dung DB nao thì use db đó 
USE QuanLySinhVien;

-- int , string -> VARCHAR(15) , string (tiếng việt ) -> NVARCHAR(15)
-- DATE ...
-- MaSV : SV001
-- 
-- KHOA CHINH: Primary key: 1 cột / nhiều cột dùng để nhận diện định danh môic 
CREATE TABLE SinhVien(
	MaSV VARCHAR(6) PRIMARY KEY,
	HoTen NVARCHAR(100),
	NgaySinh DATE,
	Lop VARCHAR(6)
)
-- thêm dữ liệu 
INSERT INTO SinhVien (MaSV, HoTen, NgaySinh, Lop)
VALUES ('SV001', N'Nguyễn Văn A', '2000-05-13','NET07');


-- câu lệnh truy vấn dữ liệu SELECT 
-- * lấy ra tất cả các  cột
select * from QuanLySinhVien.dbo.SinhVien;
select * from SinhVien;

-- lấy 1vài cột cần thiết 
Select HoTen, Lop from SinhVien;


-- them nhieu dong du lieu cung luc
-- thêm dữ liệu 
INSERT INTO SinhVien (MaSV, HoTen, NgaySinh, Lop)
VALUES 
('SV002', N'Nguyễn Văn B', '2000-05-14','NET07'),
('SV003', N'Nguyễn Văn C', '2000-05-15','NET07'),
('SV004', N'Nguyễn Văn D', '2000-05-16','NET07'),
('SV005', N'Nguyễn Văn E', '2000-05-17','NET07');

-- chinh sua , cap nhat du lieu : UPDATE
-- SV002 hoc lop NET06 
UPDATE QuanLySinhVien.dbo.SinhVien
SET Lop = 'NET06'
WHERE MaSV = 'SV002'

-- NGUY HIỂM: update mà không có WHERE -> thay doi thông tin cho toàn bộ bảng 
--UPDATE QuanLySinhVien.dbo.SinhVien
--SET Lop = 'NET06'

-- XOÁ DELETE  
DELETE  From QuanLySinhVien.dbo.SinhVien 
Where MaSV ='SV005'

-- 

select * from QuanLySinhVien.dbo.SinhVien Where MaSV ='SV001'

 SELECT [s].[MaSV], [s].[HoTen], [s].[Lop], [s].[NgaySinh]
      FROM [SinhVien] AS [s]


SELECT TOP(1) [s].[MaSV], [s].[HoTen], [s].[Lop], [s].[NgaySinh]
      FROM [SinhVien] AS [s]
      WHERE [s].[MaSV] = 'SV001'




