package com.project.cinderella.model.domain;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class PhotoReview {
	private int photoreview_id;
	private String user_id;
	private int height;
	private String product_name;
	private String wearing_size;
	private String body_type;
	private String brand;
	private String review;
	private String filename;
	private Product product;
	
	private MultipartFile repImg;	//대표이미지
	
}
