CREATE SCHEMA elearning;

CREATE TABLE elearning.students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE elearning.instructors (
    instructor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE elearning.courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    instructor_id INT,
    
    CONSTRAINT fk_instructor
        FOREIGN KEY (instructor_id)
        REFERENCES elearning.instructors(instructor_id)
);

CREATE TABLE elearning.enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT,
    course_id INT,
    enroll_date DATE NOT NULL,

    CONSTRAINT fk_student
        FOREIGN KEY (student_id)
        REFERENCES elearning.students(student_id),

    CONSTRAINT fk_course
        FOREIGN KEY (course_id)
        REFERENCES elearning.courses(course_id)
);

CREATE TABLE elearning.assignments (
    assignment_id SERIAL PRIMARY KEY,
    course_id INT,
    title VARCHAR(100) NOT NULL,
    due_date DATE NOT NULL,

    CONSTRAINT fk_course_assignment
        FOREIGN KEY (course_id)
        REFERENCES elearning.courses(course_id)
);

CREATE TABLE elearning.submissions (
    submission_id SERIAL PRIMARY KEY,
    assignment_id INT,
    student_id INT,
    submission_date DATE NOT NULL,
    grade REAL CHECK (grade >= 0 AND grade <= 100),

    CONSTRAINT fk_assignment
        FOREIGN KEY (assignment_id)
        REFERENCES elearning.assignments(assignment_id),

    CONSTRAINT fk_student_submission
        FOREIGN KEY (student_id)
        REFERENCES elearning.students(student_id)
);

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'elearning'
AND table_name = 'students';

