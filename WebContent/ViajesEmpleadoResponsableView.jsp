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
		<shiro:user>
    Welcome back <shiro:principal />! Click <a href="LogoutServlet">here</a> to logout.
		</shiro:user>
		<shiro:lacksRole name="empleado">
	No tienes permiso para ver el contenido de esta página 
		</shiro:lacksRole>
		<shiro:hasRole name="empleado">
			<div class="jumbotron text-center">
				<h1>Resposable</h1>
				<p>
					Tu Email: ${ responsable.email } <br>Tu nombre: ${ responsable.name }
				</p>
			</div>
			<div class="row well">
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
</body>
</html>
