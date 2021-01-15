package com.project.cinderella.model.product.repository;

import java.util.List;

import com.project.cinderella.model.domain.Psize;


public interface PsizeDAO {
   public List selectAll();//그냥 모든 데이터 가져오기 
   public List selectById(int product_id); //fk에 소속된 모든 데이터 가져오기
   public List selectBySize(String size); //사이즈별 상품
   public Psize select(int psize_id);
   public void insert(Psize psize);
   public void update(Psize psize);
   public void delete(int product_id);
}