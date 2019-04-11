<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Perfil responsable</title>
	</head>
	<body>
	<shiro:user>
    Welcome back <shiro:principal />! Click <a href="LogoutServlet">here</a> to logout.
	</shiro:user>
		<p>
			Tu Email: ${ responsable.email } <br>Tu nombre: ${ responsable.name }
		</p>
		<h3>Listado de empleados a su cargo</h3>
		<table border="1">
			<tr>
				<th>Nombre</th>
				<th>Email</th>
				<th>Viajes del Empleado</th>
				
			</tr>
			<c:forEach items="${empleado_list}" var="empleadoi">
				<tr>
					<td>${empleadoi.name }</td>
					<td>${empleadoi.email }</td>
					<td><a href="/ISST2019/ViajesEmpleadoServlet?email=${empleadoi.email }" > ${fn:length(empleadoi.advisedViajes) }</a></td>
				</tr>
			</c:forEach>
		</table>
	</body>
</html>