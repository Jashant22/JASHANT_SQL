# M.000.404.vze – Databases (SQL)
## Week 4 Practical Lab — SQL Fundamentals, DDL & Database Design

**Date:** 29 September 2026  
**Duration:** 90 minutes  
**Environment:** PostgreSQL + pgAdmin or VS Code + Docker  
**Submission:** Commit and push your work to your own private GitHub repository and make sure the instructor has collaborator access.

> **Goal:** Extend the CourseHub database into a robust relational schema, test database constraints, analyze a poor design, normalize it, and implement the improved design.

---

# Learning Outcomes

By the end of this lab, you should be able to:

- create and modify PostgreSQL tables using DDL;
- choose suitable PostgreSQL data types;
- implement `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `NOT NULL`, and `CHECK`;
- explain why PostgreSQL rejects invalid data;
- identify redundancy and functional dependencies;
- distinguish simple 1NF, 2NF, and 3NF problems;
- implement an improved normalized schema.

---

# Repository Structure

Create or update:

```text
week-04-sql-ddl-normalization/
├── README.md
├── sql/
│   ├── 01_schema.sql
│   └── 02_test_data.sql
└── normalization/
    └── normalization-analysis.md
```

---

# Part A — Build the Schema (25 min)

## Task A1 — Create STUDENT

Create a `student` table with:

- `student_id` — generated identity, primary key
- `name` — required
- `surname` — required
- `email` — required and unique
- `programme_id` — you may add this later after creating `programme`

## Task A2 — Create COURSE

Create a `course` table with:

- `course_id` — generated identity, primary key
- `title` — required
- `credits` — required
- credits must be greater than 0 and no more than 30

## Task A3 — Create ENROLLMENT

Create an `enrollment` table with:

- `enrollment_id` — generated identity, primary key
- `student_id` — required FK
- `course_id` — required FK
- `enrollment_date` — required
- `status` — required
- allowed status values: `active`, `completed`, `withdrawn`
- the same student must not be enrolled in the same course twice

### Checkpoint

Your schema should enforce these rules in PostgreSQL, not only in your application or documentation.

Use pgAdmin to inspect the tables after creation.

---

# Part B — Test the Constraints (15 min)

Add valid sample data to `sql/02_test_data.sql`.

Minimum:

- 4 students
- 3 courses
- 6 valid enrollments

Then deliberately try the following invalid operations **one at a time**.

## Test 1 — Missing Student

Try to create an enrollment using a `student_id` that does not exist.

**Question:** Which constraint rejects the row, and why?

## Test 2 — Invalid Status

Try:

```text
status = maybe
```

**Question:** Which constraint rejects this value?

## Test 3 — Duplicate Enrollment

Try to enroll the same student in the same course twice.

**Question:** Which constraint should prevent this?

## Test 4 — Invalid Credits

Try to create a course with:

```text
credits = -5
```

**Question:** Why should the database reject this even though `-5` is technically a valid integer?

Document the answers in your `README.md`.

> Do not remove a useful constraint just to make an invalid insert succeed.

---

# Part C — Normalize a Poor Design (25 min)

Consider the following relation:

```text
COURSE_ENROLLMENT_REPORT(
    student_id,
    student_name,
    student_email,
    programme_id,
    programme_name,
    course_id,
    course_title,
    credits,
    instructor_id,
    instructor_name,
    enrollment_date,
    enrollment_status
)
```

Assume the logical key for an enrollment is:

```text
(student_id, course_id)
```

Assume these business rules:

```text
student_id    → student_name, student_email, programme_id
programme_id  → programme_name
course_id     → course_title, credits, instructor_id
instructor_id → instructor_name
(student_id, course_id) → enrollment_date, enrollment_status
```

## Task C1 — Identify Problems

In `normalization/normalization-analysis.md`, answer:

1. What facts are repeated?
2. Give one possible **update anomaly**.
3. Give one possible **insertion anomaly**.
4. Give one possible **deletion anomaly**.

## Task C2 — 1NF

Is the given relation already in 1NF under the assumptions above?

Explain your answer.

Then answer:

> What would violate 1NF if `course_id` contained values such as `"101,102,103"` in a single cell?

## Task C3 — 2NF

The key is `(student_id, course_id)`.

Identify attributes that depend only on:

- `student_id`
- `course_id`
- the complete `(student_id, course_id)` key

Explain why the original relation has partial dependencies.

## Task C4 — 3NF

Look for transitive dependencies.

Hints:

```text
student_id → programme_id → programme_name
course_id  → instructor_id → instructor_name
```

Explain why `programme_name` and `instructor_name` should not remain in the original enrollment relation.

---

# Part D — Design and Implement the Improved Schema (15 min)

A reasonable normalized design may contain:

```text
STUDENT
PROGRAMME
COURSE
INSTRUCTOR
ENROLLMENT
```

Create your own final relational schema.

For every table, identify:

- primary key;
- foreign keys;
- required attributes;
- useful `UNIQUE` constraints;
- useful `CHECK` constraints.

Then implement the design in PostgreSQL.

You may use `ALTER TABLE` where appropriate instead of recreating every table.

### Important

There can be more than one defensible design. Document assumptions when the business rules are not explicit.

---

# Part E — Verify, Document, Commit and Push (10 min)

## Verification Checklist

- [ ] All tables are created successfully.
- [ ] Primary keys are present.
- [ ] Foreign keys are present.
- [ ] Required columns use `NOT NULL`.
- [ ] Student email is unique.
- [ ] Course credits have a `CHECK` constraint.
- [ ] Enrollment status has a `CHECK` constraint.
- [ ] Duplicate student-course enrollments are prevented.
- [ ] Valid sample data can be inserted.
- [ ] At least three invalid inserts were tested.
- [ ] Normalization analysis explains 1NF, 2NF and 3NF.
- [ ] SQL files can be executed in a logical order.

## Git Workflow

Check your changes:

```bash
git status
```

Stage them:

```bash
git add .
```

Commit:

```bash
git commit -m "Complete Week 4 DDL and normalization lab"
```

Push:

```bash
git push
```

Confirm that the files are visible in your private GitHub repository and that the instructor still has collaborator access.

---

# Reflection Questions

Add short answers to your `README.md`.

1. What is the difference between DDL and DML?
2. Why is a foreign key more than just an integer column?
3. Why is `CHECK (credits > 0)` useful even though `credits` already has type `INTEGER`?
4. What problem does `UNIQUE(student_id, course_id)` prevent?
5. What is the main idea of 1NF?
6. What is a partial dependency, and why is it relevant to 2NF?
7. What is a transitive dependency, and why is it relevant to 3NF?
8. Why should normalization decisions be based on business meaning and functional dependencies?

---

# Optional Challenge

Add a `semester` attribute to Enrollment.

Decide:

- suitable data type;
- whether it should be `NOT NULL`;
- whether `(student_id, course_id)` is still the correct uniqueness rule;
- whether the same student should be allowed to enroll in the same course in different semesters.

Document how this new requirement changes your constraint design.
