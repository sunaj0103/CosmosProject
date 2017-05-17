<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	function cancelChk(){
		if(confirm("정말로 해당 프로그램 시간을 취소하시겠습니까?")){
			location.href="/web/admin/programTimeDelete?num=${vo.pd_num}";
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
		
	<div class="contentAdmin" style="height: 1200px;">
		<ul class="nav nav-pills nav-justified">
			<li><a href="/web/admin">프로그램 정보 입력</a></li>
	    	<li><a href="/web/admin/programList">프로그램 정보 확인/수정</a></li>
	    	<li><a href="/web/admin/programTimeWrite">프로그램 시간 입력</a></li>
	    	<li class="active"><a href="/web/admin/programTimeList">프로그램 시간 정보 확인/수정</a></li>
	  	</ul>
	  	<ul class="nav nav-pills nav-justified">
	    	<li><a href="/web/admin/memberList">회원 정보 확인/탈퇴</a></li>
	    	<li><a href="/web/admin/reservList">예약 정보 확인/취소</a></li>
	    	<li><a href="/web/admin/statistics">예약 통계</a></li>
	  	</ul>
		
		<div class="admin">
			<h2 class="formTitle">프로그램 시간 정보</h2>
			<div class="adminListView">
				<ul>
					<li class="viewTitle">프로그램명</li>
					<li class="viewText">${vo.title}</li>
				</ul>
				<ul class="viewDescUl">
					<li class="viewDescTitle">프로그램 설명</li>
					<li class="viewDesc">${vo.description}</li>
				</ul>
				<ul>
					<li class="viewTitle">시행일</li>
					<li class="viewText">
						<fmt:parseDate value="${vo.start_date}" var="start_date" pattern="yyyymmdd" scope="page"/>
						<fmt:formatDate value="${start_date}" pattern="yyyy-mm-dd"/>
					</li>
				</ul>
				<ul>
					<li class="viewTitle">시작 시간</li>
					<li class="viewText">${vo.start_time}</li>
				</ul>
				<ul>
					<li class="viewTitle">종료 시간</li>
					<li class="viewText">${vo.end_time}</li>
				</ul>
				<ul>
					<li class="viewTitle">상태</li>
					<li class="viewText">
						<c:if test="${vo.status=='Y'}">
							예약 중
						</c:if>
						<c:if test="${vo.status=='N'}">
							마감
						</c:if>
					</li>
				</ul>
				<ul>
					<li class="viewTitle">신청 가능 총 인원</li>
					<li class="viewText">${vo.total_num_of_applicants}명</li>
				</ul>
				<ul>
					<li class="viewTitle">현재까지 신청한 총 인원</li>
					<li class="viewText">${vo.num_of_applicants}명</li>
				</ul>
				<ul>
					<li class="viewTitle">취소 여부</li>
					<li class="viewText">
						<c:if test="${vo.canceled=='Y'}">
							취소
						</c:if>
						<c:if test="${vo.canceled=='N'}">
							-
						</c:if>
					</li>
				</ul>
				<ul>
					<li class="viewTitle">추천대상</li>
					<li class="viewText">${vo.recommend}</li>
				</ul>
				<ul>
					<li class="viewTitle">어린이 요금</li>
					<li class="viewText"><fmt:formatNumber value="${vo.child}" pattern="#,###"/>원</li>
				</ul>
				<ul>
					<li class="viewTitle">청소년 요금</li>
					<li class="viewText"><fmt:formatNumber value="${vo.teenager}" pattern="#,###"/>원</li>
				</ul>
				<ul>
					<li class="viewTitle">성인 요금</li>
					<li class="viewText"><fmt:formatNumber value="${vo.adult}" pattern="#,###"/>원</li>
				</ul>
				<ul>
					<li class="viewTitle">단체 최소 인원</li>
					<li class="viewText">${vo.discount_min}명</li>
				</ul>
				<ul>
					<li class="viewTitle">단체 할인율</li>
					<li class="viewText">${vo.discount_rate}%</li>
				</ul>
				<ul>
					<li class="viewTitle">작성일</li>
					<li class="viewText">${fn:substring(vo.write_date,0,10)}</li>
				</ul>
				<ul class="viewbtnUl">
					<li>
						<a href="/web/admin/programTimeEdit?num=${vo.pd_num}">수정</a>
						<a href="javascript:cancelChk()">취소</a>
					</li>
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