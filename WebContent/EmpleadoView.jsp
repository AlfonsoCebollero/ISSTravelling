<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Perfil empleado</title>
	</head>
	<body>
	<shiro:user>
    Welcome back <shiro:principal />! Click <a href="LogoutServlet">here</a> to logout.
	</shiro:user>
		<p>
			Tu Email: ${ empleado.email } <br>Tu nombre: ${ empleado.name }
		</p>
		<h3>Crear solicitud de viaje</h3>
		<form action="CreateViajeServlet" method="post">
			<p>
				Destino: <input type="text" name="destino" />
			</p>
			<p>
				Fecha de ida: <input type="date" name="ida" />
			</p>
			<p>
				Fecha de vuelta: <input type="date" name="vuelta" />
			</p>
			<p>
				Propón presupuesto: <input type="number" name="presupuesto" />
			</p>
			<p>
				<button type="submit">Solicitar Viaje</button>
			</p>
		</form>
		
		<h3>Listado de viajes</h3>
		<table border="1">
			<tr>
				<th>Identificador</th>
				<th>Destino</th>
				<th>Fecha de salida</th>
				<th>Fecha de regreso</th>
				<th>Presupuesto</th>
				<th>Estado del viaje</th>
				
			</tr>
			<c:forEach items="${vieajes_list}" var="viajei">
				<tr>
					<td>${viajei.id }</td>
					<td>${viajei.destino }</td>
					<td>${viajei.fecha_inicio }</td>
					<td>${viajei.fecha_fin }</td>
					<td>${viajei.presupuesto }</td>
					<td><c:if test="${viajei.status == 1}">Solicitado</c:if>
						<c:if test="${viajei.status == 2}">Aprobado</c:if>
						<c:if test="${viajei.status == 3}">En curso</c:if>
						<c:if test="${viajei.status == 4}">Finalizado</c:if>
				    </td>
				</tr>
			</c:forEach>
		</table>
	</body>
</html>