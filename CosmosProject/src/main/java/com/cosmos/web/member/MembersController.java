package com.cosmos.web.member;

import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;
import java.util.List;

import javax.crypto.Cipher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cosmos.web.program.ReservationJoinVO;
import com.cosmos.web.program.ReservationVO;

@Controller
public class MembersController {
	//Mybaties 이용하여 jdbc와 xml 매핑파일을 사용
	@Autowired
	SqlSession sqlSession;

	@RequestMapping("/signUp")
	public String signUp(HttpServletRequest request, HttpSession session){
		try {		
			KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
			generator.initialize(1024);
			KeyPair keyPair = generator.genKeyPair();
			KeyFactory keyFactory = KeyFactory.getInstance("RSA");
			PublicKey publicKey = keyPair.getPublic();
			PrivateKey privateKey = keyPair.getPrivate();
	 
			session.setAttribute("_RSA_WEB_Key_", privateKey); //세션에 RSA 개인키를 세션에 저장
			RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
			String publicKeyModulus = publicSpec.getModulus().toString(16);
			String publicKeyExponent = publicSpec.getPublicExponent().toString(16);
			
			request.setAttribute("RSAModulus", publicKeyModulus);
			request.setAttribute("RSAExponent", publicKeyExponent);

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "member/signUp";
	}
	
	@RequestMapping("/member/signUp")
	public ModelAndView signUp(HttpServletRequest request, HttpSession session, MembersVO vo){
		MembersDAOInterface dao = sqlSession.getMapper(MembersDAOInterface.class);
		ModelAndView mav = new ModelAndView();
		
		vo.setBirth();
		vo.setPhone();
		
		PrivateKey privateKey = (PrivateKey) session.getAttribute("_RSA_WEB_Key_"); //로그인전에 세션에 저장된 개인키를 가져옴
		
		if(privateKey == null){
			mav.setViewName("member/signUp");
		}else{
			try	{
				//암호화 처리된 사용자계정 정보를 복호화 처리
				//String uid = decryptRsa(privateKey, vo.getId());
				String pwd = decryptRsa(privateKey, vo.getPassword());
				
				//vo.setId(uid);
				vo.setPassword(pwd);
				int result = dao.insertSignUp(vo);
				mav.addObject("result", result);
				mav.setViewName("member/signUpOk");	
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return mav;
	}

	@RequestMapping("/member/idCheck")
	@ResponseBody
	public String idCheck(String id){
		MembersDAOInterface dao = sqlSession.getMapper(MembersDAOInterface.class);
		int result = dao.idCheck(id);
		String chk = "";
		if(result==0){
			chk = "ok";
		}
		return chk;
	}

	@RequestMapping("/login")
	public String login(HttpServletRequest request, HttpSession session){
		try {		
			KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
			generator.initialize(1024);
			KeyPair keyPair = generator.genKeyPair();
			KeyFactory keyFactory = KeyFactory.getInstance("RSA");
			PublicKey publicKey = keyPair.getPublic();
			PrivateKey privateKey = keyPair.getPrivate();
	 
			session.setAttribute("_RSA_WEB_Key_", privateKey); //세션에 RSA 개인키를 세션에 저장
			RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
			String publicKeyModulus = publicSpec.getModulus().toString(16);
			String publicKeyExponent = publicSpec.getPublicExponent().toString(16);
			
			request.setAttribute("RSAModulus", publicKeyModulus);
			request.setAttribute("RSAExponent", publicKeyExponent); 

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "member/login";
	}
	
	@RequestMapping("/member/loginOk")
	public ModelAndView loginOk(MembersVO vo, HttpSession session){
		MembersDAOInterface dao = sqlSession.getMapper(MembersDAOInterface.class);
		ModelAndView mav = new ModelAndView();
		PrivateKey privateKey = (PrivateKey) session.getAttribute("_RSA_WEB_Key_"); //로그인전에 세션에 저장된 개인키를 가져옴
		
		if(privateKey == null){
			mav.setViewName("main");
		}else{
			try	{
				//암호화 처리된 사용자계정 정보를 복호화 처리
				String pwd = decryptRsa(privateKey, vo.getPassword());
				vo.setPassword(pwd);
				MembersVO mVo = dao.loginCheck(vo);		
				
				//로그인 -> session 객체에 데이터 세팅
				if(mVo == null){
					mav.addObject("loginErr", "Y");
					mav.setViewName("member/login");
				}else{
					session.setAttribute("seNum", mVo.getM_num());
					//session.setAttribute("seId", mVo.getId());
					session.setAttribute("seName", mVo.getName());
					session.setAttribute("seM", mVo.getIs_manager());
					//System.out.println("mVo.getIs_manager(): "+mVo.getIs_manager());
					session.setAttribute("loginStat", "Y");
					mav.addObject("vo", mVo);
					if(mVo.getIs_manager().equals("M")){
						mav.setViewName("admin/admin");
					}else{
						mav.setViewName("main");
					}
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return mav;		
	}
	
	public String decryptRsa(PrivateKey privateKey, String securedValue) {
		String decryptedValue = "";
		try {
			Cipher cipher = Cipher.getInstance("RSA");
			/**
			 * 암호화 된 값은 byte 배열이다. 이를 문자열 폼으로 전송하기 위해 16진 문자열(hex)로 변경한다. 서버측에서도
			 * 값을 받을 때 hex 문자열을 받아서 이를 다시 byte 배열로 바꾼 뒤에 복호화 과정을 수행한다.
			 */
			byte[] encryptedBytes = hexToByteArray(securedValue);
			cipher.init(Cipher.DECRYPT_MODE, privateKey);
			byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
			decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의.
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return decryptedValue;
	}

	/**
	 * 16진 문자열을 byte 배열로 변환한다.
	 */
	public static byte[] hexToByteArray(String hex) {
		if (hex == null || hex.length() % 2 != 0) {
			return new byte[] {};
		}

		byte[] bytes = new byte[hex.length() / 2];
		for (int i = 0; i < hex.length(); i += 2) {
			byte value = (byte) Integer.parseInt(hex.substring(i, i + 2), 16);
			bytes[(int) Math.floor(i / 2)] = value;
		}
		
		return bytes;
	}

	@RequestMapping("/member/idSearch")
	public String idSearch(){
		return "member/idSearch";
	}
	
	@RequestMapping("/member/idSearchOk")
	public ModelAndView idSearchOk(HttpServletRequest request, MembersVO vo){
		MembersDAOInterface dao = sqlSession.getMapper(MembersDAOInterface.class);
		MembersVO mVo = dao.idSearch(vo);
		
		ModelAndView mav = new ModelAndView();
		
		if(mVo == null){
			mav.addObject("idSearchErr", "Y");
			mav.setViewName("member/idSearch");
		}else{
			mav.addObject("vo", mVo);
			mav.setViewName("member/idSearchOk");
		}
		
		return mav;
	}
	
	@RequestMapping("/member/pwSearch")
	public String pwSearch(){
		return "member/pwSearch";
	}
	
	@RequestMapping("/member/pwSearchOk")
	public ModelAndView pwSearchOk(HttpServletRequest request, MembersVO vo){
		MembersDAOInterface dao = sqlSession.getMapper(MembersDAOInterface.class);
		MembersVO mVo = dao.pwSearch(vo);
		
		ModelAndView mav = new ModelAndView();
		
		if(mVo == null){
			mav.addObject("pwSearchErr", "Y");
			mav.setViewName("member/pwSearch");
		}else{
			mav.addObject("vo", mVo);
			mav.setViewName("member/pwSearchOk");
		}
		
		return mav;
	}
	
	@RequestMapping("/member/logout")
	public String logout(HttpSession session){
		//세션 지우기
		session.invalidate();
		return "main";
	}
	
	@RequestMapping("/member/myPage")
	public ModelAndView myPage(HttpSession session){
		MembersDAOInterface dao = sqlSession.getMapper(MembersDAOInterface.class);
		int mNum = (Integer) session.getAttribute("seNum");
		List<ReservationJoinVO> rList = dao.selectAllReservation(mNum);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("list", rList);
		mav.setViewName("member/myPage");
		return mav;
	}
	
	@RequestMapping("/member/reservView")
	public ModelAndView reservView(HttpSession session, @RequestParam("num") int r_num){
		MembersDAOInterface dao = sqlSession.getMapper(MembersDAOInterface.class);
		ReservationJoinVO vo = dao.selectMyReservation(r_num);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("vo", vo);
		mav.setViewName("member/reservView");
		return mav;
	}

	@RequestMapping("/member/reservCancel")
	public ModelAndView reservCancel(HttpSession session, @RequestParam("num") int r_num){
		MembersDAOInterface dao = sqlSession.getMapper(MembersDAOInterface.class);
		ReservationJoinVO vo = dao.selectMyReservation(r_num);
		int totalNum = vo.getChild_tot() + vo.getTeenager_tot() + vo.getAdult_tot();
		
		int result = dao.updateCancel(r_num);
		dao.applicantsReCount(vo.getPd_num(), totalNum);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName("member/reservCancelOk");
		return mav;
	}
	
	@RequestMapping("/member/reservEdit")
	public ModelAndView reservEdit(HttpSession session, @RequestParam("num") int r_num){
		MembersDAOInterface dao = sqlSession.getMapper(MembersDAOInterface.class);
		ReservationJoinVO vo = dao.selectMyReservation(r_num);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("vo", vo);
		mav.setViewName("member/reservEdit");
		return mav;
	}
	
	@RequestMapping("/member/reservEditOk")
	public ModelAndView reservEditOk(HttpSession session, ReservationVO vo){
		MembersDAOInterface dao = sqlSession.getMapper(MembersDAOInterface.class);
		int result = dao.updateReservation(vo);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName("member/reservEditOk");
		return mav;
	}

	@RequestMapping("/member/myPageInfo")
	public ModelAndView myPageInfo(HttpServletRequest request, HttpSession session){
		MembersDAOInterface dao = sqlSession.getMapper(MembersDAOInterface.class);
		MembersVO vo = dao.selectMember((Integer) session.getAttribute("seNum"));
		
		try {		
			KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
			generator.initialize(1024);
			KeyPair keyPair = generator.genKeyPair();
			KeyFactory keyFactory = KeyFactory.getInstance("RSA");
			PublicKey publicKey = keyPair.getPublic();
			PrivateKey privateKey = keyPair.getPrivate();
	 
			session.setAttribute("_RSA_WEB_Key_", privateKey); //세션에 RSA 개인키를 세션에 저장
			RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
			String publicKeyModulus = publicSpec.getModulus().toString(16);
			String publicKeyExponent = publicSpec.getPublicExponent().toString(16);
			
			request.setAttribute("RSAModulus", publicKeyModulus);
			request.setAttribute("RSAExponent", publicKeyExponent); 

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("vo", vo);
		mav.setViewName("member/myPageInfo");
		return mav;
	}
	
	@RequestMapping("/member/myPageInfoEdit")
	public ModelAndView myPageInfoEdit(HttpSession session, MembersVO vo){
		MembersDAOInterface dao = sqlSession.getMapper(MembersDAOInterface.class);
		ModelAndView mav = new ModelAndView();
		PrivateKey privateKey = (PrivateKey) session.getAttribute("_RSA_WEB_Key_"); //세션에 저장된 개인키를 가져옴
		
		if(privateKey == null){
			mav.setViewName("member/myPageInfo");
		}else{
			try	{
				//암호화 처리된 사용자계정 정보를 복호화 처리
				String pwd = decryptRsa(privateKey, vo.getPassword());
				
				vo.setPassword(pwd);
				int result = dao.updateMemberInfo(vo);
				mav.addObject("result", result);
				mav.setViewName("member/myPageInfoEditOk");	
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return mav;
	}
	
	@RequestMapping("/member/myPageInfoWithdrawal")
	public ModelAndView myPageInfowithdrawal(HttpSession session, @RequestParam("num") int m_num){
		MembersDAOInterface dao = sqlSession.getMapper(MembersDAOInterface.class);
		
		int result = dao.updateWithdrawal(m_num);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", result);
		mav.setViewName("member/myPageInfoWithdrawalOk");
		return mav;
	}
	
}
