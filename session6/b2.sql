DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    department VARCHAR(50),
    salary NUMERIC(10,2),
    hire_date DATE
);

INSERT INTO Employee (full_name, department, salary, hire_date) VALUES
('Nguyen Van An', 'IT', 10000000, '2023-02-15'),
('Tran Thi Binh', 'HR', 7000000, '2022-06-10'),
('Le Van An', 'IT', 9000000, '2023-05-20'),
('Pham Minh Tuan', 'Marketing', 8000000, '2023-03-12'),
('Hoang Thi Lan', 'IT', 5000000, '2021-11-01'),
('Doan Anh Duc', 'Sales', 6000000, '2023-08-25');

UPDATE Employee
SET salary = salary * 1.10
WHERE department = 'IT';

DELETE FROM Employee
WHERE salary < 6000000;

SELECT * FROM Employee
WHERE full_name ILIKE '%an%';

SELECT * FROM Employee
WHERE hire_date BETWEEN DATE '2023-01-01' AND DATE '2023-12-31';

SELECT * FROM Employee;