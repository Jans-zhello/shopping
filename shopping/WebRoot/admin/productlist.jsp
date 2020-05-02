<%@page import="com.shopping.dao.product.ProductManager"%>
<%@page import="com.shopping.dao.product.Product"%>
<%@page import="com.shopping.dao.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="_sessioncheck.jsp"%>
<%!private static int PAGE_SIZE = 3;%>
<%
	String pNoString = request.getParameter("pageNo");
	int pageNo = 1;
	if (pNoString != null) {
		pageNo = Integer.parseInt(pNoString);
	}
	if (pageNo < 1)
		pageNo = 1;
	//拿到所有的产品
	List<Product> list = new ArrayList<Product>();
	int pageCount = ProductManager.getInstance().getProductPageCount(
			list, pageNo, PAGE_SIZE);
	if (pageNo > pageCount)
		pageNo = pageCount;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>产品列表</title>

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
		<table align="center" border="1">
			<tr>
				<td>
					产品Id
				</td>
				<td>
					产品名称
				</td>
				<td>
					产品描述
				</td>
				<td>
					市场价格
				</td>
				<td>
					会员价格
				</td>
				<td>
					上货时间
				</td>
				<td>
					产品类别ID
				</td>
				<td>
					产品类别名称
				</td>
				<td>
					操作
				</td>
			</tr>
			<%
				for (Iterator<Product> it = list.iterator(); it.hasNext();) {
					Product p = (Product) it.next();
			%>
			<tr>
				<td>
					<%=p.getId()%>
				</td>
				<td>
					<%=p.getName()%>
				</td>
				<td>
					<%=p.getDescr()%>
				</td>
				<td>
					<%=p.getNormalprice()%>
				</td>
				<td>
					<%=p.getMemberprice()%>
				</td>
				<td>
					<%=p.getPdate()%>
				</td>
				<td>
					<%=p.getCategoryid()%>
				</td>
				<td>
					<%=Category.getCategoryById(p.getCategoryid())%>
				</td>
				<td>
					<a href="productdelete.jsp?id=<%=p.getId()%>" onclick="return confirm('确定删除?')">删除产品</a>
					&nbsp;&nbsp;
					<a href="productupdate.jsp?id=<%=p.getId()%>">更新产品</a>
					&nbsp;&nbsp;
					<a href="productimgupload.jsp?id=<%=p.getId() %>">上传图片</a>
				</td>
			</tr>
			<%
				}
			%>
		</table>
		<a href="productchart.jsp">查看产品销量图表</a>
		<center>
			当前<%=pageNo%>/<%=pageCount %>页 &nbsp;&nbsp;&nbsp;&nbsp;
			<a href="productlist.jsp?pageNo=<%=1%>">首页</a>
			<%
			  if(pageNo-1 >=1){
			 %>
			<a href="productlist.jsp?pageNo=<%=pageNo - 1%>">上一页</a>
			<%} %>
			<%
			  if(pageNo+1<=pageCount){
			 %>
			<a href="productlist.jsp?pageNo=<%=pageNo + 1%>">下一页</a>
			<%} %>
			<a href="productlist.jsp?pageNo=<%=pageCount%>">尾页</a>
		</center>
	</body>
</html>
