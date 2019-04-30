package servlets;

import java.io.IOException;
import java.util.Collection;

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
import soa.Query;
import model.Empleado;
import model.Factura;
import model.Viaje;

/**
 * Servlet implementation class EmpleadoViajeServlet
 */
@WebServlet("/EmpleadoViajeServlet")
public class EmpleadoViajeServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter("id");
		ViajeDAO vdao = ViajeDAOImplementation.getInstance();
		Viaje viaje = vdao.read(Integer.parseInt(id));
		req.getSession().setAttribute("viaje", viaje);
		Collection<Factura> facturas = viaje.getAdvisedFacturas();
		req.getSession().setAttribute("facturas_list", facturas);

		float total = 0.0f;
		int Aceptadas = 0;
		int Rechazadas = 0;
		int cantidad = facturas.size();
		if (cantidad != 0) {
			for (Factura factura : facturas) {
				if (factura.getEstado() == 2) {
					Rechazadas++;
				} else if (factura.getEstado() == 4) {
					Aceptadas++;
				}
				total += factura.getCargo();
			}
			req.getSession().setAttribute("porcentajeAceptado", (int) Aceptadas * 100 / cantidad);
			req.getSession().setAttribute("porcentajeRechazado", (int) Math.ceil(Rechazadas * 100 / (float) cantidad));
			req.getSession().setAttribute("porcentajeSolicitado",
					(int) Math.floor(100.0f -  Aceptadas * 100.0f / (float) cantidad - Rechazadas * 100.0f / (float) cantidad));
			total = (float) (Math.floor(total * 100) / 100);
			req.getSession().setAttribute("total", total);
		}

		Subject currentUser = SecurityUtils.getSubject();
		String emailEmpleado = (String) currentUser.getPrincipal();
		EmpleadoDAO edao = EmpleadoDAOImplementation.getInstance();
		Empleado empleado = edao.read(emailEmpleado);
		req.getSession().setAttribute("empleado", empleado);

		String[] Country = Query.GetCountryAndWeather(viaje.getDestino());
		if(Country[2] != "404") {
			String[] info = Query.GetNameAndCurrency(Country[0]);
			float cambio = Query.GetChange(info[1]);
			req.getSession().setAttribute("peticionHecha", true);
			req.getSession().setAttribute("country", info[0]);
			req.getSession().setAttribute("weather", Country[1]);
			req.getSession().setAttribute("currency", info[1]);
			req.getSession().setAttribute("change", cambio);
		}else {
			req.getSession().setAttribute("peticionHecha", false);
			req.getSession().setAttribute("currency", "EUR");
		}

		getServletContext().getRequestDispatcher("/EmpleadoViajeView.jsp").forward(req, resp);
	}

}
