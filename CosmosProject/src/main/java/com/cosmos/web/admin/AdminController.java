package com.cosmos.web.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cosmos.web.member.MembersDAOInterface;
import com.cosmos.web.member.MembersVO;
import com.cosmos.web.notice.NoticeBoardPagingVO;
import com.cosmos.web.program.ProgramDAOInterface;
import com.cosmos.web.program.ProgramDateJoinVO;
import com.cosmos.web.program.ProgramDateVO;
import com.cosmos.web.program.ProgramVO;
import com.cosmos.web.program.ReservationJoinVO;

@Controller
public class AdminController {
	@Autowired
	SqlSession sqlSession;
	
	@RequestMapping("/admin/memberList")
	public ModelAndView memberList(HttpSession session){
		MembersDAOInterface dao = sqlSession.getMapper(MembersDAOInterface.class);
		List<MembersVO> mList = dao.selectAllMembers();
		
		ModelAndView mav = new ModelAndView();
		if(session.getAttribute("seM").equals("M")){
			mav.setViewName("admin/memberList");
		}else{
			mav.setViewName("admin/adminNo");
		}	
		mav.addObject("list", mList);
		return mav;
	}
	
	@RequestMapping("/admin/memberListWithdrawal")
	public ModelAndView memberListWithdrawal(HttpSession session, @RequestParam("num") int m_num){
		MembersDAOInterface dao = sqlSession.getMapper(MembersDAOInterface.class);
		
		int result = dao.updateWithdrawal(m_num);
		
		ModelAndView mav = new ModelAndView();
		if(session.getAttribute("seM").equals("M")){
			mav.setViewName("admin/memberListWithdrawalOk");
		}else{
			mav.setViewName("admin/adminNo");
		}	
		mav.addObject("result", result);
		return mav;
	}
	
	@RequestMapping("/admin/reservList")
	public ModelAndView reservList(HttpSession session, HttpServletRequest request){
		ProgramDAOInterface dao = sqlSession.getMapper(ProgramDAOInterface.class);
		int cPage = 1;
		int onePageRecord = 10;
		
		if(request.getParameter("currentPage")!=null && !request.getParameter("currentPage").equals("")){
			cPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		NoticeBoardPagingVO pageVo = new NoticeBoardPagingVO(onePageRecord, cPage, dao.programTimeCount());
		
		//마지막페이지 일때
		if(pageVo.getCurrentPage()==pageVo.getTotalPageCount()){
			//마지막페이지의 남은 레코드 수
			int modRecord = pageVo.getTotalRecord() % pageVo.getOnePageRecord();
			if(modRecord!=0){
				pageVo.setLastPageRecord(modRecord);
			}
		}
		
		List<ProgramDateJoinVO> list = dao.selectAllProgramTime(pageVo);
				
		ModelAndView mav = new ModelAndView();	
		if(session.getAttribute("seM").equals("M")){
			mav.setViewName("admin/reservList");
		}else{
			mav.setViewName("admin/adminNo");
		}
		mav.addObject("pd_list", list);
		mav.addObject("pageVo", pageVo);
		return mav;
	}
	
	@RequestMapping("/admin/reservListView")
	public ModelAndView reservListView(HttpSession session, @RequestParam("num") int pd_num){
		MembersDAOInterface dao = sqlSession.getMapper(MembersDAOInterface.class);
		List<ReservationJoinVO> rList = dao.selectAllReservList(pd_num);
		
		ModelAndView mav = new ModelAndView();
		if(session.getAttribute("seM").equals("M")){
			mav.setViewName("admin/reservListView");
		}else{
			mav.setViewName("admin/adminNo");
		}	
		mav.addObject("list", rList);
		return mav;
	}
	
	@RequestMapping("/admin/reservListCancel")
	public ModelAndView reservListCancel(HttpSession session, @RequestParam("num") int r_num){
		MembersDAOInterface dao = sqlSession.getMapper(MembersDAOInterface.class);
		ReservationJoinVO vo = dao.selectMyReservation(r_num);
		int totalNum = vo.getChild_tot() + vo.getTeenager_tot() + vo.getAdult_tot();
		
		int result = dao.updateReservCancel(r_num);
		dao.applicantsReCount(vo.getPd_num(), totalNum);
		
		ModelAndView mav = new ModelAndView();
		if(session.getAttribute("seM").equals("M")){
			mav.setViewName("admin/reservListCancelOk");
		}else{
			mav.setViewName("admin/adminNo");
		}	
		mav.addObject("result", result);
		return mav;
	}

	@RequestMapping("/admin/programWrite")
	public ModelAndView programWrite(HttpSession session, HttpServletRequest request, ProgramVO vo){
		ProgramDAOInterface dao = sqlSession.getMapper(ProgramDAOInterface.class);
		int result = dao.insertProgram(vo);
		
		ModelAndView mav = new ModelAndView();		
		if(session.getAttribute("seM").equals("M")){
			mav.setViewName("admin/programWriteOk");
		}else{
			mav.setViewName("admin/adminNo");
		}		
		mav.addObject("result", result);
		return mav;
	}
	
	@RequestMapping("/admin/programList")
	public ModelAndView programList(HttpSession session){
		ProgramDAOInterface dao = sqlSession.getMapper(ProgramDAOInterface.class);
		List<ProgramVO> programList = dao.selectAllProgram();
				
		ModelAndView mav = new ModelAndView();	
		if(session.getAttribute("seM").equals("M")){
			mav.setViewName("admin/programList");
		}else{
			mav.setViewName("admin/adminNo");
		}
		mav.addObject("p_list", programList);
		return mav;
	}
	
	@RequestMapping("/admin/programListView")
	public ModelAndView programListView(HttpSession session, @RequestParam("num") int p_num){
		ProgramDAOInterface dao = sqlSession.getMapper(ProgramDAOInterface.class);
		ProgramVO vo = dao.selectProgram(p_num);
		
		ModelAndView mav = new ModelAndView();
		if(session.getAttribute("seM").equals("M")){
			mav.setViewName("admin/programListView");
		}else{
			mav.setViewName("admin/adminNo");
		}
		mav.addObject("vo", vo);
		return mav;
	}
	
	@RequestMapping("/admin/programEdit")
	public ModelAndView programEdit(HttpSession session, @RequestParam("num") int p_num){
		ProgramDAOInterface dao = sqlSession.getMapper(ProgramDAOInterface.class);
		ProgramVO vo = dao.selectProgram(p_num);
		
		ModelAndView mav = new ModelAndView();
		if(session.getAttribute("seM").equals("M")){
			mav.setViewName("admin/programEdit");
		}else{
			mav.setViewName("admin/adminNo");
		}
		mav.addObject("vo", vo);
		return mav;
	}
	
	@RequestMapping("/admin/programEditOk")
	public ModelAndView programEditOk(HttpSession session, ProgramVO vo){
		ProgramDAOInterface dao = sqlSession.getMapper(ProgramDAOInterface.class);
		int result = dao.updateProgram(vo);
		
		ModelAndView mav = new ModelAndView();	
		if(session.getAttribute("seM").equals("M")){
			mav.setViewName("admin/programEditOk");
		}else{
			mav.setViewName("admin/adminNo");
		}
		mav.addObject("result", result);
		return mav;
	}
	
	@RequestMapping("/admin/programDelete")
	public ModelAndView programDelete(HttpSession session, @RequestParam("num") int p_num){
		ProgramDAOInterface dao = sqlSession.getMapper(ProgramDAOInterface.class);
		
		int result = 0;
		int program = dao.countProgram(p_num);
		if(program==0){
			result = dao.deleteProgram(p_num);
		}
		
		ModelAndView mav = new ModelAndView();	
		if(session.getAttribute("seM").equals("M")){
			mav.setViewName("admin/programDeleteOk");
		}else{
			mav.setViewName("admin/adminNo");
		}
		mav.addObject("result", result);
		return mav;
	}
	
	@RequestMapping("/admin/programTimeWrite")
	public ModelAndView programTimeWrite(HttpSession session) {
		ProgramDAOInterface dao = sqlSession.getMapper(ProgramDAOInterface.class);
		List<ProgramVO> list = dao.selectAllProgram();
		
		ModelAndView mav = new ModelAndView();
		if(session.getAttribute("seM").equals("M")){
			mav.setViewName("admin/programTimeWrite");
		}else{
			mav.setViewName("admin/adminNo");
		}
		mav.addObject("p_list", list);
		return mav;
	}
	
	@RequestMapping("/admin/programTimeWriteOk")
	public ModelAndView programTimeWrite2(HttpSession session, HttpServletRequest request, ProgramDateVO vo){
		ProgramDAOInterface dao = sqlSession.getMapper(ProgramDAOInterface.class);
		int result = dao.insertProgramTime(vo);
		
		ModelAndView mav = new ModelAndView();	
		if(session.getAttribute("seM").equals("M")){
			mav.setViewName("admin/programTimeWriteOk");
		}else{
			mav.setViewName("admin/adminNo");
		}
		mav.addObject("result", result);
		return mav;
	}
	
	@RequestMapping("/admin/programTimeList")
	public ModelAndView programTimeList(HttpSession session, HttpServletRequest request){
		ProgramDAOInterface dao = sqlSession.getMapper(ProgramDAOInterface.class);
		int cPage = 1;
		int onePageRecord = 10;
		
		if(request.getParameter("currentPage")!=null && !request.getParameter("currentPage").equals("")){
			cPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		NoticeBoardPagingVO pageVo = new NoticeBoardPagingVO(onePageRecord, cPage, dao.programTimeCount());
		
		//마지막페이지 일때
		if(pageVo.getCurrentPage()==pageVo.getTotalPageCount()){
			//마지막페이지의 남은 레코드 수
			int modRecord = pageVo.getTotalRecord() % pageVo.getOnePageRecord();
			if(modRecord!=0){
				pageVo.setLastPageRecord(modRecord);
			}
		}
		
		List<ProgramDateJoinVO> list = dao.selectAllProgramTime(pageVo);
				
		ModelAndView mav = new ModelAndView();	
		if(session.getAttribute("seM").equals("M")){
			mav.setViewName("admin/programTimeList");
		}else{
			mav.setViewName("admin/adminNo");
		}
		mav.addObject("pd_list", list);
		mav.addObject("pageVo", pageVo);
		return mav;
	}
	
	@RequestMapping("/admin/programTimeListView")
	public ModelAndView programTimeListView(HttpSession session, @RequestParam("num") int pd_num){
		ProgramDAOInterface dao = sqlSession.getMapper(ProgramDAOInterface.class);
		ProgramDateJoinVO vo = dao.selectProgramTime(pd_num);
		
		ModelAndView mav = new ModelAndView();
		if(session.getAttribute("seM").equals("M")){
			mav.setViewName("admin/programTimeListView");
		}else{
			mav.setViewName("admin/adminNo");
		}
		mav.addObject("vo", vo);
		return mav;
	}
	
	@RequestMapping("/admin/programTimeEdit")
	public ModelAndView programTimeEdit(HttpSession session, @RequestParam("num") int pd_num){
		ProgramDAOInterface dao = sqlSession.getMapper(ProgramDAOInterface.class);
		ProgramDateJoinVO vo = dao.selectProgramTime(pd_num);
		
		ModelAndView mav = new ModelAndView();		
		if(session.getAttribute("seM").equals("M")){
			mav.setViewName("admin/programTimeEdit");
		}else{
			mav.setViewName("admin/adminNo");
		}
		mav.addObject("vo", vo);
		return mav;
	}
	
	@RequestMapping("/admin/programTimeEditOk")
	public ModelAndView programTimeEditOk(HttpSession session, ProgramDateVO vo){
		ProgramDAOInterface dao = sqlSession.getMapper(ProgramDAOInterface.class);
		int result = dao.updateProgramTime(vo);
		
		ModelAndView mav = new ModelAndView();	
		if(session.getAttribute("seM").equals("M")){
			mav.setViewName("admin/programTimeEditOk");
		}else{
			mav.setViewName("admin/adminNo");
		}
		mav.addObject("result", result);
		return mav;
	}
	
	@RequestMapping("/admin/programTimeDelete")
	public ModelAndView programTimeDelete(HttpSession session, @RequestParam("num") int pd_num){
		ProgramDAOInterface dao = sqlSession.getMapper(ProgramDAOInterface.class);
		int result = dao.deleteProgramTime(pd_num);
		
		ModelAndView mav = new ModelAndView();	
		if(session.getAttribute("seM").equals("M")){
			mav.setViewName("admin/programTimeDeleteOk");
		}else{
			mav.setViewName("admin/adminNo");
		}
		mav.addObject("result", result);
		return mav;
	}
	
	@RequestMapping("/admin/statistics")
	public ModelAndView statistics(HttpSession session){
		ProgramDAOInterface dao = sqlSession.getMapper(ProgramDAOInterface.class);
		List<StatisticsVO> list = dao.statisticsCount();
		ModelAndView mav = new ModelAndView();	
		
		if(session.getAttribute("seM").equals("M")){
			mav.setViewName("admin/statistics");
		}else{
			mav.setViewName("admin/adminNo");
		}
		mav.addObject("list", list);
		return mav;
	}
	
}
