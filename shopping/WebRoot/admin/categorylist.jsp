<%@page import="com.shopping.dao.Category"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="_sessioncheck.jsp" %>
<%
	//拿到所有的类别
	List<Category> categoryies = Category.getCategories();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>类别列表</title>
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
					name
				</td>
				<td>
					pid
				</td>
				<td>
					grade
				</td>
				<td>
					操作
				</td>
			</tr>
			<%
				for (Iterator<Category> it = categoryies.iterator(); it.hasNext();) {
					Category c = it.next();
					String preStr = "";
					for(int i = 1;i<c.getGrade();i++){
					   preStr += "---";
					}
			%>
			<tr>
				<td>
					<%=c.getId()%>
				</td>
				<td>
					<%=preStr+c.getName()%>
				</td>
				<td>
					<%=c.getPid()%>
				</td>
				<td>
					<%=c.getGrade()%>
				</td>
				<td>
				<a href="categoryadd.jsp?pid=<%=c.getId()%>">添加子类别</a>
				</td>
			</tr>
			<%
				}
			%>
		</table>
	</body>
</html>
