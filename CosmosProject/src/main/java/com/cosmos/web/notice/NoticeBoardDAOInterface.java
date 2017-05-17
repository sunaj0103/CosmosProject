package com.cosmos.web.notice;

import java.util.List;

public interface NoticeBoardDAOInterface {
	//Notice Board �� �ۼ�
	public int insertNoticeBoard(NoticeBoardVO vo);
	//Notice Board �߿� ���� ����Ʈ
	public List<NoticeBoardVO> selectNoticeList();
	//Notice Board ��ü ����Ʈ
	public List<NoticeBoardVO> selectAllList(NoticeBoardPagingVO vo);
	//���� ���ڵ� ��
	public int noticeCount();
	//Notice Board �� ���ڵ� ��
	public int recordCount();
	//1�� Notice Board ����
	public NoticeBoardVO selectNotice(int n_num);
	//��ȸ��
	public int noticeHitCount(int n_num);
	//Notice Board ����
	public int updateNotice(NoticeBoardVO vo);
	//Notice Board ����
	public int deleteNotice(int n_num);
	
}
