package com.project.cinderella.model.product.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.cinderella.exception.ProductRegistException;
import com.project.cinderella.model.domain.PhotoReview;
import com.project.cinderella.model.domain.Product;
import com.project.cinderella.model.preview.service.PhotoReviewServiceImpl;

@Repository
public class MybatisProductDAO implements ProductDAO {
	private static final Logger logger=LoggerFactory.getLogger(MybatisProductDAO.class);
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List selectAll() {
		return sqlSessionTemplate.selectList("Product.selectAll");
	}
	@Override
	public List selectAllByHit() {
		
		return sqlSessionTemplate.selectList("Product.selectAllByHit");
	}
	
	@Override
	public List selectByTopcategoryId(int topcategory_id) {
		return sqlSessionTemplate.selectList("Product.selectByTopCategoryId", topcategory_id);
	}
	
	@Override
	public List selectBySubcategoryId(int subcategory_id) {
		return sqlSessionTemplate.selectList("Product.selectBySubCategoryId", subcategory_id);
	}

	@Override
	public Product select(int product_id) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne("Product.select", product_id);
	}
	@Override
	public Product selectByProductName(String product_name) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne("Product.selectByProductName",product_name);
	}

	@Override
	public void insert(Product product) throws ProductRegistException {
		int result = sqlSessionTemplate.insert("Product.insert", product);
		if (result == 0) {
			throw new ProductRegistException("상품테이블에 입력실패");
		}
	}

	@Override
	public void update(Product product) throws ProductRegistException {
		// TODO Auto-generated method stub

	}

	@Override
	public void updateHit(int product_id) throws ProductRegistException {
		int result = sqlSessionTemplate.insert("Product.updateHit", product_id);
		if (result == 0) {
			throw new ProductRegistException("조회수 입력실패");
		}
	}

	@Override
	public void delete(int product_id) throws ProductRegistException {
		// TODO Auto-generated method stub

	}
	@Override
	public int selectProductId(String product_name) {
		
		int product_id = sqlSessionTemplate.selectOne("Product.selectproductid", product_name);
		return product_id;
	}
	


}