
package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.EmpleadoDAO;
import dao.EmpleadoDAOImplementation;
import dao.ResponsableDAO;
import dao.ResponsableDAOImplementation;
import dao.ViajeDAO;
import dao.ViajeDAOImplementation;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		EmpleadoDAO edao = EmpleadoDAOImplementation.getInstance();
		req.getSession().setAttribute( "empleado_list", edao.readAll() );
		ResponsableDAO rdao = ResponsableDAOImplementation.getInstance();
		req.getSession().setAttribute( "responsable_list", rdao.readAll() );
		ViajeDAO vdao = ViajeDAOImplementation.getInstance();
		req.getSession().setAttribute( "viaje_list", vdao.readAll() );
		
		getServletContext().getRequestDispatcher( "/AdminView.jsp" ).forward( req, resp );
	}
}
