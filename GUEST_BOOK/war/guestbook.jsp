<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
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
<form action="/sign" method="post">
	<div><textarea rows="3" cols="60" name="content"></textarea> </div>
	<div><input type="submit" value="등록"></div>
</form>
</body>
</html>