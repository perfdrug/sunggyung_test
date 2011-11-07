package guestbook;

import java.io.IOException;
import java.util.Date;
import java.util.logging.Logger;

import javax.jdo.PersistenceManager;
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
		req.setCharacterEncoding("utf-8");

		User user = userService.getCurrentUser();
		String content = req.getParameter("content");
		
		Date date = new Date();
		Greeting greeting = new Greeting(user, content, date);
		
		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			pm.makePersistent(greeting);
		} finally {
			pm.close();
		}
		/*
		if (contetn == null) {
			contetn = "no content"; 
		} 
		
		if (user != null) {
			log.info("posted by user " + user.getNickname() + ": " + contetn);
			
		}
		*/
		res.sendRedirect("/guestbook.jsp");
	}
}
