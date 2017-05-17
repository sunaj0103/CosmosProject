package com.cosmos.web.gallery;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class GalleryController {
	@Autowired
	SqlSession sqlSession;

	@RequestMapping("/gallery")
	public ModelAndView gallery(){
		GalleryDAOInterface dao = sqlSession.getMapper(GalleryDAOInterface.class);
		List<GalleryUploadVO> galleryList = dao.selectAllList();
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("list", galleryList);
		mav.setViewName("gallery/gallery");
		return mav;
	}
	
	@RequestMapping("/gallery/galleryUpload")
	public String galleryUpload(){
		return "gallery/galleryUpload";
	}
	
	@RequestMapping("/gallery/galleryUploadOk")
	public ModelAndView galleryUploadOk(HttpServletRequest request){
		GalleryDAOInterface dao = sqlSession.getMapper(GalleryDAOInterface.class);
		GalleryUploadVO vo = new GalleryUploadVO();
		vo.setM_num(Integer.parseInt(request.getParameter("m_num")));
		int result = 0;
		
		//���ε� ��ġ
		String path = request.getSession().getServletContext().getRealPath("/gallery");
		System.out.println(path);
		
		//÷������
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)request;
		
		//������ ������ ���ϸ� ������
		MultipartFile file = mr.getFile("file_name");		
		//System.out.println(file);
		
		if(file!=null){
 			//��ü�� ������ ���ϱ�
 			String oriName = file.getName();
 			System.out.println("oriName= "+oriName);
 			//���� �ִ� ���ϸ�
 			String oriFilename = file.getOriginalFilename();
 			//���ε� �ϰ����ϴ� ��ο� �̹� ���ϸ��� �ִ��� Ȯ�� �� ���ϸ� ����
 			if(!oriFilename.isEmpty()){
 				//		        ex) /upload/a.gif
 				File f = new File(path);
 				int cnt = 1; //���ϸ� ���� ��ȣ
 				String newFilename = oriFilename;
 				while(f.exists()){ //f.exists(): ���� �����ϴ� Ȯ��
 					int dot = oriFilename.lastIndexOf("."); //.��ġ
 					String fname = oriFilename.substring(0, dot);
 					String ext = oriFilename.substring(dot+1);
 					String fullName = fname + cnt++ + "."+ext;
 					
 					File ff = new File(path, fullName);
 					if(!ff.exists()){
 						newFilename = fullName;
 						break;
 					}
 				}
				
				//���ε�
				try {
					file.transferTo(new File(path, newFilename));
				} catch (Exception e) {
					e.printStackTrace();
				}
				vo.setFile_name(newFilename);
				result = dao.insertGalleryUpload(vo);
 			}
		}
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName("gallery/galleryUploadOk");
		return mav;	
	}
	
	@RequestMapping("/gallery/galleryDel")
	public ModelAndView galleryDel(){
		GalleryDAOInterface dao = sqlSession.getMapper(GalleryDAOInterface.class);
		List<GalleryUploadVO> galleryList = dao.selectAllList();
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("list", galleryList);
		mav.setViewName("gallery/galleryDel");
		return mav;	
	}
	
	@RequestMapping("/gallery/galleryDelOk")
	public ModelAndView galleryDelOk(@RequestParam("num") int g_num){
		GalleryDAOInterface dao = sqlSession.getMapper(GalleryDAOInterface.class);
		int result = dao.deleteGalleryUpload(g_num);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName("gallery/galleryDelOk");
		return mav;	
	}
}
