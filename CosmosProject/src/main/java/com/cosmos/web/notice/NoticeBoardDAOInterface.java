package com.cosmos.web.notice;

import java.util.List;

public interface NoticeBoardDAOInterface {
	//Notice Board 글 작성
	public int insertNoticeBoard(NoticeBoardVO vo);
	//Notice Board 중요 공지 리스트
	public List<NoticeBoardVO> selectNoticeList();
	//Notice Board 전체 리스트
	public List<NoticeBoardVO> selectAllList(NoticeBoardPagingVO vo);
	//공지 레코드 수
	public int noticeCount();
	//Notice Board 총 레코드 수
	public int recordCount();
	//1개 Notice Board 선택
	public NoticeBoardVO selectNotice(int n_num);
	//조회수
	public int noticeHitCount(int n_num);
	//Notice Board 수정
	public int updateNotice(NoticeBoardVO vo);
	//Notice Board 삭제
	public int deleteNotice(int n_num);
	
}
