# Week 3 – Relational Model, ER-to-Relational Mapping & Introduction to N# Week 3 – Relational Model, ER-to-Relational Mapping & Introduction to Normalization

## CourseHub

This week I transformed the Week 2 ER model into a relational schema
and created an initial PostgreSQL database schema.

## Main Tables

The database contains three tables:

- STUDENT
- COURSE
- ENROLLMENT

## Primary Keys

### STUDENT

Primary Key: `student_id`

### COURSE

Primary Key: `course_id`

### ENROLLMENT

Primary Key: `enrollment_id`

## Candidate Key

For STUDENT:

- Primary Key: `student_id`
- Candidate Key: `email`

The email address is unique, so it can uniquely identify a student.

## Foreign Keys

ENROLLMENT contains two foreign keys:

- `student_id` → `student.student_id`
- `course_id` → `course.course_id`

These foreign keys connect enrollments with existing students and courses.

## Referential Integrity

Referential integrity prevents an enrollment from referencing a
student or course that does not exist.

For example, an enrollment using `student_id = 999` was rejected
because student 999 does not exist.

## Normalization

The original combined table contains repeated student and course
information.

Separating the data into STUDENT, COURSE, and ENROLLMENT reduces
redundancy and helps prevent inconsistent updates.

See `normalization-notes.md` for details.

## SQL Files

The SQL implementation is stored in:

- `SQL/01_schema.sql`
- `SQL/02_test_data.sql`

## Test Result

Valid student, course, and enrollment rows were accepted.

The deliberately invalid enrollment using `student_id = 999` was
rejected because of the foreign key constraint.

## PostgreSQL Tables

The PostgreSQL database contains:

- `student`
- `course`
- `enrollment`

The database also contains an existing `customers` table from previous
database work.