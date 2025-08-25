<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Task Comments</title>
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
      max-width: 900px;
      margin: auto;
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
      text-align: left;
    }

    th {
      background: #3949ab;
      color: #fff;
    }

    tr:nth-child(even) {
      background: #f9f9f9;
    }

    .back-link {
      display: inline-block;
      margin-top: 15px;
      padding: 8px 14px;
      background: #3949ab;
      color: #fff;
      border-radius: 6px;
      text-decoration: none;
      font-weight: bold;
      transition: 0.3s;
    }

    .back-link:hover {
      background: #2c387e;
    }
  </style>
</head>
<body>
  <header>
    <h2>Task Comments</h2>
    <a href="${pageContext.request.contextPath}/admin/dashboard">Back</a>
  </header>

  <div class="container">
    <table>
      <tr>
        <th>#</th>
        <th>Author</th>
        <th>Comment</th>
        <th>At</th>
      </tr>
      <c:forEach items="${comments}" var="cmt" varStatus="vs">
        <tr>
          <td>${vs.index + 1}</td>
          <td>${cmt.author.username}</td>
          <td>${cmt.content}</td>
          <td>${cmt.createdAt}</td>
        </tr>
      </c:forEach>
    </table>
  </div>
</body>
</html>
