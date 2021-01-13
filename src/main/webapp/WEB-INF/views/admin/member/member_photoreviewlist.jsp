<%@page import="com.project.cinderella.model.domain.PhotoReview"%>
<%@page import="com.project.cinderella.model.domain.Product"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
   List<PhotoReview> photoreviewtList =(List)request.getAttribute("photoReviewList");
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

   <h3>리뷰목록</h3>
   <p>
   <table>
      <tr>
         <th>No</th>
         <th>회원id</th>
         <th>이미지</th>
         <th>상품명</th>
         <th>리뷰</th>
      </tr>
      <%int k = photoreviewtList.size(); %>
      <%for(int i=0;i<photoreviewtList.size();i++){%>
      <%PhotoReview photoReview = photoreviewtList.get(i); %>
      
      <tr>
         <td width="5%"><%=k-i%></td>
         <td width="8%"><%=photoReview.getUser_id() %></td>
         <td><img src="/cinderella/resources/data/previewbasic/<%=photoReview.getPhotoreview_id()%>.<%=photoReview.getFilename()%>" width="50px"></td>
         <td width="15%"><a href = "/cinderella/admin/member/member_photoreviewdetail?photoreview_id=<%=photoReview.getPhotoreview_id()%>"><%=photoReview.getProduct_name()%></a></td>
         <td width="40%"><%=photoReview.getReview() %></td>
      </tr>
      <%}%>
      <tr>
        <!-- 페이징처리 -->
      </tr>
   </table>
   </p>


</body>
</html>