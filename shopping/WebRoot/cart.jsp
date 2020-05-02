<%@page import="java.sql.Timestamp"%>
<%@page import="com.shopping.dao.order.OrderManager"%>
<%@page import="com.shopping.dao.cart.CartItem"%>
<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.shopping.dao.cart.Cart"%>
<%@page import="com.shopping.dao.User"%>
<%@page import="com.shopping.dao.order.*"  %>
<%--
 Cart c = (Cart)session.getAttribute("cart");
 if(c == null){
   c = new Cart();
   session.setAttribute("cart",c);
 }
--%>
<jsp:useBean id="c" class="com.shopping.dao.cart.Cart" scope="session"></jsp:useBean>
<%
   List<CartItem> list = c.getCaItems();
   User u = (User)session.getAttribute("user");
   if(u == null){
      response.sendRedirect("login.jsp");
      return;
   }
 if(c.getCaItems().size() == 0){
   out.print("你没有购买商品，请购买");
   return;
 }
 %>
 <%
   //获取表单的数据生成订单
   String action = request.getParameter("action");
   if(action != null && action.trim().equals("updatecount")){
       for(int i=0;i<list.size();i++){
          CartItem ciCartItem = list.get(i);
          String countstr = request.getParameter("count"+ciCartItem.getProductId());
          if(countstr != null && !countstr.trim().equals("")){
                int countnum = Integer.parseInt(countstr);
                ciCartItem.setCount(countnum);
          }
       }
       //购物车总价
       double tprice = c.TotalPrice();
       Order o = new Order();
       o.setAddr(u.getAddr());
       o.setC(c);
       o.setMoney(tprice);
       o.setOdate(new Timestamp(System.currentTimeMillis()));
       o.setUser(u);
       o.setStatus(0);
       OrderManager.getInstance().saveOrder(o);
       session.removeAttribute("cart");
       out.print("order ok");
       return;
   }
  %>
 
 
 
 
 
<!DOCTYPE jsp:useBean PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
<center>
您一共购买了这么多商品
</center>
<form name="form" action="cart.jsp" method="post">
<input type="hidden" name="action" value="updatecount">
<table border="1" align="center">
 <tr>
  <td>商品ID</td>
  <td>商品名称</td>
  <td>商品价格</td>
  <td>商品数量</td>
  <td>总价</td>
 </tr>
  <%
  for(int i=0;i<list.size();i++){
   CartItem ciItem = list.get(i);
    %>
    <tr>
      <td><%=ciItem.getProductId() %></td>
      <td><%=ciItem.getProductname() %></td>
      <td><%=ciItem.getPrice() %></td>
      <td>
       <input  id="<%="sbutton"+ciItem.getProductId() %>" type="button" value="-" >
       <input id="<%="count"+ciItem.getProductId() %>" name="<%="count"+ciItem.getProductId() %>"  type="text" value="<%=ciItem.getCount() %>">
       <input id="<%="abutton"+ciItem.getProductId() %>" type="button" value="+" >
      </td>
      <td id="<%="totalprice"+ciItem.getProductId() %>" ><%=ciItem.getCount() * ciItem.getPrice() %></td>
    <script src="script/jquery-3.1.1.min.js" ></script>
     <script type="text/javascript" >
           var totalprice = 0.0;
           $(document).ready(function(){
            var price = $("#<%="totalprice"+ciItem.getProductId() %>").html();
             totalprice += Number(price) ;
            $("#<%="sbutton"+ciItem.getProductId() %>").click(function(){
               var count =  $("#<%="count"+ciItem.getProductId() %>").val();
                count --;
                $("#<%="count"+ciItem.getProductId() %>").val(count);
                $("#<%="totalprice"+ciItem.getProductId() %>").html(count * <%=ciItem.getPrice() %>);
                totalprice -= <%=ciItem.getPrice() %>; 
                 $("#totalprice").html(totalprice+"元"); 
             });
         
         $("#<%="abutton"+ciItem.getProductId() %>").click(function(){
           var count =  $("#<%="count"+ciItem.getProductId() %>").val();
           count ++;
            $("#<%="count"+ciItem.getProductId() %>").val(count);
           $("#<%="totalprice"+ciItem.getProductId() %>").html(count * <%=ciItem.getPrice() %>);
           totalprice += <%=ciItem.getPrice() %>; 
            $("#totalprice").html(totalprice+"元"); 
         });
          });
     </script>
     
  
    <%
  }
   %>
<tr><td>共计:</td><td id="totalprice"></td></tr>  
    <script src="script/jquery-3.1.1.min.js" ></script>
     <script type="text/javascript" >
           $(document).ready(function(){
           $("#totalprice").html(totalprice+"元");
           });
      </script>
<tr><td>地址:</td><td><%=u.getAddr() %></td></tr>
<tr><td colspan="5" align="center"><input type="submit" value="生成订单"></td></tr>

</table>
</form>
</body>
</html>