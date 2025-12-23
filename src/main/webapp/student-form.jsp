<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register Student</title>
    <style>
        /* Keeping your existing Glassmorphism styles */
        body { 
            font-family: 'Segoe UI', sans-serif; 
            margin: 0; padding: 0; 
            background: linear-gradient(135deg, #a8dadc 0%, #457b9d 100%); 
            display: flex; justify-content: center; align-items: center; min-height: 100vh;
        }
        .container { 
            width: 90%; max-width: 450px; padding: 30px; border-radius: 20px; 
            background: rgba(255, 255, 255, 0.2); 
            backdrop-filter: blur(10px); -webkit-backdrop-filter: blur(10px); 
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37); 
            border: 1px solid rgba(255, 255, 255, 0.3); 
            color: #1d3557; text-align: center;
        }
        h2 { color: #1d3557; margin-bottom: 25px; font-weight: 600; }
        .form-group { margin-bottom: 15px; text-align: left; }
        label { display: block; margin-bottom: 5px; font-weight: 600; color: #1d3557; }
        
        input[type="text"], input[type="email"], select { 
            width: 100%; padding: 10px; 
            border: 1px solid rgba(29, 53, 87, 0.4); border-radius: 8px; 
            box-sizing: border-box; background: rgba(255, 255, 255, 0.6); color: #1d3557; font-size: 14px;
        }
        
        input[type="submit"] { 
            background-color: #52b788; color: white; padding: 12px; 
            border: none; border-radius: 10px; cursor: pointer; font-size: 16px; 
            width: 100%; font-weight: 600; margin-top: 10px;
            transition: transform 0.2s;
        }
        input[type="submit"]:hover { transform: translateY(-2px); background-color: #40916c; }
        a { display: inline-block; margin-top: 20px; color: #1d3557; text-decoration: none; font-weight: 600; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Register New Student</h2>
        
        <form action="StudentServlet" method="post">
            <div class="form-group">
                <label>Roll Number:</label>
                <input type="text" name="rollNumber" required placeholder="e.g. 2025-CSE-01">
            </div>

            <div class="form-group">
                <label>First Name:</label>
                <input type="text" name="firstName" required placeholder="e.g. John">
            </div>
            
            <div class="form-group">
                <label>Last Name:</label>
                <input type="text" name="lastName" required placeholder="e.g. Doe">
            </div>
            
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" required placeholder="e.g. john@example.com">
            </div>

            <div class="form-group">
                <label>Assign Class:</label>
                <select name="classId" required>
                    <option value="" disabled selected>-- Select a Class --</option>
                    <c:forEach var="cls" items="${classList}">
                        <option value="${cls.classId}">${cls.className}</option>
                    </c:forEach>
                </select>
            </div>

            <input type="submit" value="Register Student">
        </form>
        
        <p><a href="StudentServlet?action=list">← Back to Main Menu</a></p>
    </div>
</body>
</html>