package com.project.cinderella.model.domain;

import lombok.Data;

@Data
public class Member {
	   private int member_id;
	   private String user_id;
	   private String password;
	   private String name;
	   private String email_id;
	   private String email_server;
	   private String zipcode;
	   private String addr;
	   private int buy_count;
	   private int membership_id;
	   private String regdate;
}
