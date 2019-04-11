package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.EmpleadoDAO;
import dao.EmpleadoDAOImplementation;
import dao.ViajeDAO;
import dao.ViajeDAOImplementation;
import model.Empleado;

/**
 * Servlet implementation class ProfessorServlet
 */
@WebServlet("/EmpleadoServlet")
public class EmpleadoServlet extends HttpServlet {
		   
	    @Override
		protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    	String email = req.getParameter( "email" );
	    	EmpleadoDAO edao = EmpleadoDAOImplementation.getInstance();
			Empleado empleado = edao.read(email);
			req.getSession().setAttribute( "empleado", empleado);
			req.getSession().setAttribute( "vieajes_list", empleado.getAdvisedViajes());
			getServletContext().getRequestDispatcher( "/EmpleadoView.jsp" ).forward( req, resp );	
		}

}
