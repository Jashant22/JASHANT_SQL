-- ============================================
-- WEEK 4 - DDL AND NORMALIZATION
-- CourseHub Database
-- ============================================

-- ============================================
-- 1. PROGRAMME
-- ============================================

CREATE TABLE programme (
    programme_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    programme_name VARCHAR(100) NOT NULL UNIQUE
);


-- ============================================
-- 2. INSTRUCTOR
-- ============================================

CREATE TABLE instructor (
    instructor_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    instructor_name VARCHAR(100) NOT NULL
);


-- ============================================
-- 3. STUDENT
-- ============================================

CREATE TABLE student (
    student_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    programme_id INTEGER,

    CONSTRAINT fk_student_programme
        FOREIGN KEY (programme_id)
        REFERENCES programme(programme_id)
);


-- ============================================
-- 4. COURSE
-- ============================================

CREATE TABLE course (
    course_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    credits INTEGER NOT NULL,

    CONSTRAINT chk_course_credits
        CHECK (credits > 0 AND credits <= 30),

    instructor_id INTEGER NOT NULL,

    CONSTRAINT fk_course_instructor
        FOREIGN KEY (instructor_id)
        REFERENCES instructor(instructor_id)
);


-- ============================================
-- 5. ENROLLMENT
-- ============================================

CREATE TABLE enrollment (
    enrollment_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    student_id INTEGER NOT NULL,

    course_id INTEGER NOT NULL,

    enrollment_date DATE NOT NULL,

    status VARCHAR(20) NOT NULL,

    CONSTRAINT fk_enrollment_student
        FOREIGN KEY (student_id)
        REFERENCES student(student_id),

    CONSTRAINT fk_enrollment_course
        FOREIGN KEY (course_id)
        REFERENCES course(course_id),

    CONSTRAINT chk_enrollment_status
        CHECK (status IN ('active', 'completed', 'withdrawn')),

    CONSTRAINT uq_student_course
        UNIQUE (student_id, course_id)
);