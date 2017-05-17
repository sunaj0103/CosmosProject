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
	function delChk(r_num){
		if(confirm("정말로 취소처리 하시겠습니까?")){
			location.href="/web/admin/reservListCancel?num="+r_num;
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
	    	<li><a href="/web/admin/memberList">회원 정보 확인/탈퇴</a></li>
	    	<li class="active"><a href="/web/admin/reservList">예약 정보 확인/취소</a></li>
	    	<li><a href="/web/admin/statistics">예약 통계</a></li>
	  	</ul> 	
	 		
		<div class="admin">
			<h2 class="formTitle">예약 정보</h2>
			<ul class="reservList">
				<c:forEach var="vo" items="${list}">
					<li class="reservList2" style="border-top: 2px solid #2d6a9f">아이디: ${vo.id}</li>
					<li class="reservList2" style="border-top: 2px solid #2d6a9f">이름: ${vo.name}</li>
					<li class="reservList3" style="border-top: 2px solid #2d6a9f">연락처: ${vo.contact_person}, ${vo.tel}</li>
					<li class="reservList3" style="border-top: 2px solid #2d6a9f">프로그램: ${vo.title}</li>
					
					<li class="reservList4">
						예약일시: <fmt:parseDate value="${vo.start_date}" var="start_date" pattern="yyyymmdd" scope="page"/>	
								<fmt:formatDate value="${start_date}" pattern="yyyy-mm-dd"/>
				 				${vo.start_time}~${vo.end_time}
				 	</li>
					<li class="reservList3">인원: 총 ${vo.child_tot+vo.teenager_tot+vo.adult_tot}명 
						(
						<c:if test="${vo.child_tot!=0}">
						 어린이: ${vo.child_tot}명, 
						</c:if>
						<c:if test="${vo.teenager_tot!=0}">
						 청소년: ${vo.teenager_tot}명, 
						</c:if>
						<c:if test="${vo.adult_tot!=0}">
						 성인: ${vo.adult_tot}명
						</c:if>
						)
					</li>
					<li class="reservList3">취소여부: ${vo.canceled}</li>
					
					<li class="reservList2">
						결제금액: <fmt:formatNumber value="${vo.final_payment}" pattern="#,###"/>원
					</li>
					<li class="reservList2">결제방법: 
						<c:if test="${vo.payment=='C'}">신용카드</c:if>
						<c:if test="${vo.payment=='D'}">무통장입금</c:if>
					</li>
					<li class="reservList6">환불계좌: 
						<c:if test="${vo.account_holder eq null}">
							&nbsp; &nbsp; &nbsp; &nbsp;-&nbsp; &nbsp; &nbsp; &nbsp;
						</c:if>
						<c:if test="${!empty vo.account_holder}">
							입금주: ${vo.account_holder},
							은행명: ${vo.bank_name},
							계좌번호: ${vo.account_number}
						</c:if>
					</li>
					
					<li class="reservList8" style="border-bottom: 2px solid #2d6a9f;">
						<c:if test="${vo.canceled=='N'}">
							이 예약을 <a href="javascript:delChk(${vo.r_num})">취소</a>합니다.
						</c:if>
						<c:if test="${vo.canceled=='Y'}">
							취소된 예약입니다.
						</c:if>
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