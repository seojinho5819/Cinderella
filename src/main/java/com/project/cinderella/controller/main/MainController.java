package com.project.cinderella.controller.main;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.project.cinderella.model.product.service.TopCategoryService;

@Controller
public class MainController {
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@Autowired
	private TopCategoryService topCategoryService;

	@RequestMapping(value="/", method=RequestMethod.GET)
	public ModelAndView main() {
		
		ModelAndView mav = new ModelAndView();
		//카테고리들 가져오기
		List topList = topCategoryService.selectAll();
		mav.addObject("topList", topList);
		mav.setViewName("index"); //메인 페이지
		return mav;
	}
}