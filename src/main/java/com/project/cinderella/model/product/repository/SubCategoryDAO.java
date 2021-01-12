package com.project.cinderella.model.product.repository;

import java.util.List;

import com.project.cinderella.model.domain.SubCategory;


public interface SubCategoryDAO {
   
	//CRUD
	   public List selectAll();
	   public SubCategory select(int subcategory_id);
	   public List selectAllById(int topcategory_id);
	   public void insert(SubCategory subCategory);
	   public void update(SubCategory subCategory);
	   public void delete(int subcategory_id);
}