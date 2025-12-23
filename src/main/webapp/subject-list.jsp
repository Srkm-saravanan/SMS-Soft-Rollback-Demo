<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Subject List</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Glassmorphism Theme */
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            margin: 0; padding: 0; 
            background: linear-gradient(135deg, #a8dadc 0%, #457b9d 100%); 
            display: flex; justify-content: center; align-items: center; min-height: 100vh;
        }
        .container { 
            width: 90%; max-width: 900px; padding: 35px; border-radius: 20px; 
            background: rgba(255, 255, 255, 0.25); 
            backdrop-filter: blur(12px); -webkit-backdrop-filter: blur(12px); 
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37); 
            border: 1px solid rgba(255, 255, 255, 0.3); 
            color: #1d3557; text-align: center;
        }
        h2 { color: #1d3557; margin-bottom: 25px; font-weight: 600; font-size: 1.8em; }
        
        /* Table Styling */
        table { 
            width: 100%; border-collapse: separate; border-spacing: 0; 
            margin-top: 20px; border-radius: 12px; overflow: hidden; 
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            background: rgba(255,255,255,0.6);
        }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid rgba(29, 53, 87, 0.1); }
        th { background-color: #2a9d8f; color: white; text-transform: uppercase; font-size: 0.9em; letter-spacing: 0.5px; }
        tr:hover { background-color: rgba(255, 255, 255, 0.8); }

        .btn-delete {
            background-color: #e76f51; color: white; padding: 6px 12px;
            text-decoration: none; border-radius: 5px; font-size: 0.85em; font-weight: bold;
            transition: 0.3s;
        }
        .btn-delete:hover { background-color: #c0392b; }

        .add-link { 
            display: inline-block; margin: 15px 10px; padding: 12px 20px; text-decoration: none; 
            border-radius: 10px; font-weight: 600; color: white;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1); transition: 0.3s;
        }
        .add-link:hover { transform: translateY(-2px); }
        .btn-add { background-color: #2a9d8f; }
        .btn-menu { background-color: #1d3557; }
    </style>
</head>
<body>
    <div class="container">
        <h2><i class="fas fa-book"></i> Subject Management</h2>

        <c:if test="${not empty message}">
            <div style="background:#d4edda; color:#155724; padding:10px; border-radius:5px; margin-bottom:15px;">
                ${message}
            </div>
        </c:if>

        <c:choose>
            <c:when test="${not empty subjectList}">
                <table>
                    <thead>
                        <tr>
                            <th style="width: 10%;">S.No</th> <th style="width: 15%;">Subject ID</th>
                            <th>Subject Name</th>
                            <th style="width: 15%;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="subject" items="${subjectList}" varStatus="loop">
                            <tr>
                                <td>${loop.count}</td> <td>#${subject.subjectId}</td>
                                <td style="font-weight: 600; color: #333;">${subject.subjectName}</td>
                                <td>
                                    <a href="SubjectServlet?action=delete&id=${subject.subjectId}" class="btn-delete" 
                                       onclick="return confirm('Delete subject: ${subject.subjectName}?')">
                                        <i class="fas fa-trash"></i> Delete
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <p>No subjects found. Add one below!</p>
            </c:otherwise>
        </c:choose>

        <div style="margin-top: 30px;">
            <a href="subject-form.jsp" class="add-link btn-add"><i class="fas fa-plus"></i> Add New Subject</a>
            <a href="index.html" class="add-link btn-menu"><i class="fas fa-home"></i> Main Menu</a>
        </div>
    </div>
</body>
</html>