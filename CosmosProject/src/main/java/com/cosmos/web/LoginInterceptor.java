package com.cosmos.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor {

	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object obj) throws Exception {
		//��Ʈ�ѷ� ���� �� �α��� ���� Ȯ��
		try {
			//�α��� �ȵ� ���
			if(request.getSession().getAttribute("loginStat") != "Y"){
				//System.out.println("loginChk");
				response.sendRedirect("/web/login");
				return false;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		//�α���
		return true;
	}

}
