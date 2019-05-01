package servlets;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import dao.FacturaDAO;
import dao.FacturaDAOImplementation;
import dao.ViajeDAO;
import dao.ViajeDAOImplementation;
import mail.EmailHandler;
import model.Factura;
import model.Viaje;

/**
 * Servlet implementation class CrearFacturaServlet
 */
@WebServlet("/CreateFacturaServlet")
@MultipartConfig
public class CreateFacturaServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Float cargo = Float.parseFloat(req.getParameter("cargo"));
		String descripcion = req.getParameter("descripcion");
		String currency = req.getParameter("currency");
		String advisor4 = req.getParameter("advisor4");
		
		if(!currency.equals("EUR")) {
			Float change = Float.parseFloat(req.getParameter("change"));
			cargo = cargo*change;
		}cargo = (float) (Math.floor(cargo*100)/100);
		
		Part filePart = (Part) req.getPart("comprobante");
		InputStream fileContent = (InputStream) filePart.getInputStream();
		ByteArrayOutputStream output = new ByteArrayOutputStream();
		byte[] buffer = new byte[10240];
		for (int length = 0; (length = fileContent.read(buffer)) > 0;) output.write(buffer, 0, length);
		
		ViajeDAO vdao = ViajeDAOImplementation.getInstance();
		Viaje viaje = vdao.read(Integer.parseInt(advisor4));
		
		Factura factura = new Factura();
		factura.setComprobante(output.toByteArray());
		factura.setCargo(cargo);
		factura.setDescripcion(descripcion);
		factura.setAdvisor4(viaje);
		factura.setEstado(1);
		
		EmailHandler emailhandler = EmailHandler.getInstance();
		emailhandler.sendEmail(viaje.getAdvisor().getEmail(),"Subida de factura","Se ha subido una factura relacionada al viaje con id "+advisor4);

		FacturaDAO fdao = FacturaDAOImplementation.getInstance();
		fdao.create(factura);
		

		resp.sendRedirect(req.getContextPath() + "/EmpleadoViajeServlet?id="+Integer.parseInt(advisor4));
	}

}
