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
		<shiro:notAuthenticated>
	No tienes permiso para ver el contenido de esta página
		</shiro:notAuthenticated>
		<shiro:authenticated>
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
									alt="" height="36px" width="40px"> <shiro:hasRole name="empleado">Empleado</shiro:hasRole>
								<shiro:hasRole name="admin">Administrador</shiro:hasRole>
							</div>
						</div>
						<div class="collapse navbar-collapse" id="myNavbar">
							<shiro:hasRole name="empleado">
								<ul class="nav navbar-nav">
									<li><a
										href="/ISST2019/HomeEmpleadoServlet?email=${empleado.email }"><span
											class="glyphicon glyphicon-home"></span> Home</a></li>
									<li><a
										href="/ISST2019/EmpleadoServlet?email=${empleado.email }"><span
											class="glyphicon glyphicon-globe"></span> Tus Viajes</a></li>
									<li class="active"><a
										href="/ISST2019/ResponsableServlet?email=${empleado.email }"><span
											class="glyphicon glyphicon-user"></span> Tus Empleados</a></li>
								</ul>
							</shiro:hasRole>
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
				<h3 class="text-center">
					<c:if test="${viaje.status < 7}">Reembolso</c:if>
					<c:if test="${viaje.status > 7}">Reintegro</c:if>
					de facturas de ${empleado.name}
				</h3>
				<br>
				<c:choose>
					<c:when test="${fn:length(facturas_list) > 0}">
						<div class="progress">
							<div class="progress-bar progress-bar-success" role="progressbar"
								style="width: ${porcentajeAceptado}%">${porcentajeAceptado}%
								Aceptado</div>
							<div class="progress-bar progress-bar-danger" role="progressbar"
								style="width: ${porcentajeRechazado}%">${porcentajeRechazado}%
								Rechazado</div>
							<div class="progress-bar progress-bar-info" role="progressbar"
								style="width: ${porcentajeSolicitado}%">${porcentajeSolicitado}%
								Pendiente</div>
						</div>
						<br>
						<table class="table table-striped table-bordered">
							<tr>
								<th>Id</th>
								<th>Cargo (Total:${total}€)</th>
								<th>Comprobante</th>
								<th>Descripción</th>
								<th>Estado</th>
								<th>Acción requerida</th>

							</tr>
							<c:forEach items="${facturas_list}" var="facturai">
								<tr
									<c:if test="${facturai.estado == 3 && viaje.status%5 != 0}">class="success"</c:if>
									<c:if test="${facturai.estado == 4}">class="success"</c:if>
									<c:if test="${facturai.estado == 2}">class="danger"</c:if>>

									<td>${facturai.id }</td>
									<td>${facturai.cargo }€</td>
									<td><form action="DownloadFileServlet">
											<input type="hidden" name="id" value="${facturai.id}">
											<button class="btn btn-info" type="submit">
												<span class="glyphicon glyphicon-cloud-download"></span>
												Descargar
											</button>
										</form></td>
									<td>${facturai.descripcion }</td>
									<td><c:if test="${facturai.estado == 1}">Solicitado</c:if>
										<c:if test="${facturai.estado == 2}">Rechazado</c:if> <c:if
											test="${facturai.estado == 3}">A aceptar por Organo</c:if> <c:if
											test="${facturai.estado == 4}">Aprobado</c:if></td>
									<td><c:if
											test="${facturai.estado == 1 || (facturai.estado == 3 && viaje.status%5 == 0)}">
											<form id="${facturai.id}aceptForm"
												action="Form4FacturaServlet" method="post">
												<input type="hidden" name="id" value="${facturai.id}" /> <input
													type="hidden" name="viajeId" value="${viaje.id}" /> <input
													type="hidden" name="action" value="1" />
											</form>
											<form id="${facturai.id}denyForm"
												action="Form4FacturaServlet" method="post">
												<input type="hidden" name="id" value="${facturai.id}" /> <input
													type="hidden" name="viajeId" value="${viaje.id}" /> <input
													type="hidden" name="action" value="0" />
											</form>
											<button form="${facturai.id}aceptForm" type="submit"
												class="btn btn-success">
												<span class="glyphicon glyphicon-ok"></span>
											</button>
											<button form="${facturai.id}denyForm" type="submit"
												class="btn btn-danger">
												<span class="glyphicon glyphicon-remove"></span>
											</button>
										</c:if></td>
								</tr>
							</c:forEach>

						</table>
						<div class="text-center">


							<form action="Form3EmpleadoServlet" method="post">
								<input type="hidden" name="id" value="${viaje.id}" /> <input
									type="hidden" name="action" value="${viaje.status + 1 }" />
								<button type="submit" class="btn btn-success"
									<c:if test="${porcentajeSolicitado != 0}">disabled</c:if>>
									<c:if test="${viaje.status < 7}">Finalizar
									reembolso</c:if>
									<c:if test="${viaje.status > 7}">Finalizar
									reintegro</c:if>
								</button>
							</form>
					</c:when>
					<c:otherwise>
						<p class="text-center">No ha añadido ninguna factura aún</p>
					</c:otherwise>
				</c:choose>
			</div>
			<br>
			<br>
	</div>
	</shiro:authenticated>
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