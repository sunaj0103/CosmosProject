<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/web/js_css/jquery-3.1.1.min.js"></script>
<script src="/web/js_css/bootstrap.min.js"></script>
<script type="text/javascript" src="/web/js_css/RSA/jsbn.js"></script>
<script type="text/javascript" src="/web/js_css/RSA/rsa.js"></script>
<script type="text/javascript" src="/web/js_css/RSA/prng4.js"></script>
<script type="text/javascript" src="/web/js_css/RSA/rng.js"></script>
<link href="/web/js_css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="/web/js_css/subStyle.css" rel="stylesheet" type="text/css"/>
<title>가산스타천문대</title>
<style>
.viewTitle {
	color: #004ea2;
}
</style>
<script>
var regPw = /^[a-z0-9]{4,10}$/;	// 비밀번호 유효성 검사식
var regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i; // 이메일 유효성 검사식
var regPhone = /^\d{3}-\d{3,4}-\d{4}$/; // 핸드폰번호 유효성 검사
$(function(){
	$("#myPageInfoEdit").click(function(){
		if($("#password").val() == ""){
			alert("패스워드를 입력해 주세요.");
			return false;
		}else{
        	if(!regPw.test($("#password").val())) {
        		alert("패스워드는 4~10자의 영문 소문자, 숫자만 사용 가능합니다.");
        		return false;
        	}
        }
		
		if($("#password2").val() == ""){
			alert("패스워드 확인을 입력해 주세요.");
			return false;
		}else{
			if($("#password2").val() != $("#password").val()) {
        		alert("비밀번호와 일치하지 않습니다.");
        		return false;
        	}
        }
		
		if($("#phone").val() == ""){
			alert("연락처를 입력해 주세요.");
			return false;
		}else{
			if(!regPhone.test($("#phone").val())) {
        		alert("정확한 연락처를 입력해 주세요.");
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
		
		var pwd = $("#password").val();
	 
		var rsa = new RSAKey();
		rsa.setPublic($("#RSAModulus").val(), $("#RSAExponent").val());
		
		//사용자 계정정보를 암호화 처리
		pwd = rsa.encrypt(pwd); 
		
		$("#password").val(pwd);
		$("#password2").val(pwd);
		$("#myPageInfoEditFrm").submit();
    });
	
	$("#withdrawBtn").click(function(){
		if(confirm("정말로 탈퇴 하시겠습니까?")){
			location.href="/web/member/myPageInfoWithdrawal?num=${vo.m_num}";
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
	
	<div class="contentMyPage">
		<div class="myPageTop">
			<h1>마이페이지</h1>
		</div>	
		
		<ul class="nav nav-pills nav-justified">
			<li><a href="/web/member/myPage">예약 내역 확인</a></li>
		    <li class="active"><a href="/web/member/myPageInfo">개인 정보 확인/수정</a></li>
		</ul>
			
		<div class="myPageInfo">
			<form id="myPageInfoEditFrm" name="myPageInfoEditFrm" method="post" action="/web/member/myPageInfoEdit">
				<input type="hidden" id="RSAModulus" value="${RSAModulus}"/>
				<input type="hidden" id="RSAExponent" value="${RSAExponent}"/>
				<div id="myPageInfoDiv">
					<ul class="myPageInfoUl">
						<li>
							<span class="chkTitle">이름</span>
							<span class="chkAns">
								<input type="text" id="name" name="name" class="lInput" value="${vo.name}" readonly/>
							</span>
						</li>
						<li>
							<span class="chkTitle">아이디</span>
							<span class="chkAns">
								<input type="text" id="id" name="id" class="lInput" value="${vo.id}" readonly/>
							</span>
						</li>
						<li>
							<span class="chkTitle">새 비밀번호</span>
							<span class="chkAns">
								<input type="password" id="password" name="password" class="lInput"/>
							</span>
						</li>
						<li>
							<span class="chkTitle">새 비밀번호 확인</span>
							<span class="chkAns">
								<input type="password" id="password2" name="password2" class="lInput"/>
							</span>
						</li>
						<li>
							<span class="chkTitle">연락처</span> 
							<span class="chkAns">
								<input type="text" id="phone" name="phone" class="lInput" value="${vo.phone}"/>
							</span>
						</li>
						<li>
							<span class="chkTitle">생년월일</span> 
							<span class="chkAns">
								<input type="text" id="birth" name="birth" class="lInput" value="${vo.birth}" readonly/>
							</span>
						</li>
						<li>
							<span class="chkTitle">본인확인용 이메일</span> 
							<span class="chkAns">
								<input type="text" id="email" name="email" class="lInput" value="${vo.email}"/>
							</span>
						</li>
						<li>
							<span class="chkTitle">SMS 수신 확인</span> 
							<span class="chkAns genderRadio">
								<input type="radio" id="smsY" class="radio-custom" name="sms_reception" value="Y" <c:if test="${vo.sms_reception=='Y'}">checked</c:if>>
								<span>수신</span>
		          				<input type="radio" id="smsN" class="radio-custom" name="sms_reception" value="N" <c:if test="${vo.sms_reception=='N'}">checked</c:if>>
		          				<span>거부</span>
							</span>
						</li>
					</ul>
					<input type="hidden" name="m_num" value="${vo.m_num}">
					<div id="userEditBtnDiv">
						<input type="button" id="myPageInfoEdit" class="rpBtn" value="개인정보수정"/>
					</div>
				</div>
			</form>
		</div>
		
		<div class="myPageWithdraw">
			<input type="button" id="withdrawBtn" class="rpBtn" value="회원탈퇴"/>
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