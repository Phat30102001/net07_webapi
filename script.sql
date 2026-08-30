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
      WHERE [s].[MaSV] = 'SV001';


      
  -- Buoi 32

select * from QuanLySinhVien.dbo.SinhVien sv 

 SELECT [s].[MaSV], [s].[HoTen], [s].[Lop], [s].[NgaySinh]
      FROM [SinhVien] AS [s]
      WHERE [s].[HoTen] LIKE N'%Nguyễn%'
-- %nguyễn: kết thúc bằng nguyễn 
-- nguyễn% : bd bằng nguyễn
-- %nguyễn%: chứa 
      
 Create table LopHoc(
 	MaLop varchar(6) PRIMARY KEY ,
 	TenLop NVARCHAR(100) Not null
 	)
insert into LopHoc (MaLop,TenLop)
values
('IT001', N'Lập trình cơ bản'),
('IT002', N'Lập trình nâng cao');


ALter table SinhVien 
add constraint FK__SinhVien__Lop Foreign Key (Lop) references LopHoc(MaLop)

 select * from QuanLySinhVien.dbo.SinhVien sv 
 
 
-- join kết hợp table để lấy dũe liệu cần thiết 
select sv.MaSV, sv.HoTen,sv.NgaySinh ,lh.TenLop  
from QuanLySinhVien.dbo.SinhVien sv  
inner join QuanLySinhVien.dbo.LopHoc lh
on sv.Lop = lh.MaLop 

-- them moi 1 sinh vien
INSERT INTO SinhVien (MaSV, HoTen, NgaySinh)
VALUES ('SV004', N'Nguyễn Văn Phat', '2000-05-13');
-- them 1 dong cho lopHoc
insert into LopHoc (MaLop,TenLop)
values
('IT003', N'Tin hoc van phong')



-- LEFT JOIN vaf RIGHT JOIN
-- lay ra tat ca sinh vien va ten lop (neu co)
select sv.MaSV, sv.HoTen,sv.NgaySinh ,lh.TenLop
from QuanLySinhVien.dbo.SinhVien sv 
LEFT JOIN QuanLySinhVien.dbo.LopHoc lh 
ON sv.Lop = lh.MaLop 
-- ds lophoc
select sv.MaSV, sv.HoTen,sv.NgaySinh ,lh.TenLop
from QuanLySinhVien.dbo.SinhVien sv 
Right JOIN QuanLySinhVien.dbo.LopHoc lh 
ON sv.Lop = lh.MaLop 


-- tao bang MonHoc
create table MonHoc(
	MaMonHoc varchar(6) Primary Key,
	TenMonHoc nvarchar(100) Not NULL DEFAULT 'mon_hoc_default',
	TKB nvarchar(100),
	NgayBatDau DATETIME,
	NgayKetThuc DATETIME
)

Create table DangKyHoc(
	MaSV varchar(6) NOT NULL,
	MaMonHoc varchar(6) NOT NULL,
	NgayDangKy DATETIME DEFAULT GETDATE(),
	ThanhToan BIT DEFAULT 0,
	--là một sinh viên không được đăng ký trùng cùng một môn 2 lần.
	CONSTRAINT PK_DangKyHoc PRIMARY KEY (MaSV, MaMonHoc),
	CONSTRAINT FK_DangKyHoc_SinhVien FOREIGN KEY (MaSV) REFERENCES SinhVien(MaSV),
	CONSTRAINT FK_DangKyHoc_MonHoc FOREIGN KEY (MaMonHoc) REFERENCES MonHoc(MaMonHoc)
)


--nạp du lieu cho mon hoc
insert into MonHoc (MaMonHoc,TenMonHoc)
values
('MH001', N'Kỹ năng Mềm'),
('MH002', N'Tiếng anh A1');

-- nạp dữ liệu cho DangKyHoc
-- SV001, SV002, Sv003, Sv004
-- MH001, MH002
insert into DangKyHoc (MaSV, MaMonHoc)
VALUES 
('SV001','MH002'),
('SV002','MH002'),
('SV001','MH001'),
('SV003','MH001'),
('SV003','MH002');

select * from dangkyhoc
-- cố ý tạo thêm trung key =>lỗi  The duplicate key value is (SV001, MH002).
insert into DangKyHoc (MaSV, MaMonHoc)
VALUES 
('SV001','MH002')

-- ds sinh viên đăng ký môn bao gồm các thông tin , tt sv, tt mon jhoc
--  , ngày dk , thanh toán rồi hay 

select 
	sv.HoTen ,
	sv.Lop ,
	
	mh.TenMonHoc , 
	
	dkh.NgayDangKy ,
	CASE 
		WHEN dkh.ThanhToan = 1 THEN N'Đã thanh toán'
		ELSE N'Chưa thanh toán'
	END
	
from QuanLySinhVien.dbo.SinhVien sv 
inner join QuanLySinhVien.dbo.DangKyHoc dkh 
on sv.MaSV  = dkh.MaSV 
INNER  JOIN QuanLySinhVien.dbo.MonHoc mh 
ON mh.MaMonHoc = dkh.MaMonHoc 













      
      
