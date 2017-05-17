package com.cosmos.web.program;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cosmos.web.admin.StatisticsVO;
import com.cosmos.web.notice.NoticeBoardPagingVO;

public interface ProgramDAOInterface {
	//���α׷� �Է�
	public int insertProgram(ProgramVO vo);
	//��� ���α׷� ���
	public List<ProgramVO> selectAllProgram();
	//1�� ���α׷� ����
	public ProgramVO selectProgram(int p_num);
	//���α׷� ����
	public int updateProgram(ProgramVO vo);
	//���α׷� ���� �� ���� Ȯ��
	public int countProgram(int p_num);
	//���α׷� ����
	public int deleteProgram(int p_num);
	
	//���α׷� �ð� �Է�
	public int insertProgramTime(ProgramDateVO vo);
	//���α׷� �ð� ī��Ʈ
	public int programTimeCount();
	//��� ���α׷� �ð� ��� 
	public List<ProgramDateJoinVO> selectAllProgramTime(NoticeBoardPagingVO vo);
	//1�� ���α׷� �ð� ����
	public ProgramDateJoinVO selectProgramTime(int pd_num);
	//���α׷� �ð� ����
	public int updateProgramTime(ProgramDateVO vo);
	//���α׷� �ð� ����
	public int deleteProgramTime(int pd_num);
	
	//���α׷��� �ð� ���
	public List<ProgramDateVO> selectProgramTimes(int p_num);
	//���α׷� ���� �Է� 
	public int insertReservation(ReservationVO vo);
	//���α׷� ���� �ο��� ī��Ʈ(num_of_applicants)
	public int applicantsCount(@Param("pd_num") int pd_num, @Param("totalNum") int totalNum);
	
	//���α׷��� ���
	public List<StatisticsVO> statisticsCount();
	
}
