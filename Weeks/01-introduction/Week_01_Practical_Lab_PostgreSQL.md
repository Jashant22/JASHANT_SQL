# M.000.404.vze -- Databases (SQL)

# Week 1 -- Practical Lab: Getting Started with PostgreSQL

**Hochschule Fresenius -- Computer Science, B.Sc. \| Winter Semester
2026/27**

**Session:** 08 September 2026\
**Part II:** Practical Lab\
**Duration:** approximately 90 minutes\
**Environment:** Git, GitHub, VS Code, Docker Compose, PostgreSQL 15,
pgAdmin 4

## Learning Objectives

By the end of this lab, you should be able to:

-   verify the required course development environment;
-   access and clone the private course GitHub repository;
-   start PostgreSQL and pgAdmin using Docker Compose;
-   connect to PostgreSQL using `psql` and pgAdmin;
-   explore an existing database and table;
-   execute introductory `SELECT` queries;
-   save SQL as source files in VS Code;
-   explain the basic Git workflow used for student work;
-   stop the Docker environment safely.

> **Course setup:** PostgreSQL and pgAdmin run in Docker. You do not
> need to install PostgreSQL or pgAdmin separately.

------------------------------------------------------------------------

## Activity 1 -- Environment Check

**Suggested time:** 10--15 minutes

Before working with the database, verify that the required development
tools are available.

Run the following commands in a terminal:

``` bash
git --version
docker --version
docker compose version
code --version
```

Then verify: - You have a GitHub account. - You have accepted the
invitation to the private course repository. - Docker is running. -
Visual Studio Code opens correctly.

**Windows:** Docker Desktop should be running and should use the WSL 2
backend. **macOS:** Docker Desktop should be running. **Linux Mint /
Ubuntu:** Docker Engine and the Docker Compose plugin should be running;
Docker Desktop is not required.

**Checkpoint:** All four version commands work and you can access the
private course repository.

**Short reflection:** Which operating system are you using? Did you
encounter any installation or permission problem?

------------------------------------------------------------------------

## Activity 2 -- Clone and Explore the Course Repository

**Suggested time:** 10 minutes

Create or open your development directory and clone the private course
repository using the URL provided by the instructor.

``` bash
git clone <course-repository-url>
cd databases-sql-2026
git status
code .
```

You normally clone the repository only once. In later sessions, use:

``` bash
git pull
```

Explore the repository and locate at least: - `README.md` -
`compose.yaml` - `database/init/` - `weeks/01-introduction/`

**Checkpoint:** The repository opens in VS Code and `git status` runs
successfully.

**Question:** Why is it useful to store SQL scripts in Git instead of
keeping queries only inside pgAdmin?

------------------------------------------------------------------------

## Activity 3 -- Start PostgreSQL and pgAdmin with Docker

**Suggested time:** 10 minutes

From the root directory of the course repository, start the environment:

``` bash
docker compose up -d
```

Check the services:

``` bash
docker compose ps
```

The environment contains: - PostgreSQL 15 - pgAdmin 4

PostgreSQL runs internally on port `5432` and is exposed to your
computer on `localhost:5433`. pgAdmin is available on
`http://localhost:8080`.

If a service does not start, inspect the logs:

``` bash
docker compose logs
```

or:

``` bash
docker compose logs db
```

**Checkpoint:** PostgreSQL is running/healthy and pgAdmin is running.

------------------------------------------------------------------------

## Activity 4 -- Connect to PostgreSQL

**Suggested time:** 10 minutes

First connect using `psql` inside the PostgreSQL container. No separate
PostgreSQL client installation is required.

``` bash
docker compose exec db psql -U myuser -d mydb
```

Run:

``` sql
SELECT version();
SELECT current_database();
SELECT current_user;
```

Expected database and user:

``` text
Database: mydb
User:     myuser
```

Exit `psql` with:

``` text
\q
```

Next, open pgAdmin in a browser:

``` text
http://localhost:8080
```

Login:

``` text
Email:    admin@admin.com
Password: adminpassword
```

Register the PostgreSQL server using:

``` text
Name:       Databases Course
Host:       db
Port:       5432
Database:   mydb
Username:   myuser
Password:   mypassword
```

**Important:** pgAdmin runs inside Docker, so it connects to `db:5432`.
A program running directly on your computer would connect to
`localhost:5433`.

**Checkpoint:** You can connect successfully using both `psql` and
pgAdmin.

------------------------------------------------------------------------

## Activity 5 -- Explore the Existing Database

**Suggested time:** 10 minutes

Use either `psql` or pgAdmin to inspect the database.

In `psql`, try:

``` text
\l
\dt
\d customers
```

Then answer: 1. What is the name of the current database? 2. Which
tables are available? 3. Which columns exist in the `customers` table?
4. Which column appears to identify a customer uniquely? 5. Which data
types can you recognize?

Do not worry if concepts such as primary keys or data types are not yet
completely clear. They will be covered systematically later.

**Checkpoint:** You can identify the `customers` table and describe its
basic structure.

------------------------------------------------------------------------

## Activity 6 -- Your First SELECT Queries

**Suggested time:** 20 minutes

Run the following queries one by one and inspect their results.

**6.1 -- Retrieve all customer data**

``` sql
SELECT *
FROM customers;
```

What do you think `*` means?

**6.2 -- Select specific columns**

``` sql
SELECT first_name, last_name
FROM customers;
```

Compare this result with `SELECT *`.

**6.3 -- Filter rows**

``` sql
SELECT *
FROM customers
WHERE city = 'Cologne';
```

How does the result differ from the complete table?

**6.4 -- Sort results**

``` sql
SELECT first_name, last_name, city
FROM customers
ORDER BY last_name;
```

**6.5 -- Your query**

Write a query that returns `first_name`, `last_name`, and `city` for
customers from a city of your choice.

**6.6 -- Challenge**

Return all customers sorted first by `city` and then by `last_name`.

**Checkpoint:** You can explain, at an introductory level, the purpose
of `SELECT`, `FROM`, `WHERE`, and `ORDER BY`.

------------------------------------------------------------------------

## Activity 7 -- Work with an SQL File in VS Code

**Suggested time:** 5--10 minutes

Do not keep your SQL only in pgAdmin.

Create a personal working file outside the instructor-controlled
course-material files, or in the location specified by the instructor
for today's lab, for example:

``` text
my_first_queries.sql
```

Add at least three queries from Activity 6.

Example:

``` sql
SELECT *
FROM customers;

SELECT first_name, last_name
FROM customers;

SELECT *
FROM customers
WHERE city = 'Cologne';
```

Save the file and execute the queries using the database tool
demonstrated in class.

**Checkpoint:** Your SQL exists as a saved `.sql` source file and can be
executed again.

**Important:** The central course repository is instructor-managed. Your
assessed/project work will be stored in your own private GitHub
repository.

------------------------------------------------------------------------

## Activity 8 -- Practice the Git Workflow

**Suggested time:** 10 minutes

For project and assessed work, you will use your own private GitHub
repository and add the instructor as a collaborator.

If the instructor has provided a student working repository for today's
exercise, use that repository. Otherwise, practice the commands
conceptually with a local exercise file and do not push changes to the
central course repository unless instructed.

The basic workflow is:

``` bash
git status
git add <filename>
git status
git commit -m "Add Week 1 SQL exercises"
git push
```

Remember the workflow:

``` text
Working files
     ↓ git add
Staging area
     ↓ git commit
Local repository
     ↓ git push
GitHub repository
```

Before committing, always inspect:

``` bash
git status
```

**Checkpoint:** You can explain the difference between `git add`,
`git commit`, and `git push`.

**Repository rule:** Do not use the central course repository as the
submission location for assignments. Student/project work belongs in a
separate private repository, with the instructor added as a
collaborator.

------------------------------------------------------------------------

## Activity 9 -- Exit Ticket and Clean Shutdown

**Suggested time:** 5 minutes

Before finishing, answer the following questions in your own words:

1.  What is a database?
2.  What is a DBMS?
3.  What is PostgreSQL?
4.  What is SQL?
5.  Why are we using Docker in this course?
6.  Why does pgAdmin connect to `db:5432`, while applications running
    directly on your computer use `localhost:5433`?
7.  What does the following query do?

``` sql
SELECT first_name, last_name
FROM customers
WHERE city = 'Cologne'
ORDER BY last_name;
```

Finally, stop the course environment:

``` bash
docker compose down
```

This stops and removes the containers but keeps the persistent database
volumes.

Do **not** run `docker compose down -v` unless the instructor explicitly
asks you to reset the database, because `-v` deletes the project volumes
and their stored data.

**Final checkpoint:** You can start, access, query, and stop the course
database environment.

------------------------------------------------------------------------

## Lab Completion Checklist

-   [ ] Git, VS Code, Docker and Docker Compose work.
-   [ ] I can access the private course GitHub repository.
-   [ ] I can clone/pull the course repository.
-   [ ] `docker compose up -d` starts PostgreSQL and pgAdmin.
-   [ ] I can open pgAdmin at `http://localhost:8080`.
-   [ ] I can connect to PostgreSQL as `myuser` / `mydb`.
-   [ ] I can inspect the `customers` table.
-   [ ] I can execute basic `SELECT`, `WHERE`, and `ORDER BY` queries.
-   [ ] I can save SQL in a `.sql` file.
-   [ ] I understand the basic `add → commit → push` Git workflow.
-   [ ] I understand that my project/assignment work belongs in my own
    private repository.
-   [ ] I can stop the environment with `docker compose down`.

## Quick Reference

``` text
pgAdmin URL:      http://localhost:8080
pgAdmin email:    admin@admin.com
pgAdmin password: adminpassword

PostgreSQL from host:
Host:     localhost
Port:     5433
Database: mydb
User:     myuser
Password: mypassword

PostgreSQL from pgAdmin container:
Host:     db
Port:     5432
Database: mydb
User:     myuser
Password: mypassword
```

``` bash
docker compose up -d
docker compose ps
docker compose exec db psql -U myuser -d mydb
docker compose logs
docker compose down
```
