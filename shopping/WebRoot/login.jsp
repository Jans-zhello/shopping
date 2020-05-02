<%@page import="com.shopping.Utils.PasswordNotCorrectException"%>
<%@page import="com.shopping.Utils.UserNotFoundException"%>
<%@page import="com.shopping.dao.User"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String action = request.getParameter("action");
if(action != null && action.equals("login")){
     String username = request.getParameter("username");
     String password = request.getParameter("password");
     User u = null;
     try {
          u = User.validate(username,password);
     }catch (UserNotFoundException e){
           out.println("User not Found");
           return;
     }catch (PasswordNotCorrectException e){
           out.println("Password not Correct");
           return;
     } 
     session.setAttribute("user",u);
     response.sendRedirect("selfservices.jsp");
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>会员登录</title>
		<script type="text/javascript" src="script/regcheckdata.js"
			charset="gbk">
	
</script>
	</head>
	<body>
		<form name="form" action="login.jsp" method="post">
			<input type="hidden" name="action" value="login">
			<table width="750" align="center" border="2">
				<tr>
					<td colspan="2" align="center">
						会员登录
					</td>
				</tr>
				<tr>
					<td>
						用户名:
					</td>
					<td>
						<input type="text" name="username" size="30" maxlength="18">
					</td>
				</tr>
				<tr>
					<td>
						密码:
					</td>
					<td>
						<input type="password" name="password" size="15" maxlength="16">
					</td>
				</tr>
				<tr>
					<td></td>
					<td>
						<input type="submit" value="登录">
						<input type="reset" value="重置">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
