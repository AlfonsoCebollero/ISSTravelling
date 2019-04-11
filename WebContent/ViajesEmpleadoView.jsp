<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Viajes de empleado View</title>
</head>
<body>
	<shiro:user>
    Welcome back <shiro:principal />! Click <a href="LogoutServlet">here</a> to logout.
</shiro:user>
	<p>
		Tu Email: ${ responsable.email } <br>Tu nombre: ${ responsable.name }
	</p>
	<h3>Listado de viajes</h3>
	<table border="1">
		<tr>
			<th>Identificador</th>
			<th>Destino</th>
			<th>Fecha de salida</th>
			<th>Fecha de regreso</th>
			<th>Estado del viaje</th>
			<th>Presupuesto</th>
			<th>Acción requerida</th>


		</tr>
		<c:forEach items="${viajes_list}" var="viajei">
			<tr>
				<td>${viajei.id }</td>
				<td>${viajei.destino }</td>
				<td>${viajei.fecha_inicio }</td>
				<td>${viajei.fecha_fin }</td>
				<td><c:if test="${viajei.status == 1}">Solicitado</c:if> <c:if
						test="${viajei.status == 2}">Aprobado</c:if> <c:if
						test="${viajei.status == 3}">En curso</c:if> <c:if
						test="${viajei.status == 4}">Finalizado</c:if></td>
				<c:if test="${viajei.status == 1}">
					<form action="Form2ResponsableServlet" method="post">
					<td><input type="number" name="presupuesto" value="${viajei.presupuesto}" /></td>
					<td><input type="hidden" name="id" value="${viajei.id}" /> <input
						type="hidden" name="advisoremail" value="${viajei.advisor.email}" />
						<button type="submit">Aceptar viaje</button></td>
					</form>
				</c:if>
				<c:if test="${viajei.status != 1}">
					<td>${viajei.presupuesto}</td>
				</c:if>
			</tr>
		</c:forEach>
	</table>
</body>
</html>
