<%@page import="com.shopping.dao.cart.CartItem"%>
<%@page import="com.shopping.dao.cart.Cart"%>
<%@page import="com.shopping.dao.product.ProductManager"%>
<%@page import="com.shopping.dao.product.Product"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%--
  //将购物车设置在session中是为了只实例化一个购物车对象.
 Cart c = (Cart)session.getAttribute("cart");
 if(c == null){
   c = new Cart();
   session.setAttribute("cart",c);
 }
 --%>
<jsp:useBean id="c" class="com.shopping.dao.cart.Cart" scope="session"></jsp:useBean>
<%
int id = Integer.parseInt(request.getParameter("id"));
Product p = ProductManager.getInstance().getProductById(id);
CartItem cartItem = new CartItem();
cartItem.setProductId(p.getId());
cartItem.setProductname(p.getName());
cartItem.setPrice(p.getNormalprice());
cartItem.setCount(1);
c.addItem(cartItem);
response.sendRedirect("cart.jsp");
%>
