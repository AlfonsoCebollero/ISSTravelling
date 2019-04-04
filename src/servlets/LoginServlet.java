package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;

import dao.EmpleadoDAO;
import dao.EmpleadoDAOImplementation;
import dao.ResponsableDAO;
import dao.ResponsableDAOImplementation;


@WebServlet({ "/LoginServlet", "/" })
public class LoginServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ResponsableDAO rdao = ResponsableDAOImplementation.getInstance();
		req.getSession().setAttribute( "responsable_list", rdao.readAll() );
		getServletContext().getRequestDispatcher( "/LoginView.jsp" ).forward( req, resp );
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = req.getParameter( "email" );
		String pass = req.getParameter( "password" );
		Subject currentUser = SecurityUtils.getSubject();
		if ( !currentUser.isAuthenticated() ) {
			UsernamePasswordToken token = new UsernamePasswordToken( email, pass );
			try {
				currentUser.login( token );
				if ( currentUser.hasRole( "admin" ) ) {
					System.out.println("admin");
					resp.sendRedirect( req.getContextPath() + "/AdminServlet" );
				}
				else if ( currentUser.hasRole( "empleado" ) ) {
					System.out.println("empleado");
					resp.sendRedirect( req.getContextPath() + "/EmpleadoServlet?email=" + currentUser.getPrincipal() );
				}
				else if ( currentUser.hasRole( "responsable" ) ) {
					System.out.println("responsable");
					resp.sendRedirect( req.getContextPath() + "/ResponsableServlet?email=" + currentUser.getPrincipal() );
				}
				else {
					System.out.println("no rol");
					resp.sendRedirect( req.getContextPath() + "/LoginServlet" );
				}
			} catch ( Exception e ) {
				System.out.println("excep");
				System.out.println(e);
				resp.sendRedirect( req.getContextPath() + "/LoginServlet" );
			}
		} else {
			resp.sendRedirect( req.getContextPath() + "/LoginServlet" );
		}
	}
}
