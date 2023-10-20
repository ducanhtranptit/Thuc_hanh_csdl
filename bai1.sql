-- 1.1. Hiển thị phiên bản của database:
SELECT
  VERSION ();

-- 1.2. Hiển thị danh sách database:
SHOW DATABASES;

-- 1.3. Hiển thị danh sách các table của một database (ví dụ: "mydatabase"):
SHOW TABLES;

-- 1.4. Hiển thị cấu trúc của một table (ví dụ: "mytable"):
DESCRIBE khoa;

-- 1.5. Hiển thị user đang kết nối:
SELECT
  USER ();

-- 1.6. Hiển thị database (schema) đang sử dụng:
SELECT
  DATABASE ();

-- 1.7. Hiển thị ngày giờ hiện tại của database:
SELECT
  CURRENT_TIMESTAMP();