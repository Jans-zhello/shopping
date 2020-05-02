<%@page import="com.shopping.dao.User"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String action = request.getParameter("action");
if(action != null && action.equals("register")){
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String phone = request.getParameter("phone");
    String addr = request.getParameter("addr");
    User user = new User();
    user.setUsername(username);
    user.setPassword(password);
    user.setPhone(phone);
    user.setAddr(addr);
    user.setRdate(new java.util.Date(System.currentTimeMillis()));
    user.save();
    out.println("Congratulations! register ok!");
    return;
}  	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>注册</title>
		<script type="text/javascript" src="script/regcheckdata.js" charset="gbk">
	
</script>
<script type="text/javascript" charset="gbk">
   var req;
   function validate(){
    var fieldValue = document.getElementById("username");
    var url = "validateUsernameOfAjax.jsp?username="+escape(fieldValue.value);
    if(window.XMLHttpRequest){
       req = new XMLHttpRequest();
    }else if(window.ActiveXObject){
       req = new ActiveXObject("Microsoft.XMLHTTP");
    }
    req.open("GET",url,true);
    req.onreadystatechange=callback;
    req.send(null);
   }
   function callback(){
     if(req.readyState == 4){
       if(req.status == 200){
         document.getElementById("showAjaxMsg").innerHTML=req.responseText;
       }
     }
   }
  function formerStatus(){
     if(document.getElementById("showAjaxMsg").innerHTML != ""){
       document.getElementById("showAjaxMsg").innerHTML = "";
     }
  }

</script>
	</head>
	<body>
		<form name="form" action="register.jsp" method="post"
			onsubmit="return checkdata()">
			<input type="hidden" name="action" value="register">
			<table width="750" align="center" border="1">
				<tr>
					<td colspan="2" align="center">
						用户注册
					</td>
				</tr>
				<tr>
					<td>
						用户名:
					</td>
					<td >
						<input type="text" name="username" id="username" size="30" maxlength="18" onblur="validate()" onfocus="formerStatus()">
					    <span id="showAjaxMsg" style="font-family:宋体;color:red;"></span>
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
					<td>
						密码确认:
					</td>
					<td>
						<input type="password" name="password2" size="15" maxlength="16">
					</td>
				</tr>
				<tr>
					<td>
						电话:
					</td>
					<td>
						<input type="text" name="phone" size="15" maxlength="12">
					</td>
				</tr>
				<tr>
					<td>
						地址:
					</td>
					<td>
						<textarea rows="12" cols="80" name="addr"></textarea>
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
