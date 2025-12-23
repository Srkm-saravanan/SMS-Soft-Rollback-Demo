<<<<<<< HEAD
🎓 College Management System

Version 1.0 – Enterprise Java Web Application

A full-stack Java Web Application designed to efficiently manage academic entities and their relationships within a college environment. The system focuses on data integrity, scalability, and clarity, with special emphasis on Many-to-Many student–subject enrollment handling and a dynamic Enrollment Matrix Dashboard.

📌 Project Highlights

Clean MVC-style architecture using DAO design pattern

Robust handling of complex relational data

Modern Glassmorphism-based UI for enhanced user experience

Dynamic, real-time Enrollment Matrix Reporting System

🚀 Functional Capabilities
1. 🏛️ Academic Entity Management (CRUD Operations)

Class Management
Create and manage academic departments (e.g., CSE, ECE, MECH).

Subject Management
Maintain a centralized repository of subjects offered by the institution.

Student Management
Register students with automatic class association via dynamic dropdowns.

2. 🔗 Student–Subject Relationship Mapping

Supports Many-to-Many enrollment between students and subjects.

Prevents duplicate enrollments through database-level constraints.

Allows subject unassignment without affecting student or subject records.

Ensures referential integrity using cascading foreign keys.

3. 📊 Enrollment Matrix Dashboard (Core Feature)

The investigative control room of the application.

Dynamic Pivot Matrix
Automatically generates subject columns based on available data.

Real-Time Enrollment Status
Displays enrollment indicators such as “Enrolled” or “Not Enrolled” for each student–subject pair.

Instant Search & Filtering
Search the matrix by Student Name or Roll Number without page reload.

4. 🎨 User Interface & Experience

Glassmorphism Design System
Frosted glass cards, gradients, and clean typography.

Responsive Layout
Optimized for multiple screen sizes.

Context-Aware Navigation
Headers dynamically display
“Manage Subjects for [Student Name] ([Class Name])”
ensuring clarity during operations.

🛠️ Technology Stack
Layer	Technology
Backend	Java Servlets, JDBC
Design Pattern	DAO (Data Access Object)
Frontend	JSP, JSTL, HTML5, CSS3
Database	MySQL 8.0
Build Tool	Maven
Application Server	Apache Tomcat 7 (Maven Plugin)
⚙️ Installation & Configuration
1️⃣ Database Initialization

Execute the following SQL script in MySQL Workbench:

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

Database-level data consistency enforcement

Clean separation of Controller, DAO, Model, and View layers

Scalable schema suitable for future modules (attendance, marks, faculty)

Optimized queries for real-time dashboard rendering

📈 Future Enhancements (Planned)

Role-based authentication (Admin / Staff)

Export enrollment matrix as Excel / PDF

REST API integration

Pagination and advanced filtering

Cloud deployment support

✅ Summary

This project demonstrates strong fundamentals in Java Web Development, relational database design, and real-world academic system modeling. It reflects production-grade thinking — not just CRUD, but control, validation, and visibility.

Like a well-handled investigation:
no duplicate records, no missing links, no loose ends. 🚓🔥 
=======
# SMS-Soft-Rollback-Demo

# 🎓 College Management System (Soft Rollback Demo)

A robust Java web application for managing college records. This project demonstrates a **"Soft Rollback"** architecture—a real-world DevOps scenario where application features are reverted to a previous stable state (v1) without modifying or losing the advanced database schema (v2).

## 🚀 Key Features

* **Full-Stack Implementation:** Built with Java Servlets (Backend), JSP (Frontend), and MySQL (Database).
* **Database Automation:** Integrated **Liquibase** for automated schema migrations and version control.
* **Soft Rollback Architecture:**
    * **Scenario:** The app was upgraded to v2 (adding Library, Mobile, Address features).
    * **The Challenge:** A sudden requirement to revert to v1 UI/Behavior *without* deleting v2 data.
    * **The Solution:** Decoupled the Application Layer from the Database Layer. The DB retains v2 schemas (preventing data loss), while the App logic filters and hides these features to simulate a v1 environment.
* **Modern UI:** Custom CSS implementation featuring a Glassmorphism design system.
* **MVC Design Pattern:** Clean separation of concerns using DAO, Models, and Servlets.

## 🛠️ Tech Stack

* **Language:** Java (JDK 8+)
* **Framework:** Servlet API
* **Database:** MySQL 8.0
* **Migration Tool:** Liquibase
* **Frontend:** JSP, JSTL, HTML5, CSS3
* **Build Tool:** Maven

## 📸 Project Status
Currently running in **v1 Mode** (Student & Class Management only), with v2 data (Library/Subjects) preserved safely in the backend.
>>>>>>> f652d328cd4f4e6679d7b10838f5ffded85c54ab
