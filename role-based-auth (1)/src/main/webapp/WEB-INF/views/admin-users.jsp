<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Manage Users</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f4f6f9;
      margin: 0;
      padding: 0;
      color: #333;
    }

    header {
      background: #3949ab;
      color: #fff;
      padding: 15px 30px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    header h2 {
      margin: 0;
    }

    header a {
      color: #fff;
      text-decoration: none;
      font-weight: bold;
      transition: 0.3s;
    }

    header a:hover {
      text-decoration: underline;
    }

    .container {
      padding: 30px;
      max-width: 1000px;
      margin: auto;
    }

    h3 {
      margin-top: 40px;
      color: #3949ab;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background: #fff;
      margin-top: 20px;
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    }

    th, td {
      padding: 12px 15px;
      text-align: center;
    }

    th {
      background: #3949ab;
      color: #fff;
      text-transform: uppercase;
      font-size: 14px;
    }

    tr:nth-child(even) {
      background: #f9f9f9;
    }

    input[type="text"], input[type="password"], select {
      padding: 8px 10px;
      border: 1px solid #ccc;
      border-radius: 6px;
      width: 90%;
      font-size: 14px;
    }

    input:focus, select:focus {
      border-color: #3949ab;
      outline: none;
      box-shadow: 0 0 4px rgba(57,73,171,0.4);
    }

    button {
      padding: 8px 14px;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      font-size: 14px;
      font-weight: bold;
      margin: 2px;
      transition: 0.3s;
    }

    button[type="submit"] {
      background: #3949ab;
      color: #fff;
    }

    button[type="submit"]:hover {
      background: #2c387e;
    }

    button[type="button"] {
      background: #f0f0f0;
      color: #333;
    }

    button[type="button"]:hover {
      background: #e0e0e0;
    }

    .delete-btn {
      background: #e53935 !important;
      color: #fff !important;
    }

    .delete-btn:hover {
      background: #b71c1c !important;
    }

    form {
      margin: 0;
    }

    .error {
      color: red;
      font-weight: bold;
      margin-top: 10px;
    }

    /* Add User form styling */
    form.add-user {
      background: #fff;
      padding: 20px;
      border-radius: 10px;
      margin-top: 20px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    }

    form.add-user label {
      display: block;
      margin: 10px 0 5px;
      font-weight: bold;
      text-align: left;
    }

    form.add-user button {
      width: 100%;
      margin-top: 10px;
    }
  </style>

  <script>
    function toggleEditRow(id) {
      document.getElementById("viewRow-" + id).style.display = "none";
      document.getElementById("editRow-" + id).style.display = "table-row";
    }

    function cancelEditRow(id) {
      document.getElementById("viewRow-" + id).style.display = "table-row";
      document.getElementById("editRow-" + id).style.display = "none";
    }
  </script>
</head>
<body>
  <header>
    <h2>Manage Users</h2>
    <a href="${pageContext.request.contextPath}/admin/dashboard">Back</a>
  </header>

  <div class="container">
    <c:if test="${not empty error}">
      <p class="error">${error}</p>
    </c:if>

    <table>
      <tr>
        <th>ID</th>
        <th>Username</th>
        <th>Role</th>
        <th>Action</th>
      </tr>

      <c:forEach items="${users}" var="u">
        <!-- Normal display row -->
        <tr id="viewRow-${u.id}">
          <td>${u.id}</td>
          <td>${u.username}</td>
          <td>${u.role}</td>
          <td>
            <!-- Delete -->
            <form action="${pageContext.request.contextPath}/admin/users/${u.id}/delete"
                  method="post" style="display:inline">
              <button type="submit" class="delete-btn" onclick="return confirm('Delete user?')">Delete</button>
            </form>

            <!-- Edit -->
            <button type="button" onclick="toggleEditRow(${u.id})">Edit</button>
          </td>
        </tr>

        <!-- Inline edit row -->
        <tr id="editRow-${u.id}" style="display:none; background:#f9f9f9">
          <form action="${pageContext.request.contextPath}/admin/users/${u.id}/update" method="post">
            <td>${u.id}</td>
            <td><input type="text" name="username" value="${u.username}" required/></td>
            <td>
              <select name="role">
                <option value="USER" ${u.role == 'USER' ? 'selected' : ''}>USER</option>
                <option value="ADMIN" ${u.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
              </select>
            </td>
            <td>
              <button type="submit">Update</button>
              <button type="button" onclick="cancelEditRow(${u.id})">Cancel</button>
            </td>
          </form>
        </tr>
      </c:forEach>
    </table>

    <h3>Add User</h3>
    <form class="add-user" action="${pageContext.request.contextPath}/admin/users" method="post">
      <label>Username</label>
      <input name="username" value="${newUser.username}" required/>

      <label>Password</label>
      <input type="password" name="password" required/>

      <label>Role</label>
      <select name="role">
        <option value="USER">USER</option>
        <option value="ADMIN">ADMIN</option>
      </select>

      <button type="submit">Add</button>
    </form>
  </div>
</body>
</html>
