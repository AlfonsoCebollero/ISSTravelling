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
import model.Viaje;


/**
 * Servlet implementation class Form2ResponsableServlet
 */
@WebServlet("/Form2ResponsableServlet")
public class Form2ResponsableServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter( "id" );
		String email = req.getParameter( "advisoremail" );
		String presupuesto = req.getParameter( "presupuesto" );
		String action = req.getParameter( "action" );
		ViajeDAO vdao = ViajeDAOImplementation.getInstance();
		Viaje viaje = vdao.read(Integer.parseInt(id));
		
		viaje.setPresupuesto(Integer.parseInt(presupuesto));
		viaje.setStatus(Integer.parseInt(action));
		vdao.update(viaje);
		
		resp.sendRedirect( req.getContextPath() + "/ViajesEmpleadoResponsableServlet?email=" + email  );
	}

}
