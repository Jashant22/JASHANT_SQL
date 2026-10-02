# Week 3 Example — Redundancy and Normalization Preview

## A Poorly Designed Flat Table

| student_id | student_name | student_email | course_id | course_title | instructor_name |
|---:|---|---|---:|---|---|
| 1 | Anna Keller | anna@example.com | 101 | Databases | Dr. Meyer |
| 1 | Anna Keller | anna@example.com | 102 | Programming | Prof. Rossi |
| 2 | David Smith | david@example.com | 101 | Databases | Dr. Meyer |
| 3 | Maria Lopez | maria@example.com | 101 | Databases | Dr. Meyer |

## What Is Repeated?

For Course 101, the fact:

```text
101 | Databases | Dr. Meyer
```

is stored several times. Anna's student information is also repeated because she attends more than one course.

This is **redundancy**.

## 1. Update Anomaly

Suppose `Databases` is renamed to `Database Systems`.

Every row for Course 101 must be updated. If one row is missed, the database can contain conflicting course titles.

The fact:

```text
Course 101 is called Database Systems
```

should ideally be stored once in `COURSE`.

## 2. Insertion Anomaly

Suppose a new course is created:

```text
103 | Artificial Intelligence | Dr. Chen
```

but no student has enrolled yet.

If the flat table represents student-course combinations, storing the new course becomes difficult without also supplying student data.

A separate `COURSE` table avoids this problem.

## 3. Deletion Anomaly

Suppose Anna is the only student in Course 102.

Deleting Anna's enrollment could accidentally remove the only stored information about:

```text
Course 102 = Programming
Instructor = Prof. Rossi
```

We intended to delete an enrollment, not the course itself.

## Better Separation

```text
STUDENT
student_id | name | surname | email
```

```text
COURSE
course_id | title
```

```text
ENROLLMENT
enrollment_id | student_id | course_id | enrollment_date | status
```

Each fact now has a clearer home:

```text
Student facts    → STUDENT
Course facts     → COURSE
Enrollment facts → ENROLLMENT
```

## Key Idea

```text
Repeated facts
      ↓
possible inconsistencies
      ↓
update / insertion / deletion anomalies
      ↓
better separation of facts
      ↓
normalization
```

For Week 3, the goal is to recognize these problems. Formal 1NF, 2NF, and 3NF analysis comes later.
