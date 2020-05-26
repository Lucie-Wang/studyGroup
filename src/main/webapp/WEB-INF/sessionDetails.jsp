<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>

<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <meta charset="UTF-8">
    <title>Session Details</title>
    <style>
        * {
            margin-left: 1%;
        }

        p span {
            font-weight: bold;
        }
    </style>
</head>

<body>
    <a href="/dashboard">Back to Dashboard</a>
    <p><span>Session ID</span>: ${session.id}</p>
    <p><c:if test="${session.status == 0}">
            <a href="/session/${session.id}/updateStatus"><button class="action">Mark this Session as
                    Completed</button></a>
        </c:if>
    </p>
    <p><span>Date</span>: ${session.date.toString().substring(0, 16)}</p>
    <p><span>Meeting Link</span>: ${session.meetingLink}</p>
    <p><span>Notes</span>: </p>
    <textarea class="materialize-textarea" disabled="true">${session.notes}</textarea>
    <p><span>Status</span>:
        <c:if test="${session.status == 0}">
            <span style="color:red">Open</span>
        </c:if>
        <c:if test="${session.status == 1}">
            <span style="color:green">Completed</span>
        </c:if>
    </p>

    <p><span>Creator</span>:
        <c:if test="${session.sessionCreator!=null}">
            ${session.sessionCreator.name}
        </c:if>
    </p>
    <p><span>Tasks</span>:</p>
    <table class="striped">
        <thead>
            <tr>
                <th>Task ID </th>
                <th>Name</th>
                <th>Description</th>
                <th>Assignee </th>
                <th>Due Date</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>

            <c:forEach var="task" items="${session.tasks}">
                <tr>
                    <td>${task.id}</td>
                    <td><a href="/task/${task.id}">${task.name}</a></td>
                    <td>${task.description}
                    </td>
                    <td>${task.assignee.name}
                    </td>
                    <td>${task.dueDate.toString().substring(0, 10)}</td>
                    <td>
                        <c:if test="${task.status == 0}">
                            <p style="color:red">Open</p>
                        </c:if>
                        <c:if test="${task.status==1 }">
                            <p style="color:green">Completed</p>
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${task.assignee.id == user.id && task.status!=1}">
                            <form action="/task/${task.id}/updateStatus" method="POST">
                                <button type="submit" class="action" name="action">Complete</button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <p>
        <form action="/session/${session.id}/addTask" method="post">
            <select name="task">
                <c:forEach var="item" items="${allTasks}">
                    <c:if test="${item.session.id != session.id && item.session.id ==null}">
                        <option value="${item.id}">${item.name}</option>
                    </c:if>
                </c:forEach>
            </select>
            <button type="submit" class="action">Add Task</button>
        </form>

    </p>
    <p>
        <c:if test="${session.sessionCreator.id == user.id}">
            <a href="/session/${session.id}/edit"><button class="action">Edit</button></a>
            <a href="/delete/${session.id}"><button class="action">Delete</button></a>
        </c:if><br> 
    </p>

</body>

</html>