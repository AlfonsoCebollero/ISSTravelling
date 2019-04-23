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
										<input class="form-control" type="text" name="telefono"
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
											<c:forEach items="${responsable_list}" var="responsablei">
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
				<div class="text-center">
					<h3 class="text-center">Crear responsable nuevo</h3>
					<form action="CreateResponsableServlet" method="post">
						<p>
						<div class="row center-block">
							<div class="col-md-6 col-md-offset-3">
								<div class="input-group">
									<div class="input-group-addon">
										<b>Nombre</b>
									</div>
									<input class="form-control" type="text" name="name"
										placeholder="Nombre del responsable" required />
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
										placeholder="Email del responsable" required />
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
										placeholder="Contraseña del responsable" required />
								</div>
							</div>
						</div>
						</p>
						<p>
						<div class="row center-block">
							<div class="col-md-6 col-md-offset-3">
								<div class="input-group">
									<div class="input-group-addon">
										<b>Empleado que es</b>
									</div>
									<select class="form-control" name="advisor3" required>
										<option value="" disabled selected>Elija un empleado</option>
										<c:forEach items="${empleado_list}" var="empleadoi">
											<option value="${ empleadoi.email}">
												${empleadoi.name}-${empleadoi.email}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						</p>
						<p>
							<button class="btn btn-success" type="submit">Crear
								Responsable</button>
						</p>
					</form>
				</div>
				<hr>

				<h3 class="text-center">Listado de Empleados</h3>
				<table class="table table-striped table-bordered">
					<tr>
						<th>Nombre</th>
						<th>Email</th>
						<th>Viajes</th>
					</tr>
					<c:forEach items="${empleado_list}" var="emp">
						<tr>
							<td>${emp.name }</td>
							<td>${emp.email }</td>
							<td>${fn:length(emp.advisedViajes) }</td>
						</tr>
					</c:forEach>
				</table>
				<hr>
				<h3 class="text-center">Listado de Responsables</h3>
				<table class="table table-striped table-bordered">
					<tr>
						<th>Nombre</th>
						<th>Email</th>
						<th>Empleados</th>
					</tr>
					<c:forEach items="${responsable_list}" var="resp">
						<tr>
							<td>${resp.name }</td>
							<td>${resp.email }</td>
							<td>${fn:length(resp.advisedEmpleados) }</td>
						</tr>
					</c:forEach>
				</table>
				<hr>
			</div>
		</shiro:hasRole>
	</div>
</body>
</html>