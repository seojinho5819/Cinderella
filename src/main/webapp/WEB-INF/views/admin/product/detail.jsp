<%@page import="com.project.cinderella.model.domain.Psize"%>
<%@page import="com.project.cinderella.model.domain.Tag"%>
<%@page import="com.project.cinderella.model.domain.Gender"%>
<%@page import="com.project.cinderella.model.domain.Product"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	//정말로 포워딩이 요청을 유지햇는지 테스트해보자!!
	Product product =(Product)request.getAttribute("product");
		
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="../inc/header.jsp" %>
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
/*태그관련*/
#tags{
	float:left;
	width:100%;
	height:50px;
	border:2px solid #ccc;
	padding:5px;
	margin-top: 40px;
}
.tag{
	font-size:18px;
	padding:5px;
}
#tags, #sizes, #genders{
	float:left;
	width:100%;
	height:80px;
	border:2px solid #ccc;
	padding-top:15px;
	padding-bottom:15px;
	padding-left:10px;
	margin-top: 40px;
}
.tag, .size, .gender{
	font-size:18px;
	padding:5px;
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
	
	//성별 체크 확인
	$("input:checkbox[name='gender']").each(function() {
		<%for(Gender gender : product.getGenderList()){ %>
	     if(this.value == "<%=gender.getGender_name()%>"){ //값 비교
	            this.checked = true; //checked 처리
	      }
		<%}%>
	 });
	//태그 체크 확인
	$("input:checkbox[name='tag']").each(function() {
		<%for(Tag tag: product.getTagList()){ %>
	     if(this.value == "<%=tag.getTag_name()%>"){ //값 비교
	            this.checked = true; //checked 처리
	      }
		<%}%>
	 });
	//사이즈 체크 확인
	$("input:checkbox[name='size']").each(function() {
		<%for(Psize size: product.getPsizeList()){ %>
	     if(this.value == "<%=size.getFit()%>"){ //값 비교
	            this.checked = true; //checked 처리
	      }
		<%}%>
	 });
	
});
//글등록 요청
function edit(){
	$("form").attr({
		action:"/cinderella/admin/product/edit",
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
</script>
</head>
<body>
<%@ include file="../inc/main_navi.jsp" %>

<h2 style="text-align:center">[ 상품 정보 ]</h2>

<div class="container">
  <form>
  	<input type="hidden" name="product_id" value="<%=product.getProduct_id()%>">
    <%-- <input type="text" name="subcategory_name" value="<%=product.getSubCategory()%>"> --%>
    <label for="product_name"><b>상품 이름</b></label>
    <input type="text" name="product_name" value="<%=product.getProduct_name()%>">
    <label for="price"><b>상품 가격</b></label>
    <input type="text" name="price" value="<%=product.getPrice()%>">
    <label for="brand"><b>상품 브랜드</b></label>
    <input type="text" name="brand" value="<%=product.getBrand()%>">
    <label for="content"><b>상품 상세 정보</b></label>
   <textarea id="content" name="content" style="height:200px"><%=product.getDetail()%></textarea>
    
    
     <!-- 성별 선택  -->
   <div id="genders">
   <label for="genders"><b>성별</b></label><br>
    			woman<input type="checkbox" 		name="gender" value="woman">
				man<input type="checkbox" 		name="gender" value="man">
   </div>
   
   <!-- 태그 추가 -->
   <div id="tags">
   <label for="tags"><b>상품 태그</b></label><br>
   		데일리룩<input type="checkbox" 	name="tag" value="데일리룩">
   		하객룩<input type="checkbox" 	name="tag" value="하객룩">
   		오피스룩<input type="checkbox" 	name="tag" value="오피스룩">
   		캔버스룩<input type="checkbox" 	name="tag" value="캔버스룩">
   		커플룩<input type="checkbox" 	name="tag" value="커플룩">
   		스트릿<input type="checkbox" 	name="tag" value="스트릿">
   		세일중<input type="checkbox" 	name="tag" value="세일중">
   		트레이닝복<input type="checkbox" 	name="tag" value="트레이닝복">
   		로맨틱<input type="checkbox" 	name="tag" value="로맨틱">
   		파티<input type="checkbox" 	name="tag" value="파티">
   </div>
   
   <br>
   
   <!-- 지원 사이즈 선택  -->
   <div id="sizes" style="margin-bottom:20px">
   <label for="tags"><b>상품 사이즈</b></label><br>
    	S<input type="checkbox" 		name="size" value="S">
		M<input type="checkbox" 		name="size" value="M">
		L<input type="checkbox" 		name="size" value="L">
   </div>
   
   <!-- 지원 색상 -->
	<div id="colors" style="margin-bottom:30px">
   <label for="colors"><b>상품 색상</b></label><br>
		<input type="color" name="color[0].picker" value="#000000">
		<input type="color" name="color[1].picker" value="#FFFFFF">
		<input type="color" name="color[2].picker" value="#ED1C24">
		<input type="color" name="color[3].picker" value="#FF7F27">
		<input type="color" name="color[4].picker" value="#FFF200">
		<input type="color" name="color[5].picker" value="#3F48CC">
		<input type="color" name="color[5].picker" value="#A349A4">
	</div>
	
    <input type="button" value="글수정" onClick="edit()">
    <input type="button" value="글삭제">
    <input type="button" value="목록보기" onClick="location.href='/cinderella/admin/product/list'">
	<div id="list-area"></div>	   
  </form>
</div>

</body>
</html>
