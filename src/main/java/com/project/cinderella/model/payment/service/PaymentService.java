package com.project.cinderella.model.payment.service;

import java.util.List;

import com.project.cinderella.model.domain.Cart;
import com.project.cinderella.model.domain.Member;
import com.project.cinderella.model.domain.OrderSummary;
import com.project.cinderella.model.domain.Receiver;


public interface PaymentService {
	//?¥ë°”êµ¬?‹ˆ ê´?? ¨ ?—…ë¬?
	public List selectCartList();//?šŒ?› êµ¬ë¶„?—†?´ ëª¨ë“  ?°?´?„° ê°?? ¸?˜¤ê¸? 
	public List selectCartList(int member_id);//?Š¹? • ?šŒ?›?˜ ?¥ë°”êµ¬?‹ˆ ?‚´?—­
	public Cart selectCart(int cart_id);
	public void insert(Cart cart);
	public void update(List<Cart> cartList); //?¼ê´? ?ˆ˜? •
	public void delete(Cart cart); //pk?— ?†?•œ ?°?´?„° ?‚­? œ?• ?˜ˆ? •
	public void delete(Member member); //?šŒ?›?— ?†?•œ ?°?´?„° ?‚­? œ?• ?˜ˆ? •
	
	//ê²°ì œ ?—…ë¬?
	public List selectPaymethodList();
	public void registOrder(OrderSummary orderSummary, Receiver receiver);//?Š¸?œ?­?…˜ ì²˜ë¦¬ê°? ?š”êµ¬ë˜?Š” ë©”ì„œ?“œ...
}
