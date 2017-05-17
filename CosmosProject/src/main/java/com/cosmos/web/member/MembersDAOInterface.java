package com.cosmos.web.member;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cosmos.web.program.ReservationJoinVO;
import com.cosmos.web.program.ReservationVO;

public interface MembersDAOInterface {
	//회원 가입
	public int insertSignUp(MembersVO vo);
	//로그인 체크
	public MembersVO loginCheck(MembersVO vo);
	//아이디 중복 확인
	public int idCheck(String id);
	//id 찾기
	public MembersVO idSearch(MembersVO vo);
	//pw 찾기
	public MembersVO pwSearch(MembersVO vo);
	
	//해당 회원 정보 선택
	public MembersVO selectMember(int m_num);
	//마이페이지 예약리스트
	public List<ReservationJoinVO> selectAllReservation(int m_num);
	//마이페이지 예약 확인
	public ReservationJoinVO selectMyReservation(int r_num);
	//마이페이지 예약 수정
	public int updateReservation(ReservationVO vo);
	//예약 취소
	public int updateCancel(int r_num);
	//프로그램 예약 인원수 카운트 수정
	public int applicantsReCount(@Param("pd_num") int pd_num, @Param("totalNum") int totalNum);
	//회원정보 수정
	public int updateMemberInfo(MembersVO vo);
	//회원탈퇴
	public int updateWithdrawal(@Param("m_num") int m_num);
	
	//관리자 페이지 회원 정보 리스트
	public List<MembersVO> selectAllMembers();
	//관리자 페이지 전체 예약 리스트
	public List<ReservationJoinVO> selectAllReservList(@Param("pd_num") int pd_num);
	//관리자 페이지 예약 취소
	public int updateReservCancel(@Param("r_num") int r_num);
	
}
