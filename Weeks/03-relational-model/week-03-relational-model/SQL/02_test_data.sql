INSERT INTO student (name, surname, email)
VALUES
    ('Anna', 'Keller', 'anna@example.com'),
    ('David', 'Smith', 'david@example.com');

INSERT INTO course (title)
VALUES
    ('Databases'),
    ('Programming');

INSERT INTO enrollment (student_id, course_id, enrollment_date, status)
VALUES
    (1, 1, '2026-09-22', 'active'),
    (1, 2, '2026-09-22', 'active'),
    (2, 1, '2026-09-22', 'active');