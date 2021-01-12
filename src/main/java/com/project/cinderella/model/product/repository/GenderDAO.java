package com.project.cinderella.model.product.repository;

import java.util.List;

import com.project.cinderella.model.domain.Gender;

public interface GenderDAO {
	public List selectAll();//모든 목록 가져오기 
	public List selectById(int product_id); //fk에 소속된 목록 가져오기
	public Gender select(int gender_id);
	public void insert(Gender gender);
	public void update(Gender gender);
	public void delete(int gender_id);
}
