<%@page import="com.shopping.dao.order.OrderManager"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
  int id = Integer.parseInt(request.getParameter("orderid"));
  int status = Integer.parseInt(request.getParameter("status"));
  String action = request.getParameter("action"); 
  if(action != null && action.trim().equals("orderupdate")){
      int updatestatus = Integer.parseInt(request.getParameter("selectstatus")); 
      OrderManager.getInstance().updateOrderStatus(id,updatestatus);
      out.println("update ok");
      return;
  }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>订单状态修改</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
  
  <body>
     <center>订单状态</center>
     <form  name="form" action="orderupdate.jsp" method="post">
     <input type="hidden" name="action" value="orderupdate">
     <input type="hidden" name="orderid" value="<%=id %>">
     <input type="hidden" name="status" value="<%=status %>">
       <table align="center">
         <tr>
          <td>
            <select name="selectstatus" id="selectstatus">
              <option value="1">已处理</option>
              <option value="0">未处理</option>
              <option value="2">废单</option>
            </select>
          </td>
         </tr>
         <tr>
          <td><input type="submit" value="更改"></td>
         </tr>
       </table>
     </form> 
     <script type="text/javascript">
      obj = document.getElementById("selectstatus");
      for(i=0;i<obj.length;i++){
        if(obj[i].value == <%=status %>){
           obj[i].selected = true;
        }
      }
  </script>
  </body>
</html>