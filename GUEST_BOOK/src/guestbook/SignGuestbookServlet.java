package guestbook;

import java.io.IOException;
import java.util.logging.Logger;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

@SuppressWarnings("serial")
public class SignGuestbookServlet extends HttpServlet {
	private static final Logger log = Logger.getLogger(SignGuestbookServlet.class.getName());
	private static final long serialVersionUID = 2733502940600139641L;
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		
		String contetn = req.getParameter("content");
		
		if (contetn == null) {
			contetn = "no content";
		} 
		
		if (user != null) {
			log.info("posted by user " + user.getNickname() + ": " + contetn);
			
		}
		
		res.sendRedirect("/guestbook.jsp");
	}
}
