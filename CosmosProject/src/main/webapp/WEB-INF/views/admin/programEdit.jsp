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
	var regNum = /^[0-9]{1,3}$/; // 인원 유효성 검사
	var regFee = /^[0-9]{4,6}$/; // 요금 유효성 검사
	
    $("#programEditBtn").click(function(){
		if($("#title").val() == ""){
			alert("프로그램명을 입력해 주세요.");
			return false;
		}
		
		if($("#description").val() == ""){
			alert("프로그램 설명을 입력해 주세요.");
			return false;
		}
		
		if($("#recommend").val() == ""){
			alert("추천 대상을 입력해 주세요.");
			return false;
		}
		
		if($("#total_num_of_applicants").val() == ""){
			alert("신청 가능 총 인원을 입력해 주세요.");
			return false;
		}else{
			if(!regNum.test($("#total_num_of_applicants").val())) {
	    		alert("인원은 숫자만 사용 가능합니다.");
	    		return false;
	    	}
		}
		
		if($("#child").val() == ""){
			alert("어린이 요금을 입력해 주세요.");
			return false;
		}else{
			if(!regFee.test($("#child").val())) {
	    		alert("요금은 숫자만 사용 가능합니다.");
	    		return false;
	    	}
		}

		if($("#teenager").val() == ""){
			alert("청소년 요금을 입력해 주세요.");
			return false;
		}else{
			if(!regFee.test($("#teenager").val())) {
	    		alert("요금은 숫자만 사용 가능합니다.");
	    		return false;
	    	}
		}
		
		if($("#adult").val() == ""){
			alert("성인 요금을 입력해 주세요.");
			return false;
		}else{
			if(!regFee.test($("#adult").val())) {
	    		alert("요금은 숫자만 사용 가능합니다.");
	    		return false;
	    	}
		}
		
		if($("#discount_min").val() == ""){
			alert("단체 할인 최소 인원을 입력해 주세요.");
			return false;
		}else{
			if(!regNum.test($("#discount_min").val())) {
	    		alert("인원은 숫자만 사용 가능합니다.");
	    		return false;
	    	}
		}
		
		if($("#discount_rate").val() == ""){
			alert("단체 할인을 입력해 주세요.");
			return false;
		}else{
			if(!regNum.test($("#discount_rate").val())) {
	    		alert("단체 할인율은 숫자만 사용 가능합니다.");
	    		return false;
	    	}
		}
		
		$("#programEditFrm").submit();
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
	
	<div class="contentAdmin" style="height: 1200px;">
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
			<h2 class="formTitle">프로그램 정보 수정</h2>
			<p class="formDesc">프로그램 정보를 수정하세요.</p>
			<div class="adminInput">
				<form id="programEditFrm" name="programEditFrm" method="post" action="/web/admin/programEditOk">
					<input type="hidden" name="p_num" value="${vo.p_num}"/>
					<ul class="inputUl ulSize">
						<li>
							<label for="title">프로그램명</label>
						</li>
						<li>
							<input type="text" id="title" name="title" class="nInput" value="${vo.title}"/><br/>
					</ul>
					<ul class="inputUl ulSizeText">
						<li>
							<label for="description">프로그램 설명</label>
						</li>
						<li><textarea id="description" name="description" class="textInput" rows="8" cols="50">${vo.description}</textarea></li>
					</ul>
					<ul class="inputUl ulSize">
						<li>
							<label for="recommend">추천 대상</label>
						</li>
						<li>
							<input type="text" id="recommend" name="recommend" class="nInput" value="${vo.recommend}"/><br/>
						</li>
					</ul>
					<ul class="inputUl ulSize">
						<li>
							<label for="total_num_of_applicants">신청 가능 총 인원</label>
						</li>
						<li>
							<input type="text" id="total_num_of_applicants" name="total_num_of_applicants" class="mInput" value="${vo.total_num_of_applicants}"/>명<br/>
						</li>
					</ul>
					<ul class="inputUl ulSize">
						<li>
							<label for="child">어린이 요금</label>
						</li>
						<li>
							<input type="text" id="child" name="child" class="mInput" value="${vo.child}"/>원<br/>
						</li>
					</ul>
					<ul class="inputUl ulSize">
						<li>
							<label for="teenager">청소년 요금</label>
						</li>
						<li>
							<input type="text" id="teenager" name="teenager" class="mInput" value="${vo.teenager}"/>원<br/>
						</li>
					</ul>
					<ul class="inputUl ulSize">
						<li>
							<label for="adult">성인 요금</label>
						</li>
						<li>
							<input type="text" id="adult" name="adult" class="mInput" value="${vo.adult}"/>원<br/>
						</li>
					</ul>
					<ul class="inputUl ulSize">
						<li>
							<label for="discount_min">단체 할인</label>
						</li>
						<li>
							최소 인원: <input type="text" id="discount_min" name="discount_min" class="mInput" value="${vo.discount_min}"/>명, &nbsp;
							할인율: <input type="text" id="discount_rate" name="discount_rate" class="mInput" value="${vo.discount_rate}"/>%
						</li>
					</ul>
					<input type="button" id="programEditBtn" class="adminInputBtn" value="수정 완료"/>
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