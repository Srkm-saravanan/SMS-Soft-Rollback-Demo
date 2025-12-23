<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student List (v1)</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Glassmorphism Theme (Preserved) */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #89f7fe 0%, #66a6ff 100%);
            margin: 0;
            display: flex; justify-content: center; align-items: center; min-height: 100vh;
            padding: 20px;
        }
        .container {
            background: rgba(255, 255, 255, 0.25);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(4px); -webkit-backdrop-filter: blur(4px);
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.18);
            padding: 30px;
            width: 100%; max-width: 1000px;
            text-align: center;
        }
        h2 { color: #333; margin-bottom: 25px; font-weight: 600; font-size: 1.8em; }
        .table-container { overflow-x: auto; margin-top: 20px; border-radius: 10px; }
        
        table { width: 100%; border-collapse: collapse; background: rgba(255, 255, 255, 0.6); }
        th, td { padding: 15px 12px; text-align: left; border-bottom: 1px solid rgba(0,0,0,0.05); color: #444; }
        th { background-color: #4a90e2; color: white; text-transform: uppercase; font-size: 0.85em; font-weight: bold; }
        tr:hover { background-color: rgba(255, 255, 255, 0.4); }
        
        .class-badge {
            background-color: #e2e6ea; color: #555; padding: 6px 12px;
            border-radius: 20px; font-size: 0.85em; font-weight: bold;
        }

        /* Buttons */
        .action-btn {
            padding: 8px 12px; border-radius: 6px; text-decoration: none; color: white;
            font-size: 0.9em; font-weight: 600; display: inline-flex; align-items: center;
            transition: 0.3s;
        }
        .item-delete { background-color: #e74c3c; }
        .item-delete:hover { background-color: #c0392b; transform: translateY(-2px); }

        .btn-container { margin-top: 30px; display: flex; justify-content: center; gap: 15px; }
        .btn { padding: 12px 24px; border-radius: 25px; font-weight: bold; text-decoration: none; color: white; display: inline-flex; align-items: center; transition: 0.3s; }
        .btn-register { background-color: #28a745; }
        .btn-menu { background-color: #007bff; }
        .btn:hover { transform: translateY(-3px); box-shadow: 0 4px 10px rgba(0,0,0,0.2); }
        
        /* Removed styles for .item-assign and .action-btn-group as they are no longer needed */
    </style>

    <script>
        function confirmDelete(id, name) {
            if (confirm("Are you sure you want to delete this student?\n\nName: " + name + "\nThis action cannot be undone.")) {
                window.location.href = "StudentServlet?action=delete&id=" + id;
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Student Management Report</h2>

        <c:if test="${not empty message}">
            <div class="message ${message.startsWith('Error') ? 'error' : 'success'}" 
                 style="margin-bottom: 20px; padding: 12px 20px; border-radius: 8px; font-weight: 600; text-align: left; background-color: ${message.startsWith('Error') ? '#f8d7da' : '#d4edda'}; color: ${message.startsWith('Error') ? '#721c24' : '#155724'}; border: 1px solid ${message.startsWith('Error') ? '#f5c6cb' : '#c3e6cb'};">
                ${message}
            </div>
        </c:if>

        <div class="table-container">
            <c:choose>
                <c:when test="${not empty listStudent}">
                    <table>
                        <thead>
                            <tr>
                                <th>Roll No</th>
                                <th>First Name</th>
                                <th>Last Name</th>
                                <th>Email</th>
                                <th>Class</th>
                                <th style="text-align: center;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="student" items="${listStudent}">
                                <tr>
                                    <td><strong>${student.rollNumber}</strong></td>
                                    <td>${student.firstName}</td>
                                    <td>${student.lastName}</td>
                                    <td>${student.email}</td>
                                    <td><span class="class-badge">${student.studentClass.className}</span></td>
                                    <td style="text-align: center;">
                                        <a href="#" 
                                           onclick="confirmDelete(${student.studentId}, '${student.firstName} ${student.lastName}')" 
                                           class="action-btn item-delete" 
                                           title="Delete Student">
                                            <i class="fas fa-trash-alt"></i> Delete
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="no-data">
                        <p>No students found. <a href="StudentServlet?action=new">Register the first one now!</a></p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="btn-container">
            <a href="StudentServlet?action=new" class="btn btn-register">
                <i class="fas fa-user-plus"></i> Register New Student
            </a>
            <a href="index.html" class="btn btn-menu">
                <i class="fas fa-home"></i> Main Menu
            </a>
        </div>
    </div>
</body>
</html>