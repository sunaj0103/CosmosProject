<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/web/js_css/jquery-3.1.1.min.js"></script>
<link href="/web/js_css/subStyle.css" rel="stylesheet" type="text/css"/>
<title>가산스타천문대</title>
<script>
var regId = /^[a-z0-9]{3,10}$/;	// 아이디 유효성 검사식
var regNm = /^[가-힣]{2,15}|[a-zA-Z]{2,15}\s[a-zA-Z]{2,15}$/; // 이름 유효성 검사식
var regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i; // 이메일 유효성 검사식

$(function(){
	$("#pwSearchBtn").click(function(){
		if($("#id").val() == ""){
			alert("아이디를 입력해 주세요.");
			return false;
		}else{
        	if(!regId.test($("#id").val())) {
        		alert("3~10자의 영문 소문자, 숫자만 사용 가능합니다.");
        		return false;
        	}
        }
		
		if($("#name").val() == ""){
			alert("이름을 입력해 주세요.");
			return false;
		}else{
        	if(!regNm.test($("#name").val())) {
        		alert("한글, 영문 대소문자만 사용 가능합니다.");
        		return false;
        	}
        }
				
		if($("#email").val() == ""){
			alert("이메일을 입력해주세요.");
			return false;
		}else{
			if(!regEmail.test($("#email").val())) {
        		alert("이메일 형식에 맞게 입력해 주세요.");
        		return false;
        	}
        }
		
		$("#pwSearchFrm").submit();
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
	
	<c:if test="${pwSearchErr eq 'Y'}">
		<script>
			alert("일치하는 정보가 없습니다.\n다시 한번 확인해 주세요.");
		</script>
	</c:if>

	<div class="contentLogin">
		<div class="LoginForm">
			<form id="pwSearchFrm" name="pwSearchFrm" method="post" action="/web/member/pwSearchOk">
				<input type="text" id="id" name="id" class="loginInput" placeholder="아이디"/><br/>
				<input type="text" id="name" name="name" class="loginInput" placeholder="이름"/><br/>
				<input type="text" id="email" name="email" class="loginInput" placeholder="이메일"/>
				<input type="submit" id="pwSearchBtn" class="loginBtn" value="비밀번호 찾기"/>	
				<p class="frmMsg">
					아직 회원이 아니시라면 <a href="/web/signUp">회원가입</a><br/><br/>
					<a href="/web/login">로그인</a> | <a href="/web/member/idSearch">아이디 찾기</a>
				</p>
			</form>
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