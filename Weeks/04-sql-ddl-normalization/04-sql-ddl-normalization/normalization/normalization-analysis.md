# Normalization Analysis

## 1. Problems in the Original Design

The COURSE_ENROLLMENT_REPORT relation contains information about
students, programmes, courses, instructors and enrollments in one table.

This causes data redundancy because the same student, programme,
course and instructor information may be repeated across many rows.

### Update Anomaly

If a programme name changes, every row containing that programme
would need to be updated. If some rows are not updated, the database
could contain inconsistent programme names.

### Insertion Anomaly

A new course may not be insertable if the table requires an enrollment
record for the course. This means course information is dependent on
enrollment information.

### Deletion Anomaly

If the only student enrolled in a course is deleted, the course and
instructor information could also disappear from the relation.

---

## 2. First Normal Form (1NF)

The relation is in 1NF under the assumptions given because each
attribute contains a single atomic value.

For example, each row contains one student ID and one course ID.

However, a value such as:

    "101,102,103"

in the course_id column would violate 1NF because one cell would
contain multiple course IDs instead of one atomic value.

---

## 3. Second Normal Form (2NF)

The logical key is:

    (student_id, course_id)

The following attributes depend only on student_id:

- student_name
- student_email
- programme_id

Therefore:

    student_id → student_name, student_email, programme_id

The following attributes depend only on course_id:

- course_title
- credits
- instructor_id

Therefore:

    course_id → course_title, credits, instructor_id

These are partial dependencies because they depend on only part of
the composite key.

The enrollment-specific attributes depend on the complete key:

    (student_id, course_id) → enrollment_date, enrollment_status

To remove the partial dependencies, student and course information
should be stored in separate tables.

---

## 4. Third Normal Form (3NF)

There are two important transitive dependencies.

First:

    student_id → programme_id → programme_name

The programme name should therefore be stored in a separate
PROGRAMME table.

Second:

    course_id → instructor_id → instructor_name

The instructor name should therefore be stored in a separate
INSTRUCTOR table.

The normalized design contains:

- PROGRAMME
- STUDENT
- INSTRUCTOR
- COURSE
- ENROLLMENT

This reduces redundancy and prevents update, insertion and deletion
anomalies.

---

## 5. Final Design

### PROGRAMME

Primary key:

    programme_id

Unique:

    programme_name

### STUDENT

Primary key:

    student_id

Foreign key:

    programme_id → PROGRAMME(programme_id)

Unique:

    email

### INSTRUCTOR

Primary key:

    instructor_id

### COURSE

Primary key:

    course_id

Foreign key:

    instructor_id → INSTRUCTOR(instructor_id)

Check:

    credits > 0 AND credits <= 30

### ENROLLMENT

Primary key:

    enrollment_id

Foreign keys:

    student_id → STUDENT(student_id)
    course_id → COURSE(course_id)

Check:

    status IN ('active', 'completed', 'withdrawn')

Unique:

    (student_id, course_id)