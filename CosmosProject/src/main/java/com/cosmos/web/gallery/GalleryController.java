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
		
		//업로드 위치
		String path = request.getSession().getServletContext().getRealPath("/gallery");
		System.out.println(path);
		
		//첨부파일
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)request;
		
		//폼에서 선택한 파일명 얻어오기
		MultipartFile file = mr.getFile("file_name");		
		//System.out.println(file);
		
		if(file!=null){
 			//객체의 변수명 구하기
 			String oriName = file.getName();
 			System.out.println("oriName= "+oriName);
 			//폼에 있는 파일명
 			String oriFilename = file.getOriginalFilename();
 			//업로드 하고자하는 경로에 이미 파일명이 있는지 확인 후 파일명 변경
 			if(!oriFilename.isEmpty()){
 				//		        ex) /upload/a.gif
 				File f = new File(path);
 				int cnt = 1; //파일명에 붙일 번호
 				String newFilename = oriFilename;
 				while(f.exists()){ //f.exists(): 파일 존재하는 확인
 					int dot = oriFilename.lastIndexOf("."); //.위치
 					String fname = oriFilename.substring(0, dot);
 					String ext = oriFilename.substring(dot+1);
 					String fullName = fname + cnt++ + "."+ext;
 					
 					File ff = new File(path, fullName);
 					if(!ff.exists()){
 						newFilename = fullName;
 						break;
 					}
 				}
				
				//업로드
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
