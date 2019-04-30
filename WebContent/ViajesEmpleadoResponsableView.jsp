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
<title>Viajes de empleado View</title>
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
				<h3 class="text-center">Listado de viajes de empleado ${ empleadoName }</h3>
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>Id</th>
							<th>Destino</th>
							<th>Fecha de salida</th>
							<th>Fecha de regreso</th>
							<th>Estado del viaje</th>
							<th>Presupuesto</th>
							<th>Acción requerida</th>


						</tr>
					</thead>
					<tbody>
						<c:forEach items="${viajes_list}" var="viajei">
							<tr
								<c:if test="${viajei.status == 1 || viajei.status == 4 || viajei.status == 9}">class="warning"</c:if>
								<c:if test="${viajei.status > 2 && viajei.status < 12}">class="success"</c:if>
								<c:if test="${viajei.status == 2}">class="danger"</c:if>>
								<td>${viajei.id }</td>
								<td>${viajei.destino }</td>
								<td>${viajei.fecha_inicio }</td>
								<td>${viajei.fecha_fin }</td>
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

								<c:choose>
									<c:when test="${viajei.status == 1}">
										<td><form id="${viajei.id}aceptForm"
												action="Form2ResponsableServlet" method="post">
												<input class="form-control" type="number" name="presupuesto"
													value="${viajei.presupuesto}" /><input type="hidden"
													name="id" value="${viajei.id}" /> <input type="hidden"
													name="advisoremail" value="${viajei.advisor.email}" /> <input
													type="hidden" name="action" value="3" />
											</form>
											<form id="${viajei.id}denyForm"
												action="Form2ResponsableServlet" method="post">
												<input type="hidden" name="id" value="${viajei.id}" /> <input
													type="hidden" name="advisoremail"
													value="${viajei.advisor.email}" /> <input type="hidden"
													name="action" value="2" /><input type="hidden"
													name="presupuesto" value="${viajei.presupuesto}" />
											</form></td>

										<td>
											<button form="${viajei.id}aceptForm" type="submit"
												class="btn btn-success">
												<span class="glyphicon glyphicon-ok"></span>
											</button>
											<button form="${viajei.id}denyForm" type="submit"
												class="btn btn-danger">
												<span class="glyphicon glyphicon-remove"></span>
											</button>

										</td>
									</c:when>
									<c:when test="${viajei.status == 4 || viajei.status == 9}">
										<td>${viajei.presupuesto}
											<form id="${viajei.id}ReintegrarReembolsarForm"
												action="ReintegroReembolsoServlet" method="get">
												<input type="hidden" name="id" value="${viajei.id}" />
											</form>
										</td>
										<td><button form="${viajei.id}ReintegrarReembolsarForm"
												type="submit" class="btn btn-primary">
												<span class="glyphicon glyphicon-eur"></span>
												<c:if test="${viajei.status == 4}">
												Reembolsar
												</c:if>
												<c:if test="${viajei.status == 9}">
												Reintegrar
												</c:if>
											</button></td>
									</c:when>
									<c:otherwise>
										<td>${viajei.presupuesto}</td>
										<td></td>
									</c:otherwise>
								</c:choose>
							</tr>
						</c:forEach>
					</tbody>
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
