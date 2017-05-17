package com.cosmos.web.notice;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class NoticeBoardController {
	@Autowired
	SqlSession sqlSession;
	
	@RequestMapping("/notice")
	public ModelAndView noticeBoard(HttpServletRequest request, NoticeBoardVO vo){
		NoticeBoardDAOInterface dao = sqlSession.getMapper(NoticeBoardDAOInterface.class);
		int cPage = 1;
		int onePageRecord = 10;
		int noticeRecord = 0;
		
		if(request.getParameter("currentPage")!=null && !request.getParameter("currentPage").equals("")){
			cPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		noticeRecord = dao.noticeCount();
		onePageRecord = 10 - noticeRecord;		
		NoticeBoardPagingVO pageVo = new NoticeBoardPagingVO(onePageRecord, cPage, dao.recordCount());
		
		//마지막페이지 일때
		if(pageVo.getCurrentPage()==pageVo.getTotalPageCount()){
			//마지막페이지의 남은 레코드 수
			int modRecord = pageVo.getTotalRecord() % pageVo.getOnePageRecord();
			if(modRecord!=0){
				pageVo.setLastPageRecord(modRecord);
			}
		}
		
		//System.out.println("rownumEnd: "+pageVo.getRownumEnd());
		
		List<NoticeBoardVO> noticeList = dao.selectNoticeList();
		List<NoticeBoardVO> allNoticeList = dao.selectAllList(pageVo);
		
		ModelAndView mav = new ModelAndView();		
		mav.addObject("n_list", noticeList);
		mav.addObject("list", allNoticeList);
		mav.addObject("pageVo", pageVo);
		mav.setViewName("notice/notice");
		return mav;
	}
	
	@RequestMapping("/notice/noticeWrite")
	public String noticeBoardWrite(){
		return "notice/noticeWrite";
	}
	
	@RequestMapping("/notice/noticeWriteOk")
	public ModelAndView noticeWriteOk(NoticeBoardVO vo){
		NoticeBoardDAOInterface dao = sqlSession.getMapper(NoticeBoardDAOInterface.class);
		int result = dao.insertNoticeBoard(vo);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName("notice/noticeWriteOk");
		return mav;		
	}
	
	@RequestMapping("notice/noticeListView")
	public ModelAndView noticeListView(@RequestParam("num") int n_num, HttpSession session){
		NoticeBoardDAOInterface dao = sqlSession.getMapper(NoticeBoardDAOInterface.class);
		NoticeBoardVO vo = dao.selectNotice(n_num);
		
		if(session.getAttribute("seNum")!=null && !session.getAttribute("seNum").equals("")){
			int m_num = (Integer)session.getAttribute("seNum");
			if(m_num!=vo.getM_num()){
				dao.noticeHitCount(n_num);
				vo.setHit(vo.getHit()+1);
			}
		}else{
			dao.noticeHitCount(n_num);
			vo.setHit(vo.getHit()+1);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("vo", vo);
		mav.setViewName("notice/noticeListView");
		return mav;
	}
	
	@RequestMapping("notice/noticeEdit")
	public ModelAndView noticeEdit(@RequestParam("num") int n_num){
		NoticeBoardDAOInterface dao = sqlSession.getMapper(NoticeBoardDAOInterface.class);
		NoticeBoardVO vo = dao.selectNotice(n_num);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("vo", vo);
		mav.setViewName("notice/noticeEdit");
		return mav;
	}
	
	@RequestMapping("notice/noticeEditOk")
	public ModelAndView noticeEditOk(NoticeBoardVO vo){
		NoticeBoardDAOInterface dao = sqlSession.getMapper(NoticeBoardDAOInterface.class);
		int result = dao.updateNotice(vo);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName("notice/noticeEditOk");
		return mav;
	}
	
	@RequestMapping("notice/noticeDel")
	public ModelAndView noticeDel(@RequestParam("num") int n_num){
		NoticeBoardDAOInterface dao = sqlSession.getMapper(NoticeBoardDAOInterface.class);
		int result = dao.deleteNotice(n_num);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName("notice/noticeDelOk");
		return mav;
	}

}
