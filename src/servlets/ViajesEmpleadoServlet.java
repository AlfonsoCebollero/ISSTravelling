
package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.EmpleadoDAO;
import dao.EmpleadoDAOImplementation;

import model.Empleado;

@WebServlet("/ViajesEmpleadoServlet")
public class ViajesEmpleadoServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = req.getParameter( "email" );
		
		EmpleadoDAO edao = EmpleadoDAOImplementation.getInstance();
		Empleado empleado = edao.read(email);
		
		req.getSession().setAttribute("viajes", empleado.getAdvisedViajes());
		
		getServletContext().getRequestDispatcher( "/ViajesEmpleadoView.jsp" ).forward( req, resp );
	}
}