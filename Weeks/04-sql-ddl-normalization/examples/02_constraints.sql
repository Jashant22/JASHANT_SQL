-- ============================================================
-- M.000.404.vze – Databases (SQL)
-- Week 4: SQL Fundamentals, DDL & Database Design
-- File: 02_constraints.sql
-- ============================================================
--
-- Purpose:
-- Demonstrate ALTER TABLE and common PostgreSQL constraints.
--
-- Topics:
--   PRIMARY KEY
--   FOREIGN KEY
--   UNIQUE
--   NOT NULL
--   CHECK
-- ============================================================


-- ------------------------------------------------------------
-- PART 1 — Extend COURSE
-- ------------------------------------------------------------

ALTER TABLE course
ADD COLUMN credits INTEGER;


-- Existing rows currently contain NULL in credits.
-- Update them before adding NOT NULL.

UPDATE course
SET credits = 5
WHERE credits IS NULL;


-- Add a CHECK constraint.

ALTER TABLE course
ADD CONSTRAINT chk_course_credits
CHECK (
    credits > 0
    AND credits <= 30
);


-- Make credits mandatory.

ALTER TABLE course
ALTER COLUMN credits SET NOT NULL;


-- ------------------------------------------------------------
-- PART 2 — Inspect COURSE
-- ------------------------------------------------------------

SELECT *
FROM course
ORDER BY course_id;


-- ------------------------------------------------------------
-- PART 3 — STUDENT constraints
-- ------------------------------------------------------------
--
-- Assumption:
-- STUDENT was created during the previous week.
--
-- Example structure:
--
-- student_id
-- name
-- surname
-- email


-- Student email addresses should be unique.

ALTER TABLE student
ADD CONSTRAINT uq_student_email
UNIQUE (email);


-- ------------------------------------------------------------
-- PART 4 — ENROLLMENT constraints
-- ------------------------------------------------------------
--
-- ENROLLMENT represents the relationship between
-- STUDENT and COURSE.
--
-- Expected columns:
--
-- enrollment_id
-- student_id
-- course_id
-- enrollment_date
-- status
-- ------------------------------------------------------------


-- A student should not be enrolled in the same course twice.

ALTER TABLE enrollment
ADD CONSTRAINT uq_enrollment_student_course
UNIQUE (student_id, course_id);


-- Restrict allowed enrollment status values.

ALTER TABLE enrollment
ADD CONSTRAINT chk_enrollment_status
CHECK (
    status IN (
        'active',
        'completed',
        'withdrawn'
    )
);


-- ------------------------------------------------------------
-- PART 5 — Inspect the current data
-- ------------------------------------------------------------

SELECT *
FROM student;

SELECT *
FROM course;

SELECT *
FROM enrollment;


-- ============================================================
-- What do these constraints protect?
-- ============================================================
--
-- PRIMARY KEY
--   → uniquely identifies a row
--
-- FOREIGN KEY
--   → prevents references to non-existing rows
--
-- UNIQUE
--   → prevents duplicate candidate-key values
--
-- NOT NULL
--   → prevents missing required values
--
-- CHECK
--   → restricts values according to a business rule
--
-- ============================================================