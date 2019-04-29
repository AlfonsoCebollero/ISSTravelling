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
import dao.ViajeDAO;
import dao.ViajeDAOImplementation;
import model.Empleado;
import model.Viaje;


/**
 * Servlet implementation class Form2ResponsableServlet
 */
@WebServlet("/Form3EmpleadoServlet")
public class Form3EmpleadoServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter( "id" );
		String email = req.getParameter( "advisoremail" );
		String action = req.getParameter( "action" );
		
		ViajeDAO vdao = ViajeDAOImplementation.getInstance();
		Viaje viaje = vdao.read(Integer.parseInt(id));

		Subject currentUser = SecurityUtils.getSubject();
		String emailEmpleado = (String) currentUser.getPrincipal();
		EmpleadoDAO edao = EmpleadoDAOImplementation.getInstance();
		Empleado empleado = edao.read(emailEmpleado);
				
		viaje.setStatus(Integer.parseInt(action));
		vdao.update(viaje);
		
		resp.sendRedirect( req.getContextPath() + "/EmpleadoViajeServlet?email=" + emailEmpleado +"&id=" + id );
	}

}