package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.apache.shiro.subject.Subject;

import dao.EmpleadoDAO;
import dao.EmpleadoDAOImplementation;
import mail.EmailHandler;
import model.Empleado;

/**
 * Servlet implementation class UpdateEmpleadoServlet
 */
@WebServlet("/UpdateEmpleadoServlet")
public class UpdateEmpleadoServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name = req.getParameter("name");
		String password = req.getParameter("password");
		String telefono = req.getParameter("telefono");
		
		Subject currentUser = SecurityUtils.getSubject();
		String email = (String) currentUser.getPrincipal();
		
		EmpleadoDAO edao = EmpleadoDAOImplementation.getInstance();
		Empleado empleado = edao.read(email);
		if(!name.equals("")) {
			empleado.setName(name);
		}if(!telefono.equals("")) {
			empleado.setTelefono(telefono);
		}if(!password.equals("")) {
			empleado.setPassword(new Sha256Hash(password).toString());
		}

		edao.update(empleado);

		resp.sendRedirect(req.getContextPath() + "/HomeEmpleadoServlet?email="+email);
	}

}
