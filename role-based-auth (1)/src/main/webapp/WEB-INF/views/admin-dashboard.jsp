<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Admin Dashboard</title>
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

    nav a {
      color: #fff;
      margin-left: 20px;
      text-decoration: none;
      font-weight: bold;
      transition: 0.3s;
    }

    nav a:hover {
      text-decoration: underline;
    }

    .container {
      padding: 30px;
      max-width: 1100px;
      margin: auto;
    }

    h3 {
      margin-top: 30px;
      color: #3949ab;
    }

    ul.status-list {
      list-style: none;
      padding: 0;
      display: flex;
      gap: 20px;
      margin: 15px 0;
    }

    ul.status-list li {
      background: #fff;
      padding: 15px 20px;
      border-radius: 8px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.1);
      font-weight: bold;
      flex: 1;
      text-align: center;
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
    }

    tr:nth-child(even) {
      background: #f9f9f9;
    }

    select {
      padding: 6px 8px;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 14px;
      cursor: pointer;
    }

    select:focus {
      border-color: #3949ab;
      outline: none;
      box-shadow: 0 0 5px rgba(57,73,171,0.4);
    }

    a.btn-link {
      color: #3949ab;
      text-decoration: none;
      font-weight: bold;
      transition: 0.3s;
    }

    a.btn-link:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
  <header>
    <h2>Admin Dashboard</h2>
    <nav>
      <a href="${pageContext.request.contextPath}/logout">Logout</a>
      <a href="${pageContext.request.contextPath}/admin/users">Manage Users</a>
      <a href="${pageContext.request.contextPath}/admin/tasks/new">Allocate Task</a>
    </nav>
  </header>

  <div class="container">
    <h3>Task Status</h3>
    <ul class="status-list">
      <li>Pending: ${counts.PENDING}</li>
      <li>In Progress: ${counts.IN_PROGRESS}</li>
      <li>Completed: ${counts.COMPLETED}</li>
      <li>Delayed: ${counts.DELAYED}</li>
    </ul>

    <h3>All Tasks</h3>
    <table>
      <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Assignee</th>
        <th>Status</th>
        <th>Start</th>
        <th>Due</th>
        <th>Comments</th>
      </tr>
      <c:forEach items="${tasks}" var="t">
        <tr>
          <td>${t.id}</td>
          <td>${t.title}</td>
          <td>
            <c:choose>
              <c:when test="${not empty t.assignee}">
                <c:out value="${t.assignee.username}"/>
              </c:when>
              <c:otherwise>Unassigned</c:otherwise>
            </c:choose>
          </td>
          <td>
            <form method="post" action="${pageContext.request.contextPath}/admin/tasks/${t.id}/status">
              <select name="status" onchange="this.form.submit()">
                <option value="PENDING" ${t.status.toString() eq 'PENDING' ? 'selected' : ''}>Pending</option>
                <option value="IN_PROGRESS" ${t.status.toString() eq 'IN_PROGRESS' ? 'selected' : ''}>In Progress</option>
                <option value="COMPLETED" ${t.status.toString() eq 'COMPLETED' ? 'selected' : ''}>Completed</option>
                <option value="DELAYED" ${t.status.toString() eq 'DELAYED' ? 'selected' : ''}>Delayed</option>
              </select>
            </form>
          </td>
          <td>${t.startDate}</td>
          <td>${t.dueDate}</td>
          <td><a class="btn-link" href="${pageContext.request.contextPath}/admin/tasks/${t.id}/comments">View</a></td>
        </tr>
      </c:forEach>
    </table>
  </div>
</body>
</html>
