package com.project.cinderella.model.member.repository;

import java.util.List;

import com.project.cinderella.model.domain.Member;

public interface MemberDAO {
	  public List selectAll();
	   public Member select(Member member);

	   /* public List selectMember(); */ 
	   public void insert(Member member);
	   public void update(Member member);
	   public void delete(Member member);
	   public Member selectbyuser_id(String user_id);


}
