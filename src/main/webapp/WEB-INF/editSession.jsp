<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>

<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <meta charset="UTF-8">
    <title>Edit Session</title>
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

    <p><c:if test="${session.status == 0}">
            <a href="/session/${session.id}/updateStatus"><button class="action">Mark this Session as
                    Completed</button></a>
        </c:if>
    </p>
    <div class="col2 jobForm">

            <h4>Update<span>Session ID</span>: ${session.id}</h4>
            <p>
                <form:errors path="session.*" />
            </p>
            <form:form action="/session/${session.id}/edit" method="post" modelAttribute="session">
                <p>
                    <form:label path="date">Date: </form:label>
                    <form:input type="datetime-local" path="date"/>
                </p>
                <p>
                    <form:label path="meetingLink">Meeting Link: </form:label>
                    <form:input path="meetingLink" type="text" />
                </p>
                <p>
                    <form:label path="notes">Notes: </form:label>
                    <form:textarea path="notes" type="text" />
                </p>
                <input type="submit" value="Update" />
            </form:form>

    </div>

</body>

</html>