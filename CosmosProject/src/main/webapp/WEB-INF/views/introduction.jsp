<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCBtgCwDiiDcFRXpOpuDdd6y5G6J6y6fS4"></script>
<script src="/web/js_css/jquery-3.1.1.min.js"></script>
<script src="/web/js_css/jquery.gmap.js" type="text/javascript"></script>
<link href="/web/js_css/subStyle.css" rel="stylesheet" type="text/css"/>
<title>가산스타천문대</title>
<style>
.contentIntroduction1 {
	width: 100%;
	height: 400px;
	margin: 0px auto;
	background-image: url('/web/img/cosmos.jpg');
	background-size: auto;
	background-repeat: no-repeat;
	background-position: top;
}

.introduction1 {
	width: 1000px;
	margin: 0 auto;
	padding-top: 90px;
	font-size: 22px;
	font-family: 'notokrR';
	color: #fff;
	text-align: center;
	text-shadow: #fff 0 0 10px;
}

.contentIntroduction2 {
	width: 100%;
	height: 320px;
	margin: 0px auto;
	background-color: #fff;
}

.introduction2 {
	width: 1000px;
	margin: 0 auto;
	padding-top: 40px;
	font-size: 20px;
	font-family: 'notokrB';
	color: #111;
	text-align: center;
}

.introduction2>img, .introduction2>div {
	float: left;
}

.introduction2>div {
	width: 630px;
	padding-left: 30px;
	font-family: 'notokrL';
	text-align: left;
}

.contentIntroduction3 {
	width: 100%;
	height: 750px;
	margin: 0px auto;
	background-color: #fff;
}

.introduction3 {
	width: 1000px;
	margin: 0 auto;
	padding-top: 40px;
	font-size: 20px;
	font-family: 'notokrB';
	color: #111;
	text-align: center;
}

#map {
	width: 900px;
	height: 500px;
	margin: 0 auto;
	border: 1px solid #000;
}

</style>
<script>
	$(function(){	   	    
		$("#map").gMap({
			latitude:37.478955,
			longitude:126.878663,
			maptype: 'ROADMAP', 
			zoom: 14,
			markers: [{
				latitude:37.478955,
				longitude:126.878663,
				title:'가산스타천문대',
				html:'가산스타천문대',
				popup:true
			}],
			controls:{
				zoomControl:true,
				mapTypeControl:true,
				streetViewControl:true
			}
		});
	});	
</script>
</head>
<body>
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

	<div class="contentIntroduction1">
		<div class="introduction1">
			별을 보고 탄성을 질러본 적이 있습니까?<br/> 
			밤하늘을 잊고 지내던 어느 날 우연히 바라본 하늘에서 <br/> 
			초롱초롱한 별을 보고 그 별의 이름이 궁금한 적이 있습니까?<br/> 
			<br/> 
			맑은 밤이면, 서울 하늘에서도 별이 보입니다.<br/>  
			그 별 중에는 실제 별도 있지만 행성도 있다는 사실을<br/>  
			알고 있는 사람은 그리 많지 않습니다.<br/> 
		</div>
	</div>
	<div class="contentIntroduction2">
		<div class="introduction2">
			<h3>천문대 소개</h3>
			<img src="${pageContext.request.contextPath}/img/intro2.jpg">
			<div>				 
				가산스타천문대는 서울의 중심에서 별을 관측하고<br/>  
				천체투영관에서 우주를 여행할 수 있는 천문공원을 만들었습니다.<br/> 
				탁한 공기와 먼지, 바쁜 일상으로 인해 별을 잊은 사람들에게 별을 선물하는 일입니다.<br/> 
				별은 멀리 있지 않습니다. 시골이 아닌 도시에서도 충분히 별을 볼 수 있습니다.<br/> 
			 	달과 별과 행성을 관찰했을 때 느끼는 아름다움은 감탄사로 이어집니다.<br/> 
			 	서울의 중심에서 함께 외쳐요.<br/><br/> 
		 	</div>
	 	</div>
	</div>
	
	<div class="contentIntroduction3">
		<div class="introduction3">
			<h3>오시는 길</h3> 
			<h5>서울 금천구 가산디지털2로 123</h5>
			<div id="map"></div>
	 	</div>
	</div>
	
	<div id="footer">
		<div id="footerTxt">
			주소: 서울 금천구 가산디지털2로 123 <br/>
			전화번호: 02-123-1234
		</div>			
	</div>
</body>
</html>