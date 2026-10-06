# M.000.404.vze – Databases (SQL)
## Student System Setup Guide

**Hochschule Fresenius – Computer Science, B.Sc.**  
**Winter Semester 2026/27**

This course uses a practical database development environment based on:

- **Git & GitHub** – version control and course repositories
- **Visual Studio Code** – development environment
- **Docker & Docker Compose** – database environment
- **PostgreSQL 15** – relational database system
- **pgAdmin 4** – graphical database tool

PostgreSQL and pgAdmin will run through Docker. You therefore **do not need to install PostgreSQL or pgAdmin separately**.

Please complete this setup before the first practical session.

---

# 1. Create a GitHub Account

If you do not already have a GitHub account, create one at the GitHub website.

Send your **GitHub username** to the instructor.

You will receive access to the private course repository.

After receiving the invitation:

1. Log in to GitHub.
2. Accept the repository invitation.
3. Verify that you can access the course repository.

The course repository will contain:

- course examples,
- SQL scripts,
- exercises,
- Docker configuration,
- sample databases,
- supporting documentation.

For your own project work, you will later create a **private GitHub repository** and add the instructor as a collaborator.

---

# 2. Install Git

## Windows

Install **Git for Windows**.

Alternatively, using PowerShell:

```powershell
winget install --id Git.Git -e --source winget
```

Restart the terminal after installation.

Verify:

```powershell
git --version
```

---

## macOS

Git may already be available.

Check:

```bash
git --version
```

If necessary, install Apple's Command Line Tools:

```bash
xcode-select --install
```

If you use Homebrew:

```bash
brew install git
```

---

## Linux Mint / Ubuntu

Open a terminal:

```bash
sudo apt update
sudo apt install git
```

Verify:

```bash
git --version
```

---

# 3. Configure Git

Configure your name:

```bash
git config --global user.name "FirstName LastName"
```

Configure the email address associated with your GitHub account:

```bash
git config --global user.email "your-email@example.com"
```

Check:

```bash
git config --global --list
```

---

# 4. Install Visual Studio Code

Install **Visual Studio Code** for your operating system.

## Windows

Install the Windows version of VS Code.

During installation, it is recommended to enable:

```text
☑ Add to PATH
☑ Add "Open with Code"
```

Verify in PowerShell:

```powershell
code --version
```

## macOS

Install the correct version for:

- Apple silicon, or
- Intel Mac.

Move Visual Studio Code to the Applications folder.

To enable the terminal command:

```text
Cmd + Shift + P
```

Search for:

```text
Shell Command: Install 'code' command in PATH
```

Then restart the terminal.

Verify:

```bash
code --version
```

## Linux Mint / Ubuntu

Install the official `.deb` package or use Microsoft's package repository.

For a downloaded `.deb` file:

```bash
sudo apt install ./code_*.deb
```

Verify:

```bash
code --version
```

### Recommended VS Code Extensions

For this course, keep the setup simple.

Recommended:

- Python
- Docker

Additional database extensions may be introduced later if required.

---

# 5. Install Docker

Docker provides the PostgreSQL and pgAdmin environment used throughout the course.

The recommended setup depends on your operating system.

| Operating System | Recommended Setup |
|---|---|
| Windows | Docker Desktop + WSL 2 |
| macOS | Docker Desktop |
| Linux Mint / Ubuntu | Docker Engine + Docker Compose Plugin |

---

## Windows

Install **Docker Desktop for Windows**.

Docker should use the **WSL 2 backend**.

Check WSL in PowerShell:

```powershell
wsl --version
```

If WSL is not installed:

```powershell
wsl --install
```

Restart Windows if requested.

Install and start Docker Desktop.

Then verify:

```powershell
docker --version
```

```powershell
docker compose version
```

Test:

```powershell
docker run hello-world
```

**Important:** Docker Desktop must normally be running when you work with the course database.

---

## macOS

Install **Docker Desktop for Mac**.

Select the correct installer for:

- Apple silicon, or
- Intel.

Start Docker Desktop and wait until Docker is ready.

Verify:

```bash
docker --version
```

```bash
docker compose version
```

Test:

```bash
docker run hello-world
```

---

## Linux Mint / Ubuntu

Docker Desktop is not required.

Use **Docker Engine + Docker Compose Plugin**.

After configuring Docker's official package repository, the required packages are:

```bash
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Verify:

```bash
sudo systemctl status docker
```

Test:

```bash
sudo docker run hello-world
```

Check Docker Compose:

```bash
docker compose version
```

If Docker has been configured for use without `sudo`, you can test:

```bash
docker run hello-world
```

---

# 6. Clone the Course Repository

After receiving and accepting the private GitHub repository invitation, create a development directory.

## Windows PowerShell

```powershell
mkdir $HOME\development
cd $HOME\development
```

## Linux / macOS

```bash
mkdir -p ~/development
cd ~/development
```

Clone the repository using the URL provided by the instructor:

```bash
git clone https://github.com/eayan/databases-sql-2026
```

Enter the project:

```bash
cd databases-sql-2026
```

Check:

```bash
git status
```

Open it in VS Code:

```bash
code .
```

You normally need to `clone` the repository only once.

Before future classes, update your local copy with:

```bash
git pull
```

---

# 7. Start the Database Environment

The course repository contains a `compose.yaml` file.

From the repository directory, run:

```bash
docker compose up -d
```

Check the containers:

```bash
docker compose ps
```

The environment contains:

```text
PostgreSQL 15
pgAdmin 4
```

---

# 8. Open pgAdmin

Open your browser:

```text
http://localhost:8080
```

Login:

```text
Email:    admin@admin.com
Password: adminpassword
```

Register the PostgreSQL server with:

```text
Name:       Databases Course
Host:       db
Port:       5432
Database:   mydb
Username:   myuser
Password:   mypassword
```

**Important:** Because pgAdmin runs inside Docker, the PostgreSQL host is `db`, not `localhost`.

---

# 9. Test PostgreSQL

You do not need to install `psql` separately.

Run:

```bash
docker compose exec db psql -U myuser -d mydb
```

Then:

```sql
SELECT version();
```

and:

```sql
SELECT current_database();
```

Exit using:

```text
\q
```

---

# 10. PostgreSQL Connection Information

Programs running directly on your computer use:

```text
Host:     localhost
Port:     5433
Database: mydb
Username: myuser
Password: mypassword
```

pgAdmin running inside Docker uses:

```text
Host:     db
Port:     5432
Database: mydb
Username: myuser
Password: mypassword
```

Remember:

```text
Your computer → localhost:5433 → PostgreSQL

pgAdmin container → db:5432 → PostgreSQL
```

---

# 11. Essential Docker Commands

You only need a few Docker commands for this course.

Start:

```bash
docker compose up -d
```

Check:

```bash
docker compose ps
```

View logs:

```bash
docker compose logs
```

Stop:

```bash
docker compose down
```

Open PostgreSQL:

```bash
docker compose exec db psql -U myuser -d mydb
```

### Complete Database Reset

Only when instructed:

```bash
docker compose down -v
docker compose up -d
```

**Warning:** `docker compose down -v` deletes the database data stored in the project's Docker volumes.

---

# 12. Recommended Working Routine

Before a practical session:

```text
1. Open a terminal
2. Navigate to databases-sql-2026
3. git pull
4. code .
5. docker compose up -d
6. docker compose ps
7. Start working
```

At the end:

```text
1. Save your files
2. Commit/push your own work to your student repository
3. docker compose down
```

---

# 13. Your Own GitHub Repository

For project work, create your own **private GitHub repository**.

Use a clear name, for example:

```text
database-project-firstname-lastname
```

or for group work:

```text
database-project-group-01
```

Set:

```text
Visibility: Private
```

Then add the instructor as a collaborator.

Do not make your project repository public unless explicitly agreed with the instructor.

Do not commit passwords, GitHub tokens, API keys, or other sensitive credentials.

---

# 14. Installation Checklist

Complete this checklist before the first practical session.

### Git & GitHub

```text
☐ GitHub account created
☐ GitHub username sent to instructor
☐ Course repository invitation accepted
☐ Git installed
☐ git --version works
☐ Git name and email configured
☐ Course repository successfully cloned
```

### Visual Studio Code

```text
☐ VS Code installed
☐ code --version works
☐ Course repository opens in VS Code
☐ VS Code terminal works
```

### Docker

```text
☐ Docker installed
☐ Docker is running
☐ docker --version works
☐ docker compose version works
☐ docker run hello-world works
```

### Course Database

```text
☐ docker compose up -d works
☐ docker compose ps shows PostgreSQL
☐ docker compose ps shows pgAdmin
☐ PostgreSQL is healthy
☐ http://localhost:8080 opens
☐ pgAdmin login works
☐ pgAdmin connects to PostgreSQL
```

### Final Test

This command works:

```bash
docker compose exec db psql -U myuser -d mydb
```

and this query executes successfully:

```sql
SELECT version();
```

If all items are checked, your system is ready for the Databases (SQL) practical sessions.