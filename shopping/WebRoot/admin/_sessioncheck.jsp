<% 
  String msg = (String)session.getAttribute("admin");
  if(msg == null || !msg.equals("true"))
   response.sendRedirect("login.jsp");

%>