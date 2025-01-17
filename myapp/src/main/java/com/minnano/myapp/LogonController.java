package com.minnano.myapp;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.minnano.model.BoardBean;
import com.minnano.model.BookBean;
import com.minnano.model.MemberBean;
import com.minnano.service.BoardService;
import com.minnano.service.BookService;
import com.minnano.service.MemberService;

@Controller
public class LogonController extends Common {

	private static final Logger logger = LoggerFactory.getLogger(LogonController.class);
	public static final String LOGIN = "KEY_USER_ID";
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private BookService bookService;
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginPost(HttpSession session, MemberBean bean, Model model, HttpServletResponse response)
			throws IOException {

		System.out.println("aaaaa" + bean.toString());
		logger.info((String)session.getAttribute("booknum"));
		logger.info((String)session.getAttribute("go"));
		logger.info("inloginPost");
		logger.info(bean.toString());
		logger.info(bean.getmID());
		logger.info(bean.getmPasswd());

		
		if (bean.getmID() == null || bean.getmPasswd() == null) {
			logger.info("login failed1");
			return "redirect:/dologin";
		} else if (memberService.login(bean.getmID(), bean.getmPasswd())) {
			logger.info("in if");
			session.setAttribute("LOGIN", bean.getmID());
			logger.info("login success!");
		} else {
			logger.info("login failed2");
			return "redirect:/dologin";
		}
		
		if(session.getAttribute("go")==null) {
			return "redirect:/main";
		}
		else if(session.getAttribute("go").equals("goread")) {
			  Pagination pagination = new Pagination();
	            int pagenum = 1;
	            int contentnum = 10;
	            int booknum = Integer.parseInt((String)session.getAttribute("booknum"));
	             logger.info("bookpageAction3");
	             System.out.println("pagenum:"+pagenum);
	             System.out.println("contentnum:"+contentnum);
	             
	             pagination.setTotalcount(boardService.Calltestcount(booknum));   //��ü �Խñ� ������ ��Ī�Ѵ�.
	             pagination.setPagenum(pagenum-1);            //���� �������� ������ ��ü�� ��Ī�Ѵ�.
	             pagination.setContentnum(contentnum);      //�� �������� ��� �Խñ��� �������� ��Ī�Ѵ�.
	             pagination.setCurrentblock(pagenum);      //���� ������ ����� ������� ���� ������ ��ȣ�� ���ؼ� ��Ī�Ѵ�.
	             pagination.setLastblock(pagination.getTotalcount());   //������ ��� ��ȣ�� ��ü �Խñ� ���� ���ؼ� ��Ī�Ѵ�.
	             
	             pagination.prevnext(pagenum);   //���� ������ ��ȣ�� ȭ��ǥ�� ��Ÿ���� ���Ѵ�.
	             pagination.setStartPage(pagination.getCurrentblock());   //���� �������� ������ ��� ��ȣ�� ���Ѵ�.
	             pagination.setEndPage(pagination.getLastblock(), pagination.getCurrentblock());
	             List<BoardBean> testlist = boardService.list(booknum, pagination.getPagenum()*10, pagination.getContentnum());
	              
	             model.addAttribute("list", testlist);
	             model.addAttribute("page", pagination);
	             
	         logger.info((String)session.getAttribute("booknum"));
	         List<BookBean> beans =  bookService.selectBook(booknum);
	         model.addAttribute("bookinfo",beans);
	          return "book/book_info";
		}
		
		return "redirect:/main";
	}
	
	@RequestMapping(value = "/dologout", method = RequestMethod.GET)
	public String logoutGet(HttpSession session, MemberBean memberbean) {
		session.removeAttribute("LOGIN");
		return "redirect:/main";
	}
	
}