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
<hr>
	<h2>Vista de administrador</h2>
	<shiro:lacksRole name="admin">
	No tienes permiso para ver el contenido de esta página
</shiro:lacksRole>
	<shiro:hasRole name="admin">
		<h3>Crear empleado nuevo</h3>
		<form action="CreateEmpleadoServlet" method="post">
			<p>
				Nombre: <input type="text" name="name" required/>
			</p>
			<p>
				Email: <input type="text" name="email" required/>
			</p>
			<p>
				Telefono: <input type="text" name="telefono" required/>
			</p>
			<p>
				Password: <input type="password" name="password" required/>
			</p>
			<p>
				Responsable: <select name="advisor2">
					<option value="" disabled selected>Elija un responsable</option>
					<c:forEach items="${responsable_list}" var="responsablei">
						<option value="${ responsablei.email}">
							${responsablei.name}-${responsablei.email}</option>
					</c:forEach>
				</select>
			</p>
			<p>
				<button type="submit">Crear Empleado</button>
			</p>
		</form>
				<h3>Crear responsable nuevo</h3>
		<form action="CreateResponsableServlet" method="post">
			<p>
				Nombre: <input type="text" name="name" required/>
			</p>
			<p>
				Email: <input type="text" name="email" required/>
			</p>
			<p>
				Password: <input type="password" name="password" required/>
			</p>
			<p>
				Que empleado es: <select name="advisor3" required>
					<option value="" disabled selected>Elija un empleado</option>
					<c:forEach items="${empleado_list}" var="empleadoi">
						<option value="${ empleadoi.email}">
							${empleadoi.name}-${empleadoi.email}</option>
					</c:forEach>
				</select>
			</p>
			<p>
				<button type="submit">Crear Responsable</button>
			</p>
		</form>
		
		<h3>Listado de Empleados</h3>
		<table border="1">
			<tr>
				<th>Nombre</th>
				<th>Email</th>
				<th>Viajes</th>
			</tr>
			<c:forEach items="${empleado_list}" var="emp">
				<tr>
					<td>${emp.name }</td>
					<td>${emp.email }</td>
					<td>${fn:length(emp.advisedViajes) }</td>
				</tr>
			</c:forEach>
		</table>
		<h3>Listado de Responsables</h3>
		<table border="1">
			<tr>
				<th>Nombre</th>
				<th>Email</th>
				<th>Empleados</th>
			</tr>
			<c:forEach items="${responsable_list}" var="resp">
				<tr>
					<td>${resp.name }</td>
					<td>${resp.email }</td>
					<td>${fn:length(resp.advisedEmpleados) }</td>
				</tr>
			</c:forEach>
		</table>
		
	</shiro:hasRole>
</body>
</html>