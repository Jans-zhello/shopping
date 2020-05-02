<%@page import="com.shopping.dao.product.ProductManager"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.shopping.dao.product.Product"%>
<%@page import="com.shopping.dao.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="_sessioncheck.jsp" %>

<%
    request.setCharacterEncoding("utf-8");
    //拿到所有的类别
	List<Category> categoryies = Category.getCategories();
	//拿到鏈接過來的product對象
	int id = Integer.parseInt(request.getParameter("id"));
	Product p = ProductManager.getInstance().getProductById(id);
	String action = request.getParameter("action");
	if (action != null && action.equals("productupdate")) {
		String name = request.getParameter("name");
		String descr = request.getParameter("descr");
		Double normalprice = Double.parseDouble(request.getParameter("normalprice"));
		Double memberprice = Double.parseDouble(request.getParameter("memberprice"));
		int categoryid = Integer.parseInt(request.getParameter("categoryid"));
		p.setName(name);
		p.setDescr(descr);
		p.setNormalprice(normalprice);
		p.setMemberprice(memberprice);
		p.setPdate(new Timestamp(System.currentTimeMillis()));
		p.setCategoryid(categoryid);
		ProductManager.getInstance().updateProduct(p);
		out.print("update ok");
		return;
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>更新产品</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
        <script type="text/javascript">
         var arrLeaf = new Array();
         function checkdata(){
           if(arrLeaf[document.form.categoryid.selectedIndex] != "leaf"){
             alert("不能在非叶节点下面添加产品");
             document.form.categoryid.focus();
             return false;
           }
          return true;
        }
        
        </script>
	</head>

	<body>
		<form name="form" action="productupdate.jsp" method="post" onsubmit="return checkdata()">
			<input type="hidden" name="action" value="productupdate">
			<input type="hidden" name="id" value="<%=id %>">
			<table width="750" align="center" border="1">
				<tr>
					<td colspan="2" align="center">
						修改产品
					</td>
				</tr>
				<tr>
					<td>
						产品名称:
					</td>
					<td>
						<input type="text" name="name" size="30" maxlength="18" value="<%=p.getName() %>">
					</td>
				</tr>
				<tr>
					<td>
						产品描述:
					</td>
					<td>
						<textarea rows="12" cols="80" name="descr" ><%=p.getDescr() %></textarea>
					</td>
				</tr>
				<tr>
					<td>
						市场价格:
					</td>
					<td>
						<input type="text" name="normalprice" size="30" maxlength="18" value="<%=p.getNormalprice() %>">
					</td>
				</tr>
				<tr>
					<td>
						会员价格:
					</td>
					<td>
						<input type="text" name="memberprice" size="30" maxlength="18" value="<%=p.getMemberprice() %>">
					</td>
				</tr>
						<tr>
					<td>
						产品类别:
					</td>
					<td>
						<select name="categoryid">
						<option value="0">所有类别</option>
						 <script type="text/javascript">
                              arrLeaf[0] = "noleaf";						      
						      </script>
						 <%
						  int index = 1;
						  for(Iterator<Category> it = categoryies.iterator();it.hasNext();){
						     Category c = (Category)it.next();
						     %>
						      <script type="text/javascript">
                              arrLeaf[<%=index %>] = '<%=c.isLeaf() ? "leaf":"noleaf" %>';						      
						      </script>
						     <option value="<%=c.getId() %>" <%=c.getId()==p.getCategoryid()? "selected":"" %>><%=c.getName() %></option>
						     <% 
						     index++;
						  }
						  %>
						</select>
					</td>
				</tr>
				<tr>
					<td></td>
					<td>
						<input type="submit" value="提交">
						<input type="reset" value="重置">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
