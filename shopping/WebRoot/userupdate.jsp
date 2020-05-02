<%@ page language="java" import="java.util.*,com.shopping.dao.*" pageEncoding="UTF-8"%>
<%
User u = (User)session.getAttribute("user");
if(u == null){
  out.println("You havn't logged in!");
  return;
}
%>
<%
request.setCharacterEncoding("utf-8");
String action = request.getParameter("action");
if(action != null && action.equals("userupdate")){
    String username = request.getParameter("username");
    String phone = request.getParameter("phone");
    String addr = request.getParameter("addr");
    u.setUsername(username);
    u.setPhone(phone);
    u.setAddr(addr);
    u.update();
    out.println("ok!");
    return;
}  	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>修改个人信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <body>
   <form name="form" action="userupdate.jsp" method="post"
			onsubmit="return checkdata()">
			<input type="hidden" name="action" value="userupdate"> 
			<table width="750" align="center" border="2">
				<tr>
					<td colspan="2" align="center">
						用户修改
					</td>
				</tr>
				<tr>
					<td>
						用户名:
					</td>
					<td>
						<input type="text" name="username" size="30" maxlength="18" value=<%=u.getUsername() %>>
					</td>
				</tr>
				<!--<tr>
					<td>
						密码:
					</td>
					<td>
						<input type="password" name="password" size="15" maxlength="16">
					</td>
				</tr>
				-->
				<!--<tr>
					<td>
						密码确认:
					</td>
					<td>
						<input type="password" name="password2" size="15" maxlength="16">
					</td>
				</tr>
				--><tr>
					<td>
						电话:
					</td>
					<td>
						<input type="text" name="phone" size="15" maxlength="12" value=<%=u.getPhone() %>>
					</td>
				</tr>
				<tr>
					<td>
						地址:
					</td>
					<td>
						<textarea rows="12" cols="80" name="addr"><%=u.getAddr() %></textarea>
					</td>
				</tr>
				<tr>
					<td></td>
					<td>
						<input type="submit" value="提交">
						<input type="reset" value="重置">
					</td>
				</tr>
			</table>
		</form>
  </body>
</html>
