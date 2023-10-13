-- Yêu cầu 4.1: Tìm nhân viên trong tên có chữ "A"
SELECT
  *
FROM
  `hr`.`employees`
WHERE
  `first_name` LIKE '%A%';

-- Yêu cầu 4.2: Tìm nhân viên trong họ tên có chữ "V"
SELECT
  *
FROM
  `hr`.`employees`
WHERE
  `last_name` LIKE '%V%';

-- Yêu cầu 4.3: Tìm nhân viên chưa có phân công vào phòng nào
SELECT
  *
FROM
  `hr`.`employees`
WHERE
  `department_id` IS NULL;

-- Yêu cầu 4.4: Tìm nhân viên vào công ty trong năm 2000
SELECT
  *
FROM
  `hr`.`employees`
WHERE
  YEAR (`hire_date`) = 2000;

-- Yêu cầu 4.5: Tìm nhân viên sinh vào công ty trong các tháng chẵn
SELECT 
  * 
FROM 
  `hr`.`employees` 
WHERE 
  MONTH(`hire_date`) % 2 = 0;
  
-- Yêu cầu 4.6: Hiển thị danh sách phòng cùng mã nhân viên, họ, tên, ngày vào công ty, thâm niên của nhân viên cóthâm niên trên 30 năm cho tới ngày hiện tại
SELECT
  d.department_name,
  e.employee_id,
  e.last_name,
  e.first_name,
  e.hire_date,
  DATEDIFF (CURDATE(), e.hire_date) / 365 AS tenure
FROM
  `hr`.`employees` e
  JOIN `hr`.`departments` d ON e.department_id = d.department_id
WHERE
  DATEDIFF (CURDATE(), e.hire_date) / 365 > 30;

-- Yêu cầu 4.7: Hiển thị tổng số nhân viên của công ty
SELECT
  COUNT(*) AS total_employees
FROM
  `hr`.`employees`;

-- Yêu cầu 4.8: Hiển thị tên phòng và tổng số nhân viên của phòng đó
SELECT
  d.department_name,
  COUNT(*) AS total_employees
FROM
  `hr`.`employees` e
  JOIN `hr`.`departments` d ON e.department_id = d.department_id
GROUP BY
  d.department_name;

-- Yêu cầu 4.9: Hiển thị tên phòng và tổng số nhân viên của phòng đó, nếu không có nhân viên thì hiển thị là 0
SELECT
  d.department_name,
  COUNT(e.employee_id) AS total_employees
FROM
  `hr`.`departments` d
  LEFT JOIN `hr`.`employees` e ON e.department_id = d.department_id
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
  `hr`.`employees` e
  JOIN `hr`.`departments` d ON e.department_id = d.department_id
WHERE
  e.salary = (
    SELECT
      MAX(salary)
    FROM
      `hr`.`employees`
    WHERE
      department_id = d.department_id
  )
ORDER BY
  d.department_name;