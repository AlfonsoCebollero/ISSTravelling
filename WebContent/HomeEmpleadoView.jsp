<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon"
	href="https://image.flaticon.com/icons/svg/201/201623.svg"
	type="image/svg+xml" />
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
	integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu"
	crossorigin="anonymous">
<meta charset="ISO-8859-1">
<title>Perfil empleado</title>
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
								<li class="active"><a
									href="/ISST2019/HomeEmpleadoServlet?email=${empleado.email }"><span
										class="glyphicon glyphicon-home"></span> Home</a></li>
								<li><a
									href="/ISST2019/EmpleadoServlet?email=${empleado.email }"><span
										class="glyphicon glyphicon-globe"></span> Tus Viajes</a></li>
								<li><a
									href="/ISST2019/ResponsableServlet?email=${empleado.email }"><span
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
			<div class="row ">
				<br>
				<h2 class="text-center tit">
					Tu perfil
					</h3>
					<br>
					<div id="perfil" class="col-md-4 col-md-offset-4 rounded bg">
						<div class="row">
							<img id="change-image" class="image"
								src="https://mobirise.com/bootstrap-template/profile-template/assets/images/timothy-paul-smith-256424-1200x800.jpg"
								alt="tu foto" height="100%" width="100%">
						</div>
						<div class="row bod">
							<dl class="dl-horizontal">
								<dt>Descripción</dt>
								<dd>Tu nombre es ${ empleado.name}, tu cuenta de correo
									electrónico es ${ empleado.email} y tu número de teléfono es
									${empleado.telefono}.</dd>
								<dt>Viajes activos</dt>
								<dd>${fn:length(empleado.advisedViajes) } viajes.</dd>
								<dt>Empleados a tu cargo</dt>
								<dd>${tusempleados } empleados.</dd>
							</dl>
						</div>
					</div>
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
.bg {
	background-color: #000;
	border-radius: 8px;
	box-shadow: 5px 5px 5px grey;
}

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

.image {
	margin: 0%;
	border-radius: 8px 8px 0px 0px;
	cursor: pointer;
}

.bod {
	padding: 5%;
	color: white;
}

.tit {
	font-size: 300%;
	text-shadow: 0px 0px 0px black;
}
</style>
<script>
	$("#perfil")
			.hover(
					function() {
						$('#change-image').attr('src','https://image.flaticon.com/icons/svg/660/660756.svg');
						$('#change-image').attr('height','200px');
						$('#change-image').css('margin-top', '10%');
						$('#change-image').css('margin-bottom', '5%');
					},
					function() {
						$('#change-image').attr('src','https://mobirise.com/bootstrap-template/profile-template/assets/images/timothy-paul-smith-256424-1200x800.jpg');
						$('#change-image').attr('height','100%');
						$('#change-image').css('margin', '0%');
					});
</script>
