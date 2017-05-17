package com.cosmos.web.program;

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

@Controller
public class ProgramController {
	@Autowired
	SqlSession sqlSession;

	@RequestMapping("/program")
	public ModelAndView program(){
		ProgramDAOInterface dao = sqlSession.getMapper(ProgramDAOInterface.class);
		List<ProgramVO> programList = dao.selectAllProgram();
				
		ModelAndView mav = new ModelAndView();		
		mav.addObject("p_list", programList);
		mav.setViewName("program/program");
		return mav;
	}
	
	@RequestMapping("/program/programView")
	public ModelAndView pListView(@RequestParam("num") int p_num){
		ProgramDAOInterface dao = sqlSession.getMapper(ProgramDAOInterface.class);
		ProgramVO vo = dao.selectProgram(p_num);
		List<ProgramDateVO> list = dao.selectProgramTimes(p_num);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("vo", vo);
		mav.addObject("pd_list", list);
		
		if(list.isEmpty()){
			mav.setViewName("program/programNo");
		}else{
			mav.setViewName("program/programView");
		}
		
		return mav;
	}
	
	@RequestMapping("/program/programReservation")
	public ModelAndView programReservation(@RequestParam("p_num") int p_num, @RequestParam("pd_num") int pd_num,
			@RequestParam("child_tot") int child_tot, @RequestParam("teenager_tot") int teenager_tot, @RequestParam("adult_tot") int adult_tot, HttpSession session){
		ProgramDAOInterface dao = sqlSession.getMapper(ProgramDAOInterface.class);
		MembersDAOInterface mDao = sqlSession.getMapper(MembersDAOInterface.class);
		//System.out.println(p_num+", "+child_tot+", "+teenager_tot+", "+adult_tot);
		
		ProgramDateJoinVO vo = dao.selectProgramTime(pd_num);
		MembersVO mVo = mDao.selectMember((Integer) session.getAttribute("seNum"));
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("child_tot", child_tot);
		mav.addObject("teenager_tot", teenager_tot);
		mav.addObject("adult_tot", adult_tot);
		mav.addObject("vo", vo);
		mav.addObject("mVo", mVo);
		mav.setViewName("program/programReservation");
		return mav;
	}
	
	@RequestMapping("/program/programReservationOk")
	public ModelAndView programReservationOk(HttpServletRequest request, ReservationVO vo){
		ProgramDAOInterface dao = sqlSession.getMapper(ProgramDAOInterface.class);
		int totalNum = vo.getChild_tot() + vo.getTeenager_tot() + vo.getAdult_tot();
		
		int result = dao.insertReservation(vo);
		dao.applicantsCount(vo.getPd_num(), totalNum);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName("program/programReservationOk");
		return mav;
	}
	
}
