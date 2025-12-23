<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Classes</title>
    <style>
        /* Body and Background (Sky Blue Glassmorphism Theme) */
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            margin: 0; 
            padding: 0; 
            /* Subtle blue gradient for the background */
            background: linear-gradient(135deg, #a8dadc 0%, #457b9d 100%); 
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        /* Central Glass Card Container (Glassmorphism Effect) */
        .container { 
            width: 90%;
            max-width: 400px; 
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
            color: #1d3557; /* Dark Blue title */
            margin-bottom: 30px; 
            font-weight: 600;
        }
        .form-group { 
            margin-bottom: 20px; 
            text-align: left; /* Align input labels left */
        }
        label { 
            display: block; 
            margin-bottom: 8px; 
            font-weight: 600; 
            color: #1d3557; 
            font-size: 1.1em;
        }
        input[type="text"] { 
            width: 100%; 
            padding: 12px; 
            border: 1px solid rgba(29, 53, 87, 0.4); /* Subtle blue border */
            border-radius: 8px; 
            box-sizing: border-box; 
            background: rgba(255, 255, 255, 0.6); /* Slightly more opaque input field */
            color: #1d3557;
        }
        input[type="submit"] { 
            background-color: #52b788; /* Fresh green button */
            color: white; 
            padding: 12px 15px; 
            border: none; 
            border-radius: 10px; 
            cursor: pointer; 
            font-size: 16px; 
            width: 100%;
            font-weight: 600;
            transition: background-color 0.3s ease, transform 0.2s;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        input[type="submit"]:hover { 
            background-color: #40916c; 
            transform: translateY(-2px);
        }
        a {
            display: inline-block;
            margin-top: 20px;
            color: #1d3557; /* Dark blue link text */
            text-decoration: none;
            font-weight: 600;
            padding: 5px 10px;
            border: 1px solid transparent;
            border-radius: 5px;
            transition: border-color 0.2s;
        }
        a:hover {
            border-color: #1d3557;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Enter New Class</h2>
        <form action="ClassServlet" method="post">
            <div class="form-group">
                <label for="className">Class Name (e.g., AIDS, CSE, MECH):</label>
                <input type="text" id="className" name="className" required>
            </div>
            <input type="submit" value="Add Class">
        </form>
        <p><a href="index.html">← Back to Main Menu</a></p>
    </div>
</body>
</html>