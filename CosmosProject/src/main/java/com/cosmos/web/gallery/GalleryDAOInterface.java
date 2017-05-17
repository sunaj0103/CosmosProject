package com.cosmos.web.gallery;

import java.util.List;

public interface GalleryDAOInterface {
	//갤러리 이미지 전체 리스트
	public List<GalleryUploadVO> selectAllList();
	//갤러리 이미지 업로드
	public int insertGalleryUpload(GalleryUploadVO vo);
	//이미지 삭제
	public int deleteGalleryUpload(int g_num);
	
}
