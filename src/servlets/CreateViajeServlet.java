package servlets;


import dao.EmpleadoDAO;
import dao.EmpleadoDAOImplementation;
import dao.ViajeDAO;
import dao.ViajeDAOImplementation;
import model.Empleado;
import model.Viaje;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CreateViajeServlet")
public class CreateViajeServlet extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		
		String destino = req.getParameter( "destino" );
		String ida = req.getParameter( "ida" );
		String vuelta = req.getParameter( "vuelta" );
		String presupuesto = req.getParameter( "presupuesto" );
		String emailAdvisor = req.getParameter( "email" );
				
		Viaje viaje = new Viaje();
		viaje.setDestino( destino );
		viaje.setFecha_inicio( ida );
		viaje.setFecha_fin( vuelta );
		viaje.setPresupuesto( Integer.parseInt(presupuesto) );
		viaje.setStatus( 1 );
		
		Empleado advisor = new Empleado();
		EmpleadoDAO edao = EmpleadoDAOImplementation.getInstance();
		advisor = edao.read(emailAdvisor);
		viaje.setAdvisor(advisor);
		
		ViajeDAO vdao = ViajeDAOImplementation.getInstance();
		vdao.create( viaje );
		
		resp.sendRedirect(req.getContextPath() + "/EmpleadoServlet?email="+emailAdvisor);
		
	}
}
