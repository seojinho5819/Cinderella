package com.project.cinderella.model.preview.service;

import java.io.File;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.cinderella.common.FileManager;
import com.project.cinderella.model.domain.PhotoReview;
import com.project.cinderella.model.preview.repository.PhotoReviewDAO;

@Service
public class PhotoReviewServiceImpl implements PhotoReviewService{
	private static final Logger logger=LoggerFactory.getLogger(PhotoReviewServiceImpl.class);

	@Autowired
	private PhotoReviewDAO photoReviewDAO;
	
	
	
	
	@Override
	public List selectAll() {
		
		return photoReviewDAO.selectAll();
	}

	@Override
	public PhotoReview select(int photoreview_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void regist(FileManager fileManager, PhotoReview photoReview) {
		String ext=fileManager.getExtend(photoReview.getRepImg().getOriginalFilename());
		photoReview.setFilename(ext);
		photoReviewDAO.insert(photoReview);
		
		String basicImg = photoReview.getPhotoreview_id()+"."+ext;
		
		fileManager.saveFile(fileManager.getSavepreviewBasicDir()+File.separator+basicImg,photoReview.getRepImg());
		//logger.debug("시발 이미지 경로다 개객갸:",fileManager.saveFile(fileManager.getSavepreviewBasicDir()+File.separator+basicImg,photoReview.getRepImg()););
		
	}
	

	@Override
	public void delete(int photoreview_id) {
		photoReviewDAO.delete(photoreview_id);
		
	}

}
