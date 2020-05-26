<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Group Sessions</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <link rel="stylesheet" type="text/css" href="/css/dash.css">
    <script type="text/javascript" src="/js/app.js"></script>
</head>

<body>

    <div class="wrapper dashboard">

        <div class="navwrapper navLI">
            <div class="nav">
                <div class="nav1">
                    <div class="llogo"></div>
                    <form action="/search" method="POST">
                        <input class="search" name="search" type="text" placeholder="Search Posts">
                        <input class="searchSubmit" type="submit" value="Search" />
                    </form>
                </div>
                <div class="nav2">
                    <div class="icons">
                        <img class="icon-box fafa" src="/images/friends.png" alt="logo" />
                        <a class="icon-box" href="/dashboard">
                            <img class="fafa" src="/images/home.png" alt="home">
                        </a>
                    </div>
                </div>
                <div class="nav3">
                    <a class="links" href="/logout">Logout</a>
                </div>
            </div>
        </div>
        <div class="navSpacer">

        </div>
        <div class="col1">
            <div class="row">
                <h3>All Group Sessions</h3>
                <c:if test="${allSessions!= null}">
                    <table style="row-gap: 1px;">
                        <thead>
                            <tr>
                                <th>Session ID </th>
                                <th>Date Time</th>
                                <th>Meeting Link</th>
                                <th>Notes </th>
                                <th>Status</th>
                                <th>Created By</th>
                                <th>Tasks</th>
                                <th>Add Task</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>

                            <c:forEach var="session" items="${allSessions}">
                                <tr>
                                    <td>${session.id}</td>
                                    <td>${session.date.toString().substring(0, 16)}</td>
                                    <td>${session.meetingLink}</td>
                                    <td>${session.notes}</td>
                                    <td>
                                        <c:if test="${session.status == 0}">
                                            <p style="color:red">Open</p>
                                        </c:if>
                                        <c:if test="${session.status==1 }">
                                            <p style="color:green">Completed</p>
                                        </c:if>
                                    </td>

                                    <td>
                                        <c:if test="${session.sessionCreator!=null}">
                                            ${session.sessionCreator.name}
                                        </c:if>
                                    </td>
                                    <td>
                                        <ul style="list-style-type:square;">
                                            <c:forEach var="task" items="${session.tasks}">
                                                <li><a href="/task/${task.id}">${task.name}</a></li>
                                            </c:forEach>
                                        </ul>
                                    </td>
                                    <td>
                                        <form action="/session/${session.id}/addTask" method="post">
                                            <select name="task">
                                                <c:forEach var="item" items="${allTasks}">
                                                    <c:if
                                                        test="${item.session.id != session.id && item.session.id ==null}">
                                                        <option value="${item.id}">${item.name}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                            <button type="submit" class="action">Add</button>
                                        </form>

                                    </td>
                                    <td>
                                        <c:if test="${session.sessionCreator.id == user.id}">
                                            <a href="/session/${session.id}/edit"><button
                                                    class="action">Edit</button></a>
                                            <a href="/delete/${session.id}"><button class="action">Delete</button></a>
                                        </c:if>
                                        <c:if test="${session.status == 0}">
                                            <a href="/session/${session.id}/updateStatus"><button
                                                    class="action">Complete</button></a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>

                        </tbody>
                    </table>
                </c:if>
            </div>
        </div>

</body>

</html>