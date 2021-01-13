<%@page import="com.project.cinderella.model.domain.PhotoReview"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
   //정말로 포워딩이 요청을 유지햇는지 테스트해보자!!
  PhotoReview photoReview = (PhotoReview)request.getAttribute("photoReview");
      
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="../inc/header.jsp" %>
<style>
body {font-family: Arial, Helvetica, sans-serif;}
* {box-sizing: border-box;}
input[type=text], select, textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  margin-top: 6px;
  margin-bottom: 16px;
  resize: vertical;
}
input[type=button] {
  background-color: #4CAF50;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}
input[type=button]:hover {
  background-color: #45a049;
}
.container {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}
</style>
<script>
$(function(){
	 $($("input[type='button']")[0]).click(function(){ //채택
		 var result = confirm('이 게시물을 채택하시겠습니까??');
			if(result){
	     	select();//동기방식으로 요청하겠다
		}
	   });
	 function select(){
		   $("form").attr({
		      action:"/cinderella/admin/member/shot_email",
		      method:"post"
		   });      
		   $("form").submit();
		}
	
});

	
</script>
</head>
<body>
<%@ include file="../inc/main_navi.jsp" %>
<h3>Contact Form</h3>
<div class="container">
  <form>
	<input type="hidden" name="user_id" value="<%=photoReview.getUser_id()%>">
  	<label for="photoreveiw_id"><b>photoreveiw_id</b></label>
    <input type="text" name="photoreveiw_id" value="<%=photoReview.getPhotoreview_id()%>">
    <label for="photoreveiw_productname"><b>상품명</b></label>
    <input type="text" name="photoreveiw_productname" value="<%=photoReview.getProduct_name()%>">
    <label for="photoreveiw_review"><b>리뷰</b></label>
    <textarea name="photoreveiw_review" style="height:200px"><%=photoReview.getReview()%></textarea>

    <input type="button" value="채택" ">
    <input type="button" value="목록보기" onClick="location.href='/cinderella/admin/member/member_photoreviewlist'">
  </form>
</div>

</body>
</html>