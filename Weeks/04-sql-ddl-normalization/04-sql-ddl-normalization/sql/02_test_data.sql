-- ============================================
-- WEEK 4 - TEST DATA
-- ============================================

-- ============================================
-- PROGRAMMES
-- ============================================

INSERT INTO programme (programme_name)
VALUES
('B.Sc. Computer Science'),
('B.Sc. Business Administration');


-- ============================================
-- INSTRUCTORS
-- ============================================

INSERT INTO instructor (instructor_name)
VALUES
('Dr. Anna Müller'),
('Prof. John Smith'),
('Dr. Michael Weber');


-- ============================================
-- STUDENTS
-- ============================================

INSERT INTO student
(name, surname, email, programme_id)
VALUES
('Jashant', 'Sharma', 'jashant@example.com', 1),
('Max', 'Müller', 'max@example.com', 1),
('Emma', 'Schmidt', 'emma@example.com', 1),
('Liam', 'Brown', 'liam@example.com', 2);


-- ============================================
-- COURSES
-- ============================================

INSERT INTO course
(title, credits, instructor_id)
VALUES
('Database Systems', 6, 1),
('Java Programming', 6, 2),
('Operating Systems', 5, 3);


-- ============================================
-- VALID ENROLLMENTS
-- ============================================

INSERT INTO enrollment
(student_id, course_id, enrollment_date, status)
VALUES
(1, 1, '2026-09-29', 'active'),
(1, 2, '2026-09-29', 'active'),
(2, 1, '2026-09-29', 'active'),
(2, 3, '2026-09-29', 'completed'),
(3, 1, '2026-09-29', 'active'),
(4, 2, '2026-09-29', 'withdrawn');


-- ============================================
-- INVALID TESTS
-- Run these ONE AT A TIME.
-- They are expected to fail.
-- ============================================


-- TEST 1: Student does not exist
-- Expected: FOREIGN KEY violation

INSERT INTO enrollment
(student_id, course_id, enrollment_date, status)
VALUES
(999, 1, '2026-09-29', 'active');


-- TEST 2: Invalid status
-- Expected: CHECK constraint violation

INSERT INTO enrollment
(student_id, course_id, enrollment_date, status)
VALUES
(1, 3, '2026-09-29', 'maybe');


-- TEST 3: Duplicate enrollment
-- Expected: UNIQUE constraint violation

INSERT INTO enrollment
(student_id, course_id, enrollment_date, status)
VALUES
(1, 1, '2026-09-29', 'active');


-- TEST 4: Invalid credits
-- Expected: CHECK constraint violation

INSERT INTO course
(title, credits, instructor_id)
VALUES
('Invalid Course', -5, 1);