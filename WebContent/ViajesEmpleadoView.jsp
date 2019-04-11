<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin View</title>
</head>
<body>
<shiro:user>
    Welcome back <shiro:principal />! Click <a href="LogoutServlet">here</a> to logout.
</shiro:user>

<h3>Listado de viajes</h3>
		<table border="1">
			<tr>
				<th>Destino</th>
				<th>Inicio</th>
				<th>Fin</th>
				<th>Presupuesto</th>
				<th>Estado</th>
				
			</tr>
			<c:forEach items="${viajes}" var="viajei">
				<tr>
					<td>${viajei.destino }</td>
					<td>${viajei.fecha_inicio}</td>
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