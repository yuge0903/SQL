CREATE TABLE Departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE Employees (
    emp_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dob DATE,
    department_id INT,

    CONSTRAINT fk_department
        FOREIGN KEY (department_id)
        REFERENCES Departments(department_id)
        ON DELETE SET NULL
);


CREATE TABLE Projects (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(150) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,

    CONSTRAINT chk_project_dates
        CHECK (end_date IS NULL OR end_date >= start_date)
);


CREATE TABLE EmployeeProjects (
    emp_id INT NOT NULL,
    project_id INT NOT NULL,

    PRIMARY KEY (emp_id, project_id),

    CONSTRAINT fk_emp
        FOREIGN KEY (emp_id)
        REFERENCES Employees(emp_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_project
        FOREIGN KEY (project_id)
        REFERENCES Projects(project_id)
        ON DELETE CASCADE
);


CREATE INDEX idx_emp_department ON Employees(department_id);
CREATE INDEX idx_emp_proj_emp ON EmployeeProjects(emp_id);
CREATE INDEX idx_emp_proj_proj ON EmployeeProjects(project_id);