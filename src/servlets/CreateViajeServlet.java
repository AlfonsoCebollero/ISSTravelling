package servlets;

import dao.EmpleadoDAO;
import dao.EmpleadoDAOImplementation;
import dao.ViajeDAO;
import dao.ViajeDAOImplementation;
import mail.EmailHandler;
import model.Empleado;
import model.Viaje;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;

@WebServlet("/CreateViajeServlet")
public class CreateViajeServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String destino = req.getParameter("destino");
		String ida = req.getParameter("ida");
		String vuelta = req.getParameter("vuelta");
		String presupuesto = req.getParameter("presupuesto");
		Subject currentUser = SecurityUtils.getSubject();
		String emailAdvisor = (String) currentUser.getPrincipal();

		Date dateIda = null;
		Date dateVuelta = null;
		try {
			dateIda = new SimpleDateFormat("yyyy-MM-dd").parse(ida);
			dateVuelta = new SimpleDateFormat("yyyy-MM-dd").parse(vuelta);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if (dateVuelta.before(dateIda)) {
			System.out.println("fecha de vuelta anterior a la de ida");
		} else {
			Viaje viaje = new Viaje();
			viaje.setDestino(destino);
			viaje.setFecha_inicio(new java.sql.Date(dateIda.getTime()));
			viaje.setFecha_fin(new java.sql.Date(dateVuelta.getTime()));
			viaje.setPresupuesto(Integer.parseInt(presupuesto));
			viaje.setStatus(1);

			EmpleadoDAO edao = EmpleadoDAOImplementation.getInstance();
			Empleado advisor = edao.read(emailAdvisor);
			viaje.setAdvisor(advisor);

			ViajeDAO vdao = ViajeDAOImplementation.getInstance();
			vdao.create(viaje);
			EmailHandler emailhandler = EmailHandler.getInstance();
			emailhandler.sendEmail(emailAdvisor, "Creacion de viaje", "Ha solicitado exitosamente un viaje con id "
					+ viaje.getId() + " y destino a " + viaje.getDestino() + ".");
			emailhandler.sendEmail(advisor.getAdvisor2().getEmail(), "Solicitud de viaje",
					"Tu empleado con email " + emailAdvisor + " ha solicitado un viaje con id "
							+ viaje.getId() + " y destino a " + viaje.getDestino() + ", debe aceptarlo o rechazarlo lo antes posible.");
		}

		resp.sendRedirect(req.getContextPath() + "/EmpleadoServlet?email=" + emailAdvisor);

	}
}
