<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Book</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #89f7fe 0%, #66a6ff 100%);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
        }
        .glass-card {
            background: rgba(255, 255, 255, 0.25);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(4px);
            -webkit-backdrop-filter: blur(4px);
            border-radius: 10px;
            border: 1px solid rgba(255, 255, 255, 0.18);
            padding: 40px;
            width: 400px;
            text-align: center;
        }
        h2 { color: #333; margin-bottom: 30px; }
        label { display: block; text-align: left; margin: 10px 0 5px; color: #444; font-weight: bold; }
        
        input[type="text"] {
            width: 100%; padding: 10px; margin-bottom: 20px;
            border: 1px solid #ccc; border-radius: 5px;
            box-sizing: border-box; /* Ensures padding doesn't widen element */
        }
        
        button {
            width: 100%; padding: 12px;
            background-color: #28a745; color: white;
            border: none; border-radius: 5px;
            font-size: 16px; cursor: pointer; transition: 0.3s;
        }
        button:hover { background-color: #218838; }
        
        .back-link {
            display: block; margin-top: 20px;
            text-decoration: none; color: #555; font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="glass-card">
        <h2>Add New Book 📖</h2>
        <form action="BookServlet" method="post">
            <label>Book Name:</label>
            <input type="text" name="bookName" required placeholder="Ex: Clean Code">
            
            <button type="submit">Add Book</button>
        </form>
        <a href="index.html" class="back-link">← Back to Main Menu</a>
    </div>
</body>
</html>