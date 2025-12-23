<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Issue Books</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #f6d365 0%, #fda085 100%); /* Warm Orange/Gold */
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0; padding: 20px;
        }

        .glass-container {
            background: rgba(255, 255, 255, 0.3);
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(8px);
            border-radius: 15px;
            padding: 30px;
            width: 100%; max-width: 600px;
            text-align: center;
        }

        h2 { color: #d35400; margin-bottom: 5px; }
        h4 { color: #555; margin-top: 0; font-weight: 400; }

        /* --- FORM STYLING --- */
        select {
            padding: 12px; width: 70%; border-radius: 5px; border: 1px solid #ddd;
            font-size: 1rem; margin-bottom: 15px;
        }
        
        .btn-issue {
            padding: 12px 20px; border: none; border-radius: 5px;
            background-color: #e67e22; color: white; font-weight: bold;
            cursor: pointer; transition: 0.3s;
        }
        .btn-issue:hover { background-color: #d35400; }

        /* --- LIST STYLING --- */
        .book-list {
            margin-top: 25px;
            text-align: left;
            background: rgba(255,255,255,0.6);
            padding: 15px; border-radius: 10px;
        }
        
        .book-item {
            padding: 10px; border-bottom: 1px solid rgba(0,0,0,0.1);
            display: flex; justify-content: space-between; align-items: center;
        }
        .book-item:last-child { border-bottom: none; }
        
        .book-icon { color: #e67e22; margin-right: 10px; }

        .btn-back {
            display: inline-block; margin-top: 20px;
            text-decoration: none; color: #333;
            background: rgba(255,255,255,0.5); padding: 8px 15px;
            border-radius: 20px;
        }
    </style>
</head>
<body>
    <div class="glass-container">
        <h2><i class="fas fa-book-reader"></i> Library Issue Desk</h2>
        <h4>Student: <strong>${student.firstName} ${student.lastName}</strong> (${student.rollNumber})</h4>

        <c:if test="${not empty message}">
            <div style="background: rgba(255,255,255,0.8); padding: 10px; border-radius: 5px; color: #d35400; margin-bottom: 15px;">
                ${message}
            </div>
        </c:if>

        <form action="StudentServlet" method="post">
            <input type="hidden" name="formType" value="issueBook">
            <input type="hidden" name="studentId" value="${studentId}">
            
            <label>Select Book to Issue:</label><br>
            <select name="bookId" required>
                <option value="" disabled selected>-- Choose a Book --</option>
                <c:forEach var="book" items="${allBooks}">
                    <option value="${book.bookId}">${book.bookName}</option>
                </c:forEach>
            </select>
            <button type="submit" class="btn-issue"><i class="fas fa-plus-circle"></i> Issue Book</button>
        </form>

        <div class="book-list">
            <h4 style="border-bottom: 2px solid #e67e22; padding-bottom: 5px;">Currently Holding:</h4>
            <c:choose>
                <c:when test="${not empty issuedBooks}">
                    <c:forEach var="b" items="${issuedBooks}">
                        <div class="book-item">
                            <span><i class="fas fa-book book-icon"></i> ${b.bookName}</span>
                            <span style="font-size:0.8em; color:green; font-weight:bold;">Issued</span>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p style="color:#777; font-style:italic;">No books issued yet.</p>
                </c:otherwise>
            </c:choose>
        </div>

        <a href="StudentServlet" class="btn-back">← Back to Student List</a>
    </div>
</body>
</html>