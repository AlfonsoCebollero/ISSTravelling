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
								<li><a
									href="/ISST2019/HomeEmpleadoServlet?email=${empleado.email }">Home</a></li>
								<li class="active"><a
									href="/ISST2019/EmpleadoServlet?email=${empleado.email }">Tus
										Viajes</a></li>
								<li><a
									href="/ISST2019/ResponsableServlet?email=${empleado.email }">Tus
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
					<h3 class="text-center">Crear solicitud de viaje</h3>
					<form action="CreateViajeServlet" method="post">
						<div class="form-group">
							<p>
							<div class="row center-block">
								<div class="col-md-6 col-md-offset-3">
									<div class="input-group">
										<div class="input-group-addon">
											<b>Destino</b>
										</div>
										<input class="form-control" type="text" name="destino"
											placeholder="Ciudad" required />
									</div>
								</div>
							</div>
							</p>
							<p>
							<div class="row center-block">
								<div class="col-md-6 col-md-offset-3">
									<div class="input-group">
										<div class="input-group-addon">
											<b>Fecha de partida</b>
										</div>
										<input class="form-control" type="date" name="ida" required />
									</div>
								</div>
							</div>
							</p>
							<p>
							<div class="row center-block">
								<div class="col-md-6 col-md-offset-3">
									<div class="input-group">
										<div class="input-group-addon">
											<b>Fecha de regreso</b>
										</div>
										<input class="form-control" type="date" name="vuelta" required />
									</div>
								</div>
							</div>
							</p>
							<p>
							<div class="row center-block">
								<div class="col-md-6 col-md-offset-3">
									<div class="input-group">
										<div class="input-group-addon">
											<b>Propon presupuesto</b>
										</div>
										<input class="form-control" type="number" name="presupuesto"
											placeholder="Cantidad" required />
									</div>
								</div>
							</div>
							</p>
							<p>
								<button class="btn btn-success text-center" type="submit">Solicitar
									Viaje</button>
							</p>
						</div>
					</form>
				</div>
				<hr>
				<br>
				<h3 class="text-center">Listado de viajes</h3>
				<table class="table table-hover table-bordered">
					<tr>
						<th>Id</th>
						<th>Destino</th>
						<th>Fecha de salida</th>
						<th>Fecha de regreso</th>
						<th>Presupuesto</th>
						<th>Estado del viaje</th>

					</tr>
					<c:forEach items="${vieajes_list}" var="viajei">
						<tr
							class="<c:if test="${viajei.status > 2 || viajei.status < 8}">success </c:if>
						<c:if test="${viajei.status == 2 }">danger </c:if>
						<c:if test="${viajei.status > 7 }">info </c:if> clickable-row"
							data-href="/ISST2019/EmpleadoViajeServlet?id=${viajei.id }">
							<td>${viajei.id }</td>
							<td>${viajei.destino }</td>
							<td>${viajei.fecha_inicio }</td>
							<td>${viajei.fecha_fin }</td>
							<td>${viajei.presupuesto } €</td>
							<td><c:if test="${viajei.status == 1}">Solicitado</c:if> <c:if
									test="${viajei.status == 2}">Rechazado</c:if> <c:if
									test="${viajei.status == 3}">Aprobado</c:if> <c:if
									test="${viajei.status == 4}">En Reembolso Responsable</c:if> <c:if
									test="${viajei.status == 5}">En Reembolso Organo</c:if> <c:if
									test="${viajei.status == 6}">Reembolsado</c:if> <c:if
									test="${viajei.status == 7}">En curso</c:if> <c:if
									test="${viajei.status == 8}">Finalizado</c:if> <c:if
									test="${viajei.status == 9}">En reintegro Responsable</c:if> <c:if
									test="${viajei.status == 10}">En reintegro Organo</c:if> <c:if
									test="${viajei.status == 11}">Reintegrado</c:if></td>
						</tr>
					</c:forEach>
				</table>
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
</style>
<script>
	$(document).ready(function($) {
		$(".clickable-row").click(function() {
			window.document.location = $(this).data("href");
		});
	});
</script>
