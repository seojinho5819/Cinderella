package com.project.cinderella.model.domain;

import lombok.Data;

@Data
public class SubCategory {
   private int subcategory_id;
   private int topcategory_id;
   private String subcategory_name;
}