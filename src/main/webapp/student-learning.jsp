<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Learning Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #a8dadc 0%, #457b9d 100%);
            min-height: 100vh; display: flex; justify-content: center; align-items: center; margin: 0;
        }
        .container {
            width: 90%; max-width: 600px; padding: 30px; border-radius: 20px;
            background: rgba(255, 255, 255, 0.25); backdrop-filter: blur(12px);
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
            border: 1px solid rgba(255, 255, 255, 0.3); text-align: center;
        }
        h2 { color: #1d3557; margin-bottom: 5px; }
        
        /* --- TOGGLE SWITCH --- */
        .toggle-container { margin: 25px 0; display: flex; justify-content: center; align-items: center; gap: 15px; }
        .toggle-label { font-weight: bold; color: #1d3557; font-size: 1.1em; }
        
        .switch { position: relative; display: inline-block; width: 60px; height: 34px; }
        .switch input { opacity: 0; width: 0; height: 0; }
        .slider {
            position: absolute; cursor: pointer; top: 0; left: 0; right: 0; bottom: 0;
            background-color: #2a9d8f; /* Teal (Subjects) */
            transition: .4s; border-radius: 34px;
        }
        .slider:before {
            position: absolute; content: ""; height: 26px; width: 26px;
            left: 4px; bottom: 4px; background-color: white;
            transition: .4s; border-radius: 50%;
        }
        
        /* Checked State (Books) */
        input:checked + .slider { background-color: #f39c12; /* Orange (Books) */ }
        input:checked + .slider:before { transform: translateX(26px); }

        /* --- SECTIONS --- */
        .section { display: none; animation: fadeIn 0.5s; }
        .section.active { display: block; }
        
        select { padding: 12px; width: 70%; border-radius: 8px; border: 1px solid #ddd; margin-bottom: 15px; }
        
        .btn-assign { background-color: #2a9d8f; color: white; border:none; padding: 12px 20px; border-radius: 8px; font-weight: bold; cursor: pointer; }
        .btn-issue  { background-color: #f39c12; color: white; border:none; padding: 12px 20px; border-radius: 8px; font-weight: bold; cursor: pointer; }

        /* --- LISTS --- */
        .list-box { background: rgba(255,255,255,0.6); padding: 15px; border-radius: 10px; text-align: left; margin-top: 20px; }
        .list-item { padding: 10px; border-bottom: 1px solid rgba(0,0,0,0.1); display: flex; justify-content: space-between; align-items: center; }
        .list-item:last-child { border-bottom: none; }
        
        .btn-delete { background: #e76f51; color: white; text-decoration: none; padding: 5px 10px; border-radius: 5px; font-size: 0.8em; }

        .msg-box {
            background:#fff; color:#333; padding:10px; border-radius:5px; margin-bottom:15px; font-weight:bold;
            border-left: 5px solid #2a9d8f; /* Default Teal Border */
        }

        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
        
        .back-link { display:block; margin-top:20px; text-decoration:none; color:#1d3557; font-weight:bold; }
    </style>
    
    <script>
        window.onload = function() {
            var activeTab = "${activeTab}";
            if (activeTab === "book") {
                document.getElementById("modeToggle").checked = true;
                toggleMode();
            } else {
                toggleMode(); // Ensure text is correct on load
            }
        };

        function toggleMode() {
            var checkBox = document.getElementById("modeToggle");
            var subjectSection = document.getElementById("subjectSection");
            var bookSection = document.getElementById("bookSection");
            var headerText = document.getElementById("headerText");

            if (checkBox.checked == true) {
                // BOOKS MODE
                subjectSection.classList.remove("active");
                bookSection.classList.add("active");
                headerText.innerText = "Manage Books for ${student.firstName} (${student.studentClass.className})";
            } else {
                // SUBJECTS MODE
                bookSection.classList.remove("active");
                subjectSection.classList.add("active");
                headerText.innerText = "Manage Subjects for ${student.firstName} (${student.studentClass.className})";
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h2 id="headerText">Manage Subjects for ${student.firstName} (${student.studentClass.className})</h2>

        <div class="toggle-container">
            <span class="toggle-label"><i class="fas fa-chalkboard-teacher"></i> Subjects</span>
            <label class="switch">
                <input type="checkbox" id="modeToggle" onclick="toggleMode()">
                <span class="slider"></span>
            </label>
            <span class="toggle-label"><i class="fas fa-book"></i> Books</span>
        </div>

        <div id="subjectSection" class="section active">
            
            <c:if test="${not empty subjectMessage}">
                <div class="msg-box" style="border-left-color: #2a9d8f;">${subjectMessage}</div>
            </c:if>

            <form action="StudentServlet" method="post">
                <input type="hidden" name="formType" value="assignSubject">
                <input type="hidden" name="studentId" value="${studentId}">
                
                <label>Select Subject to Assign:</label><br>
                <select name="subjectId" required>
                    <option value="" disabled selected>-- Choose Subject --</option>
                    <c:forEach var="sub" items="${allSubjects}">
                        <option value="${sub.subjectId}">${sub.subjectName}</option>
                    </c:forEach>
                </select>
                <button type="submit" class="btn-assign">Assign Subject +</button>
            </form>

            <div class="list-box">
                <h4>Currently Assigned:</h4>
                <c:choose>
                    <c:when test="${not empty existingSubjects}">
                        <c:forEach var="sub" items="${existingSubjects}">
                            <div class="list-item">
                                <span><i class="fas fa-check-circle" style="color:#2a9d8f"></i> ${sub.subjectName}</span>
                                <a href="StudentServlet?action=unassign&studentId=${studentId}&subjectId=${sub.subjectId}" class="btn-delete"><i class="fas fa-trash"></i></a>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise><p style="color:#777; font-size:0.9em;">No subjects assigned.</p></c:otherwise>
                </c:choose>
            </div>
        </div>

        <div id="bookSection" class="section">
            
            <c:if test="${not empty bookMessage}">
                <div class="msg-box" style="border-left-color: #f39c12;">${bookMessage}</div>
            </c:if>

            <form action="StudentServlet" method="post">
                <input type="hidden" name="formType" value="issueBook">
                <input type="hidden" name="studentId" value="${studentId}">
                
                <label>Select Book to Issue:</label><br>
                <select name="bookId" required>
                    <option value="" disabled selected>-- Choose Book --</option>
                    <c:forEach var="book" items="${allBooks}">
                        <option value="${book.bookId}">${book.bookName}</option>
                    </c:forEach>
                </select>
                <button type="submit" class="btn-issue">Issue Book +</button>
            </form>

            <div class="list-box">
                <h4>Issued Books:</h4>
                <c:choose>
                    <c:when test="${not empty issuedBooks}">
                        <c:forEach var="b" items="${issuedBooks}">
                            <div class="list-item">
                                <span><i class="fas fa-book" style="color:#f39c12"></i> ${b.bookName}</span>
                                <a href="StudentServlet?action=returnBook&studentId=${studentId}&bookId=${b.bookId}" class="btn-delete"><i class="fas fa-trash"></i></a>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise><p style="color:#777; font-size:0.9em;">No books issued.</p></c:otherwise>
                </c:choose>
            </div>
        </div>

        <a href="StudentServlet" class="back-link">← Back to Student List</a>
    </div>
</body>
</html>