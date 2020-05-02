<%@page import="com.shopping.dao.User"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="_sessioncheck.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	//拿到所有的用户
	List<User> users = User.getUsers();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>用户列表</title>
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
		<table align="center">
			<tr>
				<td>
					Id
				</td>
				<td>
					Username
				</td>
				<td>
					Phone
				</td>
				<td>
					Addr
				</td>
				<td>
					Rdate
				</td>
				<td>
					操作
				</td>
			</tr>
			<%
				for (Iterator<User> it = users.iterator(); it.hasNext();) {
					User u = it.next();
			%>
			<tr>
				<td>
					<%=u.getId()%>
				</td>
				<td>
					<%=u.getUsername()%>
				</td>
				<td>
					<%=u.getPhone()%>
				</td>
				<td>
					<%=u.getAddr()%>
				</td>
				<td>
					<%=u.getRdate()%>
				</td>
				<td>
				<a href="admin/userdelete.jsp?id=<%=u.getId()%>">删除</a>
				</td>
			</tr>
			<%
				}
			%>
		</table>
	</body>
</html>
