-- Thêm 3 bản ghi cho bảng "Khoa"
INSERT INTO
  `Khoa` (`ma`, `ten`)
VALUES
  ('K1', 'Khoa Công nghệ thông tin'),
  ('K2', 'Khoa Điện tử Viễn thông'),
  ('K3', 'Khoa Điện điện tử');

-- Thêm 3 bản ghi cho bảng "Sinh_vien"
INSERT INTO
  `Sinh_vien` (`ma`, `ten`, `ngaysinh`, `makhoa`, `diachi`)
VALUES
  (1, 'Trần Đức Anh', '2002-04-25', 'K1', 'Hà Đông'),
  (
    2,
    'Nguyễn Tuấn Anh',
    '2002-12-20',
    'K2',
    'Thanh Xuân'
  ),
  (
    3,
    'Nguyễn Tiến Dũng',
    '2003-03-03',
    'K3',
    'Long Biên'
  );

--  Cập nhật số điện thoại thêm vào đầu mỗi số chuỗi '+84'
UPDATE `Sinh_vien`
SET
  `dienthoai` = CONCAT ('+84', `dienthoai`)
WHERE
  `dienthoai` IS NOT NULL;

-- Cập nhật số điện thoại thêm vào đầu mỗi số chuỗi '+84'. Nếu số điện thoại đã có mã quốc tế thì không được thêm vào nữa
UPDATE `Sinh_vien`
SET
  `dienthoai` = CONCAT ('+84', `dienthoai`)
WHERE
  `dienthoai` IS NOT NULL
  AND `dienthoai` NOT LIKE '+%';