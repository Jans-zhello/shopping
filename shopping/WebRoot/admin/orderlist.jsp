<%@page import="com.shopping.dao.order.OrderManager"%>
<%@page import="com.shopping.dao.order.Order"%>
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
	List<Order> list = new ArrayList<Order>();
	int pageCount = OrderManager.getInstance().getOrderPageCount(
			list, pageNo, PAGE_SIZE);
	if (pageNo > pageCount)
		pageNo = pageCount;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>订单列表</title>

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
					订单Id
				</td>
				<td>
					用户名称
				</td>
				<td>
					订单地址
				</td>
				<td>
					订单价格
				</td>
				<td>
					订单日期
				</td>
				<td>
					订单状态【0-未处理,1-已处理,2-废单】
				</td>
				<td>
					操作
				</td>
			</tr>
			<%
				for (Iterator<Order> it = list.iterator(); it.hasNext();) {
					Order order = (Order) it.next();
			%>
			<tr>
				<td>
					<%=order.getId()%>
				</td>
				<td>
					<%=order.getUser().getUsername()%>
				</td>
				<td>
					<%=order.getAddr()%>
				</td>
				<td>
					<%=order.getMoney()%>元
				</td>
				<td>
					<%=order.getOdate()%>
				</td>
				<td>
					<%=order.getStatus() %>
				</td>
				<td>
					<a href="orderdetail.jsp?orderid=<%=order.getId()%>">订单详情</a>
					&nbsp;&nbsp;
					<a href="orderupdate.jsp?orderid=<%=order.getId()%>&status=<%=order.getStatus() %>">订单状态修改</a>
				</td>
			</tr>
			<%
				}
			%>
		</table>
		<center>
			当前<%=pageNo%>/<%=pageCount %>页 &nbsp;&nbsp;&nbsp;&nbsp;
			<a href="orderlist.jsp?pageNo=<%=1%>">首页</a>
			<%
			  if(pageNo-1 >=1){
			 %>
			<a href="orderlist.jsp?pageNo=<%=pageNo - 1%>">上一页</a>
			<%} %>
			<%
			  if(pageNo+1<=pageCount){
			 %>
			<a href="orderlist.jsp?pageNo=<%=pageNo + 1%>">下一页</a>
			<%} %>
			<a href="orderlist.jsp?pageNo=<%=pageCount%>">尾页</a>
		</center>
	</body>
</html>
