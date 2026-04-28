DROP TRIGGER IF EXISTS trg_employees_audit ON employees;
DROP FUNCTION IF EXISTS log_employee_changes();
DROP TABLE IF EXISTS employees_log;
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(100),
    salary NUMERIC
);

CREATE TABLE employees_log (
    id SERIAL PRIMARY KEY,
    employee_id INT,
    operation VARCHAR(10),
    old_data JSONB,
    new_data JSONB,
    change_time TIMESTAMP
);

CREATE OR REPLACE FUNCTION log_employee_changes()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO employees_log(employee_id, operation, old_data, new_data, change_time)
        VALUES (
            NEW.id,
            'INSERT',
            NULL,
            to_jsonb(NEW),
            NOW()
        );
        RETURN NEW;

    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO employees_log(employee_id, operation, old_data, new_data, change_time)
        VALUES (
            NEW.id,
            'UPDATE',
            to_jsonb(OLD),
            to_jsonb(NEW),
            NOW()
        );
        RETURN NEW;

    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO employees_log(employee_id, operation, old_data, new_data, change_time)
        VALUES (
            OLD.id,
            'DELETE',
            to_jsonb(OLD),
            NULL,
            NOW()
        );
        RETURN OLD;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_employees_audit
AFTER INSERT OR UPDATE OR DELETE ON employees
FOR EACH ROW
EXECUTE FUNCTION log_employee_changes();

INSERT INTO employees (name, position, salary)
VALUES ('An', 'Developer', 1000);

UPDATE employees
SET salary = 1200
WHERE name = 'An';

DELETE FROM employees
WHERE name = 'An';

SELECT * FROM employees_log;