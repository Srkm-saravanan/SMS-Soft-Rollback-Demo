<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Master Enrollment Matrix</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { 
            font-family: 'Segoe UI', sans-serif; 
            margin: 0; padding: 20px; 
            background: linear-gradient(135deg, #a8dadc 0%, #457b9d 100%); 
            min-height: 100vh;
        }
        .container { 
            width: 95%; max-width: 1400px; margin: 0 auto; padding: 30px; 
            background: rgba(255, 255, 255, 0.25); 
            border-radius: 20px; box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(12px); -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: #1d3557;
        }
        h2 { 
            text-align: center; color: #1d3557; margin-bottom: 5px; 
            font-size: 1.8em; font-weight: 600;
        }
        
        /* --- TOGGLE SWITCH (Same as Learning Dashboard) --- */
        .toggle-container { 
            margin: 30px 0; display: flex; justify-content: center; align-items: center; gap: 20px; 
        }
        .toggle-label { 
            font-weight: bold; color: #1d3557; font-size: 1.2em; 
        }
        .switch { 
            position: relative; display: inline-block; width: 70px; height: 40px; 
        }
        .switch input { opacity: 0; width: 0; height: 0; }
        .slider {
            position: absolute; cursor: pointer; top: 0; left: 0; right: 0; bottom: 0;
            background-color: #2a9d8f; /* Teal - Subjects */
            transition: .4s; border-radius: 40px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
        }
        .slider:before {
            position: absolute; content: ""; height: 32px; width: 32px;
            left: 4px; bottom: 4px; background-color: white;
            transition: .4s; border-radius: 50%;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        input:checked + .slider { background-color: #f39c12; /* Orange - Books */ }
        input:checked + .slider:before { transform: translateX(30px); }

        /* --- SECTIONS --- */
        .section { display: none; animation: fadeIn 0.6s ease-out; }
        .section.active { display: block; }
        
        /* --- TABLE STYLES --- */
        .table-wrapper {
            overflow-x: auto;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            margin-top: 20px;
            background: rgba(255,255,255,0.6);
        }
        table { 
            width: 100%; border-collapse: separate; border-spacing: 0; 
            min-width: 900px; font-size: 15px;
        }
        th, td { 
            border: 1px solid rgba(0,0,0,0.1); padding: 14px 12px; text-align: center; 
        }
        th { 
            background-color: #1d3557; color: white; position: sticky; top: 0; z-index: 10;
            font-weight: 600; text-transform: uppercase; letter-spacing: 0.8px; font-size: 0.9em;
        }
        
        /* Subject Matrix Colors */
        .status-enrolled { 
            background-color: #d4edda; color: #155724; font-weight: bold; font-size: 1.1em;
        }
        .status-null { 
            color: #999; font-size: 1.4em; font-weight: bold;
        }

        /* Book Matrix Colors */
        .book-list { 
            font-weight: 500; color: #333; text-align: left; padding-left: 25px; 
            font-size: 1em; line-height: 1.5;
        }
        .book-list i { color: #f39c12; margin-right: 8px; }

        tr:hover { background-color: rgba(255,255,255,0.7); transition: 0.3s; }

        /* Sticky First Column */
        td:first-child, th:first-child {
            position: sticky; left: 0; background: #f8f9fa; z-index: 5;
            font-weight: bold; color: #1d3557; border-right: 3px solid #1d3557;
        }
        th:first-child { background: #1d3557; color: white; z-index: 15; }

        .btn-back { 
            display: block; width: fit-content; margin: 40px auto 0; 
            text-decoration: none; color: white; background: #1d3557; 
            padding: 14px 30px; border-radius: 30px; font-weight: bold; font-size: 1.1em;
            box-shadow: 0 6px 15px rgba(0,0,0,0.2); transition: all 0.3s;
        }
        .btn-back:hover { 
            transform: translateY(-4px); box-shadow: 0 10px 25px rgba(0,0,0,0.3); 
            background: #152a44;
        }

        @keyframes fadeIn { 
            from { opacity: 0; transform: translateY(20px); } 
            to { opacity: 1; transform: translateY(0); } 
        }

        .no-data {
            text-align: center; padding: 40px; color: #666; font-style: italic; font-size: 1.1em;
        }
    </style>
    
    <script>
        function toggleMode() {
            var checkBox = document.getElementById("modeToggle");
            var subjectSection = document.getElementById("subjectSection");
            var bookSection = document.getElementById("bookSection");
            var title = document.getElementById("reportTitle");

            if (checkBox.checked) {
                subjectSection.classList.remove("active");
                bookSection.classList.add("active");
                title.innerText = "Master Library Report (Issued Books)";
            } else {
                bookSection.classList.remove("active");
                subjectSection.classList.add("active");
                title.innerText = "Master Enrollment Matrix (Subjects)";
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h2 id="reportTitle">Master Enrollment Matrix (Subjects)</h2>
        
        <div class="toggle-container">
            <span class="toggle-label"><i class="fas fa-chalkboard-teacher"></i> Subjects</span>
            <label class="switch">
                <input type="checkbox" id="modeToggle" onclick="toggleMode()">
                <span class="slider"></span>
            </label>
            <span class="toggle-label"><i class="fas fa-book"></i> Books</span>
        </div>

        <!-- SUBJECT ENROLLMENT MATRIX -->
        <div id="subjectSection" class="section active">
            <div class="table-wrapper">
                <c:choose>
                    <c:when test="${not empty allStudents}">
                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Student Name</th>
                                    <th>Class</th>
                                    <c:forEach var="sub" items="${allSubjects}">
                                        <th>${sub.subjectName}</th>
                                    </c:forEach>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="student" items="${allStudents}">
                                    <tr>
                                        <td>#${student.studentId}</td>
                                        <td style="text-align:left; padding-left:20px;">
                                            <strong>${student.firstName} ${student.lastName}</strong>
                                        </td>
                                        <td>
                                            <span style="background:#a8dadc; padding:6px 12px; border-radius:20px; font-weight:bold;">
                                                ${student.studentClass.className}
                                            </span>
                                        </td>
                                        
                                        <c:forEach var="sub" items="${allSubjects}">
                                            <c:set var="isEnrolled" value="${enrollmentMap[student.studentId] != null && enrollmentMap[student.studentId].contains(sub.subjectId)}" />
                                            <td>
                                                <c:choose>
                                                    <c:when test="${isEnrolled}">
                                                        <span class="status-enrolled">✓</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-null">—</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="no-data">No students found. Add some students to see the matrix!</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- BOOK ISSUED MATRIX -->
        <div id="bookSection" class="section">
            <div class="table-wrapper">
                <c:choose>
                    <c:when test="${not empty allStudents}">
                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Student Name</th>
                                    <th>Class</th>
                                    <th style="text-align: left; padding-left: 20px;">Issued Books</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="student" items="${allStudents}">
                                    <tr>
                                        <td>#${student.studentId}</td>
                                        <td style="text-align:left; padding-left:20px;">
                                            <strong>${student.firstName} ${student.lastName}</strong>
                                        </td>
                                        <td>
                                            <span style="background:#a8dadc; padding:6px 12px; border-radius:20px; font-weight:bold;">
                                                ${student.studentClass.className}
                                            </span>
                                        </td>
                                        <td>
                                            <c:set var="issuedBooks" value="${bookMap[student.studentId]}" />
                                            <c:choose>
                                                <c:when test="${not empty issuedBooks && issuedBooks != 'None'}">
                                                    <div class="book-list">
                                                        <i class="fas fa-book"></i> ${issuedBooks}
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-null">No books issued</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="no-data">No students found.</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <a href="index.html" class="btn-back">
            <i class="fas fa-home"></i> Back to Main Menu
        </a>
    </div>
</body>
</html>