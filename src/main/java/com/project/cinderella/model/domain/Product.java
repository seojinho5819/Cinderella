package com.project.cinderella.model.domain;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Product {
	private int product_id;
	private SubCategory subCategory;
	private int subcategory_id;
	private String product_name;
	private String brand;
	private int price;
	private String detail;
	private int hit;
	private String filename; // currentTimeMils로 할 것임

	// 이미지 하나를 자동으로 처리하는 객체 선언
	// 단, 이름을 html의 업도르 컴포넌트 파라미터명과 일치시켜야 자동으로 업로드 처리
	private MultipartFile repImg; // 대표이미지
	private MultipartFile[] addImg; // 추가 이미지는 선택사항. 배열.

	// 조인할 때 사용
	//private Score score;
	private List<Psize> psizeList;
	private List<Color> colorList;
	private List<Tag> tagList;
	private List<Gender> genderList;
	private List<Image> imageList;

	// insert할 때 사용
	private Psize[] psize; // 사이즈
	private Color[] color; // 색상값들
	private Tag[] ptag; // 태그들
	private Gender[] pgender; // 성별
	

}