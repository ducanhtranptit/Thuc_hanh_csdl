CREATE TABLE
  `jobs` (
    `job_id` varchar(10) PRIMARY KEY,
    `job_title` varchar(35),
    `min_salary` decimal(8, 0),
    `max_salary` decimal(8, 0)
  );

CREATE TABLE
  `employees` (
    `employee_id` int (11) PRIMARY KEY,
    `first_name` varchar(20),
    `last_name` varchar(25) NOT NULL,
    `email` varchar(255) NOT NULL,
    `phone_number` varchar(20),
    `hire_date` date NOT NULL,
    `job_id` varchar(10),
    `salary` decimal(8, 2) NOT NULL,
    `commission_pct` decimal(2, 2),
    `manager_id` int (11),
    `department_id` int (11)
  );

CREATE TABLE
  `departments` (
    `department_id` int (11) PRIMARY KEY,
    `department_name` varchar(30) NOT NULL,
    `manager_id` int (11),
    `location_id` int (11)
  );

CREATE TABLE
  `locations` (
    `location_id` int (11) PRIMARY KEY,
    `street_address` varchar(40),
    `postal_code` varchar(12),
    `city` varchar(30) NOT NULL,
    `state_province` varchar(25),
    `country_id` char(2) NOT NULL
  );

CREATE TABLE
  `regions` (
    `region_id` int (11) PRIMARY KEY,
    `region_name` varchar(25)
  );

CREATE TABLE
  `countries` (
    `country_id` char(2) PRIMARY KEY,
    `country_name` varchar(40),
    `region_id` int (11) NOT NULL
  );

ALTER TABLE `employees` ADD FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`);

ALTER TABLE `employees` ADD FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`);

ALTER TABLE `departments` ADD FOREIGN KEY (`location_id`) REFERENCES `locations` (`location_id`);

ALTER TABLE `locations` ADD FOREIGN KEY (`country_id`) REFERENCES `countries` (`country_id`);

ALTER TABLE `countries` ADD FOREIGN KEY (`region_id`) REFERENCES `regions` (`region_id`);

-- Thêm dữ liệu vào bảng jobs
INSERT INTO
  `jobs` (`job_id`, `job_title`, `min_salary`, `max_salary`)
VALUES
  ('J001', 'Manager', 5000, 10000),
  ('J002', 'Developer', 3000, 8000),
  ('J003', 'Accountant', 2500, 7000);

-- Thêm dữ liệu vào bảng employees
INSERT INTO
  `employees` (
    `employee_id`,
    `first_name`,
    `last_name`,
    `email`,
    `phone_number`,
    `hire_date`,
    `job_id`,
    `salary`,
    `commission_pct`,
    `manager_id`,
    `department_id`
  )
VALUES
  (
    1001,
    'John',
    'Smith',
    'john.smith@example.com',
    '123456789',
    '2000-01-01',
    'J001',
    8000,
    NULL,
    NULL,
    1
  ),
  (
    1002,
    'Alice',
    'Johnson',
    'alice.johnson@example.com',
    '987654321',
    '2001-05-15',
    'J002',
    6000,
    0.05,
    1001,
    2
  ),
  (
    1003,
    'Victoria',
    'Adams',
    'victoria.adams@example.com',
    '555555555',
    '2005-11-30',
    'J002',
    5500,
    0.03,
    1001,
    2
  ),
  (
    1004,
    'David',
    'Vargas',
    'david.vargas@example.com',
    '111111111',
    '2003-07-20',
    'J003',
    4500,
    0.02,
    1001,
    3
  ),
  (
    1005,
    'Robert',
    'Valentine',
    'robert.valentine@example.com',
    '222222222',
    '2004-09-10',
    'J003',
    4000,
    0.01,
    1001,
    3
  );

-- Thêm dữ liệu vào bảng departments
INSERT INTO
  `departments` (
    `department_id`,
    `department_name`,
    `manager_id`,
    `location_id`
  )
VALUES
  (1, 'Administration', 1001, 1),
  (2, 'Development', 1001, 2),
  (3, 'Accounting', 1001, 3);

-- Thêm dữ liệu vào bảng locations
INSERT INTO
  `locations` (
    `location_id`,
    `street_address`,
    `postal_code`,
    `city`,
    `state_province`,
    `country_idlocations`
  )
VALUES
  (1, '123 Main St', '12345', 'New York', 'NY', 'US'),
  (
    2,
    '456 Oak Ave',
    '67890',
    'San Francisco',
    'CA',
    'US'
  ),
  (3, '789 Elm St', '54321', 'London', NULL, 'GB');

-- Thêm dữ liệu vào bảng regions
INSERT INTO
  `regions` (`region_id`, `region_name`)
VALUES
  (1, 'Americas'),
  (2, 'Europe');

-- Thêm dữ liệu vào bảng countries
INSERT INTO
  `countries` (`country_id`, `country_name`, `region_id`)
VALUES
  ('US', 'United States', 1),
  ('GB', 'United Kingdom', 2);

-- Yêu cầu 4.1: Tìm nhân viên trong tên có chữ "A"
SELECT
  *
FROM
  `employees`
WHERE
  `first_name` LIKE '%A%';

-- Yêu cầu 4.2: Tìm nhân viên trong họ tên có chữ "V"
SELECT
  *
FROM
  `employees`
WHERE
  `last_name` LIKE '%V%';

-- Yêu cầu 4.3: Tìm nhân viên chưa có phân công vào phòng nào
SELECT
  *
FROM
  `employees`
WHERE
  `department_id` IS NULL;

-- Yêu cầu 4.4: Tìm nhân viên vào công ty trong năm 2000
SELECT
  *
FROM
  `employees`
WHERE
  YEAR (`hire_date`) = 2000;

-- Yêu cầu 4.5: Tìm nhân viên sinh vào công ty trong các tháng chẵn
SELECT 
  * 
FROM 
  `employees` 
WHERE 
  MONTH(`hire_date`) % 2 = 0;
  
-- Yêu cầu 4.6: Hiển thị danh sách phòng cùng mã nhân viên, họ, tên, ngày vào công ty, thâm niên của nhân viên cóthâm niên trên 30 năm cho tới ngày hiện tại
SELECT
  d.department_name,
  e.employee_id,
  e.last_name,
  e.first_name,
  e.hire_date,
  DATEDIFF (CURDATE (), e.hire_date) / 365 AS tenure
FROM
  `employees` e
  JOIN `departments` d ON e.department_id = d.department_id
WHERE
  DATEDIFF (CURDATE (), e.hire_date) / 365 > 30;

-- Yêu cầu 4.7: Hiển thị tổng số nhân viên của công ty
SELECT
  COUNT(*) AS total_employees
FROM
  `employees`;

-- Yêu cầu 4.8: Hiển thị tên phòng và tổng số nhân viên của phòng đó
SELECT
  d.department_name,
  COUNT(*) AS total_employees
FROM
  `employees` e
  JOIN `departments` d ON e.department_id = d.department_id
GROUP BY
  d.department_name;

-- Yêu cầu 4.9: Hiển thị tên phòng và tổng số nhân viên của phòng đó, nếu không có nhân viên thì hiển thị là 0
SELECT
  d.department_name,
  COUNT(e.employee_id) AS total_employees
FROM
  `departments` d
  LEFT JOIN `employees` e ON e.department_id = d.department_id
GROUP BY
  d.department_name;

-- Yêu cầu 4.10: Hiển thị danh sách phòng cùng mã nhân viên, họ, tên, ngày vào công ty, lương của nhân viên có lương cao nhất phòng
SELECT
  d.department_name,
  e.employee_id,
  e.last_name,
  e.first_name,
  e.hire_date,
  e.salary
FROM
  `employees` e
  JOIN `departments` d ON e.department_id = d.department_id
WHERE
  e.salary = (
    SELECT
      MAX(salary)
    FROM
      `employees`
    WHERE
      department_id = d.department_id
  )
ORDER BY
  d.department_name;