CREATE TABLE Students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dob DATE
);

CREATE TABLE Courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL CHECK (credits > 0)
);

CREATE TABLE Enrollments (
    enrollment_id SERIAL PRIMARY KEY,

    student_id INT NOT NULL,
    course_id INT NOT NULL,

    grade CHAR(1),

    CONSTRAINT fk_student
        FOREIGN KEY (student_id)
        REFERENCES Students(student_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_course
        FOREIGN KEY (course_id)
        REFERENCES Courses(course_id)
        ON DELETE CASCADE,

    CONSTRAINT chk_grade
        CHECK (grade IN ('A', 'B', 'C', 'D', 'F')),

    CONSTRAINT unique_enrollment
        UNIQUE (student_id, course_id)
);

INSERT INTO Students (name, dob) VALUES
('Nguyen Van A', '2003-03-02'),
('Tran Thi B', '2002-07-15'),
('Le Van C', '2003-11-20');

INSERT INTO Courses (course_name, credits) VALUES
('Database Systems', 3),
('Data Structures', 4),
('Operating Systems', 3);

INSERT INTO Enrollments (student_id, course_id, grade) VALUES
(1, 1, 'A'),
(1, 2, 'B'),
(2, 1, 'C'),
(2, 3, 'B'),
(3, 2, 'A');