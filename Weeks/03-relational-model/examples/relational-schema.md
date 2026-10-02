# Week 3 Example — CourseHub Relational Schema

## Starting Point

```text
STUDENT 1 ─── N ENROLLMENT N ─── 1 COURSE
```

## Relational Schema

```text
STUDENT(
    student_id PK,
    name,
    surname,
    email
)

COURSE(
    course_id PK,
    title
)

ENROLLMENT(
    enrollment_id PK,
    student_id FK → STUDENT.student_id,
    course_id FK → COURSE.course_id,
    enrollment_date,
    status
)
```

## Keys

### STUDENT
- **Primary Key:** `student_id`
- **Candidate Key:** `email` (assuming the business rule requires unique student emails)

### COURSE
- **Primary Key:** `course_id`

### ENROLLMENT
- **Primary Key:** `enrollment_id`
- **Foreign Key:** `student_id → STUDENT.student_id`
- **Foreign Key:** `course_id → COURSE.course_id`
- **Unique combination:** `(student_id, course_id)`

## Why ENROLLMENT?

Student and Course have a many-to-many relationship:

```text
One Student can enroll in many Courses.
One Course can have many Students.
```

`ENROLLMENT` resolves this into two 1:N relationships and stores facts about the relationship itself, such as `enrollment_date` and `status`.

## Mapping Rules

| ER Model | Relational Model |
|---|---|
| Entity | Relation / table |
| Attribute | Column |
| Identifier | Primary key |
| 1:N relationship | Foreign key on the N-side |
| M:N relationship | Associative / junction table |

## Referential Integrity

```text
ENROLLMENT.student_id → STUDENT.student_id
ENROLLMENT.course_id  → COURSE.course_id
```

An enrollment therefore cannot reference a student or course that does not exist.

## Business Rule → Constraint

Assumption:

> A student can enroll in a particular course only once.

Relational constraint:

```text
UNIQUE(student_id, course_id)
```

See `sql/01_schema.sql` for the PostgreSQL implementation.
