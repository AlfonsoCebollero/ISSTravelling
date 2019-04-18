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
<body>
	<div class="container">
	<br>
		<shiro:guest>
			<div class="jumbotron text-center">
				<h1>Login</h1>
			</div>
			<div class="row text-center well">
				<form action="LoginServlet" method="post" class="form-inline">
					<div class="form-group">
						<label>Email</label> <input class="form-control" type="text"
							name="email" placeholder="Email" />
					</div>
					<div class="form-group">
						<label>Password</label> <input class="form-control"
							type="password" name="password" placeholder="Password" />
					</div>
					<button class="btn btn-primary" type="submit">Login</button>
				</form>
			</div>
		</shiro:guest>

		<shiro:user>
    Welcome back <shiro:principal />! Click <a href="LogoutServlet">here</a> to logout.
</shiro:user>
	</div>
</body>
</html>