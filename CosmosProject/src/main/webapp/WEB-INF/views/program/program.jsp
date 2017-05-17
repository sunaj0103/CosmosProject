<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/web/js_css/jquery-3.1.1.min.js"></script>
<link href="/web/js_css/programStyle.css" rel="stylesheet" type="text/css"/>
<title>가산스타천문대</title>
<script>
$(function(){
	var programListCount  = $("#programList ul").children().length;	
	var lineHeight = 215;
	var totalListHeight = ((programListCount/4)-1)*lineHeight
	$("#programList").css("height", totalListHeight+90);
	
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

	<div id="contentProgram">
		<div id="program">
			<div id="programTitle">
				<h1>프로그램 예약</h1>
			</div>
			<div id="programTop">
				<div id="programTopImg">
					<img src="${pageContext.request.contextPath}/img/program_top.jpg"/>
				</div>
				<div id="programTopDesc">
					<h3>예약 안내</h3>
					<h4>예약하고자 하는 프로그램을 선택하신 다음 시간을 고르고,<br/> 인원수를 입력해주세요.</h4>
					<p>
						관람일에 천재지변, 보수공사 등 부득이한 사유로 운영을 할 수 없는 경우 이용이 제한될 수 있습니다. 단, 이 경우 사전 연락드리며, 예매 금액은 전액 환불 조치됩니다.<br/>
						예약은 로그인 후 이용해 주세요.
					</p>
				</div>
			</div>
			<div id="programList">
				<ul class="programUl">
					<li class="programTitle1">프로그램</li>
					<li class="programTitle2">추천 대상</li>
					<li class="programTitle3">이용요금</li>
					<li class="programTitle4">단체할인</li>
					
					<c:forEach var="vo" items="${p_list}">
						<li class="programLi1">
							<h4><a href="/web/program/programView?num=${vo.p_num}">${vo.title}</a></h4>
							<p>${vo.description}</p>
						</li>
						<li class="programLi2">${vo.recommend}</li>
						<li class="programLi3">
							<br/><br/>
							어린이 요금: <fmt:formatNumber value="${vo.child}" pattern="#,###"/>원<br/>
							청소년 요금: <fmt:formatNumber value="${vo.teenager}" pattern="#,###"/>원<br/>
							성인 요금: <fmt:formatNumber value="${vo.adult}" pattern="#,###"/>원
						</li>
						<li class="programLi4">
							${vo.discount_min}명 이상,
							${vo.discount_rate}%
						</li>
					</c:forEach>
				</ul>
			</div>
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