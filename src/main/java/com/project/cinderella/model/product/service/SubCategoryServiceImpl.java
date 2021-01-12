package com.project.cinderella.model.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.cinderella.model.domain.SubCategory;
import com.project.cinderella.model.domain.TopCategory;
import com.project.cinderella.model.product.repository.SubCategoryDAO;
import com.project.cinderella.model.product.repository.TopCategoryDAO;

@Service
public class SubCategoryServiceImpl implements SubCategoryService {

	@Autowired
	private TopCategoryDAO topCategoryDAO;

	@Autowired
	private SubCategoryDAO subCategoryDAO;

	@Override
	public List selectAll() {
		return subCategoryDAO.selectAll();
	}

	@Override
	public List selectAllById(int topcategory_id) {
		return subCategoryDAO.selectAllById(topcategory_id);
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
