-- M.000.404.vze – Databases (SQL)
-- Week 3: Initial CourseHub Schema
-- PostgreSQL

-- Optional for a complete classroom reset:
-- DROP TABLE IF EXISTS enrollment;
-- DROP TABLE IF EXISTS course;
-- DROP TABLE IF EXISTS student;

CREATE TABLE student (
    student_id INTEGER GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,

    CONSTRAINT pk_student
        PRIMARY KEY (student_id),

    CONSTRAINT uq_student_email
        UNIQUE (email)
);

CREATE TABLE course (
    course_id INTEGER GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(200) NOT NULL,

    CONSTRAINT pk_course
        PRIMARY KEY (course_id)
);

CREATE TABLE enrollment (
    enrollment_id INTEGER GENERATED ALWAYS AS IDENTITY,
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    enrollment_date DATE NOT NULL,
    status VARCHAR(50) NOT NULL,

    CONSTRAINT pk_enrollment
        PRIMARY KEY (enrollment_id),

    CONSTRAINT fk_enrollment_student
        FOREIGN KEY (student_id)
        REFERENCES student(student_id),

    CONSTRAINT fk_enrollment_course
        FOREIGN KEY (course_id)
        REFERENCES course(course_id),

    -- Business rule: one enrollment per student/course pair.
    CONSTRAINT uq_enrollment_student_course
        UNIQUE (student_id, course_id)
);

-- Useful psql commands:
-- \dt
-- \d student
-- \d course
-- \d enrollment
