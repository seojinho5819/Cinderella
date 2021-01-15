package com.project.cinderella.model.product.service;

import java.io.File;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.project.cinderella.common.FileManager;
import com.project.cinderella.exception.ProductRegistException;
import com.project.cinderella.model.domain.Color;
import com.project.cinderella.model.domain.Gender;
import com.project.cinderella.model.domain.Image;
import com.project.cinderella.model.domain.Product;
import com.project.cinderella.model.domain.Psize;
import com.project.cinderella.model.domain.Tag;
import com.project.cinderella.model.product.repository.ColorDAO;
import com.project.cinderella.model.product.repository.CommentsDAO;
import com.project.cinderella.model.product.repository.GenderDAO;
import com.project.cinderella.model.product.repository.ImageDAO;
import com.project.cinderella.model.product.repository.ProductDAO;
import com.project.cinderella.model.product.repository.PsizeDAO;
import com.project.cinderella.model.product.repository.TagDAO;

@Service
public class ProductServiceImpl implements ProductService {
   private static final Logger logger = LoggerFactory.getLogger(ProductServiceImpl.class);

   @Autowired
   private ProductDAO productDAO;

   @Autowired
   private ImageDAO imageDAO;

   @Autowired
   private PsizeDAO psizeDAO;

   @Autowired
   private ColorDAO colorDAO;

   @Autowired
   private TagDAO tagDAO;

   @Autowired
   private GenderDAO genderDAO;
   
   @Autowired
   private CommentsDAO commentsDAO;

   @Override
   public List selectAll() {
      return productDAO.selectAll();
   }

   @Override
   public List selectAllByHit() {
      return productDAO.selectAllByHit();
   }
   
   @Override
   public List selectByTopcategoryId(int topcategory_id) {
      return productDAO.selectByTopcategoryId(topcategory_id);
   }
   @Override
   public List selectBySubcategoryId(int subcategory_id) {
      return productDAO.selectBySubcategoryId(subcategory_id);
   }

   @Override
   public List selectBySize(String size) {
      return psizeDAO.selectBySize(size);
   }

   @Override
   public Product select(int product_id) {
      return productDAO.select(product_id);
   }
   @Override
   public Product selectByProductName(String product_name) {
   	
   	return productDAO.selectByProductName(product_name);
   }


   @Override
   public void regist(FileManager fileManager, Product product) throws ProductRegistException {

      String ext = fileManager.getExtend(product.getRepImg().getOriginalFilename());
      product.setFilename(ext); // 확장자 결정
      // db에 넣는 일은 DAO에게 시키고
      productDAO.insert(product);

      // 파일 업로드!!는 FileManager에게 시킨다
      // 대표이미지 업로드
      String basicImg = product.getProduct_id() + "." + ext;
      fileManager.saveFile(fileManager.getSaveBasicDir() + File.separator + basicImg, product.getRepImg());

      // 추가이미지 업로드 (FileManager에게 추가이미지 갯수만큼 업로드 업무를 시키면 된다!!)
      for (int i = 0; i < product.getAddImg().length; i++) {

         MultipartFile file = product.getAddImg()[i];
         ext = fileManager.getExtend(file.getOriginalFilename());

         // image table에 넣기!!
         Image image = new Image();
         image.setProduct_id(product.getProduct_id()); // fk
         image.setFilename(ext); // 확장자 넣기
         imageDAO.insert(image);

         // 메니져의 저장 메서드 호출
         String addImg = image.getImage_id() + "." + ext;
         fileManager.saveFile(fileManager.getSaveAddonDir() + File.separator + addImg, file);
      }

      // 기타 옵션 중, 색상 사이즈 넣기 (반복문으로...)

      // 사이즈
      for (Psize psize : product.getPsize()) {
         logger.debug("당신이 선택한 사이즈는 " + psize.getFit());
         psize.setProduct_id(product.getProduct_id());// fk 대입
         psizeDAO.insert(psize);
      }

      // 색상
      for (Color color : product.getColor()) {
         logger.debug("넘겨받은 색상은 " + color.getPicker());
         color.setProduct_id(product.getProduct_id());
         colorDAO.insert(color);
      }

      // 태그
      for (Tag tag : product.getPtag()) {
         logger.debug("넘겨받은 태그는 " + tag.getTag_name());
         tag.setProduct_id(product.getProduct_id());
         tagDAO.insert(tag);
      }

      // 태그
      for (Gender gender: product.getPgender()) {
         logger.debug("넘겨받은 성별은 " + gender.getGender_name());
         gender.setProduct_id(product.getProduct_id());
         genderDAO.insert(gender);
      }

   }

   @Override
   public void update(Product product) {
      productDAO.update(product);
   }
   
   @Override
   public void updateHit(int product_id) {
      productDAO.updateHit(product_id);
   }

   @Override
   public void delete(int product_id) {
      psizeDAO.delete(product_id);
      colorDAO.delete(product_id);
      genderDAO.delete(product_id);
      imageDAO.delete(product_id);
      tagDAO.delete(product_id);
      productDAO.delete(product_id);
   }





}