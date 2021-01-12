<%@page import="com.project.cinderella.model.domain.PhotoReview"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
	List<PhotoReview> photoReviewList = (List)request.getAttribute("photoReviewList");
%>
<!DOCTYPE html>
<html lang="zxx">

<head profile="http://www.w3.org/2005/10/profile">
	

<link rel="icon" type="image/png" href="http://example.com/myicon.png">




    <meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Male-Fashion | Template</title>
	
	<%@ include file="../shop/inc/header.jsp" %>
    <!-- Google Font -->
    <style>
	/* The Modal (background) */
	.searchModal {
		display: none; /* Hidden by default */
		position: fixed; /* Stay in place */
		z-index: 10; /* Sit on top */
		left: 0;
		top: 0;
		width: 100%;
		height: 100%;
		overflow: auto; /* Enable scroll if needed */
		background-color: rgb(0,0,0); /* Fallback color */
		background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
	}
	/* Modal Content/Box */
	.search-modal-content {
		background-color: #fefefe;
		margin: 15% auto; /* 15% from the top and centered */
		padding: 20px;
		border: 1px solid #888;
		width: 35%; /* Could be more or less, depending on screen size */
		height: 30%
	}
	.photoreviewmain{
		width:30%;
		
		float: left;
	}
</style>
<script>
$(function(){
		var d = new Date();
		var currentDate = d.getFullYear() + "년 " + (d.getMonth() + 1) + "월 "
				+ d.getDate() + "일";
		var result = document.getElementById("date-result");
		result.innerHTML =  currentDate;
		
	
	$(".readMore").on("click", function(e){
		
		e.preventDefault();
	 	$("#modal").show();
	 	
		var obj = e.target;
		console.log(obj);
		
	 	var photoreview_id=$(obj).data("photoreview_id");
		var product_name=$(obj).data("product_name");
		var height=$(obj).data("height");
		var brand=$(obj).data("brand");
		var review=$(obj).data("review");
		var filename=$(obj).data("filename");
		
		console.log(photoreview_id);
		console.log(product_name);
		console.log(height);
		console.log(brand);
		console.log(review);
		console.log(filename); 
		//퀵뷰창의 상품 정보에 출력 
		
		//이미지
		$(".photoreviewmain img").attr({
				src:"/cinderella/resources/data/previewbasic/"+photoreview_id+"."+filename
		});
		//제품명
		$(".photoreview1 .product_name").html(product_name);
		$(".photoreview2 .product_height").html(height);
		$(".photoreview3 .product_brand").html(brand);
		$(".photoreview4 .product_review").html(review);
		
		
		
		   
	
	});
});
	function closeModal() {
		$('.searchModal').hide();
	};
	
	
</script>





</head>

<body>
	<%@ include file="../shop/inc/top.jsp" %>
	
	
 
    <!-- Header Section End -->

    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-blog set-bg" data-setbg="/cinderella/resources/img/breadcrumb-bg.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h2>Photo Review</h2>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- Blog Section Begin -->

	<div style="position:relative; left: 200px; top: 20px;"><a href="/cinderella/shop/RegistReview" class="primary-btn" >Regist
	<span class="arrow_right"></span></a></div>
		
		<!-- ------------------------modal start-------------------------- -->
	<div id="modal" class="searchModal">
		<div class="search-modal-content">
			<div class="photoreviewmain">
				<img alt="empty"  class="modalimg" width="117" height="163" >
			</div>
			<div class="photoreview1">
				<h2 class="product_name">MODAL</h2>
			</div>
			<div class="photoreview2">
				<h3 class="product_height">Modal창 테스트입니다.</h3>
			</div>
			<div class="photoreview3">
				<h3 class="product_brand">Modal창 테스트입니다.</h3>
			</div>
			<div class="photoreview4">
				<h4 class="product_review">Modal창 테스트입니다.</h4>
			</div>
			<hr>
			<div
				style="cursor: pointer; background-color: #DDDDDD; text-align: center; padding-bottom: 10px; padding-top: 10px;"
				onClick="closeModal();">
				<span style="font-size: 13pt;">
				</span>
			</div>
		</div>
	</div>

		<!-- ------------------------modal end-------------------------- -->
	<section class="blog spad">
        <div class="container">
            <div class="row">
            <%for(int i=0;i<photoReviewList.size();i++){ %>
            <%PhotoReview photoReview = photoReviewList.get(i);%>
           
                <div class="col-lg-4 col-md-6 col-sm-6">
                	
                    <div class="blog__item">
                        <div class="blog__item__pic set-bg" data-setbg="/cinderella/resources/data/previewbasic/<%=photoReview.getPhotoreview_id() %>.<%=photoReview.getFilename()%>"></div>
                        <div class="blog__item__text">
                            <span><img src="/cinderella/resources/img/icon/calendar.png" alt="" id="date-result"></span>
                            <h5><%=photoReview.getProduct_name()%></h5>
                            <h5><%=photoReview.getReview()%>...</h5>
                            <div class="readMore" >
                            <a  data-target="#modal"
                              data-photoreview_id="<%=photoReview.getPhotoreview_id()%>"
                   			  data-product_name="<%=photoReview.getProduct_name()%>" 
                              data-height="<%=photoReview.getHeight() %>" 
                              data-brand="<%=photoReview.getBrand() %>"  
                              data-review="<%=photoReview.getReview() %>"
                              data-filename="<%=photoReview.getFilename() %>">Read More</a>
                        </div>
                        </div>
                    </div>
                </div>
                <%} %>
               
            </div>
        </div>
    </section>
    <!-- Blog Section End -->

    <!-- Footer Section Begin -->
    <%@ include file="../shop/inc/footer.jsp" %>
    <!-- Footer Section End -->

    <!-- Search Begin -->
    <div class="search-model">
        <div class="h-100 d-flex align-items-center justify-content-center">
            <div class="search-close-switch">+</div>
            <form class="search-model-form">
                <input type="text" id="search-input" placeholder="Search here.....">
            </form>
        </div>
    </div>
    <!-- Search End -->

    <!-- Js Plugins -->
      <script src="/cinderella/resources/js/jquery-3.3.1.min.js"></script>
    <script src="/cinderella/resources/js/bootstrap.min.js"></script>
    <script src="/cinderella/resources/js/jquery.nice-select.min.js"></script>
    <script src="/cinderella/resources/js/jquery.nicescroll.min.js"></script>
    <script src="/cinderella/resources/js/jquery.magnific-popup.min.js"></script>
    <script src="/cinderella/resources/js/jquery.countdown.min.js"></script>
    <script src="/cinderella/resources/js/jquery.slicknav.js"></script>
    <script src="/cinderella/resources/js/mixitup.min.js"></script>
    <script src="/cinderella/resources/js/owl.carousel.min.js"></script>
    <script src="/cinderella/resources/js/main.js"></script>
</body>

</html>