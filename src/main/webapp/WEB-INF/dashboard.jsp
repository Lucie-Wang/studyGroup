<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Dashboard</title>
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
						<input class="search" name="search" type="text"
							placeholder="Search Posts"> <input class="searchSubmit"
							type="submit" value="Search" />
					</form>
				</div>
				<div class="nav2">
					<div class="icons">
						<img class="icon-box fafa" src="/images/friends.png" alt="logo" />
						<a class="icon-box" href="/dashboard"> <img class="fafa"
							src="/images/home.png" alt="home">
						</a>
					</div>
				</div>
				<div class="nav3">
					<a class="links" href="/logout">Logout</a>
				</div>
			</div>
		</div>

		<div class="navSpacer"></div>

		<!-- HEADER -->

		<!-- DASH GRID -->

		<div class="dash">
			<!-- COLUMN 1 -->
			<div class="col1">
				<!-- Each div you add below here will be a row in column 1 -->
				<!-- Profile page -->
				<div class="row profileRow">
					<img id="profileImage" src="${ user.picture }" alt="logo"
						class="logo" />
					<div>
						<h1>${ user.name }</h1>
						<p>${ user.city }, ${user.region}</p>
							<c:if test="${ user.joinedGroups.size() == 0 }">
							<p>You do not have any study groups... <button> Get Started </button></p>
							</c:if>
					</div>
				</div>
				<div class="row">
					<h3>Connections</h3>
					<div class="dashConnections">
						<c:forEach items="${ friends }" var="friend">
							<c:if test="${ friend.name != null }">
								<div class="dashConnectionsRow">
									<img src="${ friend.picture }" /> <a
										href="/dashboard/${ friend.id }"> ${ friend.name }</a>
								</div>
							</c:if>
						</c:forEach>
					</div>
					</div>
					<div class="row">
						<h3>Feed</h3>
						<div class="feed">
							<p class="error">
								<form:errors path="post.*" />
							</p>
							<form:form class="form" action="/post/new" method="post"
								modelAttribute="post">
								<p>
									<form:input class="content" path="content" placeholder="Share what's on your mind!" />
									<input class="submit" type="submit" value="Post" />
								</p>
							</form:form>
							<div class="feed">
								<div class="feedSubHeader">
									<h3>Posts</h3>
									<c:if test="${ allPosts.size()!= 0 }">
										<c:forEach items="${ allPosts }" var="post">
											<div class="post">
												<div class="postGrid">
													<img class="postPic" src="${ post.postWriter.picture }"
														alt="" />
													<div>
														<p class="postName">${ post.postWriter.name }(${ post.postWriter.assignedGroup.name})</p>
														<p class="postCreated">${post.createdAt.toString().substring(0, 16)}</p>
													</div>
												</div>
												<p class="postContent">
													<c:if test="${post.content.length() >= 150}"> ${ post.content.substring(0, 150)}<a
															href="/post/${post.id}">...</a>
													</c:if>
													<c:if test="${post.content.length() < 150}"> ${ post.content}</c:if>
												</p>
											</div>
										</c:forEach>
									</c:if>

									<div class="loadMore">

										<c:if
											test="${posts.size() < allPosts.size() && allPosts.size() >= 4}">
											<a href="/dashboard/${user.id}/loadmore">
												<button>Load More</button>
											</a>
										</c:if>

										<c:if
											test="${posts.size() >= allPosts.size() && allPosts.size() > 3}">
											<p>
												No more posts... <a href="/dashboard/${user.id}">Click
													to fold</a>
											</p>
										</c:if>

									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- COLUMN 2 -->

				<div class="col2">
					<!-- Each div you add below here will be a row in column 2 -->
					<div class="row">
						<h3>Upcoming Group Sessions</h3>
						<div class="feed">
							<c:if test="${allSessions!= null}">
								<table>
									<thead>
										<tr>
											<th>ID</th>
											<th>Date Time</th>
											<th>Meeting Link</th>
											<th>Status</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody>

										<c:forEach var="session" items="${allSessions}">
											<c:if test="${session.status == 0}">
												<tr>
													<td>${session.id}</td>
													<td>${session.date.toString().substring(0, 16)}</td>
													<td>${session.meetingLink}</td>
													<td><c:if test="${session.status == 0}">
															<p style="color: red">Open</p>
														</c:if> <c:if test="${session.status==1 }">
															<p style="color: green">Completed</p>
														</c:if></td>

													<td><a href="/session/${session.id}">
															<button class="action">View</button>
													</a> <c:if test="{session.sessionCreator.id == user.id}">
															<a href="/session/${session.id}/edit"><button
																	class="action">Edit</button></a>
															<a href="/delete/${session.id}"><button
																	class="action">Delete</button></a>
														</c:if> <a href="/session/${session.id}/updateStatus"><button
																class="action">Complete</button></a></td>
												</tr>
											</c:if>
										</c:forEach>

									</tbody>
								</table>
							</c:if>
							<div>
								<a href="/session/new"><button class="submit">Create
										a New Session</button></a> <a href="/session/all"><button
										class="submit">View All Sessions</button></a>
							</div>
						</div>
					</div>

					<div class="row">
						<h3>Tasks</h3>
						<div class="feed">
							<p>
								<a href="/task/highpriority">
									<button class="action">Priority High - Low</button>
								</a> <a href="/task/lowpriority"><button class="action">Priority
										Low - High</button></a>
							</p>
							<c:if test="${allTasks!= null}">
								<table>
									<thead>
										<tr>
											<th>ID</th>
											<th>Name</th>
											<th>Assignee</th>
											<th>Due Date</th>
											<th>Status</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody>

										<c:forEach var="task" items="${allTasks}">
											<tr>
												<td>${task.id}</td>
												<td><a href="/task/${task.id}">${task.name}</a></td>
												<td>${task.assignee.name}</td>
												<td>${task.dueDate.toString().substring(0, 10)}</td>
												<td><c:if test="${task.status == 0}">
														<p style="color: red">Open</p>
													</c:if> <c:if test="${task.status==1 }">
														<p style="color: green">Completed</p>
													</c:if></td>
												<td><c:if
														test="${task.assignee.id == user.id && task.status!=1}">
														<form action="/task/${task.id}/updateStatus" method="POST">
															<button type="submit" class="action" name="action">Complete</button>
														</form>
													</c:if></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</c:if>
							<div>
								<a href="/task/new"><button class="submit">Create a
										New Task</button></a>
							</div>
						</div>
					</div>

					<div class="row">
						<h3>My Open Tasks</h3>
						<div class="feed">
							<table>
								<thead>
									<tr>
										<th>Task ID</th>
										<th>Name</th>
										<th>Session ID</th>
										<th>Due Date</th>
										<th>Status</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="task" items="${allTasks}">
										<tr>
											<c:if
												test="${task.assignee.id == user.id && task.status == 0}">
												<td>${task.id}</td>
												<td><a href="/task/${task.id}">${task.name}</a></td>
												<td>${task.session.id}</td>
												<td>${task.dueDate.toString().substring(0, 10)}</td>
												<td><c:if test="${task.status == 0}">
														<p style="color: red">Open</p>
													</c:if> <c:if test="${task.status == 1 }">
														<p style="color: green">Completed</p>
													</c:if></td>
												<td><c:if test="${task.assignee.id == user.id}">
														<form action="/task/${task.id}/updateStatus" method="POST">
															<button type="submit" class="action" name="action">Complete</button>
														</form>
													</c:if></td>
											</c:if>
										</tr>
									</c:forEach>

								</tbody>
							</table>

						</div>
					</div>

				</div>
			</div>

		</div>
</body>

</html>