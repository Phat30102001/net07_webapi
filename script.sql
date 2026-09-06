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
	END as TrangThaiThanhToan
	
from QuanLySinhVien.dbo.SinhVien sv 
inner join QuanLySinhVien.dbo.DangKyHoc dkh 
on sv.MaSV  = dkh.MaSV 
INNER  JOIN QuanLySinhVien.dbo.MonHoc mh 
ON mh.MaMonHoc = dkh.MaMonHoc 






select sv.MaSV, sv.HoTen,sv.NgaySinh ,lh.TenLop
from QuanLySinhVien.dbo.SinhVien sv 
LEFT JOIN QuanLySinhVien.dbo.LopHoc lh 
ON sv.Lop = lh.MaLop 

except

select sv.MaSV, sv.HoTen,sv.NgaySinh ,lh.TenLop
from QuanLySinhVien.dbo.SinhVien sv 
inner JOIN QuanLySinhVien.dbo.LopHoc lh 
ON sv.Lop = lh.MaLop 



select * from sinhvien -- 4 SV (3 sv da chon lop)
select * from lophoc -- 3 lop

-- inner join - tập hop giao nhau  dăuj trên mã lớp 

select * from sinhvien sv
inner join lophoc lh
on sv.lop = lh.malop

-- left join  lay tat ca cac dong cua bang ben trai 
select * from sinhvien sv Left join lophoc lh
on sv.lop = lh.malop

-- right join laay ra tat cua cac dong cua bang been phai
select * from sinhvien sv right join lophoc lh
on sv.lop = lh.malop

-- Buoi 33
 SELECT TOP(1) [s].[MaSV], [s].[HoTen], [s].[Lop], [s].[NgaySinh], [l].[MaLop], [l].[TenLop]
      FROM [SinhVien] AS [s]
      INNER JOIN [LopHoc] AS [l] ON [s].[Lop] = [l].[MaLop]
      WHERE [s].[MaSV] = 'SV001'

select * from lophoc

SELECT [d].[MaSV], [s].[HoTen], [d].[MaMonHoc], [m].[TenMonHoc], [d].[NgayDangKy], [d].[ThanhToan]
FROM [DangKyHoc] AS [d]
INNER JOIN [SinhVien] AS [s] ON [d].[MaSV] = [s].[MaSV]
INNER JOIN [MonHoc] AS [m] ON [d].[MaMonHoc] = [m].[MaMonHoc]


-- buổi 34
use quanlysinhvien;
------------------------------------
-- ONE - ONE
------------------------------------
-- SinhVienProfile (CCCD, SoDienThoai, email, DiaChi,..)
-- MaSV vua la PK và đồng thời cũng  là FK - mói quan hệ 1-1
Create table SinhVienProfile (
	MaSV varchar(6) primary key,
	CCCD varchar(20),
	SoDienThoai varchar(12),
	Email varchar(100),
	DiaChi nvarchar(200),
	Constraint FK_SinhVienProfile_SinhVien 
	FOREIGN  KEY (MaSV) REFERENCES SinhVien(MaSV)
)

select * from sinhvien
select * from sinhvienProfile
-- insẻt dữ  lieu
Insert into SinhVienProfile (MaSV, CCCD, SoDienThoai, Email, DiaChi)
VALUES
('SV001','079200123456', '0792001234','sv001@gmail.com', N'Nha Trang')
-- them masv chua cos trong bang SinhVien
Insert into SinhVienProfile (MaSV, CCCD, SoDienThoai, Email, DiaChi)
VALUES
('SV009','079200123456', '0792001234','sv001@gmail.com', N'Nha Trang')
Insert into SinhVienProfile (MaSV, CCCD, SoDienThoai, Email, DiaChi)
VALUES
('SV002','079200123257', '0792001232','sv002@gmail.com', N'Vũng Tàu'),
('SV003','079200123357', '0792001233','sv003@gmail.com', N'Quy Nhơn'),
('SV004','079200123457', '0792001234','sv004@gmail.com', N'')

-- Them SV moi
INSERT INTO SinhVien (MaSV, HoTen, NgaySinh, Lop)
VALUES ('SV005', N'Tran Van Trung', '2000-05-13','IT008');
-- viet cau query

SELECT 
sv.MaSV, HoTen, NgaySinh, Lop,

CCCD, SoDienThoai, Email, DiaChi
From SinhVien sv 
LEFT join SinhVienProfile p 
on sv.MaSV = p.MaSV


------------------------------------
-- Self Referencing
------------------------------------
-- GiangVien (MaGV, HoTen, MaGVQuanLy)
Create table GiangVien (
	MaGV varchar(6) PRIMARY KEY ,
	HoTen nvarchar(100),
	MaGVQuanLy varchar(6),
	Constraint FK_GiangVien_QuanLy 
	FOREIGN KEY (MaGVQuanLy) REFERENCES GiangVien(MaGV)
)

-- inssety du lieu
Insert into GiangVien (MaGV, HoTen, MaGVQuanLy)
VALUES ('GV001' , N'Nguyễn Văn An', NULL)

INSERT INTO GiangVien (MaGV, HoTen, MaGVQuanLy)
VALUES
('GV002', N'Trần Minh Bình', 'GV001'),
('GV003', N'Lê Hoàng Nam', 'GV001');

--
Select * from GiangVien 
-- Hiện thên người quản lý 
SELECT 
gv.MaGV, gv.HoTen as TenGiangVien, ql.HoTen as TenQuanLy
FROM GiangVien gv
LEFT Join GiangVien ql 
on gv.MaGVQuanLy = ql.MaGV



------------------------------------
-- Hierarchical Relationship
------------------------------------
/*
 Khoa
 ├── Bộ môn CNTT
 │    ├── Lập trình
 │    └── Cơ sở dữ liệu
 └── Bộ môn Kinh tế
 
 GIAm DOC
 ├── TruongPhong
 │    ├── Pho phong
 │    └── Truong Bo Phan
 └── PhoGiamDoc
 * */
-- DanhMuc(MaDanhMuc, TenDanhMuc, MaDanhMucCha)
Create table DanhMuc (
	MaDanhMuc varchar(6) Primary key,
	TenDanhMuc nvarchar(100),
	MaDanhMucCha varchar(6),
	constraint FK_DanhMuc_Cha 
	FOREIGN key (MaDanhMucCha) REFERENCES DanhMuc(MaDanhMuc)
)
-- insert data

insert into DanhMuc(MaDanhMuc, TenDanhMuc, MaDanhMucCha)
Values
('DM001', N'Khoa Công nghệ thông tin', NULL),
('DM002', N'Khoa Truyền thông', NULL)
-- danh mục con 
insert into DanhMuc(MaDanhMuc, TenDanhMuc, MaDanhMucCha)
Values
('DM003', N'Bộ môn lập trình web','DM001' ),
('DM004', N'Bộ môn lập trình app','DM001' ),

('DM005', N'Bộ môn truyền thống', 'DM002'),
('DM006', N'Bộ môn hiện đại', 'DM002')

-- con của DM003, DM004
insert into DanhMuc(MaDanhMuc, TenDanhMuc, MaDanhMucCha)
Values
('DM007', N'Lap trinh web co ban','DM003' ),
('DM008', N'Lap trinh web nang cao','DM003' ),
('DM009', N'Lap trinh App co ban','DM004' ),
('DM0010', N'Lap trinh App nang cao','DM004' )

select * from DanhMuc
-- select laasy ra dm va dm cha
select d.MaDanhMuc, d.TenDanhMuc , c.TenDanhMuc as DanhMucCha from DanhMuc d
left join DanhMuc c 
on d.MaDanhMucCha = c.MaDanhMuc

------------------------------------
-- Temporal Relationship (Quan hệ theo thời gian)
------------------------------------
-- PK FK 
-- 


update SinhVien set Lop= 'IT006' where masv='SV005'

-- LichSuLopHoc (PK, MaSV, MaLop , TuNgay, DenNgay)
-- SV001 - IT008 - 1/1/2025 -> 1/9/2025 
-- SV001 - IT006 - 2/9/2025 -> NULL 

Create table LichSuLopHoc(
	Id int IDENTITY(1,1) PRIMARY KEY ,
	MaSV varchar(6),
	MaLop varchar(6),
	TuNgay DATE NOT NULL,
	DenNgay Date NULL,
	
	Constraint FK_LichSuLopHoc_SinhVien Foreign key (MaSV) references SinhVien(MaSV),
	Constraint FK_LichSuLopHoc_LopHoc Foreign key (MaLop) references LopHoc(MaLop)

)

INSERT INTO LichSuLopHoc
    (MaSV, MaLop, TuNgay, DenNgay)
VALUES
('SV005', 'IT008', '2026-01-01', '2026-09-05'),
('SV005', 'IT006', '2026-09-06', NULL);

select * from LichSuLopHoc



------------------------------------
-- VIEW - bảng ảo lệnh select đuoecj đặt 
------------------------------------
Create view vw_DanhSachDangKyHoc
as
select 
	sv.HoTen ,
	sv.Lop ,
	
	mh.TenMonHoc , 
	
	dkh.NgayDangKy ,
	CASE 
		WHEN dkh.ThanhToan = 1 THEN N'Đã thanh toán'
		ELSE N'Chưa thanh toán'
	END as TrangThaiThanhToan
	
from QuanLySinhVien.dbo.SinhVien sv 
inner join QuanLySinhVien.dbo.DangKyHoc dkh 
on sv.MaSV  = dkh.MaSV 
INNER  JOIN QuanLySinhVien.dbo.MonHoc mh 
ON mh.MaMonHoc = dkh.MaMonHoc 

-- thao tac nhu table binh thuong
-- CRUD -> 
-- Insert/ update/ delete -> it dung
-- where 
-- ho tro gom nhom du lieu - su dung lai nhanh
select * from vw_DanhSachDangKyHoc
Where lop<>'IT001'

-- FUNCTION 
-- dong goi code tsql thanh funtion va goi lai khi can

Create function fn_TraiThaiThanhToan(@ThanhToan BIT)
returns NVARCHAR(50)
as Begin
	Declare @KetQua NVARCHAR(50);
	-- than ham
	IF @ThanhToan = 1
		set @KetQua = N'Da Thanh Toan';
	ELSE 
		set @KetQua = N'Chua Thanh Toan';
	
	return @KetQua;
END
-- su dun fnc
select dbo.fn_TraiThaiThanhToan(0)

select 
	sv.HoTen ,
	sv.Lop ,
	
	mh.TenMonHoc , 
	
	dkh.NgayDangKy ,
	-- goi function
	dbo.fn_TraiThaiThanhToan(dkh.ThanhToan)
	
from QuanLySinhVien.dbo.SinhVien sv 
inner join QuanLySinhVien.dbo.DangKyHoc dkh 
on sv.MaSV  = dkh.MaSV 
INNER  JOIN QuanLySinhVien.dbo.MonHoc mh 
ON mh.MaMonHoc = dkh.MaMonHoc 
      
-- SP - chuong trinh dc code tren sql, thuc hien nhieu cau lenh 
Create Procedure sp_ChuyenLopSinhVien 
	@MaSV varchar(6), 
	@MaLopMoi varchar(6)
AS BEGIN
	-- than sp
	-- kiem tra xem sv co ton tai hay khong => da loi neu khong ton tai
	IF NOT EXISTS (Select 1 From SinhVien where MaSV = @MaSV )
		BEGIN
			RAISERROR(N'Sinh vien khong ton tai',16,1);
			RETURN;
		END
		
	-- kiem tra lop hoc co ton tai hay khong
	IF NOT EXISTS (Select 1 From LopHoc where MaLop = @MaLopMoi )
		BEGIN
			RAISERROR(N'Lop hoc khong ton tai',16,1);
			RETURN;
		END
	
	-- update dong hien tai trong lichsulophoc
	-- lop dang hoc thi sex co denngay = null
	UPDATE LichSuLopHoc SET DenNgay = GETDATE()
	WHERE MaSV= @MaSV and DenNgay IS NULL
	
	-- cap nhat sinhvien
	UPDATE SinhVien Set Lop = @MaLopMoi 
	Where MaSV= @MaSV
	
	-- them lich su moi
	INSERT INTO LichSuLopHoc (MaSV, MaLop, TuNgay, DenNgay)
	VALUES 
	(@MaSV, @MaLopMoi, GETDATE(), NULL)
END

exec sp_ChuyenLopSinhVien 'SV001' , 'IT011'
-- dong cũ của lớp IT008 
-- update dogn của sinhvien
-- insert dòng cho lop IT006

exec sp_ChuyenLopSinhVien @MaSV='SV001' , @MaLopMoi='IT008'


select * from lichsulophoc

