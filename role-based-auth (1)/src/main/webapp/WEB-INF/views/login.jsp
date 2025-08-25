<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Login</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: linear-gradient(135deg, #74ebd5 0%, #ACB6E5 100%);
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .login-container {
      background: rgba(255, 255, 255, 0.9);
      padding: 30px 40px;
      border-radius: 12px;
      box-shadow: 0 8px 20px rgba(0,0,0,0.2);
      width: 350px;
      text-align: center;
    }

    .login-container h2 {
      margin-bottom: 20px;
      color: #333;
    }

    .login-container label {
      display: block;
      text-align: left;
      margin: 10px 0 5px;
      font-weight: bold;
      color: #444;
    }

    .login-container input {
      width: 100%;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 8px;
      outline: none;
      font-size: 14px;
      transition: 0.3s;
    }

    .login-container input:focus {
      border-color: #5a67d8;
      box-shadow: 0 0 5px rgba(90,103,216,0.5);
    }

    .login-container button {
      margin-top: 15px;
      width: 100%;
      padding: 12px;
      background: #5a67d8;
      border: none;
      border-radius: 8px;
      color: white;
      font-size: 16px;
      cursor: pointer;
      transition: 0.3s;
    }

    .login-container button:hover {
      background: #434190;
    }

    .login-container a {
      display: inline-block;
      margin-top: 15px;
      text-decoration: none;
      color: #5a67d8;
      font-weight: bold;
      transition: 0.3s;
    }

    .login-container a:hover {
      color: #434190;
    }

    p {
      margin: 10px 0;
    }
  </style>
</head>
<body>
  <div class="login-container">
    <h2>Login</h2>

    <c:if test="${not empty error}">
      <p style="color:red">${error}</p>
    </c:if>
    <c:if test="${not empty success}">
      <p style="color:green">${success}</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
      <label>Username</label>
      <input name="username" required/>
      
      <label>Password</label>
      <input type="password" name="password" required/>
      
      <button type="submit">Login</button>
    </form>
    <p><a href="${pageContext.request.contextPath}/register">New user? Register</a></p>
  </div>
</body>
</html>
