<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>My Tasks</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f7fa;
            margin: 0;
            padding: 20px;
        }

        h2 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 20px;
        }

        a {
            color: #3498db;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }

        .logout-link {
            display: block;
            text-align: right;
            margin-bottom: 15px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            border-radius: 6px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 15px;
            text-align: center;
        }

        th {
            background: #3498db;
            color: white;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        tr:nth-child(even) {
            background: #f9f9f9;
        }

        tr:hover {
            background: #f1f7fd;
        }

        select {
            padding: 6px 8px;
            border-radius: 4px;
            border: 1px solid #ccc;
            background: #fff;
            font-size: 14px;
            cursor: pointer;
        }

        select:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.5);
        }

        .btn-view {
            display: inline-block;
            padding: 6px 12px;
            background: #2ecc71;
            color: white;
            border-radius: 4px;
            font-size: 14px;
            text-decoration: none;
            transition: background 0.3s;
        }

        .btn-view:hover {
            background: #27ae60;
        }
    </style>
</head>
<body>
    <h2>My Tasks</h2>
    <div class="logout-link">
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>

    <table>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Assignee</th>
            <th>Status</th>
            <th>Start</th>
            <th>Due</th>
            <th>Details</th>
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
                    <form method="post" action="${pageContext.request.contextPath}/user/tasks/${t.id}/status">
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
                <td><a class="btn-view" href="${pageContext.request.contextPath}/user/tasks/${t.id}">View</a></td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
