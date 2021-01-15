package com.project.cinderella.model.payment.repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.cinderella.exception.ReceiverRegistException;
import com.project.cinderella.model.domain.Receiver;

@Repository
public class MybatisReceiverDAO implements ReceiverDAO{
   @Autowired
   private SqlSessionTemplate sqlSessionTemplate;
   
   @Override
   public void insert(Receiver receiver) throws ReceiverRegistException{
      int result = sqlSessionTemplate.insert("Receiver.insert", receiver);
      //result=0; //?ùºÎ∂??ü¨ ?Öå?ä§?ä∏ Î™©Ï†Å..
      if(result==0) {
         throw new ReceiverRegistException("Î∞õÎäî?Ç¨?ûå ?ì±Î°ùÏã§?å®");
      }
   }
   
}