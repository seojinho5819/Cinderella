<%@page import="com.project.cinderella.model.domain.Product"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
	List<Product> productList =(List)request.getAttribute("productList");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="../inc/header.jsp" %>
<script>
$(function(){
	$("button").click(function(){
		location.href="/cinderella/admin/product/registform"; //글쓰기 폼 요청
	})
})
</script>
</head>
<body>
<%@ include file="../inc/main_navi.jsp" %>

	<h3>상품목록</h3>
	<p>
	<table>
		<tr>
			<th>No</th>
			<th>이미지</th>
			<th>카테고리명</th>
			<th>상품명</th>
			<th>가격</th>
			<th>브랜드</th>
			<th>대여수량</th>
		</tr>
		<%for(int i=0;i<productList.size();i++){%>
		<%Product product = productList.get(i); %>
		<tr>
			<td>Jill</td>
			<td><img src="/cinderella/resources/data/basic/<%=product.getProduct_id()%>.<%=product.getFilename()%>" width="50px"></td>
			<%-- <td><%=product.getSubCategory().getSubcategory_name() %></td> --%>
			<td><a href = "/cinderella/admin/product/detail?product_id="><%=product.getProduct_name() %></a></td>
			<td><%=product.getPrice() %></td>
			<td><%=product.getBrand() %></td>
			<td><%=product.getQuantity() %></td>
		</tr>
		<%}%>
		<tr>
			<td colspan="7">
				<button>상품등록</button>
			</td>
		</tr>
	</table>
	</p>


</body>
</html>

