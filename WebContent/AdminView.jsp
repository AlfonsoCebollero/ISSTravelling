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
		<shiro:user>
    Welcome back <shiro:principal />! Click <a href="LogoutServlet">here</a> to logout.
		</shiro:user>
		<shiro:lacksRole name="admin">
	No tienes permiso para ver el contenido de esta página
		</shiro:lacksRole>
		<shiro:hasRole name="admin">
			<div class="jumbotron text-center">
				<h1>Administrador</h1>
			</div>
			<div class="row well">
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
							class="<c:if test="${viajei.status == 2 || viajei.status == 3}">success </c:if>
						<c:if test="${viajei.status == 5 }">danger </c:if> "
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
				<hr>
			</div>
		</shiro:hasRole>
	</div>
</body>
</html>