CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    job_level INT,
    salary NUMERIC
);

INSERT INTO employees (emp_name, job_level, salary) VALUES 
('An', 1, 1000), ('Bình', 2, 2000), ('Chi', 3, 3000);

CREATE OR REPLACE PROCEDURE update_salaries()
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE employees
    SET salary = CASE 
        WHEN job_level = 1 THEN salary * 1.05
        WHEN job_level = 2 THEN salary * 1.10
        WHEN job_level = 3 THEN salary * 1.15
        ELSE salary
    END;
END;
$$;

CALL update_salaries();
SELECT * FROM employees;