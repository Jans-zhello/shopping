<%@page import="com.shopping.dao.Category"%>
<%@page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<% 
 response.setContentType("text/xml");
 response.setHeader("Cache-Control","no-store");//HTTP 1.1
 response.setHeader("Pragma", "no-cache");//HTTP 1.0
 response.setDateHeader("Expires", 0);
 int cid = Integer.parseInt(request.getParameter("cid"));
 List<Category> list = Category.getCategories(cid);
 StringBuffer buf = new StringBuffer();
 if(list != null && list.size()>0){
/*字符串方式解析    for(int i=0;i<list.size();i++){
     Category c = list.get(i);
     buf.append(c.getId()+","+c.getName()+"-");
    }
  buf.deleteCharAt(buf.length()-1); */
  for(int i=0;i<list.size();i++){
     Category c = list.get(i);
     buf.append("<category>\n<id>"+c.getId()+"</id>\n<name>"+c.getName()+"</name>\n</category>");
    }
    buf.insert(0, "<categories>");
    buf.append("</categories>");
 response.getWriter().println(buf.toString());
 }else{
 response.getWriter().println("0");
 }
%>

