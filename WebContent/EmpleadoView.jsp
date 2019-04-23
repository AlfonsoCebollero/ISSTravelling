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
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<meta charset="ISO-8859-1">
<title>Perfil empleado</title>
</head>
<body>
	<div class="container">
		<shiro:user>
    Welcome back <shiro:principal />! Click <a href="LogoutServlet">here</a> to logout.
		</shiro:user>
		<shiro:lacksRole name="empleado">
	No tienes permiso para ver el contenido de esta página
	</shiro:lacksRole>
		<shiro:hasRole name="empleado">
			<div class="jumbotron text-center">
				<h1>Empleado</h1>
				<p>
					Tu Email: ${ empleado.email } <br>Tu nombre: ${ empleado.name }
				</p>
			</div>
			<div class="row well">
				<div class="text-center">
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
							class="<c:if test="${viajei.status == 2 || viajei.status == 3}">success </c:if>
						<c:if test="${viajei.status == 5 }">danger </c:if> clickable-row"
							data-href="/ISST2019/EmpleadoViajeServlet?id=${viajei.id }">
							<td>${viajei.id }</td>
							<td>${viajei.destino }</td>
							<td>${viajei.fecha_inicio }</td>
							<td>${viajei.fecha_fin }</td>
							<td>${viajei.presupuesto }</td>
							<td><c:if test="${viajei.status == 1}">Solicitado</c:if> <c:if
									test="${viajei.status == 2}">Aprobado</c:if> <c:if
									test="${viajei.status == 3}">En curso</c:if> <c:if
									test="${viajei.status == 4}">Finalizado</c:if> <c:if
									test="${viajei.status == 5}">Rechazado</c:if></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</shiro:hasRole>
	</div>
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
