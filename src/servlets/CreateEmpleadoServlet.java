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
import model.Empleado;
import mail.EmailHandler;

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
		EmpleadoDAO edao = EmpleadoDAOImplementation.getInstance();
		Empleado responsable = edao.read(advisor2);
		Empleado empleado = new Empleado();
		empleado.setName(name);
		empleado.setEmail(email);
		empleado.setTelefono(telefono);
		empleado.setAdvisor2(responsable);
		empleado.setPassword(new Sha256Hash(password).toString());
		
		EmailHandler emailhandler = EmailHandler.getInstance();
		emailhandler.sendEmail(email,"Alta de empleado","Se le ha dado de alta como empleado en la plataforma.");

		edao.create(empleado);

		resp.sendRedirect(req.getContextPath() + "/AdminServlet");
	}

}
