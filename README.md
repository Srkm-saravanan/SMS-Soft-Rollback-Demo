🎓 College Management System

Version 1.0 – Enterprise Java Web Application

A production-ready Java Web Application designed to manage academic entities and their complex relationships within a college environment.
The system emphasizes data integrity, scalability, and architectural clarity, while also demonstrating a real-world Soft Rollback strategy used in enterprise and DevOps environments.

Think of it like a police database:
✔ No duplicate FIRs
✔ No missing suspects
✔ Every relationship traceable
✔ Even rollback happens without destroying evidence

📌 Project Overview

This application manages Classes, Students, and Subjects with a strong focus on Many-to-Many enrollment handling and a dynamic Enrollment Matrix Dashboard.
Additionally, it showcases a Soft Rollback Architecture, where application features can be reverted safely without altering the database schema or losing data.

🚀 Key Highlights

Clean MVC architecture with DAO pattern

Robust handling of Many-to-Many relationships

Soft Rollback Demo (real-world enterprise scenario)

Dynamic Enrollment Matrix Dashboard

Modern Glassmorphism UI

Database-level integrity and constraints

Liquibase-powered schema versioning

🏛️ Core Functional Capabilities
1️⃣ Academic Entity Management (CRUD)

Class Management

Create and manage academic departments (CSE, ECE, MECH, etc.)

Subject Management

Centralized subject repository for the institution

Student Management

Student registration with automatic class mapping via dropdowns

Like registering citizens at a police station—clean records, proper jurisdiction.

2️⃣ Student–Subject Relationship Mapping

Supports Many-to-Many enrollment

Prevents duplicate enrollments using UNIQUE constraints

Allows safe subject unassignment

Uses cascading foreign keys to maintain referential integrity

No duplicate criminals in records, no ghost entries 🚔

3️⃣ 📊 Enrollment Matrix Dashboard (Flagship Feature)

The Control Room of the Application

Dynamic Pivot Matrix

Subject columns generated automatically from the database

Real-Time Enrollment Status

Displays “Enrolled” / “Not Enrolled” for every student-subject pair

Instant Search & Filtering

Search by Student Name or Roll Number without page reload

Like a crime board—one glance shows who is connected to whom.

🔄 Soft Rollback Architecture (Enterprise Scenario)
🔹 The Scenario

Application upgraded to v2 with additional features (Library, Mobile, Address, etc.)

Business suddenly demands a rollback to v1 behavior

🔹 The Challenge

Roll back application logic without deleting v2 database data

🔹 The Solution

Application Layer rollback

Database Layer preserved

v2 tables and data remain intact

v1 UI & logic selectively hide advanced features

Police analogy:
Old rules enforced, but evidence locker remains untouched 🔐

🎨 User Interface & Experience

Glassmorphism Design System

Frosted glass cards, gradients, clean typography

Responsive Layout

Optimized for different screen sizes

Context-Aware Navigation

Headers dynamically display:
“Manage Subjects for [Student Name] ([Class Name])”

🛠️ Technology Stack
Layer	Technology
Backend	Java Servlets, JDBC
Design Pattern	DAO (Data Access Object)
Frontend	JSP, JSTL, HTML5, CSS3
Database	MySQL 8.0
Migration Tool	Liquibase
Build Tool	Maven
Application Server	Apache Tomcat
⚙️ Installation & Configuration
1️⃣ Database Initialization

Execute the following SQL in MySQL Workbench:

CREATE DATABASE college_student_db;
USE college_student_db;

CREATE TABLE class (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(100) NOT NULL
);

CREATE TABLE subject (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL
);

CREATE TABLE student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    roll_number VARCHAR(50) UNIQUE NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100),
    class_id INT,
    FOREIGN KEY (class_id) REFERENCES class(class_id)
);

CREATE TABLE student_subject_mapping (
    mapping_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subject(subject_id) ON DELETE CASCADE,
    UNIQUE (student_id, subject_id)
);

🧠 Architectural Strengths

Database-level consistency enforcement

Clear separation of Controller, DAO, Model, and View

Liquibase-enabled schema evolution

Optimized queries for real-time dashboards

Scalable for future academic modules

📈 Planned Enhancements

Role-based authentication (Admin / Staff)

Export Enrollment Matrix (Excel / PDF)

REST API integration

Pagination & advanced filters

Cloud deployment support
