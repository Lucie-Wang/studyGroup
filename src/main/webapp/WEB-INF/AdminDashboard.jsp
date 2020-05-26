<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Manager</title>
</head>

<body>

	<div class="wrapper">

		<div class="nav">
			<div>
				<h1 style="color:black">Welcome,
					<c:out value="${user.name}" />
				</h1>

			</div>
			<div class="nav2">
				<a href="/logout">Logout</a>
			</div>
		</div>


		<div class="jobForms">


			<div class="col1 companyForm">

				<h2>Add a Group</h2>
				<p>
					<form:errors path="group.*" />
				</p>
				<form:form action="/group/new" method="post" modelAttribute="group">
					<p>
						<form:label path="name">Group Name:</form:label>
						<form:input path="name" />
					</p>
					<p>
						<form:label path="weChatGroupName">WeChat Group Name:</form:label>
						<form:input path="weChatGroupName" />
					</p>
					<input type="submit" value="Create a Group!" />
				</form:form>

			</div>


			<div class="col2 jobForm">
				<c:if test="${userGroup.id != null}">
					<h2>Add a Session for Your Group</h2>
					<p>
						<form:errors path="session.*" />
					</p>
					<form:form action="/${userGroup.id}/session/new" method="post" modelAttribute="session">
						<p>
							<form:label path="group" >Group: <span style="font-weight: bold;">${userGroup.name}</span></form:label>
							<form:input value="${userGroup.id}" path="group" hidden="true" />
						</p>

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
							<form:input path="notes" type="text" />
						</p>
						<p>
							<form:input path="status" value="0" hidden="true" />
						</p>
						<input type="submit" value="Create a new Session!" />
					</form:form>
				</c:if>
			</div>
		</div>



		<div class="jobListings">
			<c:if test="${allSessions!= null}">
				<table>
					<thead>
						<tr>
							<th>Session ID </th>
							<th>Date Time</th>
							<th>Meeting Link</th>
							<th>Notes </th>
							<th>Status</th>
							<th>Created By</th>
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
										<p>Open</p>
									</c:if>
									<c:if test="${session.status==1 }">
										<p>Completed</p>
									</c:if>
								</td>
							
								<td><c:if test="${session.sessionCreator!=null}">
									${session.sessionCreator.name}
								</c:if></td>
							</tr>
						</c:forEach>

					</tbody>
				</table>
			</c:if>
		</div>
		<div class="jobListings">
			<c:if test="${allGroups!= null}">
				<table>
					<thead>
						<tr>
							<th>Name </th>
							<th>Email </th>
							<th>Group</th>
							<th>Is Group Lead? </th>
						</tr>
					</thead>
					<tbody>

						<c:forEach var="one" items="${allUsers}">
							<tr>
								<td>${one.name}</td>
								<td>${one.email}</td>
								<td>${one.assignedGroup.name}</td>
								<td>
									<c:if test="${one.assignedGroup.groupLead.id == one.id}">
										<p>Yes</p>
									</c:if>
									<c:if test="${one.assignedGroup.groupLead.id != one.id}">
										<p>No</p>
									</c:if>

								</td>
							</tr>
						</c:forEach>

					</tbody>
				</table>
			</c:if>
		</div>
		<div class="jobListings">
			<c:if test="${allGroups!= null}">
				<table>
					<thead>
						<tr>
							<th>Group Name</th>
							<th>WeChat Group Name</th>
							<th>Group Lead</th>
							<th>Group Members</th>
							<th>Upcoming Group Sessions</th>
						</tr>
					</thead>
					<tbody>

						<c:forEach var="group" items="${allGroups}">
							<tr>
								<td>${group.name}</td>
								<td>${group.weChatGroupName}</td>
								<td>
									<c:if test="${group.groupLead!=null}"> ${group.groupLead.name}</c:if>
									<c:if test="${group.groupLead ==null}">
										<form action="/${group.id}/assignGroupLead" method="POST">
											<select name="groupLead">
												<c:forEach var="item" items="${allUsers}">
													<c:if test="${item.groupLeading == null}">
														<option value="${item.id}">${item.name}</option>
													</c:if>
												</c:forEach>
											</select>
											<button type="submit" name="action">Assign Group Lead</button>
										</form>
									</c:if>
								</td>
								<td>
									<ul>
										<c:forEach var="member" items="${group.groupMembers}">
											<li>${member.name}</li>
										</c:forEach>
									</ul>
								</td>
								<td>placeholder</td>
							</tr>
						</c:forEach>

					</tbody>
				</table>
			</c:if>
		</div>
	</div>


</body>

</html>