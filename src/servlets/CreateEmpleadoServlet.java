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
 * Servlet implementation class CreateEmpleadoServlet
 */
@WebServlet("/CreateEmpleadoServlet")
public class CreateEmpleadoServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name = req.getParameter("name");
		String password = req.getParameter("password");
		String email = req.getParameter("email");
		String telefono = req.getParameter("telefono");
		String advisor2 = req.getParameter("advisor2");
		ResponsableDAO rdao = ResponsableDAOImplementation.getInstance();
		boolean existe = rdao.exists(email);
		if (!existe) {
			Responsable responsable = rdao.read(advisor2);
			Empleado empleado = new Empleado();
			empleado.setName(name);
			empleado.setEmail(email);
			empleado.setTelefono(telefono);
			empleado.setAdvisor2(responsable);
			empleado.setPassword(new Sha256Hash(password).toString());

			EmpleadoDAO edao = EmpleadoDAOImplementation.getInstance();
			edao.create(empleado);
		} else {
			System.out.println("Ya existe un responsable con este email");
		}

		resp.sendRedirect(req.getContextPath() + "/AdminServlet");
	}

}
