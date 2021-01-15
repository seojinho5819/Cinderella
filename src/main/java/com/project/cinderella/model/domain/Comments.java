package com.project.cinderella.model.domain;

import lombok.Data;

@Data
public class Comments {
	private int comment_id;
	private int product_id;
	private String comment_content;
	private String comment_writer;
	private String regdate;
	private int hit;
}
