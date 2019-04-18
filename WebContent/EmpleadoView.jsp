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
						<p>
						<div class="row center-block">
							<div class="col-md-1 col-md-offset-3">
								<label>Destino</label>
							</div>
							<div class="col-md-4">
								<input class="form-control" type="text" name="destino"
									placeholder="Ciudad" required />
							</div>
						</div>
						</p>
						<p>
						<div class="row center-block">
							<div class="col-md-1 col-md-offset-3">
								<label>Fecha de ida</label>
							</div>
							<div class="col-md-4">
								<input class="form-control" type="date" name="ida" required />
							</div>
						</div>
						</p>
						<p>
						<div class="row center-block">
							<div class="col-md-1 col-md-offset-3">
								<label>Fecha de vuelta</label>
							</div>
							<div class="col-md-4">
								<input class="form-control" type="date" name="vuelta" required />
							</div>
						</div>
						</p>
						<p>
						<div class="row center-block">
							<div class="col-md-1 col-md-offset-3">
								<label>Propón presupuesto</label>
							</div>
							<div class="col-md-4">
								<input class="form-control" type="number" name="presupuesto"
									placeholder="Cantidad" required />
							</div>
						</div>
						</p>
						<p>
							<button class="btn btn-success text-center" type="submit">Solicitar
								Viaje</button>
						</p>
					</form>
				</div>
				<hr>

				<h3 class="text-center">Listado de viajes</h3>
				<table class="table table-striped table-bordered">
					<tr>
						<th>Id</th>
						<th>Destino</th>
						<th>Fecha de salida</th>
						<th>Fecha de regreso</th>
						<th>Presupuesto</th>
						<th>Estado del viaje</th>

					</tr>
					<c:forEach items="${vieajes_list}" var="viajei">
						<tr <c:if test="${viajei.status == 2 || viajei.status == 3}">class="success"</c:if>
						<c:if test="${viajei.status == 5}">class="danger"</c:if>>
							<td>${viajei.id }</td>
							<td>${viajei.destino }</td>
							<td>${viajei.fecha_inicio }</td>
							<td>${viajei.fecha_fin }</td>
							<td>${viajei.presupuesto }</td>
							<td><c:if test="${viajei.status == 1}">Solicitado</c:if> <c:if
									test="${viajei.status == 2}">Aprobado</c:if> <c:if
									test="${viajei.status == 3}">En curso</c:if> <c:if
									test="${viajei.status == 4}">Finalizado</c:if><c:if
									test="${viajei.status == 5}">Rechazado</c:if></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</shiro:hasRole>
	</div>
</body>
</html>