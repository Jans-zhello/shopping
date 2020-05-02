<%@ page import="com.shopping.dao.*" %>
<% 
 response.setContentType("text/xml");
 response.setHeader("Cache-Control","no-store");//HTTP 1.1
 response.setHeader("Pragma", "no-cache");//HTTP 1.0
 response.setDateHeader("Expires", 0);
 String username = request.getParameter("username");
 boolean result = User.validateUsernameOfAjax(username); 
 if(result){
 response.getWriter().write("*用户名已存在！");
 }else{
  response.getWriter().write("");
 }
%>

