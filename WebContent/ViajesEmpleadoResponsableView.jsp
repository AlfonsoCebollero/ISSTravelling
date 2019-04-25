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
									href="/ISST2019/HomeEmpleadoServlet?email=${responsable.email }">Home</a></li>
								<li><a
									href="/ISST2019/EmpleadoServlet?email=${responsable.email }">Tus
										Viajes</a></li>
								<li class="active"><a
									href="/ISST2019/ResponsableServlet?email=${responsable.email }">Tus
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
				<h3 class="text-center">Listado de viajes de empleado ${ empleadoName }</h3>
				<table class="table table-bordered table-hover">
					<tr>
						<th>Id</th>
						<th>Destino</th>
						<th>Fecha de salida</th>
						<th>Fecha de regreso</th>
						<th>Estado del viaje</th>
						<th>Presupuesto</th>
						<th>Acción requerida</th>


					</tr>
					<c:forEach items="${viajes_list}" var="viajei">
						<tr
							<c:if test="${viajei.status == 2 || viajei.status == 3}">class="success"</c:if>
							<c:if test="${viajei.status == 5}">class="danger"</c:if>
							<c:if test="${viajei.status == 1}">class="warning"</c:if>>
							<td>${viajei.id }</td>
							<td>${viajei.destino }</td>
							<td>${viajei.fecha_inicio }</td>
							<td>${viajei.fecha_fin }</td>
							<td><c:if test="${viajei.status == 1}">Solicitado</c:if> <c:if
									test="${viajei.status == 2}">Aprobado</c:if> <c:if
									test="${viajei.status == 3}">En curso</c:if> <c:if
									test="${viajei.status == 4}">Finalizado</c:if> <c:if
									test="${viajei.status == 5}">Rechazado</c:if></td>
							<c:if test="${viajei.status == 1}">
								<form action="Form2ResponsableServlet" method="post">
									<td><input class="form-control" type="number"
										name="presupuesto" value="${viajei.presupuesto}" /></td>
									<td><input type="hidden" name="id" value="${viajei.id}" />
										<input type="hidden" name="advisoremail"
										value="${viajei.advisor.email}" /> <input type="hidden"
										name="action" value="2" />
										<button type="submit" class="btn btn-success">Aceptar
											viaje</button>
								</form>
								<form action="Form2ResponsableServlet" method="post">
									<input type="hidden" name="id" value="${viajei.id}" /> <input
										type="hidden" name="advisoremail"
										value="${viajei.advisor.email}" /> <input type="hidden"
										name="action" value="5" /><input type="hidden"
										name="presupuesto" value="${viajei.presupuesto}" />
									<button type="submit" class="btn btn-danger">Rechazar
										viaje</button>
								</form>
								</td>
							</c:if>
							<c:if test="${viajei.status != 1}">
								<td>${viajei.presupuesto}</td>
								<td></td>
							</c:if>
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
