
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
import model.Empleado;


/**
 * Servlet implementation class ViajesEmpleadoServlet
 */
@WebServlet("/ViajesEmpleadoResponsableServlet")
public class ViajesEmpleadoResponsableServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = req.getParameter("email");
		EmpleadoDAO edao = EmpleadoDAOImplementation.getInstance();
		req.getSession().setAttribute("empleadoName", edao.read(email).getName());
		req.getSession().setAttribute("viajes_list", edao.read(email).getAdvisedViajes());

		Subject currentUser = SecurityUtils.getSubject();
		String emailResponsable = (String) currentUser.getPrincipal();
		Empleado responsable = edao.read(emailResponsable);
		req.getSession().setAttribute( "responsable", responsable);
		
		
		
		getServletContext().getRequestDispatcher("/ViajesEmpleadoResponsableView.jsp").forward(req, resp);
	}

}

