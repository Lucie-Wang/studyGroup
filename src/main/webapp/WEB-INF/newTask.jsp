<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>

<head>
    <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/css/bootstrap-select.min.css">
        <meta charset="UTF-8">
        <style>
            .error{
                color:red;
            }
        </style>
    <title>Create Task</title>
</head>

<body>
    <a href="/dashboard">Go Back</a>
    <h3>Create a New Task</h3>
    <p class="error"><form:errors path="task.*"/></p>
    <form:form action="/task/new" method="post" modelAttribute="task">
        <p>
            <form:label path="name">Name</form:label>
            <form:input path="name" />
        </p>
        <p>
            <form:label path="description">Description</form:label>
            <form:textarea path="description" />
        </p>
        <p>
            <form:label path="assignee">Assignee</form:label>
            <form:select path="assignee">
                <c:forEach var="item" items="${allUsers}">
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
        <input type="submit" value="Create" />
    </form:form>
</body>

</html>