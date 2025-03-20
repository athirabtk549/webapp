<%
    session.invalidate(); 
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); 
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
       body {
            font-family: Arial, sans-serif;
            margin: 0;
            display: flex;
            height: 100vh;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            
            background: url('<%= request.getContextPath() %>/images/train.jpg') no-repeat center center; 
           
            background-size: cover;
        }

        .container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            width: 100%;
            max-width: 400px;
            background: rgba(255, 255, 255, 0.8);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            padding: 40px;
            backdrop-filter: blur(10px);
            margin-left: 550px;
        }

        .logo {
            width: 60px;
            margin-bottom: 3px;
        }

        h2 {
            font-size: 1.5rem;
            margin-bottom: 20px;
            color: #333;
            text-align: center;
            text-shadow: 0.5px 0.5px 2px white;
        }

        form {
            display: flex;
            flex-direction: column;
            width: 100%;
        }

        input[type="text"],
        input[type="password"],
        button {
            width: 100%;
            padding: 15px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
            padding-left: 35px;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #007bff;
        }

        button {
            background-color: #000;
            color: white;
            border: none;
            cursor: pointer;
        }

        button:hover {
            background-color: #333;
        }

        .social-container {
            text-align: center;
            margin-top: 20px;
        }

        .social-container p {
            margin: 10px 0;
            color: #555;
        }

        .social-icons {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 15px;
        }

        .social-icons a {
            font-size: 18px;
            color: #000;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .social-icons a:hover {
            color: #007bff;
        }


        .input-icon {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: black;
        }


        .eye-icon {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: black;
        }

        .input-container {
            position: relative;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        
        <img src="<%= request.getContextPath() %>/images/logo1.png" alt="Logo" class="logo">
        
        <h2>Welcome to Indian Railways!</h2>

        
        <form id="loginForm" action="LoginServlet" method="post" autocomplete="off">
            <div class="input-container">
                <i class="fas fa-user input-icon"></i>
                <input type="text" name="username" placeholder="Username" required>
            </div>
            <div class="input-container">
                <i class="fas fa-lock input-icon"></i>
                <input type="password" name="password" id="password" placeholder="Password" required>
                <i class="fas fa-eye eye-icon" id="togglePassword" onclick="togglePasswordVisibility()"></i>
            </div>
            <button type="submit">LOGIN</button>
        </form>
        <% String loginError = (String) request.getAttribute("loginError"); %>
<% if (loginError != null) { %>
    <p style="color: red; font-weight: bold;"><%= loginError %></p>
<% } %>
        
        <div class="social-container">
            <p style="color: black; text-shadow: 0.5px 0.5px 1px white;">Not a member? <a href="register.jsp" style="color: blue; text-decoration: none; font-size: 15px; margin-left:5px;">Register</a></p>
            <p style="color: black; text-shadow: 0.5px 0.5px 1px white;">or sign up with:</p>
            <div class="social-icons">
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-google"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
            </div>
        </div>
    </div>

    <script>
    (function preventBackNavigation() {
        history.pushState(null, null, location.href);
        window.onpopstate = function () {
            history.pushState(null, null, location.href);
        };
    })();
        function togglePasswordVisibility() {
            const passwordField = document.getElementById('password');
            const toggleIcon = document.getElementById('togglePassword');

            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordField.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }

    </script>
</body>
</html>
