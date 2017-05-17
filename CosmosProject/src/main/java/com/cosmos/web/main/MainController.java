package com.cosmos.web.main;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	
	@RequestMapping("/introduction")
	public String introduction(){
		return "introduction";
	}
	
	@RequestMapping("/astronomy")
	public String astronomy(){
		return "astronomy";
	}
	
	@RequestMapping("/weather")
	public String weather(){
		return "weather";
	}
	
	@RequestMapping("/admin")
	public String admin(HttpSession session){
		if(session.getAttribute("seM").equals("M")){
			return "admin/admin";
		}else{
			return "admin/adminNo";
		}
	}
	
}
