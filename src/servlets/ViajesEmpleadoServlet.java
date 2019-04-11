package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;

import dao.EmpleadoDAO;
import dao.EmpleadoDAOImplementation;
import dao.ResponsableDAO;
import dao.ResponsableDAOImplementation;
import model.Responsable;


/**
 * Servlet implementation class ViajesEmpleadoServlet
 */
@WebServlet("/ViajesEmpleadoServlet")
public class ViajesEmpleadoServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = req.getParameter("email");
		EmpleadoDAO edao = EmpleadoDAOImplementation.getInstance();
		req.getSession().setAttribute("viajes_list", edao.read(email).getAdvisedViajes());

		Subject currentUser = SecurityUtils.getSubject();
		String emailResponsable = (String) currentUser.getPrincipal();
    	ResponsableDAO rdao = ResponsableDAOImplementation.getInstance();
		Responsable responsable = rdao.read(emailResponsable);
		req.getSession().setAttribute( "responsable", responsable);
		
		
		
		getServletContext().getRequestDispatcher("/ViajesEmpleadoView.jsp").forward(req, resp);
	}

}
