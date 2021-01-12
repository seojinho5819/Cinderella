package com.project.cinderella.model.product.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.cinderella.model.domain.SubCategory;

@Repository
public class MybatisSubCategoryDAO implements SubCategoryDAO{

   @Autowired
   private SqlSessionTemplate sessionTemplate;
   
   @Override
   public List selectAll() {
      return sessionTemplate.selectList("SubCategory.selectAll");
   }

   @Override
   public List selectAllById(int topcategory_id) {
      return sessionTemplate.selectList("SubCategory.selectAllById", topcategory_id);
   }
   
   @Override
   public SubCategory select(int subcategory_id) {
      // TODO Auto-generated method stub
      return null;
   }

   @Override
   public void insert(SubCategory subCategory) {
      // TODO Auto-generated method stub
      
   }

   @Override
   public void update(SubCategory subCategory) {
      // TODO Auto-generated method stub
      
   }

   @Override
   public void delete(int subcategory_id) {
      // TODO Auto-generated method stub
      
   }

}