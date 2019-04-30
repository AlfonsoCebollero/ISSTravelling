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
<title>Perfil responsable</title>
</head>
<body>
	<div class="container">
		<br>
		<shiro:lacksRole name="empleado">
	No tienes permiso para ver el contenido de esta página
	</shiro:lacksRole>
		<shiro:hasRole name="empleado">
			<div class="row">
				<nav class="navi navbar navbar-inverse">
					<div class="container-fluid">
						<div class="navbar-header">
							<button type="button" class="navbar-toggle"
								data-toggle="collapse" data-target="#myNavbar">
								<span class="icon-bar"></span> <span class="icon-bar"></span> <span
									class="icon-bar"></span>
							</button>
							<div class="brand col-xs-12">
								<img src="https://image.flaticon.com/icons/svg/201/201623.svg"
									alt="" height="36px" width="40px"> Empleado
							</div>
						</div>
						<div class="collapse navbar-collapse" id="myNavbar">
							<ul class="nav navbar-nav">
								<li><a
									href="/ISST2019/HomeEmpleadoServlet?email=${responsable.email }"><span
										class="glyphicon glyphicon-home"></span> Home</a></li>
								<li><a
									href="/ISST2019/EmpleadoServlet?email=${responsable.email }"><span
										class="glyphicon glyphicon-globe"></span> Tus Viajes</a></li>
								<li class="active"><a
									href="/ISST2019/ResponsableServlet?email=${responsable.email }"><span
										class="glyphicon glyphicon-user"></span> Tus Empleados</a></li>
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
				<h3 class="text-center">Listado de empleados a su cargo</h3>
				<br>
				<c:choose>
					<c:when test="${fn:length(empleado_list) > 0}">
						<table class="table table-hover table-bordered">
							<thead>
								<tr>
									<th>Nombre</th>
									<th>Email</th>
									<th>Viajes del Empleado</th>

								</tr>
							</thead>
							<tbody>
								<c:forEach items="${empleado_list}" var="empleadoi">
									<tr class=" clickable-row"
										data-href="/ISST2019/ViajesEmpleadoResponsableServlet?email=${empleadoi.email }">
										<td>${empleadoi.name }</td>
										<td>${empleadoi.email }</td>
										<td>${fn:length(empleadoi.advisedViajes) }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:when>
					<c:otherwise>
						<p class="text-center">No tiene ningún empleado a su cargo</p>
					</c:otherwise>
				</c:choose>
			</div>
		</shiro:hasRole>
	</div>
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
		integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
</body>
</html>
<style>
.clickable-row {
	cursor: pointer;
}

.navi {
	border-radius: 0px 0px 0px 0px;
	border: 0px;
}

.brand {
	margin-top: 0%;
	margin-bottom: 0%;
	padding-top: 7px;
	padding-bottom: 7px;
	padding-left: 0%;
	height: 50px;
	vertical-align: middle;
	font-size: x-large;
	color: white;
}
</style>
<script>
	$(document).ready(function($) {
		$(".clickable-row").click(function() {
			window.document.location = $(this).data("href");
		});
	});
</script>