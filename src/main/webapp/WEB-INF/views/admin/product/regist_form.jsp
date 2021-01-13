<%@page import="com.project.cinderella.model.domain.TopCategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
   List<TopCategory> topList = (List)request.getAttribute("topList");
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
input[type=checkbox]{
   padding:5px;
   font-size:12px;
}
div.button {
   text-align:center;
   margin: auto;
   width: 50%;
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
/*드래드 관련 */
#dragArea{
   width:100%;
   height:300px;
   overflow:scroll;
   border:2px solid #ccc;
}
.dragBorder{
   background:#BFBFBF;
}
.box{
   width:200px;
   height:150px;
   float:left;
   padding:10px;
}
.box > img{
   width:100%; 
}
.close{
   color:red;
   cursor:pointer;
}
/*태그관련*/
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
<script type="text/javascript">
var uploadFiles=[]; //미리보기 이미지 목록 
var psize=[];
var ptag=[];
var pgender=[];
$(function(){
   CKEDITOR.replace("detail");   
   
   
   //상위 카테고리 선택하면..
   $($("select")[0]).change(function(){
         //비동기 방식으로 서버에 요청하되, 순수 ajax보다는 jquery ajax 를 이용하자!!
         getSubList(this);
      });
   
      /*드래그 관련 이벤트 */
   
   $("#dragArea").on("dragenter", function(e){ //드래그로 영역에 진입했을때...
      //$(this).append("dragenter<br>");
      $(this).addClass("dragBorder");
   });
   
   $("#dragArea").on("dragover", function(e){ //드래그영역 위에 있는 동안...
      //$(this).append("dragover<br>");
      e.preventDefault();
   });
   
   $("#dragArea").on("drop", function(e){ //드래그영역 위에서 이미지를 떨구면..
      e.preventDefault(); //여타 다른 이벤트를 비활성화시키자...
      //$(this).append("drop<br>");
      
      //자바스크립트로 드래그된 이미지 정보를 구해와서, div영역에 미리보기 효과..
      var fileList = e.originalEvent.dataTransfer.files; //드래그한 파일들에 대한 배열 얻기!!
      console.log(fileList);
      
      //배열안에 들어있는 이미지들에 대한 미리보기처리...
      for(var i=0;i<fileList.length;i++){
         uploadFiles.push(fileList[i]); //fileList안의 요소들을 일반배열에 옮겨심기 
         //왜 심었나? 배열이 지원하는 여러 메서드들을 활용하기 위해...(ex : indexOf..)
         preview(uploadFiles[i], i); //파일 요소 하나를 넘기기
      }
   });
   
   $("#dragArea").on("dragleave", function(e){ //드래그 영역에서 빠져나가면
      //$(this).append("dragleave<br>");
      $(this).removeClass("dragBorder");
   });
   
   //이미지 삭제 이벤트 처리 
   $("#dragArea").on("click", ".close", function(e){
      console.log(e);
      
      //대상 요소 배열에서 삭제
      //삭제전에 uploadFiles 라는 배열에 들어있는 file의 index를 구하자!!
      var f = uploadFiles[e.target.id];
      var index = uploadFiles.indexOf(f); //파일 객체가 몇번째 들어있는지 추출
      
      //alert(e.target.id+"클릭햇어?");
      uploadFiles.splice(index ,1);
      
      //대상 요소 삭제 (시각적으로 삭제)
      $(e.target).parent().remove();
   });
   
   //사이즈 체크박스 이벤트 구현 
   $("input[type='checkbox']").on("click", function(e){
      var ch = e.target;//이벤트 일으킨 주체컴포넌트 즉 체크박스
      //체크박스의 길이 얻기 
      var ch=$("input[name='size']");
      var len =$(ch).length; //반복문이용하려고..
   
      psize=[];//배열 초기화
      
      for(var i=0;i<len;i++){
         //만일 체크가 되어있다면, 기존 배열을 모두 지우고, 체크된 체크박스 값만 배열에 넣자!!
         if($($(ch)[i]).is(":checked")){
            psize.push($($(ch)[i]).val());
         }
         console.log(i,"번째 체크박스 상태는 ", $($(ch)[i]).is(":checked"));
      }      
      console.log("서버에 전송할 사이즈 배열의 구성은 ", psize);
   });
   
   //태그 체크박스 이벤트 구현 
   $("input[type='checkbox']").on("click", function(e){
      var ch2 = e.target;//이벤트 일으킨 주체컴포넌트 즉 체크박스
      //체크박스의 길이 얻기 
      var ch2=$("input[name='tag']");
      var len2 =$(ch2).length; //반복문이용하려고..
   
      ptag=[];//배열 초기화
      
      for(var i=0;i<len2;i++){
         //만일 체크가 되어있다면, 기존 배열을 모두 지우고, 체크된 체크박스 값만 배열에 넣자!!
         if($($(ch2)[i]).is(":checked")){
            ptag.push($($(ch2)[i]).val());
         }
         console.log(i,"번째 체크박스 상태는 ", $($(ch2)[i]).is(":checked"));
      }      
      console.log("서버에 전송할 사이즈 배열의 구성은 ", ptag);
   });
   
   //성별 체크박스 이벤트 구현 
   $("input[type='checkbox']").on("click", function(e){
      var ch3 = e.target;//이벤트 일으킨 주체컴포넌트 즉 체크박스
      //체크박스의 길이 얻기 
      var ch3=$("input[name='gender']");
      var len3 =$(ch3).length; //반복문이용하려고..
   
      pgender=[];//배열 초기화
      
      for(var i=0;i<len3;i++){
         //만일 체크가 되어있다면, 기존 배열을 모두 지우고, 체크된 체크박스 값만 배열에 넣자!!
         if($($(ch3)[i]).is(":checked")){
            pgender.push($($(ch3)[i]).val());
         }
         console.log(i,"번째 체크박스 상태는 ", $($(ch3)[i]).is(":checked"));
      }      
      console.log("서버에 전송할 사이즈 배열의 구성은 ", pgender);
   });
   
});

//업로드 이미지 미리보기
function preview(file, index){
   //js로 이미지 미리보기를 구현하려면, 파일리더를 이용하면 된다 FileReader
   var reader = new FileReader(); //아직은 읽을 대상 파일이 결정되지 않음..
   //파일일 읽어들이면, 이벤트 발생시킴 
   reader.onload=function(e){
      console.log(e.currentTarget.result);
      
      var tag="<div class=\"box\">";
      tag+="<div class=\"close\" id=\""+index+"\">X</div>";
      tag+="<img src=\""+e.currentTarget.result+"\">";
      tag+="</div>";
      
      $("#dragArea").append(tag);
   };
   
   reader.readAsDataURL(file); //지정한 파일을 읽는다(매개변수로는 파일이 와야함)
}
   
//비동기 방식으로 하위 카테고리 요청하기!!
function getSubList(obj){
      //alert($(obj).val());
      
      $.ajax({
         url:"/cinderella/admin/product/sublist", 
         type:"get",
         data:{
            topcategory_id:$(obj).val()         
         },
         success:function(result){
            //서버가 이미  json 으로 전송해주었으므로 별도의  parsing이 필요없다!!
            //기존 option태그를 먼저 지우자!!
            $($("select")[1]).empty();
            $($("select")[1]).append("<option>하위 카테고리 선택</option>");
            
            for(var i=0;i<=result.length;i++){
               var subCategory = result[i]; //subcategory 1건에 대한 json 객체얻기!!
               $($("select")[1]).append("<option value=\""+subCategory.subcategory_id+"\">"+subCategory.subcategory_name+"</option>");
            }
         }
      });
   }

//상품 등록
function regist(){
   /*비동기 전송시, 기존의 form을 이용할수 있을까?  yes!!*/
   //$("textarea").val(CKEDITOR.instances.detail.getData());
   
   var formData = new FormData($("form")[0]);//<form>태그와는 틀리다..전송할때 파라미터들을 담을수있지만 이 자체가
                                       //폼태그는 아니다!!
   
   //미리보기했떤 이미지들은 파일컴포넌트화 되어있지 않기 때문에 , 전송데이터에서 빠져잇다..
   //따라서 formData전송 전에, 동적으로 파일컴포넌트화시켜 formData에 추가하자!!!
   //java에서의 improved for문과 동일한 역할(주로 컬렉션에서 객체를 꺼낼때 편하게 사용..)
   $.each(uploadFiles, function( i, file){
      formData.append("addImg", file,  file.name); // <input type="file" name="addImg> 동일한 효과
      console.log(file.name);
   });   
   
   //폼데이터에 에디터의 값 추가하기
   formData.append("detail", CKEDITOR.instances["detail"].getData());
   
   //사이즈
   for(var i=0;i<psize.length;i++){
      formData.append("psize["+i+"].fit", psize[i]);
   }
   
   //태그
    for(var i=0;i<ptag.length;i++){
      formData.append("ptag["+i+"].tag_name", ptag[i]);
   }
   
   //성별
    for(var i=0;i<pgender.length;i++){
      formData.append("pgender["+i+"].gender_name", pgender[i]);
   }
   
   /*비동기 업로드*/
   $.ajax({
      url:"/cinderella/admin/product/regist",
      data:formData,
      contentType:false, /* false일 경우 multipart/form-data*/
      processData:false, /* false일 경우 query-string으로 전송하지 않음*/
      type:"post",
      success:function(responseData){
         var json = JSON.parse(responseData); //String -> Json으로 파싱
         if(json.result==1){
            alert(json.msg);
            location.href="/cinderella/admin/product/list";
         }else {
            alert(json.msg);
         }
      }
   });
   
   /* 동기방식 업로드    
   $("form").attr({
      action:"/admin/product/regist",
      method:"post",
      enctype:"multipart/form-data"
   });   
   $("form").submit();
   */
}
</script>
</head>
<body>
<%@ include file="../inc/main_navi.jsp" %>

<h2 style="text-align:center">[ 상품등록 ]</h2>
<div class="container">
  <form>
     
     <select name="topcategory_id">
        <option>상위카테고리 선택</option>
        <%for(TopCategory topCategory : topList){%>
        <option value="<%=topCategory.getTopcategory_id()%>"><%=topCategory.getTopcategory_name()%></option>
        <%} %>
     </select>
     
     
    <select name="subCategory.subcategory_id">
        <option>하위카테고리 선택</option>
     </select>
     
    <input type="text" name="product_name" placeholder="상품명">
    <input type="text" name="price" placeholder="가격">
    <input type="text" name="brand" placeholder="브랜드">
    
   <!-- 파일 최대 4개까지 지원 -->
   <p>대표이미지 :     <input type="file"  name="repImg"></p>
   
   <div id="dragArea"><p align="center">추가 이미지를 드래그하세요.</p></div>
   
   <!-- 성별 선택  -->
   <div id="genders">
   <label for="genders"><b>성별</b></label><br>
       Woman<input type="checkbox"       name="gender" value="woman">
      Man<input type="checkbox"       name="gender" value="man">
   </div>
   
   <!-- 태그 추가 -->
   <div id="tags">
   <label for="tags"><b>상품 태그</b></label><br>
         데일리룩<input type="checkbox"    name="tag" value="데일리룩">
         하객룩<input type="checkbox"    name="tag" value="하객룩">
         오피스룩<input type="checkbox"    name="tag" value="오피스룩">
         캔버스룩<input type="checkbox"    name="tag" value="캔버스룩">
         커플룩<input type="checkbox"    name="tag" value="커플룩">
         스트릿<input type="checkbox"    name="tag" value="스트릿">
         세일중<input type="checkbox"    name="tag" value="세일중">
         트레이닝복<input type="checkbox"    name="tag" value="트레이닝복">
         로맨틱<input type="checkbox"    name="tag" value="로맨틱">
         파티<input type="checkbox"    name="tag" value="파티">
   </div>
   
   <br>
   
   <!-- 지원 사이즈 선택  -->
   <div id="sizes" style="margin-bottom:20px">
   <label for="tags"><b>상품 사이즈</b></label><br>
       S<input type="checkbox"       name="size" value="S">
      M<input type="checkbox"       name="size" value="M">
      L<input type="checkbox"       name="size" value="L">
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
      <input type="color" name="color[6].picker" value="#A349A4">
   </div>
   
    <textarea id="detail" name="detail" placeholder="상세정보.." style="height:200px"></textarea>
    
    <div class=buttons" style="text-align:center">
       <input type="button" value="글등록" onClick="regist()" style="text-align:center">
       <input type="button" value="목록보기" onClick="location.href='/cinderella/admin/product/list'">
    </div>
  </form>
</div>

</body>
</html>