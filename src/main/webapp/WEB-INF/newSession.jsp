<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
<meta charset="UTF-8">
<title>Create Session</title>
</head>
<body>
<a href="/dashboard">Go Back</a>
<div class="col2 jobForm">
    <c:if test="${userGroup.id != null}">
        <h5>Create a Session for Your Group</h5>
        <p>
            <form:errors path="session.*" />
        </p>
        <form:form action="/${userGroup.id}/session/new" method="post" modelAttribute="session">
            <h5>
                <form:label path="group" >Group: <span style="font-weight: bold;">${userGroup.name}</span></form:label>
                <form:input value="${userGroup.id}" path="group" hidden="true" />
            </h5>

            <p>
                <form:label path="date">Date: </form:label>
                <form:input type="datetime-local" path="date" value="${session.date}"/>
            </p>
            <p>
                <form:label path="meetingLink">Meeting Link: </form:label>
                <form:input path="meetingLink" type="text" />
            </p>
            <p>
                <form:label path="notes">Notes: </form:label>
                <form:textarea path="notes" type="text" />
            </p>
            <p>
                <form:input path="status" value="0" hidden="true" />
            </p>
            <input type="submit" value="Create a new Session!" />
        </form:form>
    </c:if>
</div>
</body>
</html>