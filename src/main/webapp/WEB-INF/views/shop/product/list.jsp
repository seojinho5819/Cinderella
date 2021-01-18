<%@page import="com.project.cinderella.common.Formatter"%>
<%@page import="com.project.cinderella.model.domain.Product"%>
<%@page import="com.project.cinderella.model.domain.SubCategory"%>
<%@page import="com.project.cinderella.model.domain.TopCategory"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
   //List<TopCategory> topList = (List)request.getAttribute("topList");
   //int topcategory_id = (int)request.getAttribute("topcategory_id");
   List<SubCategory> subList = (List)request.getAttribute("subList");
   //System.out.println("subList" + subList.toString());
   List<Product> productList  = (List)request.getAttribute("productList");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
    <meta name="description" content="Male_Fashion Template">
    <meta name="keywords" content="Male_Fashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Cinderella | ProductList</title>
    <%@ include file="../inc/header.jsp" %>
</head>
<style>
</style>
<script>
function sizeS(){
   var sizeS = document.getElementById('s').value;
   alert("눌렀?"+ sizeS);
   sizeList(sizeS);
}
function sizeM(){
   var sizeM = document.getElementById('m').value;
   alert("눌렀?"+ sizeM);
}
function sizeL(){
   var sizeL = document.getElementById('l').value;
   alert("눌렀?"+ sizeL);
}
<%-- function sizeList(size){
   locathion.href="/cinderella/shop/product/list/topcategory_id=<%=%>size="+size
} --%>
</script>
<body>
<%@ include file="../inc/top.jsp" %>

    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__text">
                            <%-- <%TopCategory topCategory1 = topList.get(topcategory_id-1); %>  --%>
                           <h4>Product -<%--  <%=topCategory1.getTopcategory_name()%> --%></h4>
                        <div class="breadcrumb__links">
                            <a href="/cinderella/">Home</a>
                            <span>Product</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- Shop Section Begin -->
    <section class="shop spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="shop__sidebar">
                        <div class="shop__sidebar__search">
                            <form action="#">
                                <input type="text" placeholder="Search...">
                                <button type="submit"><span class="icon_search"></span></button>
                            </form>
                        </div><!--딱 이 부분만 TopList 불러오는거였어요,, 근데 gender_id를 못받아와서 에러떠요 -->
                        <div class="shop__sidebar__accordion">
                            <div class="accordion" id="accordionExample">
                            <%for(int i=0; i<topList.size(); i++){ %>
                            <%TopCategory topCategory = topList.get(i); %> 
                                <div class="card">
                                    <div class="card-heading">
                                        <a data-toggle="collapse" data-target="#collapseOne">Category > <%=topCategory.getTopcategory_name() %> </a>
                                    </div>
                                    <div id="collapseOne" class="collapse show" data-parent="#accordionExample">
                                        <div class="card-body">
                                            <div class="shop__sidebar__categories">
                                                <ul class="nice-scroll">
                                                  <%for(int j=0; j<topCategory.getSubCategory().size(); j++){ %>
                                                   <%SubCategory subCategory = topCategory.getSubCategory().get(j); %>
                                                    <li><a href="/cinderella/shop/product/sublist?subcategory_id=<%=subCategory.getSubcategory_id()%>"><%=subCategory.getSubcategory_name() %></a></li>
                                                    <%} %> 
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%} %> 
                        
                               
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-9">
                    <div class="shop__product__option">
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="shop__product__option__left">
                                  
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="shop__product__option__right">
                              
                               
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 상품 -->
                    
                    <div class="row">
                               <%for(int i=0; i<productList.size(); i++){ %>
                               <%Product product = productList.get(i); %>
                        <div class="col-lg-4 col-md-6 col-sm-6">
                            <div class="product__item">
                                <div class="product__item__pic set-bg" >
                                   <img src="/cinderella/resources/data/basic/<%=product.getProduct_id()%>.<%=product.getFilename()%>" width="250px" height="200px">
                                    <ul class="product__hover">
                                        <li><a href="#"><img src="/cinderella/resources/img/icon/heart.png" alt=""></a></li>
                                        <li><a href="#"><img src="/cinderella/resources/img/icon/compare.png" alt=""> <span>Compare</span></a> </li>
                                        <li><a href="/cinderella/shop/product/detail?product_id=<%=product.getProduct_id()%>&product_name=<%=product.getProduct_name()%>"><img src="/cinderella/resources/img/icon/search.png" alt=""></a><span>detail</span></li>
                                    </ul>
                                </div>
                                <div class="product__item__text">
                                    <h6><%=product.getProduct_name() %>  (<%=product.getHit() %>)</h6>
                                    <a href="/cinderella/shop/product/detail?product_id=<%=product.getProduct_id()%>" class="add-cart">+ Add To Cart</a>
                                    <div class="rating">
                                        <i class="fa fa-star-o"></i>
                                        <i class="fa fa-star-o"></i>
                                        <i class="fa fa-star-o"></i>
                                        <i class="fa fa-star-o"></i>
                                        <i class="fa fa-star-o"></i>
                                    </div>
                                    <h5><%=Formatter.getCurrency(product.getPrice())%></h5>
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
                                <%} %>
                    </div>
                    
            </div>
        </div>
    </section>
    <!-- Shop Section End -->
    
    <!-- Footer Section Begin -->
   <%@ include file="../inc/footer.jsp" %>
    <!-- Footer Section End -->
           <%@ include file="../inc/bottom.jsp" %>
    
    
</body>
</html>