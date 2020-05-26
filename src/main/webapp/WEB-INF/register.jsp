<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   
 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration Page</title>
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<script type="text/javascript" src="/js/app.js"></script>
</head>
<body>

	<div class="wrapper">
	
		<div class="navwrapper">
			<div class="nav">
				<div class="nav1">
					<p class="llogo">Study Group</p>
				</div>
				<div></div>
				<div class="nav3">
					<a class="links" href="/logout">Logout</a>
				</div>
			</div>
		</div>	
		
		<div class="navSpacer"></div>    
		
		<div class="regLog">
			<h1 class="welcome">Welcome, Aspiring Software Engineer!</h1>
			<p class="blurb">As you know, learning a new skill or making a career change is never easy. We should certainly not do it alone! We are self-organized study groups. This is a simple platform put together within 2 days to facilitate our study group activities.Please use it wisely and keep working with your team members!</p>
		
			<p class="error"><form:errors path="user.*"/></p>
			<form:form class="form" method="POST" action="/registration" modelAttribute="user">
					<form:input class="input" type="email" path="email" placeholder="Email"/>
					<form:password class="input" path="password" placeholder="Password"/>
					<form:password class="input" path="confirmPassword" placeholder="Confirm Password"/>
				<input class="input submit" type="submit" value="Register!"/>
			</form:form>
			
			<p class="switch">Already have an account? <a href="/login">Login</a></p>
		</div>
    </div>
    
</body>
</html>