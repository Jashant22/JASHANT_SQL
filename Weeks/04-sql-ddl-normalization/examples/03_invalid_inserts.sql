-- ============================================================
-- M.000.404.vze – Databases (SQL)
-- Week 4: SQL Fundamentals, DDL & Database Design
-- File: 03_invalid_inserts.sql
-- ============================================================
--
-- Purpose:
-- Intentionally violate database constraints.
--
-- IMPORTANT:
-- Run the examples ONE AT A TIME.
--
-- Read the PostgreSQL error message before fixing anything.
-- ============================================================


-- ------------------------------------------------------------
-- First inspect the current data.
-- ------------------------------------------------------------

SELECT *
FROM student
ORDER BY student_id;

SELECT *
FROM course
ORDER BY course_id;

SELECT *
FROM enrollment
ORDER BY enrollment_id;


-- ============================================================
-- TEST 1 — FOREIGN KEY violation
-- ============================================================
--
-- Assume student_id = 999 does not exist.
--
-- Uncomment and execute:
--
-- INSERT INTO enrollment (
--     student_id,
--     course_id,
--     enrollment_date,
--     status
-- )
-- VALUES (
--     999,
--     1,
--     CURRENT_DATE,
--     'active'
-- );
--
-- EXPECTED RESULT:
--
-- PostgreSQL should reject the INSERT because student 999
-- does not exist.
--
-- Constraint involved:
--
-- FOREIGN KEY
--
-- Question:
--
-- Why is student_id not simply "an integer" in ENROLLMENT?


-- ============================================================
-- TEST 2 — CHECK constraint violation
-- ============================================================
--
-- Uncomment and execute:
--
-- INSERT INTO enrollment (
--     student_id,
--     course_id,
--     enrollment_date,
--     status
-- )
-- VALUES (
--     1,
--     2,
--     CURRENT_DATE,
--     'maybe'
-- );
--
-- EXPECTED RESULT:
--
-- PostgreSQL should reject 'maybe'.
--
-- Allowed values:
--
-- active
-- completed
-- withdrawn
--
-- Constraint involved:
--
-- CHECK


-- ============================================================
-- TEST 3 — UNIQUE constraint violation
-- ============================================================
--
-- First make sure the following relationship already exists:
--
-- student_id = 1
-- course_id  = 1
--
-- Then try:
--
-- INSERT INTO enrollment (
--     student_id,
--     course_id,
--     enrollment_date,
--     status
-- )
-- VALUES (
--     1,
--     1,
--     CURRENT_DATE,
--     'active'
-- );
--
-- EXPECTED RESULT:
--
-- PostgreSQL should reject the duplicate relationship.
--
-- Constraint involved:
--
-- UNIQUE(student_id, course_id)


-- ============================================================
-- TEST 4 — CHECK constraint on COURSE
-- ============================================================
--
-- Uncomment and execute:
--
-- INSERT INTO course (
--     title,
--     credits
-- )
-- VALUES (
--     'Impossible Course',
--     -5
-- );
--
-- EXPECTED RESULT:
--
-- PostgreSQL should reject the row.
--
-- Question:
--
-- -5 is a valid INTEGER.
--
-- Why is it nevertheless invalid for this database?
--
-- Answer:
--
-- The DATA TYPE defines the technical domain.
-- The CHECK constraint defines an additional business rule.


-- ============================================================
-- TEST 5 — NOT NULL violation
-- ============================================================
--
-- Uncomment and execute:
--
-- INSERT INTO course (
--     title,
--     credits
-- )
-- VALUES (
--     NULL,
--     5
-- );
--
-- EXPECTED RESULT:
--
-- PostgreSQL should reject the row because every course
-- must have a title.
--
-- Constraint involved:
--
-- NOT NULL


-- ============================================================
-- FINAL DISCUSSION
-- ============================================================
--
-- For every error ask:
--
-- 1. Which rule did we violate?
--
-- 2. Which PostgreSQL constraint detected the problem?
--
-- 3. Would the SQL statement have been technically executable
--    without that constraint?
--
-- 4. Why is it useful to enforce this rule in the database
--    instead of only in application code?
--
--
-- KEY MESSAGE:
--
-- A database error is not always a problem with the database.
--
-- Sometimes the database is protecting our design.
-- ============================================================