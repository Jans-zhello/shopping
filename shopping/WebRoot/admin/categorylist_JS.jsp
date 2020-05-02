<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.shopping.dao.Category"%>
<%@ include file="_sessioncheck.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	//拿到所有的类别
	List<Category> categoryies = Category.getCategories();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>类别列表_JS</title>
		<script type="text/javascript" src="script/TV20.js"></script>
		<script type="text/javascript">
		 function click(key,parentkey){
		   form.pid.value=key;
		 }
		 function dblclick(key,parentkey){
		    alert("ok");
		 }
		</script>
	</head>

	<body>
		<form name="form" action="admin/categoryadd.jsp" method="post">
		<input type="hidden" name="action" value="categoryadd">
			<table align="center" border="1">
			    <tr><td id="show"></td></tr>
				<tr>
					<td>
						点击获取到对应的父亲节点:
					</td>
					<td>
						<input type="text" name="pid" value="" readonly="readonly">
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
					<td>
						<input type="submit" value="提交">
					</td>
				</tr>
			</table>
		</form>
		<script language="javascript">
		<!--
	addNode(-1, 0, "产品类别", "images/top.gif");
<%
	 for(Iterator i = categoryies.iterator();i.hasNext();){
	     Category c = (Category)i.next();
	  %>
	  addNode(<%=c.getPid() %>,<%=c.getId() %> , "<%=c.getName() %>","images/top.gif");
<%   
	}
	%>
	showTV();
	addListener("click", "click");
	addListener("dblclick", "dblclick");
//-->
</script>
	</body>
</html>
