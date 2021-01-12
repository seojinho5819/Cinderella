package com.project.cinderella.model.product.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.cinderella.exception.ProductRegistException;
import com.project.cinderella.model.domain.Tag;

@Repository
public class MybatisTagDAO implements TagDAO{
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
	public Tag select(int tag_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Tag selectByName(String tag_name) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insert(Tag tag) throws ProductRegistException  {
		int result = sqlSessionTemplate.insert("Tag.insert", tag);
		if(result==0) {
			throw new ProductRegistException("태그 등록에 실패하였습니다");
		}
		
	}

	@Override
	public void update(Tag tag) throws ProductRegistException  {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int tag_id) throws ProductRegistException  {
		// TODO Auto-generated method stub
		
	}
	
}