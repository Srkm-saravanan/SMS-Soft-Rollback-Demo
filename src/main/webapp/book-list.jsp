<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Library Books</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #89f7fe 0%, #66a6ff 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0; padding: 20px;
        }
        .glass-container {
            background: rgba(255, 255, 255, 0.25);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(4px);
            -webkit-backdrop-filter: blur(4px);
            border-radius: 15px;
            padding: 30px;
            width: 100%; max-width: 800px;
            text-align: center;
        }
        h2 { color: #333; margin-bottom: 25px; }
        
        table { width: 100%; border-collapse: collapse; background: rgba(255,255,255,0.6); border-radius: 8px; overflow: hidden; }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid rgba(0,0,0,0.1); }
        th { background-color: #6c5ce7; color: white; } /* Purple Header for Books */
        
        .main-btn {
            display: inline-block; margin-top: 20px;
            background: #333; color: white; padding: 10px 20px;
            text-decoration: none; border-radius: 20px;
        }
        .add-btn {
            display: inline-block; margin-bottom: 15px;
            background: #28a745; color: white; padding: 10px 20px;
            text-decoration: none; border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="glass-container">
        <h2>Available Books in Library 📚</h2>
        
        <a href="BookServlet?action=new" class="add-btn"><i class="fas fa-plus"></i> Add New Book</a>

        <table>
            <thead>
                <tr>
                    <th>Book ID</th>
                    <th>Book Name</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="book" items="${listBook}">
                    <tr>
                        <td>#${book.bookId}</td>
                        <td style="font-weight:bold;">${book.bookName}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <a href="index.html" class="main-btn">Main Menu</a>
    </div>
</body>
</html>