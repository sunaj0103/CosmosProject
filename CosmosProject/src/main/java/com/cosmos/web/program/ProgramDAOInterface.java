package com.cosmos.web.program;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cosmos.web.admin.StatisticsVO;
import com.cosmos.web.notice.NoticeBoardPagingVO;

public interface ProgramDAOInterface {
	//프로그램 입력
	public int insertProgram(ProgramVO vo);
	//모든 프로그램 목록
	public List<ProgramVO> selectAllProgram();
	//1개 프로그램 선택
	public ProgramVO selectProgram(int p_num);
	//프로그램 수정
	public int updateProgram(ProgramVO vo);
	//프로그램 삭제 전 실행 확인
	public int countProgram(int p_num);
	//프로그램 삭제
	public int deleteProgram(int p_num);
	
	//프로그램 시간 입력
	public int insertProgramTime(ProgramDateVO vo);
	//프로그램 시간 카운트
	public int programTimeCount();
	//모든 프로그램 시간 목록 
	public List<ProgramDateJoinVO> selectAllProgramTime(NoticeBoardPagingVO vo);
	//1개 프로그램 시간 선택
	public ProgramDateJoinVO selectProgramTime(int pd_num);
	//프로그램 시간 수정
	public int updateProgramTime(ProgramDateVO vo);
	//프로그램 시간 삭제
	public int deleteProgramTime(int pd_num);
	
	//프로그램별 시간 목록
	public List<ProgramDateVO> selectProgramTimes(int p_num);
	//프로그램 예약 입력 
	public int insertReservation(ReservationVO vo);
	//프로그램 예약 인원수 카운트(num_of_applicants)
	public int applicantsCount(@Param("pd_num") int pd_num, @Param("totalNum") int totalNum);
	
	//프로그램별 통계
	public List<StatisticsVO> statisticsCount();
	
}
