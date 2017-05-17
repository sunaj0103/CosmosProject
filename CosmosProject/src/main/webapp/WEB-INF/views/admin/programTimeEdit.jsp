<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
$(function(){
	var regDate = /^[0-9]{8}$/; // 일자 유효성 검사
	var regTime = /^([0-9]{2}):([0-9]{2})$/; // 시간 유효성 검사
	
    $("#programTimeEditBtn").click(function(){
		if($("#start_date").val() == ""){
			alert("프로그램 시행일을 입력해 주세요.");
			return false;
		}else{
			if(!regDate.test($("#start_date").val())) {
	    		alert("시행일은 숫자만 사용 가능합니다.\n 예)20170501");
	    		return false;
	    	}
		}
		
		if($("#start_time").val() == ""){
			alert("시작 시간을 입력해 주세요.");
			return false;
		}else{
			if(!regTime.test($("#start_time").val())) {
	    		alert("시간은 숫자와 :만 사용 가능합니다.\n 예)18:00");
	    		return false;
	    	}
		}
		
		if($("#end_time").val() == ""){
			alert("종료 시간을 입력해 주세요.");
			return false;
		}else{
			if(!regTime.test($("#end_time").val())) {
				alert("시간은 숫자와 :만 사용 가능합니다.\n 예)18:00");
	    		return false;
	    	}
		}
		
		$("#programTimeEditFrm").submit();
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

	<div class="contentAdmin" style="height: 900px;">
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
			<h2 class="formTitle">프로그램 시간 정보 수정</h2>
			<p class="formDesc">프로그램 시간 정보를 수정하세요.</p>
			<div class="adminInput">
				<form id="programTimeEditFrm" name="programTimeEditFrm" method="post" action="/web/admin/programTimeEditOk">
					<input type="hidden" name="pd_num" value="${vo.pd_num}"/>
					<input type="hidden" name="p_num" value="${vo.p_num}"/>
					<ul class="inputUl ulSize">
						<li>
							<label for="title">프로그램명</label>
						</li>
						<li>
							<input type="text" name="title" class="nInput" value="${vo.title}" readonly/><br/>
						</li>
					</ul>
					<ul class="inputUl ulSize">
						<li>
							<label for="start_date">프로그램 시행일</label>
						</li>
						<li>
							<input type="text" id="start_date" name="start_date" class="nInput" value="${vo.start_date}"/><br/>
						</li>
					</ul>
					<ul class="inputUl ulSize">
						<li>
							<label for="start_time">시작 시간</label>
						</li>
						<li>
							<input type="text" id="start_time" name="start_time" class="nInput" value="${vo.start_time}"/><br/>
						</li>
					</ul>
					<ul class="inputUl ulSize">
						<li>
							<label for="end_time">종료 시간</label>
						</li>
						<li>
							<input type="text" id="end_time" name="end_time" class="nInput" value="${vo.end_time}"/><br/>
						</li>
					</ul>
					<ul class="inputUl ulSize">
						<li>
							<label for="status">상태</label>
						</li>
						<li class="genderRadio">
							<input type="radio" id="statY" class="radio-custom" name="status" value="Y"
								<c:if test="${vo.status=='Y'}">checked="checked"</c:if>/>
							<span>예약 진행</span>
	          				<input type="radio" id="statN" class="radio-custom" name="status" value="N"
								<c:if test="${vo.status=='N'}">checked="checked"</c:if>/>
	          				<span>마감</span>
						</li>
					</ul>
					<ul class="inputUl ulSize">
						<li>
							<label for="canceled">취소</label>
						</li>
						<li class="genderRadio">
							<input type="radio" id="canceledY" class="radio-custom" name="canceled" value="Y"
								<c:if test="${vo.canceled=='Y'}">checked="checked"</c:if>/>
							<span>취소</span>
	          				<input type="radio" id="canceledN" class="radio-custom" name="canceled" value="N"
								<c:if test="${vo.canceled=='N'}">checked="checked"</c:if>/>
	          				<span>취소 아님</span>
						</li>
					</ul>
					<input type="button" id="programTimeEditBtn" class="adminInputBtn" value="수정 완료"/>
				</form>
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