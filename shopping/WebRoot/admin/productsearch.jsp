<%@page import="com.shopping.dao.product.Product"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.shopping.dao.Category"%>
<%@ include file="_sessioncheck.jsp"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	List<Category> caList = Category.getCategories();
%>
<%!
  private static int PAGE_SIZE = 3;
 %>
<%
	request.setCharacterEncoding("utf-8");
	String action = request.getParameter("action");
	if (action != null && action.equals("productcomplex")) {
	   int pageNo = 1;
	   String pageString = request.getParameter("pageNo");
	   if(pageString != null && !pageString.equals("")){
	      pageNo =Integer.parseInt(pageString);
	   }
	 if(pageNo <1)pageNo = 1;
	 
		String keyword = request.getParameter("keyword");
		Double lownormalprice = Double.parseDouble(request
				.getParameter("lownormalprice"));
		Double highnormalprice = Double.parseDouble(request
				.getParameter("highnormalprice"));
		Double lowmemberprice = Double.parseDouble(request
				.getParameter("lowmemberprice"));
		Double highmemberprice = Double.parseDouble(request
				.getParameter("highmemberprice"));
		int categoryid = Integer.parseInt(request
				.getParameter("categoryid"));
		int[] idarray;
	    if(categoryid == 0){
	       idarray = null;
	    }else{
           idarray = new int[]{categoryid};	      
	    }			
		Timestamp startpdate;		
	    String  startString = request.getParameter("startpdate");
		if(startString == null || startString.trim().equals("")){
		   startpdate = null;
		}else{
		   startpdate =  Timestamp.valueOf(request
				.getParameter("startpdate"));
		}		
		Timestamp endpdate;		
	    String  endString = request.getParameter("endpdate");
		if(endString == null || endString.trim().equals("")){
		   endpdate = null;
		}else{
		   endpdate =  Timestamp.valueOf(request
				.getParameter("endpdate"));
		}
		List<Product> list = new ArrayList<Product>();
		int pageCount = com.shopping.dao.product.ProductManager.getInstance()
				.searchProducts(list,idarray, keyword, lownormalprice,
						highnormalprice, lowmemberprice,
						highmemberprice, startpdate, endpdate,pageNo,PAGE_SIZE);
		if(pageNo > pageCount) pageNo = pageCount;
		%>
<center>
	搜索结果
</center>
<table align="center" border="1">
	<tr>
		<td>
			产品Id
		</td>
		<td>
			产品名称
		</td>
		<td>
			产品描述
		</td>
		<td>
			市场价格
		</td>
		<td>
			会员价格
		</td>
		<td>
			上货时间
		</td>
		<td>
			产品类别ID
		</td>
		<td>
			操作
		</td>
	</tr>
	<%
				for (Iterator<Product> it = list.iterator(); it.hasNext();) {
					Product p = (Product) it.next();
			%>
	<tr>
		<td>
			<%=p.getId()%>
		</td>
		<td>
			<%=p.getName()%>
		</td>
		<td>
			<%=p.getDescr()%>
		</td>
		<td>
			<%=p.getNormalprice()%>
		</td>
		<td>
			<%=p.getMemberprice()%>
		</td>
		<td>
			<%=p.getPdate()%>
		</td>
		<td>
			<%=p.getCategoryid()%>
		</td>
		<td>
			<a href="admin/productdelete.jsp?id=<%=p.getId()%>">删除产品</a>
			&nbsp;&nbsp;
			<a href="admin/productupdate.jsp?id=<%=p.getId()%>">更新产品</a>
		</td>
	</tr>
	<%
				}
			%>
</table>
<center>
	共<%=pageCount %>页
	<%
	  if(pageNo-1 >=1){
	%>
	<a href="productsearch.jsp?action=<%=action %>&keyword=<%=keyword %>&lownormalprice=<%=lownormalprice %>&highnormalprice=<%=highnormalprice %>&lowmemberprice=<%=lowmemberprice %>&highmemberprice=<%=highmemberprice %>&startpdate=<%=startString %>&endpdate=<%=endString %>&categoryid=<%=categoryid %>&pageNo=<%=pageNo-1 %>">上一页</a>
	<%} %>
	<%
	  if(pageNo+1<=pageCount){
	%>
	<a href="productsearch.jsp?action=<%=action %>&keyword=<%=keyword %>&lownormalprice=<%=lownormalprice %>&highnormalprice=<%=highnormalprice %>&lowmemberprice=<%=lowmemberprice %>&highmemberprice=<%=highmemberprice %>&startpdate=<%=startString %>&endpdate=<%=endString %>&categoryid=<%=categoryid %>&pageNo=<%=pageNo+1 %>">下一页</a>
  <% } %>
</center>
<%
		
	}else if(action != null && action.equals("productsimple")){
	   int pageNo = 1;
	   String pageString = request.getParameter("pageNo");
	   if(pageString != null && !pageString.equals("")){
	      pageNo =Integer.parseInt(pageString);
	   }
	    if(pageNo <1)pageNo = 1;
	 
		String keyword = request.getParameter("keyword");
		int categoryid = Integer.parseInt(request
				.getParameter("categoryid"));
		int[] idarray;
	    if(categoryid == 0){
	       idarray = null;
	    }else{
           idarray = new int[]{categoryid};	      
	    }			
		List<Product> list = new ArrayList<Product>();
		int pageCount = com.shopping.dao.product.ProductManager.getInstance()
				.searchProducts(list,idarray, keyword, -1,-1, -1,-1, null, null,pageNo,PAGE_SIZE);
		if(pageNo > pageCount) pageNo = pageCount;
		%>
<center>
	搜索结果
</center>
<table align="center" border="1">
	<tr>
		<td>
			产品Id
		</td>
		<td>
			产品名称
		</td>
		<td>
			产品描述
		</td>
		<td>
			市场价格
		</td>
		<td>
			会员价格
		</td>
		<td>
			上货时间
		</td>
		<td>
			产品类别ID
		</td>
		<td>
			操作
		</td>
	</tr>
	<%
				for (Iterator<Product> it = list.iterator(); it.hasNext();) {
					Product p = (Product) it.next();
			%>
	<tr>
		<td>
			<%=p.getId()%>
		</td>
		<td>
			<%=p.getName()%>
		</td>
		<td>
			<%=p.getDescr()%>
		</td>
		<td>
			<%=p.getNormalprice()%>
		</td>
		<td>
			<%=p.getMemberprice()%>
		</td>
		<td>
			<%=p.getPdate()%>
		</td>
		<td>
			<%=p.getCategoryid()%>
		</td>
		<td>
			<a href="admin/productdelete.jsp?id=<%=p.getId()%>">删除产品</a>
			&nbsp;&nbsp;
			<a href="admin/productupdate.jsp?id=<%=p.getId()%>">更新产品</a>
		</td>
	</tr>
	<%
				}
			%>
</table>
<center>
	共<%=pageCount %>页
	<%
	   if(pageNo-1 >=1){
	 %>
	<a href="productsearch.jsp?action=<%=action %>&keyword=<%=keyword %>&categoryid=<%=categoryid %>&pageNo=<%=pageNo-1 %>">上一页</a>
	<%} %>
	<%
	  if(pageNo+1<=pageCount){
	%>
	<a href="productsearch.jsp?action=<%=action %>&keyword=<%=keyword %>&categoryid=<%=categoryid %>&pageNo=<%=pageNo+1 %>">下一页</a>
	<%} %>
</center>
<%
} %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>产品搜索</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript">
<!--
	function checkdata() {
		with (document.forms["complex"]) {
			if (lownormalprice.value == null || lownormalprice.value == "") {
				lownormalprice.value = -1;
			}
			if (highnormalprice.value == null || highnormalprice.value == "") {
				highnormalprice.value = -1;
			}
			if (lowmemberprice.value == null || lowmemberprice.value == "") {
				lowmemberprice.value = -1;
			}
			if (highmemberprice.value == null || highmemberprice.value == "") {
				highmemberprice.value = -1;
			}
		}

	}
//-->
</script>
	</head>

	<body>
		<center>
			简单搜索

			<form action="productsearch.jsp" method="post">
				<input type="hidden" name="action" value="productsimple">
				产品类别:
				<select name="categoryid">
					<option value="0">
						所有类别
					</option>
					<%
						for (Iterator<Category> it = caList.iterator(); it.hasNext();) {
							Category c = (Category) it.next();
							String pre = "";
							for (int i = 1; i < c.getGrade(); i++) {
								pre += "--";
							}
					%>
					<option value="<%=c.getId()%>"><%=pre + c.getName()%></option>
					<%
						}
					%>

				</select>
				关键字:
				<input type="text" name="keyword">
				<input type="submit" value="搜索">
			</form>
		</center>
		<center>
			复杂搜索
		</center>
		<form action="productsearch.jsp" method="post" name="complex"
			onsubmit="checkdata()">
			<input type="hidden" name="action" value="productcomplex">
			<table width="750" align="center" border="1">
				<tr>
					<td>
						类别名称:
					</td>
					<td>
						<select name="categoryid">
							<option value="0">
								所有类别
							</option>
							<%
								for (Iterator<Category> it = caList.iterator(); it.hasNext();) {
									Category c = (Category) it.next();
									String pre = "";
									for (int i = 1; i < c.getGrade(); i++) {
										pre += "--";
									}
							%>
							<option value="<%=c.getId()%>"><%=pre + c.getName()%></option>
							<%
								}
							%>

						</select>
					</td>
				</tr>
				<tr>
					<td>
						关键字:
					</td>
					<td>
						<input type="text" name="keyword" size="30" maxlength="18">
					</td>
				</tr>
				<tr>
					<td>
						市场价格:
					</td>
					<td>
						from:
						<input type="text" name="lownormalprice" size="30" maxlength="18">
						to:
						<input type="text" name="highnormalprice" size="30" maxlength="18">
					</td>
				</tr>
				<tr>
					<td>
						会员价格:
					</td>
					<td>
						from:
						<input type="text" name="lowmemberprice" size="30" maxlength="18">
						to:
						<input type="text" name="highmemberprice" size="30" maxlength="18">
					</td>
				</tr>
				<tr>
					<td>
						上货日期
					</td>
					<td>
						from:
						<input type="text" name="startpdate" size="30" maxlength="18">
						to:
						<input type="text" name="endpdate" size="30" maxlength="18">
					</td>
				</tr>
				<tr>
					<td></td>
					<td>
						<input type="submit" value="搜索">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
