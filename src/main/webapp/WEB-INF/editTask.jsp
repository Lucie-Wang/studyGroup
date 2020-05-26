<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>

<head>
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <meta charset="UTF-8">
    <style>
        .error{
            color:red;
        }
    </style>
    <title>Edit Task</title>
</head>

<body>
    <a href="/task/${task.id}">Go Back</a>
    <h5>Edit ${task.name }</h5>
    <div>
        <p class="error"><form:errors path="task.*"/></p>
        <form:form action="/task/${task.id}/edit" method="post" modelAttribute="task">
            <p>
                <form:label path="name">Name</form:label>
                <form:input path="name" />
            </p>
            <p>
                <form:label path="Description">Description</form:label>
                <form:textarea path="Description" />
            </p>
            <p>
                <form:label path="assignee">Assignee</form:label>
                <form:select path="assignee">
                    <c:forEach var="item" items="${users}">
                        <form:option value="${item.id}" label="${item.name}" />
                    </c:forEach>
                </form:select>
            </p>
            <p>
                <form:label path="dueDate">Due Date</form:label>
                <form:input type="date" path="dueDate" />
            </p>
            <p>
                <form:label path="priority">Priority</form:label>
                <form:select path="priority">
                    <form:option value="1" label="High" />
                    <form:option value="2" label="Medium" />
                    <form:option value="3" label="Low" />
                </form:select>
            </p>

            <button type="submit">Edit</button>
        </form:form>
    </div>
</body>

</html>