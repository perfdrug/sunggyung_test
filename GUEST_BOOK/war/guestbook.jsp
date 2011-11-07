<%@page import="java.util.List"%>
<%@page import="guestbook.Greeting"%>
<%@page import="guestbook.PMF"%>
<%@page import="javax.jdo.PersistenceManager"%>
<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link type="text/css" rel="stylesheet" href="/css/main.css">
<title>Insert title here</title>
<script type="text/javascript">

</script>
</head>
<body>
<%
UserService userService = UserServiceFactory.getUserService();
User user = userService.getCurrentUser();

if (user != null) {
%>
<p>Hello, <%=user.getNickname() %><br>
<a href="<%=userService.createLogoutURL(request.getRequestURI()) %>">로그아웃</a>
</p>
<% 
} else {
%>
<p>hello!
<a href="<%=userService.createLoginURL(request.getRequestURI()) %>">로그인</a>

</p>
<%
}
%>
<%
PersistenceManager pm = PMF.get().getPersistenceManager();
String query = "select from " + Greeting.class.getName();
List<Greeting> greetings = (List<Greeting>)pm.newQuery(query).execute();

if (greetings.isEmpty()) {
%>
<p>the guestbook has no messages.</p>
<%
} else {
	User author = null;
	String authorNm = null;
	
	for (Greeting g: greetings) {
		author = g.getAuthor();
		authorNm = null;
		
		if ( author != null) {
			authorNm = author.getNickname();
		} else {
			authorNm = "An anonymous person ";
		}

%>
<p><%=authorNm %> wrote: </p>
<blockquote><%=g.getContent() %></blockquote>
<%
		
	}
}
pm.close();
%>
<form action="/sign" method="post">
	<div><textarea rows="3" cols="60" name="content"></textarea> </div>
	<div><input type="submit" value="등록"></div>
</form>
</body>
</html>