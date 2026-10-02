# Week 3 – Relational Schema

## CourseHub Relational Model

### STUDENT

# Relational Schema

## STUDENT

```text
STUDENT(
    student_id PK,
    name,
    surname,
    email
)

### COURSE

COURSE(
    course_id PK,
    title
)

- Primary Key: course_id

### ENROLLMENT

ENROLLMENT(
    enrollment_id PK,
    student_id FK → STUDENT.student_id,
    course_id FK → COURSE.course_id,
    enrollment_date,
    status
)

enrollment_id is the primary key.
student_id is a foreign key referencing STUDENT.student_id.
course_id is a foreign key referencing COURSE.course_id.

## Questions
1. Which attributes uniquely identify rows?

The primary keys uniquely identify rows:

student_id in STUDENT
course_id in COURSE
enrollment_id in ENROLLMENT

2. Which attributes reference another table?
ENROLLMENT.student_id references STUDENT.student_id.
ENROLLMENT.course_id references COURSE.course_id.

3. Why are student_id and course_id in ENROLLMENT?
They connect students with courses. ENROLLMENT represents the relationship between STUDENT and COURSE.

4. What happens if ENROLLMENT contains a non-existent student_id?
The database rejects the row because of the foreign key constraint. This maintains referential integrity.

## Primary Key vs Candidate Key

A primary key is the selected key used to uniquely identify each row.
A candidate key is any minimal attribute or attribute set that could
uniquely identify a row.

For STUDENT:

Primary Key: student_id

Candidate Key: email

## Referential Integrity

Referential integrity protects the database from references to
non-existing parent rows. A foreign key ensures that a referenced
student or course exists before the enrollment can be created.