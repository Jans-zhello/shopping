<%@page import="com.shopping.dao.Category"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
  List<Category> categorylist = Category.getCategories();
  int lengthcategory1 = 0,lengthcategory2 = 0;
  //获取一级目录和二级目录的总长度
  for(int i = 0;i<categorylist.size();i++){
  Category c = categorylist.get(i);
  switch(c.getGrade()){
  case 1:
        lengthcategory1++;
        break;
  case 2:
        lengthcategory2++;
        break;
    }
  }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>商城首页</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript">
	   var req;
	 function changeCategory(){
	       var fieldValue = document.formindex.category1.options[document.formindex.category1.selectedIndex];
		   var url = "indexCategoryAjax.jsp?cid="+escape(fieldValue.value);
		   if(window.XMLHttpRequest){
		      req = new XMLHttpRequest();
		   }else if(window.ActiveXObject){
		      req = new ActiveXObject("Microsoft.XMLHTTP");
		   }
		   req.open("GET",url,true);
		   req.onreadystatechange=callback;
		   req.send(null);
		}
	function callback(){
     if(req.readyState == 4){
       if(req.status == 200){
       if(trim(req.responseText) == "0"){
            document.formindex.category2.length = 1;
            document.formindex.category2.selectedIndex = 0;
            document.formindex.category2.options[0].text="查询二级目录";
            document.formindex.category2.options[0].value="-1"; 
         }else{
             /* 字符串方式解析    var array = req.responseText.split("-");
              document.formindex.category2.length = array.length+1;
              document.formindex.category2.selectedIndex = 0;
	          for ( var i = 0; i <array.length; i++){
              var array2 = array[i].split(",");
              document.formindex.category2.options[i+1].text=trim(array2[1]);
              document.formindex.category2.options[i+1].value=array2[0]; 
          } */
          
            //XML解析
            var categories = req.responseXML.getElementsByTagName("categories")[0];
            document.formindex.category2.length = categories.childNodes.length+1;
            document.formindex.category2.selectedIndex = 0;
            for(var i=0;i<categories.childNodes.length;i++){
                   var category = categories.childNodes[i];            
                   var id = category.childNodes[0].childNodes[0].nodeValue;
                   var name = category.childNodes[1].childNodes[0].nodeValue;
                   document.formindex.category2.options[i+1].text=name;
                   document.formindex.category2.options[i+1].value=id; 
            }
         } 
       }
     }
   }
	function trim(str) {
       return str.replace(/(^\s+)|(\s+$)/g, "");
    }
	</script>
  </head>
  
  <body>
      <center>
    <form name="formindex" >
       <select name="category1" onchange="changeCategory()">
       <option value="-1" selected>查询一级目录</option>
       <% 
        for(int i=0;i<categorylist.size();i++){
          Category c = categorylist.get(i);
          if(c.getGrade() == 1){%>
          <option value="<%=c.getId() %>" ><%=c.getName() %></option>
          <% 
          }        
        }
       
       %>
       </select>
       <select name="category2">
 <option value="-1" selected>查询二级目录</option>
       
       </select>
    </form>
       </center>      
  </body>
</html>
