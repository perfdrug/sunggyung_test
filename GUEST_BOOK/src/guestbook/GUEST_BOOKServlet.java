package guestbook;

import java.io.IOException;
import javax.servlet.http.*;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

@SuppressWarnings("serial")
public class GUEST_BOOKServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		
		if (user != null) {
			resp.setContentType("text/html");
			resp.getWriter().println("Hello, world! " + user.getNickname() + "ÁÁ±¸³ª");
			resp.getWriter().println("<a href='http://localhost:8888" + userService.createLogoutURL(req.getRequestURI()) +"'>sign out</a>");
			
		} else {
			resp.sendRedirect(userService.createLoginURL(req.getRequestURI()));
		}
		 
		
		
	}
}
