package com.project.cinderella.model.preview.repository;
import java.util.List;

import com.project.cinderella.model.domain.PhotoReview;

public interface PhotoReviewDAO {
	public List selectAll();
	public PhotoReview select(int photoreview_id);
	public void insert(PhotoReview photoReview);
	
	public void delete(int photoreview_id);
	

}
