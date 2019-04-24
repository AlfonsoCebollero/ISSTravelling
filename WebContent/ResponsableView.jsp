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
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>

<meta charset="ISO-8859-1">
<title>Perfil responsable</title>
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
				<h1>Responsable</h1>
				<p>
					Tu Email: ${ responsable.email } <br>Tu nombre: ${ responsable.name }
				</p>
			</div>
			<div class="row well">
				<h3 class="text-center">Listado de empleados a su cargo</h3>
				<table class="table table-hover table-bordered">
					<tr>
						<th>Nombre</th>
						<th>Email</th>
						<th>Viajes del Empleado</th>

					</tr>
					<c:forEach items="${empleado_list}" var="empleadoi">
						<tr class=" warning clickable-row"
							data-href="/ISST2019/ViajesEmpleadoResponsableServlet?email=${empleadoi.email }">
							<td>${empleadoi.name }</td>
							<td>${empleadoi.email }</td>
							<td>${fn:length(empleadoi.advisedViajes) }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</shiro:hasRole>
	</div>
</body>
</html>
<style>
.clickable-row {
	cursor: pointer;
}
</style>
<script>
	$(document).ready(function($) {
		$(".clickable-row").click(function() {
			window.document.location = $(this).data("href");
		});
	});
</script>