	<%@page import="com.project.cinderella.model.domain.PhotoReview"%>
<%@page import="java.util.List"%>
<%@page import="com.project.cinderella.model.domain.Tag"%>
	<%@page import="com.project.cinderella.common.Pager"%>
	<%@page import="com.project.cinderella.model.domain.Comments"%>
	<%@ page contentType="text/html; charset=utf-8"%>
	<%@page import="com.project.cinderella.model.domain.Color"%>
	<%@page import="com.project.cinderella.model.domain.Psize"%>
	<%@page import="com.project.cinderella.common.Formatter"%>
	<%@page import="com.project.cinderella.model.domain.Image"%>
	<%@page import="com.project.cinderella.model.domain.Product"%>
	<%
	   Product product = (Product)request.getAttribute("product");
	   List<PhotoReview> photoReviewList = (List)request.getAttribute("photoReviewList");
	   List<Comments> commentsList = (List)request.getAttribute("commentsList");
	   Pager pager=new Pager();
	   pager.init(request, commentsList);
	
	%>
	
	<!DOCTYPE html>
	<html lang="zxx">
	<head>
		<meta charset="UTF-8">
	<meta name="description" content="Male_Fashion Template">
	<meta name="keywords" content="Male_Fashion, unica, creative, html">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>Male-Fashion | Template</title>
	<%@ include file="../inc/header.jsp" %>
	<style>
	/* The container */
	.container {
	  display: block;
	  position: relative;
	  padding-left: 35px;
	  margin-bottom: 12px;
	  cursor: pointer;
	  font-size: 22px;
	  -webkit-user-select: none;
	  -moz-user-select: none;
	  -ms-user-select: none;
	  user-select: none;
	}
	/* Create a custom radio button */
	.checkmark {
	  position: absolute;
	  top: 0;
	  left: 0;
	  height: 25px;
	  width: 25px;
	  background-color: #eee;
	  border-radius: 50%;
	}
	
	/* On mouse-over, add a grey background color */
	.container:hover input ~ .checkmark {
	  background-color: #ccc;
	}
	
	/* When the radio button is checked, add a blue background */
	.container input:checked ~ .checkmark {
	  background-color: #808080;
	}
	
	/* Create the indicator (the dot/circle - hidden when not checked) */
	.checkmark:after {
	  content: "";
	  position: absolute;
	  display: none;
	}
	
	/* Show the indicator (dot/circle) when checked */
	.container input:checked ~ .checkmark:after {
	  display: block;
	}
	
	/* Style the indicator (dot/circle) */
	.container .checkmark:after {
	 	top: 9px;
		left: 9px;
		width: 8px;
		height: 8px;
		border-radius: 50%;
		color:white;
		background: black;
	}
	 table {
	  border-collapse: collapse;
	  border-spacing: 0;
	  width: 100%;
	  border: 1px solid #ddd;
	}
	th, td {
	  text-align: left;
	  padding: 16px;
	}
	tr:nth-child(even) {
	  background-color: #f2f2f2;
	}
	img{
	   box-sizing:border-box;
	}
	a {
	
	   text-decoration:none; 
	}
	 
	</style>
	 <script>
	 //장바구니 담기
	 function addCart(){
	      var formData = $("#cart_form").serialize(); //파라미터를 전송할 수 있는 상태의 문자열로 나열해준다
	      $.ajax({
	         url:"/cinderella/shop/cart/regist",
	         type:"post",
	         data:formData,
	         success:function(responseData){
	            if(responseData.resultCode==1){
	               if(confirm(responseData.msg+"\n장바구니에 담긴 상품을 보러갈까요?")){
	                  location.href=responseData.url;
	               }
	            }else{
	               alert(responseData.msg);
	            }
	         }
	      });
	   }
	
	  //요청이 완료되는 시점에 프로그래스바를 감춘다!!
	  function regist(){
	     //로딩바 시작
	     //$("#loader").addClass("loader"); //class 동적 적용
	     //form 태그의 파라미터들을 전송할수있는 상태로 둬야  data키값에 form 자체를 넣을 수 있다.
	     var formData = $("#comments_form").serialize(); //전부 문자열화 시킨다!!
	     
	     $.ajax({
	        url:"/cinderella/shop/product/comment_regist", 
	        type:"post",
	        data:formData,
	        success:function(responseData){
	           //서버로부터 완료 응답을 받으면 로딩바 효과를 중단!!
	           //$("#loader").removeClass("loader"); //class 동적 제거
	           var json = JSON.parse(responseData);
	           if(json.result==1){
	              alert(json.msg);
	              location.href="/cinderella/shop/product/detail?product_id=<%=product.getProduct_id()%>"; 
	           }else{
	              alert(json.msg);
	           }
	        }
	     });
	  }
	  
	  function deleteComment(){
	     var comment_id = document.getElementById('comment_id_image').value;
	     alert(comment_id);
	     
	     if(confirm("댓글 삭제를 하시겠습니까?")){
	         location.href="/cinderella/shop/product/comment_delete?comment_id="+comment_id;
	      }   
	     
	     <%--  $.ajax({
	           url:"/cinderella/shop/product/comment_delete?comment_id="+comment_id
	           type:"post",
	           data:{
	              comment_id:$("img[name='comment_id_image']").val()
	           },
	           success:function(responseData){
	              //서버로부터 완료 응답을 받으면 로딩바 효과를 중단!!
	              //$("#loader").removeClass("loader"); //class 동적 제거
	              var json = JSON.parse(responseData);
	              if(json.result==1){
	                 alert(json.msg);
	                 location.href="/cinderella/shop/product/detail?product_id=<%=product.getProduct_id()%>"; 
	              }else{
	                 alert(json.msg);
	              }
	           }
	        });    --%>
	  }
	 </script>
	</head>
	<body>
	<%@ include file="../inc/top.jsp" %>
	     <!-- Shop Details Section Begin -->
	    <section class="shop-details">
	        <div class="product__details__pic">
	            <div class="container">
	                <div class="row">
	                    <div class="col-lg-12">
	                        <div class="product__details__breadcrumb">
	                            <a href="/cinderella/">Home</a>
	                            <a href="#">Product</a>
	                            <span>Product Details</span>
	                        </div>
	                    </div>
	                </div>
	                <div class="row">
	                    <div class="col-lg-3 col-md-3">
	                        <ul class="nav nav-tabs" role="tablist">
	                                 
	                            <li class="nav-item">
	                                <a class="nav-link active" data-toggle="tab" href="#tabs-1" role="tab">
	                                    <div class="product__thumb__pic set-bg"> <img src="/cinderella/resources/data/basic/<%=product.getProduct_id()%>.<%=product.getFilename()%>" >
	                                    </div>
	                                </a>
	                            </li>
	                           
	                            <%for(int i=0;i<product.getImageList().size();i++){ %>
	                                   <%Image image = product.getImageList().get(i); %>
	                                   <%if(i>=4)break; //총 4개까지만 허용할 것이므로..%>
	                            <li class="nav-item">
	                                <a class="nav-link" data-toggle="tab" href="#tabs-<%=i+2 %>" role="tab">
	                                    <div class="product__thumb__pic set-bg"><img src="/cinderella/resources/data/addon/<%=image.getImage_id()%>.<%=image.getFilename()%>" >
	                                    </div>
	                                </a>
	                            </li> 
	                            <%} %>
	                        </ul>
	                    </div>
	                    
	                    <div class="col-lg-6 col-md-9">
	                        <div class="tab-content">
	                            <div class="tab-pane active" id="tabs-1" role="tabpanel">
	                                <div class="product__details__pic__item">
	                                    <img src="/cinderella/resources/data/basic/<%=product.getProduct_id()%>.<%=product.getFilename()%>" alt="">
	                                </div>
	                            </div>
	                            <%for(int j=0;j<product.getImageList().size();j++){ %>
	                                   <%Image image = product.getImageList().get(j); %>
	                                   <%if(j>=4)break; //총 4개까지만 허용할 것이므로..%>
	                            <div class="tab-pane" id="tabs-<%=j+2 %>" role="tabpanel">
	                                <div class="product__details__pic__item">
	                                    <img src="/cinderella/resources/data/addon/<%=image.getImage_id()%>.<%=image.getFilename()%>" alt="">
	                                </div>
	                            </div>
	                             <%} %>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	
	        <div class="product__details__content">
	            <div class="container">
	                <div class="row d-flex justify-content-center">
	                    <div class="col-lg-8">
	                        <div class="product__details__text">
	                               <h4><%=product.getProduct_name() %></h4>
	                            <div class="rating">
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star-o"></i>
	                                <span> - 5 Reviews</span>
	                            </div>
	                            
	                          <form id="cart_form">
	                             <input type="hidden" name="product_id" value="<%=product.getProduct_id() %>">
	                               <h3><%=Formatter.getCurrency(product.getPrice()) %><span>70.00</span></h3>
	                               <p><%=product.getDetail() %></p>
	                            <div class="product__details__option">
	                                <div class="product__details__option__size">
	                                    <span>Size:</span>
	                                      <%for(Psize psize : product.getPsizeList()){ %>
	                                        <label class="container"><%=psize.getFit() %>
											  <input type="radio" checked="checked" name="ppsize" value="<%=psize.getFit() %>">
											  <span class="checkmark" name="ppsize"></span>
											</label>
	                          			 <%} %>
	                                </div>
	                                <br>
	                                <div class="product__details__option__size" >
	                                    <span>Tag:</span>
	                                     <%for(Tag tag: product.getTagList()){ %>
	                                        <label class="active" for="xxl"  style="margin-top:20px"><%=tag.getTag_name() %>
	                                        <input type="radio" id="xxl">
	                                    </label>
	                           <%} %>
	                                </div>
	                                <br>
	                                <div class="product__details__option__color">
	                                   <span>Color:</span>
	                                   <%for(Color color: product.getColorList()) {%>
	                                       <label class="c-1" for="sp-1" style="background-color:<%=color.getPicker() %> ">
	                                           <input type="radio" id="sp-1" >
	                                       </label>
	                                   <%} %>
	                                </div>
	                                
	                            </div>
	                            <div class="product__details__cart__option">
	                                <div class="quantity">
	                                    <div class="pro-qty">
	                                        <input type="text" name="quantity" value="1">
	                                    </div>
	                                </div>
	                                <a href="#" class="primary-btn" onClick="addCart()">add to cart</a>
	                            </div>
	                         </form>
	                            <div class="product__details__btns__option">
	                                <a href="#"><i class="fa fa-heart"></i> add to wishlist</a>
	                                <a href="#"><i class="fa fa-exchange"></i> Add To Compare</a>
	                            </div>
	                            <div class="product__details__last__option">
	                                <h5><span>Guaranteed Safe Checkout</span></h5>
	                                <img src="/cinderella/resources/img/shop-details/details-payment.png" alt="">
	                                <ul>
	                                    <li><span>SKU:</span> 3812912</li>
	                                    <li><span>Categories:</span> Clothes</li>
	                                    <li><span>Tag:</span> Clothes, Skin, Body</li>
	                                </ul>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="row">
	                    <div class="col-lg-12">
	                        <div class="product__details__tab">
	                            <ul class="nav nav-tabs" role="tablist">
	                                <li class="nav-item">
	                                    <a class="nav-link active" data-toggle="tab" href="#tabs-5" role="tab">Comment</a>
	                                </li>
	                                <li class="nav-item">
	                                    <a class="nav-link" data-toggle="tab" href="#tabs-6" role="tab">Customer PhotoReviews(<%=photoReviewList.size() %>)</a>
	                                </li>
	                            <!--     <li class="nav-item">
	                                    <a class="nav-link" data-toggle="tab" href="#tabs-7" role="tab">Additional
	                                    information</a>
	                                </li> -->
	                            </ul>
	                            
	                            <!-- 댓글/대댓글 -->
							<div class="tab-content">
								<div class="tab-pane active" id="tabs-5" role="tabpanel">
									<div class="product__details__tab__content">
										<p class="note">
										<div class="reply-box">
											<form id="comments_form">
												<input type="hidden" name="product_id"
													value="<%=product.getProduct_id()%>"> <input
													type="text" name="comment_content" placeholder="댓글 입력.."
													style="width: 70%"> <input type="text"
													name="comment_writer" placeholder="작성자 입력.."
													style="width: 15%"> <input type="button"
													value="댓글 등록" onClick="regist()">
											</form>
										</div>
										<div id="list-area"></div>
										</p>

										<div class="product__details__tab__content__item">
											<h5 style="text-align: center">Product Comment List</h5>
											<table>
												<tr>
													<th>No</th>
													<th>제목</th>
													<th>작성자</th>
													<th>등록일</th>
													<th>삭제</th>
												</tr>
												<%int curPos=pager.getCurPos(); int num=pager.getNum();%>
												<%for(int i=0;i<pager.getPageSize();i++){ %>
												<%if(pager.getNum()<=i)break; %>

												<%Comments comments = commentsList.get(curPos++); %>
												<tr>
													<input type="hidden" name="comment_id"
														value="<%= comments.getComment_id() %> ">
													<td><%=num--%></td>
													<td><%=comments.getComment_content() %></td>
													<td><%=comments.getComment_writer() %></td>
													<td><%=comments.getRegdate() %></td>
													<td><input type="button" onClick="deleteComment()"
														id="comment_id_image"
														value="<%=comments.getComment_id()%>" img
														src="/cinderella/resources/img/icon/delete.png"> <%--  <img src="/cinderella/resources/img/icon/delete.png" width="30px" height="30px" onClick="deleteComment()" id="comment_id_image" value="<%=comments.getComment_id()%>"></td> --%>
												</tr>
												<%} %>
												<tr>
													<td colspan="5" style="text-align: center"><a
														href="/cinderella/shop/product/detail?currentPage=<%if(pager.getFirstPage()==1){%>1<%}else{ %><%=pager.getFirstPage()-1%><a href="javascript:alert('첫 페이지입니다');"><%}%>">◀</a>
														<%for(int i=pager.getFirstPage();i<=pager.getLastPage();i++){ %>
														<%if(i>pager.getTotalPage())break;//총 페이지수를 넘어서면... %> <a
														<%if(pager.getCurrentPage()==i){%> class="pageNum" <%}%>
														href="/cinderella/shop/product/detail?currentPage=<%=i%>">[<%=i %>]
													</a> <%} %> <a
														href="/cinderella/shop/product/detail?currentPage=<%if(pager.getLastPage()>=pager.getTotalPage()){%><%=pager.getTotalPage()%><%}else{ %><%=pager.getLastPage()+1%><%}%>">▶</a>
													</td>
												</tr>

											</table>

										</div>
									</div>
								</div>


								<div class="tab-pane" id="tabs-6" role="tabpanel">
									<div class="product__details__tab__content">
										<div class="product__details__tab__content__item">
											<section class="blog spad">
												<div class="container">
													<div class="row">
														<%for (int i = 0; i < photoReviewList.size(); i++) {%>
														<%PhotoReview photoReview = photoReviewList.get(i);%>
														<div class="col-lg-4 col-md-6 col-sm-6">
															<div class="blog__item">
																<div class="blog__item__pic set-bg"
																	data-setbg="/cinderella/resources/data/previewbasic/<%=photoReview.getPhotoreview_id()%>.<%=photoReview.getFilename()%>"></div>
																<div class="blog__item__text">
																	<h5><%=photoReview.getReview()%>...</h5>
																	<h6>작성자-<%=photoReview.getUser_id()%></h6>
																</div>
															</div>
														</div>
														<%}%>

													</div>
												</div>
											</section>
										</div>
									</div>
								</div>


							</div>
						</div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </section>
	    <!-- Shop Details Section End -->
	
	    <!-- Related Section Begin -->
	    <section class="related spad">
	        <div class="container">
	            <div class="row">
	                <div class="col-lg-12">
	                    <h3 class="related-title">Related Product</h3>
	                </div>
	            </div>
	            <div class="row">
	                <div class="col-lg-3 col-md-6 col-sm-6 col-sm-6">
	                    <div class="product__item">
	                        <div class="product__item__pic set-bg" data-setbg="img/product/product-1.jpg">
	                            <span class="label">New</span>
	                            <ul class="product__hover">
	                                <li><a href="#"><img src="/cinderella/resources/img/icon/heart.png" alt=""></a></li>
	                                <li><a href="#"><img src="/cinderella/resources/img/icon/compare.png" alt=""> <span>Compare</span></a></li>
	                                <li><a href="#"><img src="/cinderella/resources/img/icon/search.png" alt=""></a></li>
	                            </ul>
	                        </div>
	                        <div class="product__item__text">
	                            <h6>Piqué Biker Jacket</h6>
	                            <a href="#" class="add-cart">+ Add To Cart</a>
	                            <div class="rating">
	                                <i class="fa fa-star-o"></i>
	                                <i class="fa fa-star-o"></i>
	                                <i class="fa fa-star-o"></i>
	                                <i class="fa fa-star-o"></i>
	                                <i class="fa fa-star-o"></i>
	                            </div>
	                            <h5>$67.24</h5>
	                            <div class="product__color__select">
	                                <label for="pc-1">
	                                    <input type="radio" id="pc-1">
	                                </label>
	                                <label class="active black" for="pc-2">
	                                    <input type="radio" id="pc-2">
	                                </label>
	                                <label class="grey" for="pc-3">
	                                    <input type="radio" id="pc-3">
	                                </label>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-lg-3 col-md-6 col-sm-6 col-sm-6">
	                    <div class="product__item">
	                        <div class="product__item__pic set-bg" data-setbg="img/product/product-2.jpg">
	                            <ul class="product__hover">
	                                <li><a href="#"><img src="/cinderella/resources/img/icon/heart.png" alt=""></a></li>
	                                <li><a href="#"><img src="/cinderella/resources/img/icon/compare.png" alt=""> <span>Compare</span></a></li>
	                                <li><a href="#"><img src="/cinderella/resources/img/icon/search.png" alt=""></a></li>
	                            </ul>
	                        </div>
	                        <div class="product__item__text">
	                            <h6>Piqué Biker Jacket</h6>
	                            <a href="#" class="add-cart">+ Add To Cart</a>
	                            <div class="rating">
	                                <i class="fa fa-star-o"></i>
	                                <i class="fa fa-star-o"></i>
	                                <i class="fa fa-star-o"></i>
	                                <i class="fa fa-star-o"></i>
	                                <i class="fa fa-star-o"></i>
	                            </div>
	                            <h5>$67.24</h5>
	                            <div class="product__color__select">
	                                <label for="pc-4">
	                                    <input type="radio" id="pc-4">
	                                </label>
	                                <label class="active black" for="pc-5">
	                                    <input type="radio" id="pc-5">
	                                </label>
	                                <label class="grey" for="pc-6">
	                                    <input type="radio" id="pc-6">
	                                </label>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-lg-3 col-md-6 col-sm-6 col-sm-6">
	                    <div class="product__item sale">
	                        <div class="product__item__pic set-bg" data-setbg="img/product/product-3.jpg">
	                            <span class="label">Sale</span>
	                            <ul class="product__hover">
	                                <li><a href="#"><img src="/cinderella/resources/img/icon/heart.png" alt=""></a></li>
	                                <li><a href="#"><img src="/cinderella/resources/img/icon/compare.png" alt=""> <span>Compare</span></a></li>
	                                <li><a href="#"><img src="/cinderella/resources/img/icon/search.png" alt=""></a></li>
	                            </ul>
	                        </div>
	                        <div class="product__item__text">
	                            <h6>Multi-pocket Chest Bag</h6>
	                            <a href="#" class="add-cart">+ Add To Cart</a>
	                            <div class="rating">
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star"></i>
	                                <i class="fa fa-star-o"></i>
	                            </div>
	                            <h5>$43.48</h5>
	                            <div class="product__color__select">
	                                <label for="pc-7">
	                                    <input type="radio" id="pc-7">
	                                </label>
	                                <label class="active black" for="pc-8">
	                                    <input type="radio" id="pc-8">
	                                </label>
	                                <label class="grey" for="pc-9">
	                                    <input type="radio" id="pc-9">
	                                </label>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-lg-3 col-md-6 col-sm-6 col-sm-6">
	                    <div class="product__item">
	                        <div class="product__item__pic set-bg" data-setbg="img/product/product-4.jpg">
	                            <ul class="product__hover">
	                                <li><a href="#"><img src="/cinderella/resources/img/icon/heart.png" alt=""></a></li>
	                                <li><a href="#"><img src="/cinderella/resources/img/icon/compare.png" alt=""> <span>Compare</span></a></li>
	                                <li><a href="#"><img src="/cinderella/resources/img/icon/search.png" alt=""></a></li>
	                            </ul>
	                        </div>
	                        <div class="product__item__text">
	                            <h6>Diagonal Textured Cap</h6>
	                            <a href="#" class="add-cart">+ Add To Cart</a>
	                            <div class="rating">
	                                <i class="fa fa-star-o"></i>
	                                <i class="fa fa-star-o"></i>
	                                <i class="fa fa-star-o"></i>
	                                <i class="fa fa-star-o"></i>
	                                <i class="fa fa-star-o"></i>
	                            </div>
	                            <h5>$60.9</h5>
	                            <div class="product__color__select">
	                                <label for="pc-10">
	                                    <input type="radio" id="pc-10">
	                                </label>
	                                <label class="active black" for="pc-11">
	                                    <input type="radio" id="pc-11">
	                                </label>
	                                <label class="grey" for="pc-12">
	                                    <input type="radio" id="pc-12">
	                                </label>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </section>
	    <!-- Related Section End -->
	   <%@ include file="../inc/footer.jsp" %>
	   <%@ include file="../inc/bottom.jsp" %>
	</body>
	
	</html>