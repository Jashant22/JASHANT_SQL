# CourseHub — Poor Database Design Example

## M.000.404.vze – Databases (SQL)

**Week 4 — SQL Fundamentals, DDL & Database Design**

---

# 1. Scenario

Imagine that the CourseHub application stores student,
course, programme, instructor and enrollment information
in a single table.

The database contains the following relation:

COURSE_ENROLLMENT_REPORT

| student_id | student_name | student_email | programme_id | programme_name | course_id | course_title | credits | instructor_id | instructor_name | enrollment_date | enrollment_status |
|---|---|---|---|---|---|---|---:|---|---|---|---|
| 1 | Anna Müller | anna@example.com | P01 | Computer Science | C101 | Databases | 5 | I10 | Dr. Meyer | 2026-09-01 | active |
| 2 | David Smith | david@example.com | P01 | Computer Science | C101 | Databases | 5 | I10 | Dr. Meyer | 2026-09-02 | active |
| 3 | Maria Rossi | maria@example.com | P01 | Computer Science | C101 | Databases | 5 | I10 | Dr. Meyer | 2026-09-03 | active |
| 1 | Anna Müller | anna@example.com | P01 | Computer Science | C102 | Programming | 6 | I20 | Prof. Weber | 2026-09-01 | active |

At first sight, the table appears convenient.

Everything is available in one place.

However, the design contains several problems.

---

# 2. What Information Is Repeated?

Look at the first three rows.

The following facts are repeated:

- Course C101 is called "Databases".
- Course C101 has 5 credits.
- Course C101 is taught by instructor I10.
- Instructor I10 is Dr. Meyer.
- Programme P01 is called "Computer Science".

These are not enrollment facts.

They describe other entities.

---

# 3. Functional Dependencies

Assume the logical key of an enrollment is:

(student_id, course_id)

We can describe the business rules using functional dependencies.

student_id → student_name, student_email, programme_id

programme_id → programme_name

course_id → course_title, credits, instructor_id

instructor_id → instructor_name

(student_id, course_id)
→ enrollment_date, enrollment_status

The arrow can be read as:

> "determines"

For example:

course_id → course_title

means:

> If we know the course ID, we can determine the course title.

---

# 4. Update Anomaly

Suppose:

C101 = Databases

is renamed to:

Database Systems

The course title occurs in several rows.

We would therefore need to update multiple rows.

If one row is forgotten, the database might contain:

C101 → Databases

and

C101 → Database Systems

at the same time.

This creates inconsistent information.

This is an **update anomaly**.

---

# 5. Insertion Anomaly

Suppose the university creates a new course:

C200
Data Engineering
5 credits

but no student has enrolled yet.

If COURSE_ENROLLMENT_REPORT requires student information,
we may not be able to store the new course without inventing
a student enrollment.

This is an **insertion anomaly**.

A fact about a course should not depend on the existence of
an enrollment.

---

# 6. Deletion Anomaly

Imagine that only one student is enrolled in C102.

If that student leaves the course and we delete the enrollment row,
we might also accidentally delete the only stored information about:

- course C102;
- its title;
- its credits;
- its instructor.

This is a **deletion anomaly**.

Deleting an enrollment should not delete the definition of a course.

---

# 7. First Normal Form — 1NF

Consider this alternative design:

| student_id | student_name | course_ids |
|---|---|---|
| 1 | Anna Müller | C101, C102, C103 |

The `course_ids` attribute contains several independent course
references in one cell.

This creates problems for a relational design.

For example:

- How do we create a foreign key for each course?
- How do we efficiently search for one course?
- How do we prevent duplicates?
- How do we remove one enrollment?
- How do we store attributes of the relationship?

A better representation is:

| student_id | course_id |
|---|---|
| 1 | C101 |
| 1 | C102 |
| 1 | C103 |

Each relationship is represented as a separate row.

This is one reason why we introduced the ENROLLMENT relation.

---

# 8. Second Normal Form — 2NF

The logical key of the original report is:

(student_id, course_id)

Now examine:

student_id → student_name

`student_name` depends only on `student_id`.

It does not depend on the complete key.

Similarly:

course_id → course_title

`course_title` depends only on `course_id`.

These are examples of **partial dependencies**.

A better design separates these facts.

STUDENT

- student_id
- student_name
- student_email
- programme_id

COURSE

- course_id
- course_title
- credits
- instructor_id

ENROLLMENT

- student_id
- course_id
- enrollment_date
- enrollment_status

Now enrollment attributes describe the relationship between
Student and Course.

---

# 9. Third Normal Form — 3NF

Consider the Student information:

student_id → programme_id

and:

programme_id → programme_name

Therefore:

student_id
→ programme_id
→ programme_name

The programme name does not directly describe the student.

It describes the programme.

This is a **transitive dependency**.

A better design introduces:

PROGRAMME

- programme_id
- programme_name

STUDENT then contains:

- student_id
- student_name
- student_email
- programme_id

where:

programme_id

is a foreign key.

---

# 10. Another Transitive Dependency

We have:

course_id → instructor_id

and:

instructor_id → instructor_name

Therefore:

course_id
→ instructor_id
→ instructor_name

The instructor name describes the instructor, not the course.

We can therefore create:

INSTRUCTOR

- instructor_id
- instructor_name

and COURSE can reference INSTRUCTOR.

---

# 11. Improved Design

A possible normalized design is:

STUDENT

student_id PK  
student_name  
student_email UNIQUE  
programme_id FK

PROGRAMME

programme_id PK  
programme_name

COURSE

course_id PK  
course_title  
credits  
instructor_id FK

INSTRUCTOR

instructor_id PK  
instructor_name

ENROLLMENT

student_id FK  
course_id FK  
enrollment_date  
enrollment_status

A possible key for ENROLLMENT is:

(student_id, course_id)

Alternatively, an artificial `enrollment_id` can be used as the
primary key while keeping:

UNIQUE(student_id, course_id)

to enforce the business rule.

---

# 12. Dependency Overview

The improved model can be understood as:

student_id
    ↓
STUDENT
    ↓
programme_id
    ↓
PROGRAMME


course_id
    ↓
COURSE
    ↓
instructor_id
    ↓
INSTRUCTOR


student_id + course_id
          ↓
      ENROLLMENT
          ↓
enrollment_date
enrollment_status

Each fact now has a clearer home.

---

# 13. Key Idea

Normalization is not simply:

> "Create more tables."

Normalization asks:

> What does this attribute describe?

and:

> Which key determines this value?

The goal is to organize facts so that unnecessary redundancy
and dependency problems are reduced.

A useful beginner checklist is:

1. **1NF**  
   Are there repeating groups or multi-valued relationship fields?

2. **2NF**  
   If the key is composite, does every non-key attribute depend
   on the whole key?

3. **3NF**  
   Does a non-key attribute depend on another non-key attribute?

The final objective is simple:

> **Each fact should have a clear and appropriate home.**