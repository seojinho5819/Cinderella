package com.project.cinderella.model.domain;

import lombok.Data;
@Data
public class Cart extends Product {
	private int cart_id;
	//product_id는 상속받은 Product내에 있으므로 불필요
	private int quantity;
	private int member_id;
	private String ppsize;
}
