<%@page import="com.shopping.chart.JfreeChart"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
JfreeChart.getInstance().generateImageOfProductSales();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>图表图片</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
  
  <body>
    <center>
     <img alt="产品销量" src="../images/chart/chart.jpg"/>
      <img alt="产品销量" src="../images/chart/chart_pie.jpg"/>
    </center>
  </body>
</html>
