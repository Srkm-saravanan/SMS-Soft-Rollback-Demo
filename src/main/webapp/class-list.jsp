<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Classes</title>
    <style>
        /* Body and Background (Sky Blue Glassmorphism Theme) */
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            margin: 0; 
            padding: 0; 
            background: linear-gradient(135deg, #a8dadc 0%, #457b9d 100%); 
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        /* Central Glass Card Container (Glassmorphism Effect) */
        .container { 
            width: 90%;
            max-width: 900px; 
            padding: 30px; 
            border-radius: 20px; 
            
            /* Glassmorphism Properties */
            background: rgba(255, 255, 255, 0.2); 
            backdrop-filter: blur(10px);        
            -webkit-backdrop-filter: blur(10px); 
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37); 
            border: 1px solid rgba(255, 255, 255, 0.3); 
            
            color: #1d3557; 
            text-align: center;
        }
        h2 { 
            color: #1d3557; 
            margin-bottom: 20px; 
            font-weight: 600;
        }
        h3 {
            color: #457b9d; 
            margin-top: 20px;
            font-size: 1.1em;
            text-align: left;
        }
        .message { 
            padding: 15px; 
            margin-bottom: 20px; 
            border-radius: 8px; 
            font-weight: 600; 
            background-color: #d8f3da;
            color: #1e7e34; 
            border: 1px solid #c3e6cb;
            text-align: left;
        }

        /* Table Styling */
        table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-top: 20px; 
            border-radius: 8px;
            overflow: hidden; 
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        th, td { 
            border: 1px solid rgba(29, 53, 87, 0.1); 
            padding: 15px; 
            text-align: left; 
        }
        th { 
            background-color: #457b9d; 
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.9em;
        }
        tr:nth-child(even) {
            background-color: rgba(255, 255, 255, 0.3); 
        }
        tr:hover {
            background-color: rgba(255, 255, 255, 0.5); 
        }
        th:first-child, td:first-child {
            width: 5%;
            text-align: center;
        }
        /* Specific styling for the Delete column */
        th:last-child, td:last-child {
            width: 10%;
            text-align: center;
        }

        /* Delete Button Style */
        .delete-btn {
            background-color: #e76f51; /* Coral Red for danger */
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
            transition: background-color 0.3s;
        }
        .delete-btn:hover {
            background-color: #cc4e30;
        }
        
        /* Navigation Link Styling */
        .add-link { 
            display: inline-block; 
            margin-top: 20px; 
            padding: 12px 15px; 
            text-decoration: none; 
            border-radius: 10px; 
            font-size: 15px;
            font-weight: 600;
            transition: background-color 0.3s ease, transform 0.2s;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .add-another-btn {
            background-color: #52b788; 
            color: white;
        }
        .main-menu-btn {
            background-color: #00bfff; 
            color: white;
            margin-left: 10px;
        }
        .add-link:hover {
            transform: translateY(-2px);
            opacity: 0.9;
        }
    </style>

    <script type="text/javascript">
        function confirmDelete(classId, className) {
            // Displays the confirmation dialog
            var message = "Are you sure you want to delete the class: " + className + "?";
            if (confirm(message)) {
                // If user presses OK, navigate to the Servlet with the delete action
                window.location.href = 'ClassServlet?action=delete&id=' + classId;
            }
            // If user presses Cancel, do nothing
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Class Management Report</h2>

        <c:if test="${not empty message}">
            <p class="message">${message}</p>
        </c:if>

        <h3>Existing Classes in Database:</h3>
        <c:if test="${empty classList}">
            <p style="text-align: left;">No classes found in the database yet. Click 'Add Another Class' to get started!</p>
        </c:if>
        <c:if test="${not empty classList}">
            <table>
                <thead>
                    <tr>
                        <th>S.No.</th>
                        <th>ID</th>
                        <th>Class Name</th>
                        <th>Action</th> </tr>
                </thead>
                <tbody>
                    <c:forEach var="cls" items="${classList}" varStatus="loop"> 
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td>${cls.classId}</td>
                            <td>${cls.className}</td>
                            <td>
                                <button class="delete-btn" 
                                    onclick="confirmDelete(${cls.classId}, '${cls.className}')">
                                    Delete
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <a href="class-form.jsp" class="add-link add-another-btn">← Add Another Class</a>
        <a href="index.html" class="add-link main-menu-btn">Main Menu</a>
    </div>
</body>
</html>