package com.cosmos.web.gallery;

import java.util.List;

public interface GalleryDAOInterface {
	//������ �̹��� ��ü ����Ʈ
	public List<GalleryUploadVO> selectAllList();
	//������ �̹��� ���ε�
	public int insertGalleryUpload(GalleryUploadVO vo);
	//�̹��� ����
	public int deleteGalleryUpload(int g_num);
	
}
