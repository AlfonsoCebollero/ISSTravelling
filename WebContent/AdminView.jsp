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
<title>Admin</title>
</head>
<body>
	<div class="container">
		<br>
		<shiro:lacksRole name="admin">
	No tienes permiso para ver el contenido de esta página
		</shiro:lacksRole>
		<shiro:hasRole name="admin">
			<div class="row">
				<nav class="navbar navbar-default">
					<div class="container-fluid">
						<div class="navbar-header">
							<button type="button" class="navbar-toggle"
								data-toggle="collapse" data-target="#myNavbar">
								<span class="icon-bar"></span> <span class="icon-bar"></span> <span
									class="icon-bar"></span>
							</button>
							<b class="navbar-brand">Administrador</b>
						</div>
						<div class="collapse navbar-collapse" id="myNavbar">
							<ul class="nav navbar-nav navbar-right">
								<li><a href="LogoutServlet"><span
										class="glyphicon glyphicon-log-out"></span> Logout</a></li>
							</ul>
						</div>
					</div>
				</nav>
			</div>
			<br>
			<div class="row ">
				<div class="text-center">
					<h3 class="text-center">Crear empleado nuevo</h3>
					<form action="CreateEmpleadoServlet" method="post">
						<div class="form-group">
							<p>
							<div class="row center-block">
								<div class="col-md-6 col-md-offset-3">
									<div class="input-group">
										<div class="input-group-addon">
											<b>Nombre</b>
										</div>
										<input class="form-control" type="text" name="name"
											placeholder="Nombre del empleado" required />
									</div>
								</div>
							</div>
							</p>
							<p>
							<div class="row center-block">
								<div class="col-md-6 col-md-offset-3">
									<div class="input-group">
										<div class="input-group-addon">
											<b>Email</b>
										</div>
										<input class="form-control" type="text" name="email"
											placeholder="Email el empleado" required />
									</div>
								</div>
							</div>
							</p>
							<p>
							<div class="row center-block">
								<div class="col-md-6 col-md-offset-3">
									<div class="input-group">
										<div class="input-group-addon">
											<b>Telefono</b>
										</div>
										<input class="form-control" type="tel" name="telefono"
											placeholder="Teléfono del empleado" required />
									</div>
								</div>
							</div>
							</p>
							<p>
							<div class="row center-block">
								<div class="col-md-6 col-md-offset-3">
									<div class="input-group">
										<div class="input-group-addon">
											<b>Password</b>
										</div>
										<input class="form-control" type="password" name="password"
											placeholder="Contraseña del empleado" required />
									</div>
								</div>
							</div>
							</p>
							<p>
							<div class="row center-block">
								<div class="col-md-6 col-md-offset-3">
									<div class="input-group">
										<div class="input-group-addon">
											<b>Responsable a su cargo</b>
										</div>
										<select class="form-control" name="advisor2">
											<option value="" disabled selected>Elija un
												responsable</option>
											<c:forEach items="${empleado_list}" var="responsablei">
												<option value="${ responsablei.email}">
													${responsablei.name}-${responsablei.email}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
							</p>
							<p>
								<button class="btn btn-success text-center" type="submit">Crear
									Empleado</button>
							</p>
						</div>
					</form>
				</div>
				<hr>


				<h3 class="text-center">Listado de Empleados</h3>
				<table class="table table-striped table-bordered">
					<tr>
						<th>Nombre</th>
						<th>Email</th>
						<th>Teléfono</th>
						<th>Viajes</th>
						<th>Responsable</th>
					</tr>
					<c:forEach items="${empleado_list}" var="emp">
						<tr>
							<td>${emp.name }</td>
							<td>${emp.email }</td>
							<td>${emp.telefono }</td>
							<td>${fn:length(emp.advisedViajes) }</td>
							<td>${emp.advisor2.email }</td>
						</tr>
					</c:forEach>
				</table>
				<hr>
				<h3 class="text-center">Listado de Viajes</h3>
				<table class="table table-hover table-bordered">
					<tr>
						<th>Id</th>
						<th>Destino</th>
						<th>Fecha de salida</th>
						<th>Fecha de regreso</th>
						<th>Presupuesto</th>
						<th>Estado del viaje</th>

					</tr>
					<c:forEach items="${viajes_list}" var="viajei">
						<tr
							class="<c:if test="${viajei.status > 2}">success </c:if>
						<c:if test="${viajei.status == 2 }">danger </c:if> "
							data-href="/ISST2019/EmpleadoViajeServlet?id=${viajei.id }">
							<td>${viajei.id }</td>
							<td>${viajei.destino }</td>
							<td>${viajei.fecha_inicio }</td>
							<td>${viajei.fecha_fin }</td>
							<td>${viajei.presupuesto }</td>
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
				<hr>
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