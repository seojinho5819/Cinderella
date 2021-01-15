package com.project.cinderella.model.product.service;

import java.util.List;

import com.project.cinderella.common.FileManager;
import com.project.cinderella.model.domain.Product;


public interface ProductService {
   public List selectAll(); //모든 상품
   public List selectAllByHit(); //조회수순으로 모든 상품
   public List selectByTopcategoryId(int topcategory_id); //상위 카테고리에 소속된 모든 상품
   public List selectBySubcategoryId(int subcategory_id); //하위 카테고리에 소속된 모든 상품
   public List selectBySize(String size); //사이즈별 모든 상품
   public Product select(int product_id); //아이디로검색
   public Product selectByProductName(String product_name); //제품명으로 검색
   public void regist(FileManager fileManager, Product product); //insert만 하는게 아니기 때문
   public void updateHit(int product_id); //조회수 증가
   public void update(Product product);
   public void delete(int product_id);
}