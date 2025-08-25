<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Create Task</title>
    <style>
        body {
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            margin: 40px auto;
            background: #fff;
            padding: 25px 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        a {
            display: inline-block;
            margin-bottom: 20px;
            text-decoration: none;
            color: #3498db;
            font-size: 14px;
        }
        a:hover {
            text-decoration: underline;
        }

        form label {
            display: block;
            margin: 12px 0 6px;
            font-weight: 500;
            color: #444;
        }

        input[type="text"],
        input[type="date"],
        select,
        textarea {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
            margin-bottom: 10px;
            box-sizing: border-box;
        }

        textarea {
            resize: vertical;
        }

        button {
            width: 100%;
            padding: 12px;
            background: #3498db;
            color: #fff;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        button:hover {
            background: #2980b9;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Allocate Task</h2>
    <a href="${pageContext.request.contextPath}/admin/dashboard">&larr; Back</a>

    <form action="${pageContext.request.contextPath}/admin/tasks" method="post">
        <label>Title</label>
        <input name="title" required/>

        <label>Description</label>
        <textarea name="description" rows="4"></textarea>

        <label>Start Date</label>
        <input type="date" name="startDate" required/>

        <label>Due Date</label>
        <input type="date" name="dueDate" required/>

        <label>Assign To</label>
        <select name="assigneeId" required>
            <c:forEach items="${users}" var="u">
                <option value="${u.id}">${u.username} (${u.role})</option>
            </c:forEach>
        </select>

        <button type="submit">Create</button>
    </form>
</div>
</body>
</html>
