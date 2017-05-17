package com.cosmos.web.member;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cosmos.web.program.ReservationJoinVO;
import com.cosmos.web.program.ReservationVO;

public interface MembersDAOInterface {
	//ȸ�� ����
	public int insertSignUp(MembersVO vo);
	//�α��� üũ
	public MembersVO loginCheck(MembersVO vo);
	//���̵� �ߺ� Ȯ��
	public int idCheck(String id);
	//id ã��
	public MembersVO idSearch(MembersVO vo);
	//pw ã��
	public MembersVO pwSearch(MembersVO vo);
	
	//�ش� ȸ�� ���� ����
	public MembersVO selectMember(int m_num);
	//���������� ���ฮ��Ʈ
	public List<ReservationJoinVO> selectAllReservation(int m_num);
	//���������� ���� Ȯ��
	public ReservationJoinVO selectMyReservation(int r_num);
	//���������� ���� ����
	public int updateReservation(ReservationVO vo);
	//���� ���
	public int updateCancel(int r_num);
	//���α׷� ���� �ο��� ī��Ʈ ����
	public int applicantsReCount(@Param("pd_num") int pd_num, @Param("totalNum") int totalNum);
	//ȸ������ ����
	public int updateMemberInfo(MembersVO vo);
	//ȸ��Ż��
	public int updateWithdrawal(@Param("m_num") int m_num);
	
	//������ ������ ȸ�� ���� ����Ʈ
	public List<MembersVO> selectAllMembers();
	//������ ������ ��ü ���� ����Ʈ
	public List<ReservationJoinVO> selectAllReservList(@Param("pd_num") int pd_num);
	//������ ������ ���� ���
	public int updateReservCancel(@Param("r_num") int r_num);
	
}
