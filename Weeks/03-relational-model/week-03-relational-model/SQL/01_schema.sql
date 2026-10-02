CREATE TABLE student (
    student_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE course (
    course_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(200) NOT NULL
);

CREATE TABLE enrollment (
    enrollment_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    enrollment_date DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    CONSTRAINT fk_enrollment_student
        FOREIGN KEY (student_id)
        REFERENCES student(student_id),
    CONSTRAINT fk_enrollment_course
        FOREIGN KEY (course_id)
        REFERENCES course(course_id),
    CONSTRAINT uq_student_course
        UNIQUE (student_id, course_id)
);