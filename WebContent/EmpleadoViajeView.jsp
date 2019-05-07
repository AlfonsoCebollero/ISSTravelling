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
									href="/ISST2019/HomeEmpleadoServlet?email=${empleado.email }"><span
										class="glyphicon glyphicon-home"></span> Home</a></li>
								<li class="active"><a
									href="/ISST2019/EmpleadoServlet?email=${empleado.email }"><span
										class="glyphicon glyphicon-globe"></span> Tus Viajes</a></li>
								<li><a
									href="/ISST2019/ResponsableServlet?email=${empleado.email }"><span
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
				<div class="row">
					<h3 class="text-center">Descripción de viaje con id ${ viaje.id }</h3>
					<br>
					<div class=" col-md-offset-3">
						<ul>
							<li>El estado del viaje es <b><c:if
										test="${viaje.status == 1}">Solicitado</c:if> <c:if
										test="${viaje.status == 2}">Rechazado</c:if> <c:if
										test="${viaje.status == 3}">Aprobado</c:if> <c:if
										test="${viaje.status == 4}">En Reembolso Responsable</c:if> <c:if
										test="${viaje.status == 5}">En Reembolso Organo</c:if> <c:if
										test="${viaje.status == 6}">Reembolsado</c:if> <c:if
										test="${viaje.status == 7}">En curso</c:if> <c:if
										test="${viaje.status == 8}">Finalizado</c:if> <c:if
										test="${viaje.status == 9}">En reintegro Responsable</c:if> <c:if
										test="${viaje.status == 10}">En reintegro Organo</c:if> <c:if
										test="${viaje.status == 11}">Reintegrado</c:if></b></li>
							<li>El destino del viaje es <b>${ viaje.destino }</b> <c:if
									test="${peticionHecha}"> en <b>${country}</b>
								</c:if></li>
							<li>La fecha de inicio es <b>${ viaje.fecha_inicio }</b> y
								de vuelta <b>${viaje.fecha_fin}</b></li>
							<li>El presupuesto del que dispones es de <b>${ viaje.presupuesto }
									€</b></li>
							<c:if test="${peticionHecha}">
								<li>La moneda en <b>${country}</b> es <b>${ currency }</b>
									con cambio al EUR de <b>${change}</b></li>
								<li>El tiempo actual en <b>${viaje.destino}</b> es <b>${ weather }</b></li>
							</c:if>
							<c:if test="${!peticionHecha}">
								<li>No se ha podido consultar información adicional</li>
							</c:if>
						</ul>
					</div>
				</div>
				<hr>
				<c:if test="${viaje.status > 2}">
					<c:if test="${viaje.status < 9}">
						<div class="row text-center">
							<h3 class="text-center">Añadir factura</h3>
							<form action="CreateFacturaServlet" enctype="multipart/form-data"
								method="post">
								<div class="form-group">
									<p>
									<div class="row center-block">
										<div class="col-md-6 col-md-offset-3">

											<div class="input-group">
												<div class="input-group-addon">
													<b>Cargo</b>
												</div>
												<input type="number" step="0.01" class="form-control"
													name="cargo" placeholder="Cantidad" required>
												<div class="input-group-addon">
													<select name="currency" placeholder="EUR">
														<option value="EUR">EUR</option>
														<c:if test="${currency != 'EUR'}">
															<option value="${ currency}">${ currency}</option>
														</c:if>
													</select>
												</div>
											</div>
										</div>
									</div>
									</p>
									<p>
									<div class="row center-block">
										<div class="col-md-6 col-md-offset-3">

											<div class="input-group">
												<div class="input-group-addon">
													<b>Comprobante</b>
												</div>
												<input type="file" class="form-control" name="comprobante"
													required>
											</div>
										</div>
									</div>
									</p>
									<p>
									<div class="row center-block">
										<div class="col-md-6 col-md-offset-3">

											<div class="input-group">
												<div class="input-group-addon">
													<b>Descripcion</b>
												</div>
												<input type="text" class="form-control" name="descripcion"
													placeholder="Su descripción" required> <input
													type="hidden" name="change" value="${change}"><input
													type="hidden" name="advisor4" value="${viaje.id}">
											</div>
										</div>
									</div>
									</p>
									<p>
										<button class="btn btn-success text-center" type="submit">
											<span class="glyphicon glyphicon-plus"></span> Añadir
										</button>
									</p>
								</div>
							</form>
						</div>
						<hr>
					</c:if>
					<h3 class="text-center">Listado de facturas</h3>
					<br>
					<c:choose>
						<c:when test="${fn:length(facturas_list) > 0}">
							<div class="progress">
								<div class="progress-bar progress-bar-success"
									role="progressbar" style="width: ${porcentajeAceptado}%">${porcentajeAceptado}%
									Aceptado</div>
								<div class="progress-bar progress-bar-danger" role="progressbar"
									style="width: ${porcentajeRechazado}%">${porcentajeRechazado}%
									Rechazado</div>
								<div class="progress-bar progress-bar-info" role="progressbar"
									style="width: ${porcentajeSolicitado}%">${porcentajeSolicitado}%
									Solicitado</div>
							</div>
							<br>
							<table class="table table-striped table-bordered">
								<tr>
									<th>Id</th>
									<th>Cargo (Total:${total}€)</th>
									<th>Comprobante</th>
									<th>Descripción</th>
									<th>Estado</th>

								</tr>
								<c:forEach items="${facturas_list}" var="facturai">
									<tr <c:if test="${facturai.estado == 4}">class="success"</c:if>
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
												test="${facturai.estado == 3}">En proceso</c:if> <c:if
												test="${facturai.estado == 4}">Aprobado</c:if></td>
									</tr>
								</c:forEach>

							</table>
							<div class="text-center">


								<form id="ReembolsoForm" action="Form3EmpleadoServlet"
									method="post">
									<input type="hidden" name="id" value="${viaje.id}" /> <input
										type="hidden" name="action" value="4" />
								</form>
								<form id="ReintegroForm" action="Form3EmpleadoServlet"
									method="post">
									<input type="hidden" name="id" value="${viaje.id}" /> <input
										type="hidden" name="action" value="9" />
								</form>
								<button form="ReembolsoForm" type="submit"
									class="btn btn-success"
									<c:if test="${viaje.status != 3 || total <= viaje.presupuesto*0.5}">disabled</c:if>>Solicitar
									reembolso</button>
								<button form="ReintegroForm" class="btn btn-success"
									type="submit" <c:if test="${viaje.status != 8}">disabled</c:if>>Solicitar
									reintegro</button>

								<p class="text-left">
									<br> <span class="glyphicon glyphicon-info-sign"></span>
									Solicitar el reembolso solo será posible antes de que el viaje
									comience y las facturas hayan superado el 50% del presupuesto,
									es decir, ${viaje.presupuesto*0.5 } €. Solicitar el reintegro
									solo será posible cuando el viaje sea finalizado.
								</p>
							</div>
						</c:when>
						<c:otherwise>
							<p class="text-center">No ha añadido ninguna factura aún</p>
						</c:otherwise>
					</c:choose>
			</div>
			</c:if>
			<br>
			<br>
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
