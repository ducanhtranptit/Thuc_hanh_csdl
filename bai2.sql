-- Tạo table `Khoa` và `Sinh_vien`
CREATE TABLE
  `Khoa` (
    `ma` varchar(4) PRIMARY KEY NOT NULL,
    `ten` varchar(100) NOT NULL
  );

CREATE TABLE
  `Sinh_vien` (
    `ma` int (10) NOT NULL,
    `ten` varchar(100) NOT NULL,
    `ngaysinh` date NOT NULL,
    `makhoa` varchar(4),
    `diachi` varchar(100) NOT NULL
  );

-- Thêm khóa ngoại cho bảng "Sinh_vien"
ALTER TABLE `Sinh_vien` ADD FOREIGN KEY (`makhoa`) REFERENCES `Khoa` (`ma`);

-- Bổ sung cột "dienthoai" cho bảng "Sinh_vien"
ALTER TABLE `Sinh_vien`
ADD COLUMN `dienthoai` varchar(15);

-- Mở rộng độ dài cho cột "dienthoai"
ALTER TABLE `Sinh_vien` MODIFY COLUMN `dienthoai` varchar(20);

-- Bổ sung ràng buộc (constraint) để đảm bảo cặp (tên, ngày sinh) không trùng nhau
ALTER TABLE `Sinh_vien` ADD CONSTRAINT `uq_sinhvien_tensinh_unique` UNIQUE (`ten`, `ngaysinh`);

-- Tạo view để hiển thị sinh viên của một khoa có mã nhất định (ví dụ: 'CNTT')
CREATE VIEW
  `View_Sinhvien_Khoa` AS
SELECT
  `Sinh_vien`.`ma`,
  `Sinh_vien`.`ten`,
  `Sinh_vien`.`ngaysinh`,
  `Sinh_vien`.`makhoa`,
  `Sinh_vien`.`diachi`
FROM
  `Sinh_vien`
  JOIN `Khoa` ON `Sinh_vien`.`makhoa` = `Khoa`.`ma`
WHERE
  `Khoa`.`ma` = 'CNTT';

-- Gán quyền cho người dùng dblab.user02 có quyền thêm bản ghi vào bảng sinhvien
CREATE USER 'user02.dblab' IDENTIFIED BY '123456';

GRANT INSERT ON Thuc_hanh_csdl_01.sinhvien TO 'user02.dblab';

-- Tạo index cho cột "dienthoai" của bảng "Sinh_vien"
CREATE INDEX `idx_sinhvien_dienthoai` ON `Sinh_vien` (`dienthoai`);