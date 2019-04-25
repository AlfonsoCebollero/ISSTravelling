package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import dao.FacturaDAO;
import dao.FacturaDAOImplementation;
import model.Factura;

/**
 * Servlet implementation class DownloadFileServlet
 */
@WebServlet("/DownloadFileServlet")
public class DownloadFileServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter("id");
		FacturaDAO fdao = FacturaDAOImplementation.getInstance();
		Factura factura = fdao.read(Integer.parseInt(id));
		
		resp.setContentLength(factura.getComprobante().length);
		resp.getOutputStream().write(factura.getComprobante());
		
	}

}
