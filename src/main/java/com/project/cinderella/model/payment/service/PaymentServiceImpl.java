package com.project.cinderella.model.payment.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.cinderella.exception.CartException;
import com.project.cinderella.model.domain.Cart;
import com.project.cinderella.model.domain.Member;
import com.project.cinderella.model.domain.OrderSummary;
import com.project.cinderella.model.domain.Receiver;
import com.project.cinderella.model.payment.repository.CartDAO;
import com.project.cinderella.model.payment.repository.OrderSummaryDAO;
import com.project.cinderella.model.payment.repository.PaymethodDAO;
import com.project.cinderella.model.payment.repository.ReceiverDAO;


@Service
public class PaymentServiceImpl implements PaymentService{
   @Autowired
   private CartDAO cartDAO;
   
   
   @Autowired
   private PaymethodDAO paymethodDAO;

   
   //ì£¼ë¬¸ê´?? ¨ 3ê°?ì§? DAO 
   @Autowired
   private OrderSummaryDAO orderSummaryDAO;
   
   @Autowired
   private ReceiverDAO receiverDAO;
   
   /*
    * @Autowired private OrderDetailDAO orderDetailDAO;
    */
   
   
   @Override
   public List selectCartList() {
      // TODO Auto-generated method stub
      return null;
   }

   @Override
   public List selectCartList(int member_id) {
      return cartDAO.selectAll(member_id);
   }

   @Override
   public Cart selectCart(int cart_id) {
      // TODO Auto-generated method stub
      return null;
   }

   @Override
   public void insert(Cart cart) throws CartException{
      cartDAO.duplicateCheck(cart);
      cartDAO.insert(cart);
   }

   @Override
   public void update(List<Cart> cartList) throws CartException{
      //?ƒ?’ˆ ê°??ˆ˜ë§Œí¼ ?ˆ˜? • ?š”ì²? 
      for(Cart cart : cartList) {
         cartDAO.update(cart);
      }
   }

   @Override
   public void delete(Cart cart) {
      // TODO Auto-generated method stub
      
   }

   public void delete(Member member) throws CartException{
      cartDAO.delete(member);
   }
   
   @Override
   public List selectPaymethodList() {
      return paymethodDAO.selectAll();
   }
   
   //ì£¼ë¬¸ ?“±ë¡? 
   @Override
   public void registOrder(OrderSummary orderSummary, Receiver receiver) {
      //ì£¼ë¬¸?š”?•½ ?“±ë¡? 
      orderSummaryDAO.insert(orderSummary);
      //ì£¼ë¬¸ ?š”?•½?´ ?“±ë¡ëœ ?´?›„, orderSummary VO?—?Š” mybatis?˜ selectkey?— ?˜?•´ order_summary_id ê°?  ì±„ì›Œ? ¸ ?ˆ?‹¤..
      //?”°?¼?„œ ì·¨ë“?•œ ì£¼ë¬¸ë²ˆí˜¸ë¥? ë°›ëŠ”?‚¬?Œ, ?ƒ?„¸?— ?„£?–´ì¤˜ì•¼ ?•¨.
      
      //ë°›ëŠ”?‚¬?Œ ? •ë³? ?“±ë¡?
      receiver.setOrder_summary_id(orderSummary.getOrder_summary_id()); //ì£¼ë¬¸ë²ˆí˜¸ ? „?‹¬!!
      receiverDAO.insert(receiver);
      
      //ì£¼ë¬¸?ƒ?„¸ ?“±ë¡?
      //?¥ë°”êµ¬?‹ˆë¥? ì¡°íšŒ?•˜?—¬ OrderDetail VO ì²˜ë¦¬ 
      //?¥ë°”êµ¬?‹ˆ ê°?? ¸?˜¤ê¸? 
      
      
   }
   
   
}