<%@page import="com.shopping.dao.Category"%>
<%@page import="com.shopping.dao.User"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="_sessioncheck.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	String pidstring = request.getParameter("pid");
	int pid = 0;
	if (pidstring != null) {
		pid = Integer.parseInt(pidstring);
	}
	String action = request.getParameter("action");
	if (action != null && action.equals("categoryadd")) {
		String name = request.getParameter("name");
		String descr = request.getParameter("descr");
		if (pid == 0) {
			Category c = new Category();
			c.setId(-1);
			c.setName(name);
			c.setDescr(descr);
			c.setPid(0);
			c.setLeaf(true);
			c.setGrade(1);
			Category.save(c);
			out.println("ok!");
			return;
		} else {
		    Category.saveChild(pid,name,descr);
			out.println("ok!");
			return;

		}
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>资源管理</title>
		<script type="text/javascript" src="script/regcheckdata.js"
			charset="gbk">
	
</script>
	</head>
	<body>
		<form name="form" action="categoryadd.jsp" method="post">
			<input type="hidden" name="action" value="categoryadd">
			<input type="hidden" name="pid" value="<%=pid %>">
			<table width="750" align="center" border="1">
				<tr>
					<td colspan="2" align="center">
						添加类别
					</td>
				</tr>
				<tr>
					<td>
						类别名称:
					</td>
					<td>
						<input type="text" name="name" size="30" maxlength="18">
					</td>
				</tr>
				<tr>
					<td>
						类别描述:
					</td>
					<td>
						<textarea rows="12" cols="80" name="descr"></textarea>
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
