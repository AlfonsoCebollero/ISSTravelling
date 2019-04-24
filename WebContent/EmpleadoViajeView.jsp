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
				<div class="row">
					<h3 class="text-center">Descripción de viaje con id ${ viaje.id }</h3>
					<br>
					<div class=" col-md-offset-3">
						<ul>
							<li>El estado del viaje es <b><c:if
										test="${viaje.status == 1}">Solicitado</c:if> <c:if
										test="${viaje.status == 2}">Aprobado</c:if> <c:if
										test="${viaje.status == 3}">En curso</c:if> <c:if
										test="${viaje.status == 4}">Finalizado</c:if> <c:if
										test="${viaje.status == 5}">Rechazado</c:if></b></li>
							<li>El destino del viaje es <b>${ viaje.destino }</b> en <b>${country}</b></li>
							<li>La fecha de inicio es <b>${ viaje.fecha_inicio }</b> y
								de vuelta <b>${viaje.fecha_fin}</b></li>
							<li>La moneda en <b>${country}</b> es <b>${ currency }</b>
								con cambio al EUR de <b>${change}</b></li>
							<li>El tiempo actual en <b>${viaje.destino}</b> es <b>${ weather }</b></li>
						</ul>
					</div>
				</div>
				<hr>
				<c:if test="${viaje.status >= 2 && viaje.status <= 4 }">
					<div class="row text-center">
						<h3 class="text-center">Añadir factura</h3>
						<form action="CreateFacturaServlet" method="post">
							<div class="form-group">
								<p>
								<div class="row center-block">
									<div class="col-md-6 col-md-offset-3">

										<div class="input-group">
											<div class="input-group-addon">
												<b>Cargo</b>
											</div>
											<input type="number" step="0.01" class="form-control" name="cargo"
												placeholder="Cantidad" required>
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
												type="hidden" name="change" value="${change}">
										</div>
									</div>
								</div>
								</p>
								<p>
									<button class="btn btn-success text-center" type="submit">Añadir</button>
								</p>
							</div>
						</form>
					</div>
					<hr>
					<h3 class="text-center">Listado de facturas</h3>
					<table class="table table-striped table-bordered">
						<tr>
							<th>Id</th>
							<th>Cargo</th>
							<th>Comprobante</th>
							<th>Descripción</th>
							<th>Estado</th>

						</tr>
						<c:forEach items="${facturas_list}" var="facturai">
							<tr <c:if test="${facturai.status == 2}">class="success"</c:if>
								<c:if test="${viajei.status == 5}">class="danger"</c:if>>

								<td>${facturai.id }</td>
								<td>${facturai.cargo }</td>
								<td>${facturai.comprobante }</td>
								<td>${facturai.descripcion }</td>
								<td><c:if test="${facturai.status == 1}">Solicitado</c:if>
									<c:if test="${facturai.status == 2}">Aprobado</c:if> <c:if
										test="${facturai.status == 3}">Rechazado</c:if></td>
							</tr>
						</c:forEach>

					</table>
					<div class="text-center">
						<p>

							<button class="btn btn-success" name="reembolso"
								value="reembolso" type="submit" <c:if test="${facturai.status == 2}">disabled</c:if> >Solicitar reembolso</button>

							<button class="btn btn-success" name="reembolso"
								value="reembolso" type="button" <c:if test="${facturai.status != 2}">disabled</c:if> >Solicitar reintegro</button>
						</form>
						</p>

					</div>
				</c:if>
			</div>
		</shiro:hasRole>
	</div>
</body>
</html>