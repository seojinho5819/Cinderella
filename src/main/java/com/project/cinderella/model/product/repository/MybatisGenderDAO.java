package com.project.cinderella.model.product.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.cinderella.exception.ProductRegistException;
import com.project.cinderella.model.domain.Gender;

@Repository
public class MybatisGenderDAO implements GenderDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List selectById(int product_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Gender select(int gender_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insert(Gender gender) throws ProductRegistException {
		int result = sqlSessionTemplate.insert("Gender.insert", gender);		
		if(result==0) {
			throw new ProductRegistException("성별 등록에 실패하였습니다.");
		}
	}

	@Override
	public void update(Gender gender) throws ProductRegistException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int gender_id) throws ProductRegistException {
		// TODO Auto-generated method stub
		
	}
	
	
	
}