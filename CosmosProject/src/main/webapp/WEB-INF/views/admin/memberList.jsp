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
<script>
	function delChk(m_num){
		if(confirm("정말로 탈퇴처리 하시겠습니까?")){
			location.href="/web/admin/memberListWithdrawal?num="+m_num;
		}
	}
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
	
	<div class="contentAdmin">
		<ul class="nav nav-pills nav-justified">
			<li><a href="/web/admin">프로그램 정보 입력</a></li>
	    	<li><a href="/web/admin/programList">프로그램 정보 확인/수정</a></li>
	    	<li><a href="/web/admin/programTimeWrite">프로그램 시간 입력</a></li>
	    	<li><a href="/web/admin/programTimeList">프로그램 시간 정보 확인/수정</a></li>
	  	</ul> 	
	  	<ul class="nav nav-pills nav-justified">
	    	<li class="active"><a href="/web/admin/memberList">회원 정보 확인/탈퇴</a></li>
	    	<li><a href="/web/admin/reservList">예약 정보 확인/취소</a></li>
	    	<li><a href="/web/admin/statistics">예약 통계</a></li>
	  	</ul> 	
	 		
		<div class="admin">
			<h2 class="formTitle">회원 정보 확인/탈퇴</h2>
			<ul class="memberList">
				<li class="memberList1 plTitle">아이디</li>
				<li class="memberList1 plTitle">이름</li>
				<li class="memberList2 plTitle">생년월일</li>
				<li class="memberList1 plTitle">성별</li>
				<li class="memberList2 plTitle">이메일</li>
				<li class="memberList1 plTitle">SMS 수신</li>
				<li class="memberList1 plTitle">탈퇴</li>

				<c:forEach var="vo" items="${list}">
					<li class="memberList1">${vo.id}</li>
					<li class="memberList1">${vo.name}</li>
					<li class="memberList2">
						<fmt:parseDate value="${vo.birth}" var="birth" pattern="yyyymmdd" scope="page"/>
						<fmt:formatDate value="${birth}" pattern="yyyy-mm-dd"/>
					</li>
					<li class="memberList1">${vo.gender}</li>
					<li class="memberList2">${vo.email}</li>
					<li class="memberList1">${vo.sms_reception}</li>
					<li class="memberList1">
						<a href="javascript:delChk(${vo.m_num})">탈퇴</a>
					</li>
				</c:forEach>
			</ul>
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