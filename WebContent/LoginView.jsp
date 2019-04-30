<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
	integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu"
	crossorigin="anonymous">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login View</title>
</head>
<body class="bg">
	<div class="container">
		<br>
		<shiro:guest>
			<div class="row text-center mtop">
				<h1>Gestor de Viajes</h1>
			</div>
			<div class="row text-center mtop2">
				<form action="LoginServlet" method="post" class="form-inline">
					<div class="form-group input-group shad">
						<div class="input-group-addon">
							<b>Email</b>
						</div>
						<input type="text" class="form-control" name="email"
							placeholder="Email" required>
					</div>
					<div class="form-group input-group shad">
						<div class="input-group-addon">
							<b>Password</b>
						</div>
						<input type="password" class="form-control" name="password"
							placeholder="password" required>
					</div>
					&nbsp;
					<div class="form-group input-group">
						<button class="btn btn-primary btn-lg shad" type="submit">
							<span class="glyphicon glyphicon-log-in"></span> Log in
						</button>
					</div>
				</form>
			</div>
		</shiro:guest>

		<shiro:user>
    Welcome back <shiro:principal />! Click <a href="LogoutServlet">here</a> to logout.
</shiro:user>
	</div>
</body>
</html>
<style>
.bg {
	/* The image used */
	background-image:
		url("https://s3.amazonaws.com/tinycards/image/84a993ab59004cfea945f8e9ae7f1abe");
	background-position: center;
	background-repeat: no-repeat;
	height: 100%;
	background-size: cover;
	position: relative;
}

.mtop {
	padding-top: 15%;
}

.mtop2 {
	padding-top: 4%;
}

.shad {
	box-shadow: 5px 5px 5px grey;
}

h1 {
	font-size: 600%;
	color: white;
	text-shadow: 0px 2px 7px black;
}

html, body {
	height: 100%;
}
</style>