package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.crypto.hash.Sha256Hash;

import dao.EmpleadoDAO;
import dao.EmpleadoDAOImplementation;
import dao.ResponsableDAO;
import dao.ResponsableDAOImplementation;
import model.Empleado;
import model.Responsable;

/**
 * Servlet implementation class CreateResponsableServlet
 */
@WebServlet("/CreateResponsableServlet")
public class CreateResponsableServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name = req.getParameter("name");
		String password = req.getParameter("password");
		String email = req.getParameter("email");
		String advisor3 = req.getParameter( "advisor3" );

		EmpleadoDAO edao = EmpleadoDAOImplementation.getInstance();
		boolean exists = edao.exists(email);
		if (!exists) {
			Empleado empleado = edao.read(advisor3);
			
			Responsable responsable = new Responsable();
			responsable.setName(name);
			responsable.setEmail(email);
			responsable.setAdvisor3(empleado);

			responsable.setPassword(new Sha256Hash(password).toString());

			ResponsableDAO rdao = ResponsableDAOImplementation.getInstance();
			rdao.create(responsable);
		}
		else {
			System.out.println("Ya existe un empleado con este email");
		}

		resp.sendRedirect(req.getContextPath() + "/AdminServlet");
	}

}
