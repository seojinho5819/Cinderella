package com.project.cinderella.model.product.repository;

import java.util.List;

import com.project.cinderella.model.domain.PhotoReview;
import com.project.cinderella.model.domain.Product;


public interface ProductDAO {
	public List selectAll();
	public List selectAllByHit();
	public List selectByTopcategoryId(int topcategory_id); 
	public List selectBySubcategoryId(int subcategory_id);
	public Product select(int product_id); 
	public Product selectByProductName(String product_name); 
	public void insert(Product product);
	public void update(Product product);
	public void updateHit(int product_id);
	public void delete(int product_id);
	public int selectProductId(String product_name);
	
}
