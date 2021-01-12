package com.project.cinderella.controller.preview;

import java.util.List;

import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.ModelAndView;

import com.project.cinderella.common.FileManager;
import com.project.cinderella.model.domain.PhotoReview;
import com.project.cinderella.model.preview.service.PhotoReviewService;

@Controller
public class PhotoReviewController implements ServletContextAware{
	private static final Logger logger=LoggerFactory.getLogger(PhotoReviewController.class);
	@Autowired
	private FileManager filemanager;
	
	@Autowired
	private PhotoReviewService photoReviewService;
	
	private ServletContext servletContext;
	
	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		//이 타이밍을 놓치지말고, 실제 물리적 경로를 FileManager 에 대입해놓자!!!

		filemanager.setSavepreviewBasicDir(servletContext.getRealPath(filemanager.getSavepreviewBasicDir()));
		logger.debug(filemanager.getSavepreviewBasicDir());
		
	}
	
	
		@RequestMapping(value = "/shop/RegistReview", method = RequestMethod.GET)
		public String registReview() {
			return "shop/RegistReview";
		}
		//등록
		@RequestMapping(value = "/shop/review/regist", method = RequestMethod.POST, produces ="text/html;charset=utf8")
		@ResponseBody
		public String reviewRegist(PhotoReview photoReview) {
			photoReviewService.regist(filemanager, photoReview);
			StringBuilder sb = new StringBuilder();
			sb.append("{");
			sb.append("\"result\":1,");
			sb.append("\"msg\":\"상품등록 성공\"");
			sb.append("}");
			return sb.toString();
		}
		//삭제
		@RequestMapping(value = "/shop/review/del" , method = RequestMethod.GET)
		public String delPhotoReview(int photoreview_id) {
			photoReviewService.delete(photoreview_id);
			return "redirect:/shop/photoreview";
		}
		//카드목록
		@RequestMapping(value = "/shop/photoreview", method = RequestMethod.GET)
		public ModelAndView getPhotoReviewList() {
			ModelAndView mav = new ModelAndView("shop/photoreview");
			List photoReviewList = photoReviewService.selectAll();
			mav.addObject("photoReviewList", photoReviewList);
			return mav;
		}
		
}
