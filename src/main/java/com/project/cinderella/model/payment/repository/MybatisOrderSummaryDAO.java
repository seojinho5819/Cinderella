package com.project.cinderella.model.payment.repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.cinderella.exception.OrderSummaryRegistException;
import com.project.cinderella.model.domain.OrderSummary;

@Repository
public class MybatisOrderSummaryDAO implements OrderSummaryDAO{
   @Autowired
   private SqlSessionTemplate sqlSessionTemplate;
   
   public void insert(OrderSummary orderSummary) throws OrderSummaryRegistException{
      int result=sqlSessionTemplate.insert("OrderSummary.insert", orderSummary);
      if(result==0) {
         throw new OrderSummaryRegistException("Ï£ºÎ¨∏?öî?ïΩ ?ì±Î°ùÏã§?å®");
      }
   }
   
}