<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/web/js_css/jquery-3.1.1.min.js"></script>
<script src="/web/js_css/bootstrap.min.js"></script>
<link href="/web/js_css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="/web/js_css/subStyle.css" rel="stylesheet" type="text/css"/>
<title>가산스타천문대</title>
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

	<div class="contentMyPage">
		<div class="myPageTop">
			<h1>마이페이지</h1>
		</div>	
		
		<ul class="nav nav-pills nav-justified">
			<li class="active"><a href="/web/member/myPage">예약 내역 확인</a></li>
		    <li><a href="/web/member/myPageInfo">개인 정보 확인/수정</a></li>
		</ul>
		
		<div class="myPageReserv">
			<div id="myPageReservDiv">
				<ul class="myPageReservUl">
					<li class="reservName reservT">프로그램명</li>
					<li class="reservDesc reservT">예약 내역</li>
					<li class="reservPay reservT">금액</li>
					<li class="reservPayment reservT">결제</li>
					
					<c:forEach var="vo" items="${list}">
						<li class="reservName">${vo.title}</li>
						<li class="reservDesc">
							<a href="/web/member/reservView?num=${vo.r_num}">
							<fmt:parseDate value="${vo.start_date}" var="start_date" pattern="yyyymmdd" scope="page"/>
							<fmt:formatDate value="${start_date}" pattern="yyyy-mm-dd"/>, 
							${vo.start_time}~${vo.end_time}, 총 ${vo.child_tot+vo.teenager_tot+vo.adult_tot}명</a>
						</li>
						<li class="reservPay">
							<fmt:formatNumber value="${vo.final_payment}" pattern="#,###"/>원
						</li>
						<li class="reservPayment">
							<c:if test="${vo.payment=='C'}">신용카드</c:if>
							<c:if test="${vo.payment=='D'}">무통장입금</c:if>
						</li>
					</c:forEach>
				</ul>			
			</div>
		</div>
	</div>
	<div class="clearDiv"></div>
	
	<div id="footer">
		<div id="footerTxt">
			주소: 서울 금천구 가산디지털2로 123 <br/>
			전화번호: 02-123-1234
		</div>
	</div>
</body>
</html>