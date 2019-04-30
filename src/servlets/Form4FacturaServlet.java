package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;

import dao.FacturaDAO;
import dao.FacturaDAOImplementation;
import dao.ViajeDAO;
import dao.ViajeDAOImplementation;
import model.Factura;
import model.Viaje;

/**
 * Servlet implementation class Form4FacturaServlet
 */
@WebServlet("/Form4FacturaServlet")
public class Form4FacturaServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter("id");
		String viajeId = req.getParameter("viajeId");
		int action = Integer.parseInt(req.getParameter("action"));

		FacturaDAO fdao = FacturaDAOImplementation.getInstance();
		Factura factura = fdao.read(Integer.parseInt(id));
		
		ViajeDAO vdao = ViajeDAOImplementation.getInstance();
		Viaje viaje = vdao.read(Integer.parseInt(viajeId));

		if (viaje.getStatus()%5 == 0 && action != 0) {
			action++;
		}
		factura.setEstado(2 + action);
		fdao.update(factura);
		
		resp.sendRedirect(req.getContextPath() + "/ReintegroReembolsoServlet?id=" + viajeId);
	}

}
