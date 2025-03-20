<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            height: 100vh;
            overflow: hidden;
            background: url('<%= request.getContextPath() %>/images/m33.jpg') no-repeat center center;
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
            padding: 15px;
            margin: 50px 70px;
        }

        .logo {
            width: 50px;
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

        .input-container {
            position: relative;
            margin: 10px 0;
        }

        .input-container i {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: black;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 15px;
            padding-left: 35px;
            padding-right: 15px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
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
            padding: 15px;
            border-radius: 5px;
            font-size: 16px;
            margin-top: 10px;
        }

        button:hover {
            background-color: #333;
        }

        .error-message {
            color: red;
            text-align: center;
            font-size: 14px;
            margin-top: 5px;
        }

        .strength-bar {
            height: 5px;
            margin-top: 5px;
            width: 100%;
            background-color: #e0e0e0;
        }

        .strength-bar div {
            height: 100%;
        }
        
        .error-message {
    color: red;
    text-align: center;
    font-weight: bold;
}
        
    </style>
</head>
<body>

    <div class="container">
        <img src="<%= request.getContextPath() %>/images/logo1.png" alt="Logo" class="logo">
        <h2>Register to Indian Railways!</h2>

        <% 
    String error = request.getParameter("error");
    if (error != null) {
        String message = "";
        if (error.equals("usernameexists")) {
            message = "User name already exists! Kindly login!";
        } else if (error.equals("server")) {
            message = "Server error! Please try again later.";
        }

        if (!message.isEmpty()) {
%>
            <p class="error-message"><%= message %></p>
<%      
        }
    }
%>

        <form action="RegisterServlet" method="post" onsubmit="return validateForm()">
            <div class="input-container">
                <i class="fas fa-user"></i>
                <input type="text" name="username" placeholder="Username" required>
            </div>

            <div class="input-container">
                <i class="fas fa-lock"></i>
                <input type="password" id="password" name="password" placeholder="Password" required oninput="checkStrength('password')">
            </div>

            <div id="passwordStrengthIndicator" class="strength-bar">
                <div id="passwordStrengthLevel" style="width: 0%;"></div>
            </div>

            <div class="input-container">
                <i class="fas fa-lock"></i>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required oninput="checkStrength('confirmPassword')">
            </div>

            <div id="confirmPasswordStrengthIndicator" class="strength-bar">
                <div id="confirmPasswordStrengthLevel" style="width: 0%;"></div>
            </div>

            <!-- Error message for password mismatch -->
            <p id="error-message" class="error-message" style="display: none;">Passwords do not match!</p>

            <button type="submit">REGISTER</button>
        </form>
        <p style="text-align: center; margin-top: 15px;">
    <a href="index.jsp" style="color: blue; text-decoration: none; font-weight: bold;">Back to Login</a>
</p>
        
    </div>

<script>
    function validateForm() {
        var password = document.getElementById("password").value;
        var confirmPassword = document.getElementById("confirmPassword").value;
        var errorMessage = document.getElementById("error-message");

        if (password !== confirmPassword) {
            errorMessage.style.display = "block";
            event.preventDefault();  // Prevent form submission
        } else {
            errorMessage.style.display = "none";
           
        }
    }

    function checkStrength(inputType) {
        var password = document.getElementById("password").value;
        var confirmPassword = document.getElementById("confirmPassword").value;
        var strengthLevel = (inputType === 'password') ? document.getElementById("passwordStrengthLevel") : document.getElementById("confirmPasswordStrengthLevel");
        var passToCheck = (inputType === 'password') ? password : confirmPassword;

        var strength = 0;
        if (passToCheck.length >= 8) strength += 20;
        if (/[A-Z]/.test(passToCheck)) strength += 20;
        if (/[0-9]/.test(passToCheck)) strength += 20;
        if (/[^A-Za-z0-9]/.test(passToCheck)) strength += 20;
        if (passToCheck.length >= 12) strength += 20;

        strengthLevel.style.width = strength + "%";
        strengthLevel.style.backgroundColor = strength < 40 ? "red" : (strength < 70 ? "orange" : "green");
    }
</script>

</body>
</html>
