<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Assign Subject</title>
    <style>
        /* Glassmorphism Theme */
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            margin: 0; padding: 0; 
            background: linear-gradient(135deg, #a8dadc 0%, #457b9d 100%); 
            display: flex; justify-content: center; align-items: center; min-height: 100vh;
        }
        .container { 
            width: 90%; max-width: 600px; padding: 30px; border-radius: 20px; 
            background: rgba(255, 255, 255, 0.2); 
            backdrop-filter: blur(10px); -webkit-backdrop-filter: blur(10px); 
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37); 
            border: 1px solid rgba(255, 255, 255, 0.3); 
            color: #1d3557; text-align: center;
        }
        h2 { color: #1d3557; margin-bottom: 5px; font-weight: 600; }
        
        .student-class-badge {
            background-color: #00bfff; color: white; padding: 4px 10px; 
            border-radius: 15px; font-size: 0.6em; vertical-align: middle; 
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        select { 
            width: 70%; padding: 10px; border-radius: 8px; border: 1px solid rgba(29, 53, 87, 0.4);
            margin-bottom: 15px;
        }
        input[type="submit"] { 
            background-color: #ff9f1c; color: white; padding: 10px 20px; 
            border: none; border-radius: 8px; cursor: pointer; font-weight: 600;
        }
        input[type="submit"]:hover { background-color: #e68a00; }

        .subject-list {
            margin-top: 30px; text-align: left;
            background: rgba(255, 255, 255, 0.4); padding: 15px; border-radius: 10px;
        }
        ul { list-style-type: none; padding: 0; }
        
        li { 
            padding: 10px; border-bottom: 1px solid rgba(0,0,0,0.1); 
            display: flex; justify-content: space-between; align-items: center;
        }
        li:last-child { border-bottom: none; }
        
        .sub-info { font-weight: 500; }
        .sub-id { 
            display: inline-block; background: #457b9d; color: white; 
            padding: 2px 6px; border-radius: 4px; font-size: 0.85em; margin-right: 8px;
        }

        .remove-btn {
            background-color: #e76f51; color: white; text-decoration: none;
            padding: 5px 10px; border-radius: 5px; font-size: 0.8em; font-weight: bold;
        }
        .remove-btn:hover { background-color: #d62828; }

        .message { color: green; font-weight: bold; margin-bottom: 15px; }
        a.back-link { text-decoration: none; color: #1d3557; font-weight: 600; margin-top: 20px; display: inline-block; }
    </style>
</head>
<body>
    <div class="container">
        <h2>
            Manage Subjects for<br>
            <span style="color: #457b9d;">${student.firstName} ${student.lastName}</span>
            <span class="student-class-badge">${student.studentClass.className}</span>
        </h2>
        
        <c:if test="${not empty message}"><p class="message">${message}</p></c:if>

        <form action="StudentServlet" method="post">
            <input type="hidden" name="formType" value="assignSubject">
            <input type="hidden" name="studentId" value="${studentId}">
            
            <label><b>Select Subject to Add:</b></label><br>
            <select name="subjectId" required>
                <option value="" disabled selected>-- Choose Subject --</option>
                <c:forEach var="sub" items="${allSubjects}">
                    <option value="${sub.subjectId}">${sub.subjectName}</option>
                </c:forEach>
            </select>
            <input type="submit" value="Assign +">
        </form>

        <div class="subject-list">
            <h3>Currently Assigned:</h3>
            <c:if test="${empty existingSubjects}">
                <p>No subjects assigned yet.</p>
            </c:if>
            <ul>
                <c:forEach var="exist" items="${existingSubjects}">
                    <li>
                        <span class="sub-info">
                            <span class="sub-id">#${exist.subjectId}</span> ${exist.subjectName}
                        </span>
                        
                        <a href="StudentServlet?action=unassign&studentId=${studentId}&subjectId=${exist.subjectId}" 
                           class="remove-btn" 
                           onclick="return confirm('Remove subject: ${exist.subjectName}?');">
                           X
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </div>

        <br>
        <a href="StudentServlet" class="back-link">← Back to Student List</a>
    </div>
</body>
</html>