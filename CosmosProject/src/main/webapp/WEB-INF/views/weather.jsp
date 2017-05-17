<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.w3c.dom.*"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/web/js_css/jquery-3.1.1.min.js"></script>
<link href="/web/js_css/subStyle.css" rel="stylesheet" type="text/css"/>
<title>가산스타천문대</title>
<style>
#loginDiv {
	position:fixed;
	width: 100%;
	height: 40px;
	background-color: #fff;
	color: #000;
	text-align: center;
	z-index: 35;
}

#menuDiv {
	position:fixed;
	width: 100%;
	height: 70px;
	top: 40px;
	background-color: #809bb6;
	z-index: 50;
}

#footer {
	position:fixed;
	bottom: 30px;
	z-index: 20;
	width: 100%;
	height: 70px;
	background-color: #222;
}

#footerTxt {
	margin-left: 70px;
	padding: 15px 0px;
	color: #ADD8E6;
	font-family: 'notokrR';
	font-size: 0.8em;
}

#contentWeather {
	position:fixed;
	width: 100%;
	height: 1000px;
	top: 200px;
	z-index: 8;
}

#contentWeather>div{
	width: 1000px;
	height: 600px;
	margin: 0 auto;
	z-index: 10;
	color: #fff;
	
}

#contentWeather>div ul {
	width: 280px;
	margin: 20px 10px;
	padding: 10px;
	float: left;
}

#contentWeather>div ul li {
	padding: 2px 60px;
}

.wCenter {
	font-size: 18px;
	font-weight: bold;
	text-align: center;
}

@keyframes move-twink-back {
    from {background-position:0 0;}
    to {background-position:-10000px 5000px;}
}
@-webkit-keyframes move-twink-back {
    from {background-position:0 0;}
    to {background-position:-10000px 5000px;}
}
@-moz-keyframes move-twink-back {
    from {background-position:0 0;}
    to {background-position:-10000px 5000px;}
}
@-ms-keyframes move-twink-back {
    from {background-position:0 0;}
    to {background-position:-10000px 5000px;}
}
@keyframes move-clouds-back {
    from {background-position:0 0;}
    to {background-position:10000px 0;}
}
@-webkit-keyframes move-clouds-back {
    from {background-position:0 0;}
    to {background-position:10000px 0;}
}
@-moz-keyframes move-clouds-back {
    from {background-position:0 0;}
    to {background-position:10000px 0;}
}
@-ms-keyframes move-clouds-back {
    from {background-position: 0;}
    to {background-position:10000px 0;}
}

.stars, .twinkling, .clouds {
	position:absolute;
	top:0;
  	left:0;
  	right:0;
  	bottom:0;
  	width:100%;
  	height:100%;
  	display:block;
}

.stars {
	background:#000 url('img/back/stars.png') repeat top center;
  	z-index:0;
}

.twinkling {
	background:transparent url('img/back/twinkling.png') repeat top center;
  	z-index:1;

  	-moz-animation:move-twink-back 200s linear infinite;
  	-ms-animation:move-twink-back 200s linear infinite;
  	-o-animation:move-twink-back 200s linear infinite;
  	-webkit-animation:move-twink-back 200s linear infinite;
  	animation:move-twink-back 200s linear infinite;
}

.clouds {
	background:transparent url('img/back/clouds.png') repeat top center;
    z-index:3;

  	-moz-animation:move-clouds-back 200s linear infinite;
  	-ms-animation:move-clouds-back 200s linear infinite;
  	-o-animation:move-clouds-back 200s linear infinite;
  	-webkit-animation:move-clouds-back 200s linear infinite;
  	animation:move-clouds-back 200s linear infinite;
}
</style>
</head>
<body>
<% 
	String urlStr = "http://www.kma.go.kr/wid/queryDFSRSS.jsp?zone=1154551000"; //금천구 가산동
	//서버에서리턴될 XML데이터의 엘리먼트 이름 배열
	//<temp>4.5</temp> 현재시간온도(18시~21시)
	//<wfKor>흐림</wfKor> 날씨한국어
	//<wfEn>Cloudy</wfEn> 날씨영어
	//<pop>23</pop> 강수확률%
	//<hour>21</hour> 동네예보 3시간단위(18시~21시까지)
	//<day>0</day> 1번째날(오늘/내일/모레 중 오늘)
	//<ws>1.8</ws> 풍속(m/s)
	//<wdEn>E</wdEn> 풍향영어
	//<reh>60</reh> 습도%
	String[] fieldNames ={"temp", "wfKor", "wfEn", "pop", "hour", "day", "ws", "wdEn", "reh"};
	//각 게시물하나에 해당하는 XML 노드를 담을 리스트
	ArrayList<HashMap<String, String>> pubList = new ArrayList<HashMap<String, String>>();
 
	String day1 = "";
	String hour1 = "";
	String wfKor1 = "";
	String imgWfKor1 = ""; 
	String wfTemp1 = "";
	String wfEn1 = "";
	String pop1 = "";
	String wdEn1 = "";
	String ws1 = "";
	String reh1 = "";
 
	String day2 = "";
	String hour2 = "";
	String wfKor2 = "";
	String imgWfKor2 = ""; 
	String wfTemp2 = "";
	String wfEn2 = "";
	String pop2 = "";
	String wdEn2 = "";
	String ws2 = "";
	String reh2 = "";
	
	String hour3 = "";
	String wfKor3 = "";
	String imgWfKor3 = "";
	String wfTemp3 = "";
	String wfEn3 = "";
	String pop3 = "";
	String wdEn3 = "";
	String ws3 = "";
	String reh3 = "";
 
	try{
		//XML파싱 준비
		DocumentBuilderFactory f = DocumentBuilderFactory.newInstance();
		DocumentBuilder b = f.newDocumentBuilder();
  
		//위에서 구성한 URL을 통해 XMl 파싱 시작
		Document doc = b.parse(urlStr);
		doc.getDocumentElement().normalize();
  
		//서버에서 응답한 XML데이터를 data(발행문서 1개 해당) 태그로 각각 나눔(파라미터로 요청한 size 항목의 수만큼)
		NodeList items = doc.getElementsByTagName("data");    
  
		//for 루프시작
		for(int i=0; i<items.getLength(); i++){
			//i번째 publication 태그를 가져와서
			Node n = items.item(i);
   
			Element e = (Element) n;
			HashMap<String, String> pub = new HashMap<String,String>();
   
   			//for 루프 시작
   			for(String name : fieldNames){
    			//"temp" 등 해당하는 값을 XML 노드에서 가져옴
    			NodeList titleList = e.getElementsByTagName(name);
    			Element titleElem = (Element) titleList.item(0);
    			Node titleNode = titleElem.getChildNodes().item(0);
    			//가져온 XML 값을 맵에 엘리먼트 이름 - 값으로 넣음
    			pub.put(name, titleNode.getNodeValue());
			}
   		//데이터가 전부 들어간 맵을 리스트에 넣고 화면에 뿌릴 준비.
   		pubList.add(pub);
		} 
  
	}catch(Exception ee){
		ee.printStackTrace();
	}
   
	for(int i = 0; i < pubList.size(); i++){
		HashMap<String,String> pub = pubList.get(i);
  
		String tmpWfKor = pub.get("wfKor");   
		if(tmpWfKor == null) tmpWfKor = "";
  
		String tmpImgWfKor = "ico01"; //기본으로 아이콘 맑음으로 놓은 뒤에 변경
		String tmpWfDay = pub.get("day");
  		String tmpWfHour = pub.get("hour");
  		String tmpWfEn = pub.get("wfEn");
  		String tmpPop = pub.get("pop");
  		String tmpWdEn = pub.get("wdEn");
  		String tmpWs = pub.get("ws");
  		String tmpReh = pub.get("reh");
    
		if(tmpWfKor.equals("구름 조금")) tmpImgWfKor = "ico02";
		else if(tmpWfKor.equals("구름 많음")) tmpImgWfKor = "ico03";
		else if(tmpWfKor.equals("흐림")) tmpImgWfKor = "ico04";
		else if(tmpWfKor.equals("비")) tmpImgWfKor = "ico05";
		else if(tmpWfKor.equals("눈/비")) tmpImgWfKor = "ico06";
		else if(tmpWfKor.equals("눈")) tmpImgWfKor = "ico07";
		String tmpWfTemp = pub.get("temp");
		
		if(i == 0){
			day1 = tmpWfDay;
			hour1 = tmpWfHour;
			wfKor1 = tmpWfKor;
			imgWfKor1 = tmpImgWfKor;
			wfTemp1 = tmpWfTemp;
			wfEn1 = tmpWfEn;
			pop1 = tmpPop;
			wdEn1 = tmpWdEn;
			if(tmpWs.length()>4){
				tmpWs = tmpWs.substring(0, 4); 
			}
			ws1 = tmpWs;
			reh1 = tmpReh;
		}
		
		if(i == 0 && tmpWfHour.equals("18")){
			day1 = tmpWfDay;
			hour1 = tmpWfHour;
			wfKor1 = tmpWfKor;
			imgWfKor1 = tmpImgWfKor;
			wfTemp1 = tmpWfTemp;
			wfEn1 = tmpWfEn;
			pop1 = tmpPop;
			wdEn1 = tmpWdEn;
			if(tmpWs.length()>4){
				tmpWs = tmpWs.substring(0, 4); 
			}
			ws1 = tmpWs;
			reh1 = tmpReh;
		}
		
		//내일 날씨
		if(tmpWfDay.equals("1") && tmpWfHour.equals("18")){
			hour2 = tmpWfHour;
			wfKor2 = tmpWfKor;
			imgWfKor2 = tmpImgWfKor;
			wfTemp2 = tmpWfTemp;
			wfEn2 = tmpWfEn;
			pop2 = tmpPop;
			wdEn2 = tmpWdEn;
			if(tmpWs.length()>4){
				tmpWs = tmpWs.substring(0, 4); 
			}
			ws2 = tmpWs;
			reh2 = tmpReh;
		}
		
	  	if(!tmpWfKor.equals("") && tmpWfDay.equals("2") && tmpWfHour.equals("18")){
	  		hour3 = tmpWfHour;
			wfKor3 = tmpWfKor;
			imgWfKor3 = tmpImgWfKor;
			wfTemp3 = tmpWfTemp;
			wfEn3 = tmpWfEn;
			pop3 = tmpPop;
			wdEn3 = tmpWdEn;
			if(tmpWs.length()>4){
				tmpWs = tmpWs.substring(0, 4); 
			}
			ws3 = tmpWs;
			reh3 = tmpReh;
	  	}
 	}
%>

<nav role='navigation'>
	<div id="menuToggle">    
	    <input type="checkbox" />
	    
	    <span></span>
	    <span></span>
	    <span></span>
	    
	    <ul id="menu">
	    	<li><a href="/web/introduction">소개</a></li>
			<li><a href="/web/program">관람 안내 / 예약</a></li>
			<li><a href="/web/astronomy">천문 정보</a></li>
			<li><a href="/web/notice">공지사항 / 뉴스</a></li>
			<li><a href="/web/gallery">갤러리</a></li>
			<li><a href="/web/weather">날씨 정보</a></li>
	    </ul>
	</div>
</nav>

	<div id="loginDiv">
		<ul id="loginUl">
			<li>
				<c:if test="${loginStat!='Y'}">
					<a class="loginTop" href="/web/signUp">회원가입</a>
				</c:if>
			</li>
			<li>
				<c:if test="${loginStat!='Y'}">
					<a class="loginTop loginLink" href="/web/login">로그인</a>
				</c:if>
				<c:if test="${loginStat=='Y'}">
					<span class="userName">${seName}님</span>
					<c:if test="${seM=='M'}">
						<a class="loginTop" href="/web/admin">관리자페이지</a>
					</c:if>
					<a class="loginTop" href="/web/member/myPage">마이페이지</a>
					<a class="loginTop" href="/web/member/logout">로그아웃</a> 
				</c:if>
			</li>
		</ul>
	</div>
	<div id="menuDiv">		
		<div id="logoDiv"><a href="/web"><img src="${pageContext.request.contextPath}/img/logo.png"/></a></div>
	</div>
	
<%
	Calendar cal1 = new GregorianCalendar(Locale.KOREA);
	cal1.setTime(new Date());
	Calendar cal2 = new GregorianCalendar(Locale.KOREA);
	cal2.add(Calendar.DAY_OF_YEAR, 1);
	Calendar cal3 = new GregorianCalendar(Locale.KOREA);
	cal3.add(Calendar.DAY_OF_YEAR, 2);
	
	SimpleDateFormat fm = new SimpleDateFormat("MM/dd");
	String date1 = fm.format(cal1.getTime());
	String date2 = fm.format(cal2.getTime());
	String date3 = fm.format(cal3.getTime());
%>
	
	<div id="contentWeather">
		<div>
		<h2 class="formTitle">금천구 가산동 기상 정보</h2>
		<ul>
			<li class="wCenter">오늘(<%=date1%>)  18시</li>
			<li class="wCenter"><img src="img/weather_icon/<%=imgWfKor1%>.png"/></li>
			<li><%=wfKor1%></li>
			<li><%=wfEn1%></li>
			<li><%=wfTemp1%>&deg;C</li>
			<li>강수확률: <%=pop1%>%</li>
			<li>풍향: <%=wdEn1%></li>
			<li>풍속: <%=ws1%>m/s</li>
			<li>습도: <%=reh1%>%</li>
		</ul>
		<ul>
			<li class="wCenter">내일(<%=date2%>) 18시</li>
			<li class="wCenter"><img src="img/weather_icon/<%=imgWfKor2%>.png"/></li>
			<li><%=wfKor2%></li>
			<li><%=wfEn2%></li>
			<li><%=wfTemp2%>&deg;C</li>
			<li>강수확률: <%=pop2%>%</li>
			<li>풍향: <%=wdEn2%></li>
			<li>풍속: <%=ws2%>m/s</li>
			<li>습도: <%=reh2%>%</li>
		</ul>
		<ul>
			<li class="wCenter">모레(<%=date3%>) 18시</li>
			<li class="wCenter"><img src="img/weather_icon/<%=imgWfKor3%>.png"/></li>
			<li><%=wfKor3%></li>
			<li><%=wfEn3%></li>
			<li><%=wfTemp3%>&deg;C</li>
			<li>강수확률: <%=pop3%>%</li>
			<li>풍향: <%=wdEn3%></li>
			<li>풍속: <%=ws3%>m/s</li>
			<li>습도: <%=reh3%>%</li>
		</ul>
		</div>
	</div>
	
	<div id="back">
		<div class="stars"></div>
		<div class="twinkling"></div>
		<div class="clouds"></div>
	</div>

	<div id="footer">
		<div id="footerTxt">
			주소: 서울 금천구 가산디지털2로 123 <br/>
			전화번호: 02-123-1234
		</div>
	</div>
</body>
</html>