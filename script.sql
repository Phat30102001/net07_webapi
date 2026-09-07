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
-- bắt buộc có giá trị trả về 

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
ALTER Procedure sp_ChuyenLopSinhVien 
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
	-- bổ sung kiểm tra chua có data thì thêm 1 dòng để lưu lại lớp cũ
	-- 
	-- Kiểm tra lớp hiện tại có lưu lịch sử chưa
	IF NOT EXISTS (SELECT 1 From LichSuLopHoc Where MaSV = @MaSV AND DenNgay IS NULL)
	BEGIN
		-- lưu lại lớp hiện tại của sinh vien vào lịch sử 
		INSERT INTO LichSuLopHoc (MaSV, MaLop, TuNgay, DenNgay)
		 	SELECT MaSV, Lop, NULL, GETDATE()  
		 	from SinhVien 
			where MaSV = @MaSV
		
	END
	ELSE
	BEGIN
		UPDATE LichSuLopHoc SET DenNgay = GETDATE()
		WHERE MaSV= @MaSV and DenNgay IS NULL
	END
	
	
	
	
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

exec sp_ChuyenLopSinhVien @MaLopMoi='IT008', @MaSV='SV001' ,


select * from lichsulophoc
select * from sinhvien

-- 2 dòng ụịch sử 
-- dòng là lớp hiện : IT001 từ ngày A ->hôm nay
-- dòng lớp mới IT002 từ ngày Hôm ngay ->  NULL 
exec sp_ChuyenLopSinhVien @MaLopMoi='IT002', @MaSV='SV002'
SELECT MaSV, Lop, NULL, GETDATE()  from SinhVien 
			where MaSV = 'SV001' 
exec sp_ChuyenLopSinhVien @MaLopMoi='IT001', @MaSV='SV003'


-- update kieu du lieu cua 1 field trong table da tao 
ALTER table LichSuLopHoc
ALTER COLUMN TuNgay Date NULL
delete LichSuLopHoc where id in (8,9)

-- xoá dữ liệu 
-- bảng sinh vien  
-- TRIGGER 
-- tự động khi có thao tác xoá sinh
-- tạo bảng để lưu thông tin log
create table LogSinhVien(
	Id int Identity(1,1) Primary key,
	MaSV varchar(6),
	HoTen nvarchar(100),
	ThoiGian DATETIME Default GETDATE(),
	ThaoTac varchar(20)
)

-- trigger tracking  lich su thao tac len bang sinh vien
Create Trigger trg_LogInsertSinhVien
ON SinhVien
AFTER INSERT
AS
BEGIN
	INSERT INTO LogSinhVien(MaSV, HoTen, ThaoTac)
	SELECT MaSV, HoTen, 'INSERT' from inserted
END


CREATE Trigger trg_LogSinhVien
ON SinhVien
AFTER INSERT, Update, Delete
-- inserted, deleted(cu) -> inserted(moi), deleted
AS
BEGIN
	-- INSERT
	INSERT INTO LogSinhVien(MaSV, HoTen, ThaoTac)
	SELECT i.MaSV, i.HoTen, 'INSERT' from inserted i 
	left join deleted d on i.MaSV =  d.MaSV
	where d.MaSV is NULL
	-- update
	INSERT INTO LogSinhVien(MaSV, HoTen, ThaoTac)
	SELECT i.MaSV, i.HoTen, 'UPDATE' from inserted i 
	inner join deleted d on i.MaSV = d.MaSV
	-- deleted
	INSERT INTO LogSinhVien(MaSV, HoTen, ThaoTac)
	SELECT d.MaSV, d.HoTen, 'DELETE' from deleted d
	left join inserted i on i.MaSV =  d.MaSV
	where i.MaSV is NULL
END

-- VIEW			- luu lai cau select de tai su dung nhanh hon
-- FUNCTION		- tinh toan,.. bat buoc co return
-- SP   		- chuong trinh mini dat tren sql, chay dc nhieu cau lenh , co/ khong return
-- TRIGGER 		- khong can goi - tu chayj theo thao tac duoc cau hinh




select * from LogSinhVien
select * from SinhVien

-- theem sv
INSERT INTO SinhVien (MaSV, HoTen, NgaySinh, Lop)
VALUES ('SV006', N'Le Thi My', '2000-05-13','IT001');

-- them nhieu sv
INSERT INTO SinhVien (MaSV, HoTen, NgaySinh, Lop)
VALUES ('SV007', N'Le Thi My', '2000-05-13','IT001'),
 ('SV008', N'Le Van Minh', '2000-05-13','IT001'),
 ('SV009', N'Tran Manh', '2000-05-13','IT001')

 Update sinhvien set NgaySinh=N'2001-05-13' where masv='SV008'
 
 delete sinhvien where masv='SV006'




 
 
 
 
 -- khi thêm thì có dữ liệu trong insert mà delete tương ứng rỗng 
 -- khi xoá thì có dữ liệu trong delete mà insert tương ứng rỗng 
 
CREATE Trigger trg_LogSinhVien_V2
ON SinhVien
AFTER INSERT, Update, Delete
-- inserted, deleted(cu) -> inserted(moi), deleted
AS
BEGIN
	-- INSERT
	INSERT INTO LogSinhVien(MaSV, HoTen, ThaoTac)
	SELECT i.MaSV, i.HoTen, 'INSERT' from inserted i 
--	left join deleted d on i.MaSV =  d.MaSV
--	where d.MaSV is NULL
	-- deleted
	INSERT INTO LogSinhVien(MaSV, HoTen, ThaoTac)
	SELECT d.MaSV, d.HoTen, 'DELETE' from deleted d
--	left join inserted i on i.MaSV =  d.MaSV
--	where i.MaSV is NULL
END


-- 10.000 sản phẩm trong đó chủ yếu là sp giá cao 
-- sp giá = 20k (1%)
-- select * from sanpham where gia = 20

-- index - 
-- 
-- tạo bảng sanpham (id, ten , gia , soluong
CREATE TABLE SanPham
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    TenSanPham NVARCHAR(100),
    Gia DECIMAL(18,2),
    SoLuong INT,
    -- dc cua hang
    -- mau sac
    -- size 
);
-- index - 




Declare @i int = 10001
while @i <=100000
begin 
	insert into SanPham(TenSanPham, Gia, SoLuong)
	values
	(N'San Pham' + cast(@i as nvarchar(20)),10000 + (@i * 100),@i)
	set @i = @i +1;
end


select * from sanpham where TenSanPham like N'%pham9%'

SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT *
FROM SanPham
WHERE TenSanPham = N'San pham9000';

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









