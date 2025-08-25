<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Task Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            margin: 20px;
        }
        h2, h3 {
            color: #333;
        }
        a {
            display: inline-block;
            margin-bottom: 15px;
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }
        a:hover {
            text-decoration: underline;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 25px;
            background: #fff;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            border-radius: 6px;
            overflow: hidden;
        }
        th, td {
            padding: 12px 15px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }
        th {
            background: #007bff;
            color: #fff;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            font-size: 14px;
        }
        tr:nth-child(even) {
            background: #f9f9f9;
        }
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #bbb;
            border-radius: 5px;
            font-size: 14px;
            resize: vertical;
            margin-bottom: 10px;
        }
        input[type="submit"] {
            background: #007bff;
            border: none;
            padding: 10px 18px;
            border-radius: 5px;
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.2s;
        }
        input[type="submit"]:hover {
            background: #0056b3;
        }
        .comment-section {
            background: #fff;
            padding: 15px;
            border-radius: 6px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
<h2>Task Details</h2>
<p><a href="${pageContext.request.contextPath}/user/tasks">⬅ Back to My Tasks</a></p>

<h3>Comments</h3>
<table>
  <tr>
    <th>Author</th>
    <th>Content</th>
    <th>Created At</th>
  </tr>
  <c:forEach items="${comments}" var="c">
    <tr>
      <td>
          <c:choose>
              <c:when test="${not empty c.author}">
                  <c:out value="${c.author.username}"/>
              </c:when>
              <c:otherwise>
                  Unknown
              </c:otherwise>
          </c:choose>
      </td>
      <td><c:out value="${c.content}"/></td>
      <td>${c.createdAt}</td>
    </tr>
  </c:forEach>
</table>

<h3>Add Comment</h3>
<div class="comment-section">
    <form action="${pageContext.request.contextPath}/user/tasks/${taskId}/comments" method="post">
      <textarea name="content" rows="4" required></textarea><br/>
      <input type="submit" value="Add Comment"/>
    </form>
</div>
</body>
</html>
