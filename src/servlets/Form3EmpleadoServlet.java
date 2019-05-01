package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;

import dao.ViajeDAO;
import dao.ViajeDAOImplementation;
import mail.EmailHandler;
import model.Viaje;

/**
 * Servlet implementation class Form2ResponsableServlet
 */
@WebServlet("/Form3EmpleadoServlet")
public class Form3EmpleadoServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter("id");
		int action = Integer.parseInt(req.getParameter("action"));

		ViajeDAO vdao = ViajeDAOImplementation.getInstance();
		Viaje viaje = vdao.read(Integer.parseInt(id));
		
		if (action == viaje.getStatus() + 1) {
			viaje.setStatus(action);
			vdao.update(viaje);
		}
		EmailHandler emailhandler = EmailHandler.getInstance();
		Subject currentUser = SecurityUtils.getSubject();
		String emailEmpleado = (String) currentUser.getPrincipal();
		
		if (action == 4 || action == 9) {
			
	
			emailhandler.sendEmail(emailEmpleado,"Cambio de estado de su viaje","Su viaje con id " + id + " ha cambiado de estado.");

			resp.sendRedirect(req.getContextPath() + "/EmpleadoViajeServlet?email=" + emailEmpleado + "&id=" + id);
		}
		else if (action == 5 || action == 10) {

			emailhandler.sendEmail(emailEmpleado,"Cambio de estado de su viaje","Su viaje con id " + id + " ha cambiado de estado.");
			
			resp.sendRedirect(req.getContextPath() + "/ViajesEmpleadoResponsableServlet?email=" + viaje.getAdvisor().getEmail());
		}else {
			resp.sendRedirect(req.getContextPath() + "/AdminServlet");
		}
	}

}