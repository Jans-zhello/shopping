<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
 String idstr = request.getParameter("id");
 int id = 0;
 if(idstr != null && !idstr.trim().equals("")){
   id = Integer.parseInt(idstr);
 }
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 <head>
  <title>图片上传</title>
 
  <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
  <meta http-equiv="description" content="this is my page">
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
 </head>
 
 <body>
  <form action="../FileUpload" method="post" enctype="multipart/form-data" name="form1">
  <input type="hidden" name="id" value="<%=id %>">
  <input type="file" name="file"/>
  <input type="submit" name="submit" value="upload"/>
  </form>
  
  <form action="../FileUpload" method="post" enctype="multipart/form-data" name="uploadform">
  <input type="hidden" name="id" value="<%=id %>">
  <table>
  <tr>
   <td>
   文件1：<input type="file" name="X" size="40"/>
   </td>
  </tr>
  <tr>
   <td>
   文件2：<input type="file" name="Y" size="40"/>
   </td>
  </tr>
  <tr>
   <td>
   文件3：<input type="file" name="Z" size="40"/>
   </td>
  </tr>
  </table>
  <input type="submit" name="upload" value="开始上传"/> 
  </form>
 </body>
</html>
