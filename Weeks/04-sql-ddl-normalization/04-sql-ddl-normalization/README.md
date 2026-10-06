# Week 4 SQL DDL and Normalization Lab

## Overview

This project extends the CourseHub database using PostgreSQL.
It demonstrates DDL, constraints, relational design and
normalization up to 3NF.

---

# Constraint Testing

## Test 1 — Missing Student

The FOREIGN KEY constraint rejects the enrollment because the
student_id does not exist in the student table.

A foreign key ensures that an enrollment references an existing
student.

## Test 2 — Invalid Status

The CHECK constraint rejects the value "maybe".

Only the following statuses are allowed:

- active
- completed
- withdrawn

## Test 3 — Duplicate Enrollment

The UNIQUE(student_id, course_id) constraint prevents the same
student from being enrolled in the same course twice.

## Test 4 — Invalid Credits

The database rejects -5 because of the CHECK constraint:

    credits > 0 AND credits <= 30

INTEGER only ensures that the value is a whole number. It does not
ensure that the value is within the required business range.

---

# Reflection Questions

## 1. What is the difference between DDL and DML?

DDL stands for Data Definition Language. It is used to create and
modify database structures, such as tables.

Examples include:

- CREATE TABLE
- ALTER TABLE
- DROP TABLE

DML stands for Data Manipulation Language. It is used to work with
the data inside tables.

Examples include:

- INSERT
- UPDATE
- DELETE

---

## 2. Why is a foreign key more than just an integer column?

A foreign key is an integer column that also has a relationship with
a primary key in another table.

It ensures referential integrity by preventing references to
non-existing records.

---

## 3. Why is CHECK(credits > 0) useful even though credits is INTEGER?

INTEGER only controls the data type. It allows negative integers and
zero.

The CHECK constraint enforces the business rule that course credits
must be greater than zero.

---

## 4. What problem does UNIQUE(student_id, course_id) prevent?

It prevents the same student from being enrolled in the same course
more than once.

---

## 5. What is the main idea of 1NF?

1NF requires attributes to contain atomic values. Each cell should
contain one value rather than a list of multiple values.

---

## 6. What is a partial dependency?

A partial dependency occurs when a non-key attribute depends on only
part of a composite key rather than the entire key.

This is relevant to 2NF because 2NF removes partial dependencies.

---

## 7. What is a transitive dependency?

A transitive dependency occurs when a non-key attribute depends on
another non-key attribute.

For example:

    student_id → programme_id → programme_name

This is relevant to 3NF because 3NF removes transitive dependencies.

---

## 8. Why should normalization decisions be based on business meaning
and functional dependencies?

Normalization should reflect how the data actually works in the real
world.

Functional dependencies show which attributes determine other
attributes. Understanding these relationships helps us decide which
information belongs in each table and prevents unnecessary redundancy.