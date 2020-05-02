<%@page import="com.shopping.dao.order.OrderManager,com.shopping.dao.order.OrderItem"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
  int orderid = Integer.parseInt(request.getParameter("orderid"));
  List<OrderItem> list = OrderManager.getInstance().getOrderItems(orderid);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>订单详情</title>
    
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
   <center>
      订单明细:
   </center>
   		<table align="center" border="1">
			<tr>
				<td>
					产品名称：
				</td>
				<td>
					产品数量
				</td>
				<td>
					产品单价
				</td>
			    
			</tr>
			<%
				for (Iterator<OrderItem> it = list.iterator(); it.hasNext();) {
					OrderItem oItem = (OrderItem) it.next();
			%>
			<tr>
				<td>
					<%=oItem.getProduct().getName()%>
				</td>
				<td>
					<%=oItem.getPcount()%>
				</td>
				<td>
					<%=oItem.getUnitprice()%>
				</td>
			</tr>
			<%
				}
			%>
		</table>
  </body>
</html>
