<%@page import="com.project.cinderella.model.domain.Product"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	//정말로 포워딩이 요청을 유지햇는지 테스트해보자!!
	Product product =(Product)request.getAttribute("product");
	out.print("요청객체에 담겨진 board는 "+ product);
		
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
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
.reply-box{
	background:yellow;
}
.reply-list{
	overflow:hidden;
}
.reply-list p{
	float:left;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.ckeditor.com/4.15.1/standard/ckeditor.js"></script>
<script>
$(function(){
	CKEDITOR.replace("content"); //textarea의 id가 content인 컴포넌트를 편집기 스킨으로 변경
	
	$($("input[type='button']")[0]).click(function(){ //수정버튼
		edit();//동기방식으로 요청하겠다
	});
	$($("input[type='button']")[1]).click(function(){ //삭제버튼
		del();//동기방식으로 요청하겠다
	});
	
	getCommentList(); //댓글 목록 비동기로 가져오기!!!
});
//글등록 요청
function edit(){
	$("form").attr({
		action:"/board/edit",
		method:"post"
	});		
	$("form").submit();
}
//글삭제 요청
function del(){
	$("form").attr({
		action:"/board/delete",
		method:"post"
	});		
	$("form").submit();
}
//현재 페이지가 새로고침 (reloading)되지 않게, 비동기방식으로 등록요청을 시도하자!!
//순수 js의 ajax를 사용하면 처리가 복잡하므로, jquery-ajax로 처리해보자!!
function registComment(){
	$.ajax({
		url:"/board/comment_regist",	
		type:"post",
		data:{ 
			msg:$("input[name='msg']").val(),
			author:$("input[name='author']").val(),
			board_id: <%=product.getProduct_id()%>
		},
		//피드백은 success로 받는다, 즉 서버에서 에러없이 데이터가 결과값이 전송되면
		//success 우측에 명시된 익명함수가 동작하게 된다.. 
		success:function(result){
			//alert("서버로 부터 받은 결과 데이터 "+result);
			if(result==1){
				getCommentList();
			}else{
				alert("등록실패");
			}
		}		
	});
	
}
</script>
</head>
<body>

<h3>Contact Form</h3>

<div class="container">
  <form>
  	<input type="hidden" name="product_id" value="<%=product.getProduct_id()%>">
    <%-- <input type="text" name="subcategory_name" value="<%=product.getSubCategory()%>"> --%>
    <input type="text" name="product_name" value="<%=product.getProduct_name()%>">
    <input type="text" name="price" value="<%=product.getPrice()%>">
    <input type="text" name="brand" value="<%=product.getBrand()%>">
    <input type="text" name="quality" value="<%=product.getQuantity()%>">
   <%--  <textarea id="content" name="content" style="height:200px"><%=product.getContent() %></textarea> --%>
    
    <input type="button" value="글수정">
    <input type="button" value="글삭제">
    <input type="button" value="목록보기" onClick="location.href='/board/list'">
	<div class="reply-box">
		<input type="text" name="msg" placeholder="댓글 입력.." style="width:75%">
		<input type="text" name="author" placeholder="작성자 입력.." style="width:15%">
		<button type="button" onClick="registComment()">댓글등록</button>
	</div> 
	<div id="list-area"></div>	   
  </form>
</div>

</body>
</html>
