<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Register</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: linear-gradient(135deg, #ffecd2, #fcb69f);
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    .register-container {
      background: #fff;
      padding: 30px 40px;
      border-radius: 12px;
      box-shadow: 0 6px 20px rgba(0,0,0,0.15);
      width: 380px;
      text-align: center;
    }

    h2 {
      margin-bottom: 20px;
      color: #333;
    }

    label {
      display: block;
      text-align: left;
      margin: 10px 0 5px;
      font-weight: bold;
      color: #444;
    }

    input, select {
      width: 100%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 8px;
      margin-bottom: 15px;
      font-size: 14px;
      transition: 0.3s;
    }

    input:focus, select:focus {
      border-color: #ff6f61;
      outline: none;
      box-shadow: 0 0 5px rgba(255,111,97,0.5);
    }

    button {
      width: 100%;
      padding: 12px;
      background: #ff6f61;
      color: #fff;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      font-size: 15px;
      font-weight: bold;
      transition: background 0.3s;
    }

    button:hover {
      background: #e65b4f;
    }

    p {
      margin-top: 15px;
      font-size: 14px;
    }

    a {
      color: #ff6f61;
      text-decoration: none;
      font-weight: bold;
    }

    a:hover {
      text-decoration: underline;
    }

    .error {
      color: red;
      margin-bottom: 10px;
      font-size: 14px;
    }
  </style>
</head>
<body>
  <div class="register-container">
    <h2>Register</h2>

    <c:if test="${not empty error}">
      <p class="error">${error}</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="post">
      <label>Username</label>
      <input name="username" required/>

      <label>Password</label>
      <input type="password" name="password" required/>

      <label>Role</label>
      <select name="role">
        <option value="USER">USER</option>
        <option value="ADMIN">ADMIN</option>
      </select>

      <button type="submit">Register</button>
    </form>

    <p><a href="${pageContext.request.contextPath}/login">Back to Login</a></p>
  </div>
</body>
</html>
