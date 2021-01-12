package com.project.cinderella.model.domain;

import java.util.List;

import lombok.Data;

@Data
public class TopCategory {
	 private int topcategory_id;
	   private String topcategory_name;
	   private int rank;
	   private List<SubCategory> subCategory;
}