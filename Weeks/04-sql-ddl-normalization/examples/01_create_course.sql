-- ============================================================
-- M.000.404.vze – Databases (SQL)
-- Week 4: SQL Fundamentals, DDL & Database Design
-- File: 01_create_course.sql
-- ============================================================
--
-- Purpose:
-- Demonstrate basic Data Definition Language (DDL)
-- using CREATE TABLE.
--
-- This example extends the CourseHub database used
-- during the previous weeks.
-- ============================================================


-- ------------------------------------------------------------
-- 1. Optional cleanup
-- ------------------------------------------------------------
-- Use this only if you want to recreate the table.
--
-- IMPORTANT:
-- If ENROLLMENT already references COURSE, PostgreSQL may
-- prevent COURSE from being dropped because of the FK.
--
-- DROP TABLE IF EXISTS course;


-- ------------------------------------------------------------
-- 2. Create the COURSE table
-- ------------------------------------------------------------

CREATE TABLE course (
    course_id INTEGER GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(200) NOT NULL,

    CONSTRAINT pk_course
        PRIMARY KEY (course_id)
);


-- ------------------------------------------------------------
-- 3. Inspect the table
-- ------------------------------------------------------------

SELECT *
FROM course;


-- ------------------------------------------------------------
-- 4. Insert a few example courses
-- ------------------------------------------------------------

INSERT INTO course (title)
VALUES
    ('Databases'),
    ('Programming'),
    ('Artificial Intelligence');


-- ------------------------------------------------------------
-- 5. Check the inserted data
-- ------------------------------------------------------------

SELECT *
FROM course
ORDER BY course_id;


-- ============================================================
-- Discussion Questions
-- ============================================================
--
-- 1. Why do we not manually enter course_id?
--
-- 2. What does GENERATED ALWAYS AS IDENTITY do?
--
-- 3. Why is title defined as NOT NULL?
--
-- 4. What would happen if we tried to insert a course
--    without a title?
--
-- 5. What is the role of the PRIMARY KEY?
-- ============================================================