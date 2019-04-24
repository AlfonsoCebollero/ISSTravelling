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
<meta charset="ISO-8859-1">
<title>Perfil empleado</title>
</head>
<body>
	<div class="container">
		<br>
		<shiro:lacksRole name="empleado">
	No tienes permiso para ver el contenido de esta página
		</shiro:lacksRole>
		<shiro:hasRole name="empleado">
			<div class="row">
				<nav class="navbar navbar-default">
					<div class="container-fluid">
						<div class="navbar-header">
							<button type="button" class="navbar-toggle"
								data-toggle="collapse" data-target="#myNavbar">
								<span class="icon-bar"></span> <span class="icon-bar"></span> <span
									class="icon-bar"></span>
							</button>
							<b class="navbar-brand">Empleado</b>
						</div>
						<div class="collapse navbar-collapse" id="myNavbar">
							<ul class="nav navbar-nav">
								<li class="active"><a
									href="/ISST2019/HomeEmpleadoServlet?email=b">Home</a></li>
								<li><a href="/ISST2019/EmpleadoServlet?email=b">Tus
										Viajes</a></li>
								<li><a href="/ISST2019/ResponsableServlet?email=b">Tus
										Empleados</a></li>
							</ul>
							<ul class="nav navbar-nav navbar-right">
								<li><a href="LogoutServlet"><span
										class="glyphicon glyphicon-log-out"></span> Logout</a></li>
							</ul>
						</div>
					</div>
				</nav>
			</div>
			<br>
			<div class="row">
				<div class="text-center">
					<br>
					<h3 class="text-center">Tu perfil</h3>
					<br>
					<div class=" col-md-offset-3">
						<ul>
							<li>Tu nombre es <b>${ empleado.name}</b></li>
							<li>Tu email es <b>${ empleado.email}</b></li>
							<li>Tu teléfono es <b>&{empleado.telefono}</b></li>
							<li>Tienes <b>${fn:length(empleado.advisedViajes) }</b> viajes activos</li>
							<li>Tienes <b>${tusempleados }</b> empleados a tu cargo</li>
						</ul>
					</div>
				</div>
			</div>
		</shiro:hasRole>
	</div>
</body>
</html>
