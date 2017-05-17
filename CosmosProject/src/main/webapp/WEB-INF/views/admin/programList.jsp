<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true" %>
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
		
	<div class="contentAdmin">
		<ul class="nav nav-pills nav-justified">
			<li><a href="/web/admin">프로그램 정보 입력</a></li>
	    	<li class="active"><a href="/web/admin/programList">프로그램 정보 확인/수정</a></li>
	    	<li><a href="/web/admin/programTimeWrite">프로그램 시간 입력</a></li>
	    	<li><a href="/web/admin/programTimeList">프로그램 시간 정보 확인/수정</a></li>
	  	</ul> 	
	  	<ul class="nav nav-pills nav-justified">
	    	<li><a href="/web/admin/memberList">회원 정보 확인/탈퇴</a></li>
	    	<li><a href="/web/admin/reservList">예약 정보 확인/취소</a></li>
	    	<li><a href="/web/admin/statistics">예약 통계</a></li>
	  	</ul>
	  	
	  	<div class="admin">
			<h2 class="formTitle">프로그램 정보</h2>
			<ul id="programList">
				<li class="programList1 plTitle">번호</li>
				<li class="programList2 plTitle">프로그램명</li>
				<li class="programList1 plTitle">어린이 요금</li>
				<li class="programList1 plTitle">청소년 요금</li>
				<li class="programList1 plTitle">성인 요금</li>
				<li class="programList1 plTitle">단체 최소 인원</li>
				<li class="programList1 plTitle">단체 할인율</li>

				<c:forEach var="vo" items="${p_list}">
					<li class="programList1">${vo.p_num}</li>
					<li class="programList2"><a	href="/web/admin/programListView?num=${vo.p_num}">${vo.title}</a></li>
					<li class="programList1"><fmt:formatNumber value="${vo.child}" pattern="#,###"/>원</li>
					<li class="programList1"><fmt:formatNumber value="${vo.teenager}" pattern="#,###"/>원</li>
					<li class="programList1"><fmt:formatNumber value="${vo.adult}" pattern="#,###"/>원</li>
					<li class="programList1">${vo.discount_min}명</li>
					<li class="programList1">${vo.discount_rate}%</li>
				</c:forEach>
			</ul>
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