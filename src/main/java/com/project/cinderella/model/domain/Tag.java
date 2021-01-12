package com.project.cinderella.model.domain;

import lombok.Data;

@Data
public class Tag {
	private int tag_id;
	private int product_id;
	private String tag_name;
}
