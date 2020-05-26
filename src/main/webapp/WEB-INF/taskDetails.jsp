<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
<meta charset="UTF-8">
<style>
    *{
        margin-left: 1%;
    }
    p span{
        font-weight: bold;
    }
</style>
<title>${task.name}</title>
</head>
<body>
<a href="/dashboard">Back to Dashboard</a>
<h4>Task: ${task.name}</h4>
<p><span>Description</span>: ${task.description}</p>
<p><span>Creator</span>: ${task.taskCreator.name}</p>
<p><span>Assignee</span>: ${task.assignee.name}</p>
<p><span>Due Date</span>: ${task.dueDate.toString().substring(0,10)}</p>
<p><span>Status</span>:  <c:if test="${task.status == 1}">
    <span style="color:green"> Completed</span>
</c:if>
<c:if test="${task.status == 0}">
<span style="color:red">Open</span>
</c:if>
</p>
<p><span>Priority</span>:  <c:if test="${task.priority == 1}">
                   	High
                </c:if>
                <c:if test="${task.priority == 2}">
                    Medium
                </c:if>
                <c:if test="${task.priority ==3}">
                    Low
                </c:if></p>
                <c:if test="${task.taskCreator.id == user.id}">
                	<a href="/task/${task.id}/edit"><button>Edit</button></a>
                    <a href="/delete/${task.id}"><button>Delete</button></a>
                </c:if>
                
                <c:if test="${task.assignee.id == user.id}">
                    <a href="/task/${task.id}/updateStatus"><button>Completed</button></a>
                </c:if>
  
</body>
</html>