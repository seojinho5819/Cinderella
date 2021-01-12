package com.project.cinderella.controller.member;



import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.cinderella.common.MessageData;
import com.project.cinderella.exception.MailSendException;
import com.project.cinderella.exception.MemberNotFoundException;
import com.project.cinderella.exception.MemberRegistException;
import com.project.cinderella.model.domain.Member;
import com.project.cinderella.model.member.service.MemberService;
import com.project.cinderella.model.product.service.TopCategoryService;

@Controller
public class MemberController {
   private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

   @Autowired
   private MemberService memberService;

   
   @Autowired
   private TopCategoryService topCategoryService;
   
   
   // ȸ�������� ��û
   @RequestMapping(value = "/shop/member/registForm", method = RequestMethod.GET)
   public ModelAndView getRegistForm() {
	   List topList = topCategoryService.selectAll();
      ModelAndView mav = new ModelAndView("shop/member/signup");
      mav.addObject("topList", topList); //���
      return mav;
   }

   // ȸ������ ��û ó��
   @RequestMapping(value = "/shop/member/regist", method = RequestMethod.POST, produces="text/html;charset=utf-8")
   @ResponseBody
   public String regist(Member member) {
      logger.debug("���̵� " + member.getUser_id());
      logger.debug("�̸� " + member.getName());
      logger.debug("��� " + member.getPassword());
      logger.debug("�̸���id " + member.getEmail_id());
      logger.debug("�̸���server " + member.getEmail_server());
      logger.debug("������ȣ " + member.getZipcode());
      logger.debug("�ּ� " + member.getAddr());
      logger.debug("�ֹ�Ƚ�� " + member.getBuy_count());
      logger.debug("����ʵ��" + member.getMembership_id());

      memberService.regist(member);

      StringBuffer sb = new StringBuffer();
      sb.append("{");
      sb.append(" \"result\":1, ");
      sb.append(" \"msg\":\"ȸ������ ����\"");
      sb.append("}");
      
      return sb.toString();
      
   }
   
   
   //�α���ȭ�� ��û 
      @RequestMapping(value="/shop/member/loginForm", method=RequestMethod.GET)
      public ModelAndView getLoginForm() {
         List topList = topCategoryService.selectAll();
         ModelAndView mav = new ModelAndView("shop/member/signin");
         mav.addObject("topList", topList); //���
         
         return mav;
      }
   
      //�α��� ��û ó��
      @RequestMapping(value="/shop/member/login", method=RequestMethod.POST)
      public String login(Member member, HttpServletRequest request) {
         //db�� ���翩�� Ȯ�� 
         Member obj=memberService.select(member);
         System.out.println(obj);
         //���� O : ���ǿ� ȸ������ ��Ƶα�
         
           HttpSession session=request.getSession();
           session.setAttribute("member",obj); //���� Ŭ���̾�Ʈ ��û�� ����� ���ǿ� ������ ���´�
          
         return "redirect:/";
      }
   
      //�α׾ƿ� ��û ó�� 
      @RequestMapping(value="/shop/member/logout", method=RequestMethod.GET)
      public ModelAndView logout(HttpServletRequest request) {
         request.getSession().invalidate(); //���� ��ȿȭ, �̽������� ����� �����Ͱ� �� ��ȿ�� �ȴ�
         MessageData messageData = new MessageData();
         messageData.setResultCode(1);
         messageData.setMsg("�α׾ƿ� �Ǿ����ϴ�");
         messageData.setUrl("/cinderella/");
         
         ModelAndView mav = new ModelAndView("shop/error/message");
         mav.addObject("messageData", messageData);
         return mav;
      }

      
      //�����ڸ�忡�� ȸ����Ϻ���
        @RequestMapping(value = "/admin/member/member_list", method = RequestMethod.GET)
         public ModelAndView getProductList() {
           ModelAndView mav = new ModelAndView("admin/member/member_list");
            List memberList = memberService.selectAll();
            mav.addObject("memberList", memberList);
            return mav;
         }

      
   
        //���� �ڵ鷯 2���� ó��
        @ExceptionHandler(MemberRegistException.class) public ModelAndView
        handleException(MemberRegistException e) { ModelAndView mav = new
        ModelAndView(); mav.addObject("msg", e.getMessage()); //����ڰ� ���Ե� ���� �޽���
        mav.setViewName("shop/error/result"); return mav; }
       
    

   
     @ExceptionHandler(MailSendException.class) public ModelAndView
     handleException(MailSendException e) {
     ModelAndView mav = new ModelAndView();
     mav.addObject("msg", e.getMessage()); //����ڰ� ���Ե� ���� �޽���
     mav.setViewName("shop/error/result"); 
     return mav; 
     }

      @ExceptionHandler(MemberNotFoundException.class)
      public ModelAndView handleException(MemberNotFoundException e) {
         
         ModelAndView mav = new ModelAndView();
         
         List topList = topCategoryService.selectAll();
         mav.addObject("topList", topList); //���
         mav.addObject("msg", e.getMessage());
         mav.setViewName("shop/error/result");
         return mav;
      }

}