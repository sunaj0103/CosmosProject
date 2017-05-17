<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/web/js_css/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="/web/js_css/RSA/jsbn.js"></script>
<script type="text/javascript" src="/web/js_css/RSA/rsa.js"></script>
<script type="text/javascript" src="/web/js_css/RSA/prng4.js"></script>
<script type="text/javascript" src="/web/js_css/RSA/rng.js"></script>
<link href="/web/js_css/subStyle.css" rel="stylesheet" type="text/css"/>
<title>가산스타천문대</title>
<script>
var regId = /^[a-z0-9]{3,10}$/;	// 아이디 유효성 검사식
var regPw = /^[a-z0-9]{4,10}$/;	// 비밀번호 유효성 검사식
var regNm = /^[가-힣]{2,15}|[a-zA-Z]{2,15}\s[a-zA-Z]{2,15}$/; // 이름 유효성 검사식
var regEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i; // 이메일 유효성 검사식
var birth = /^[0-9]{4}$/; // 연도 유효성 검사
var regPhone = /^[0-9]{3,4}$/; // 핸드폰번호 유효성 검사
var regPhone2 = /^[0-9]{4}$/; // 핸드폰번호 유효성 검사

$(function(){
	$("#id").focusout(function(){
		if($(this).val() == ""){
			$("#idErr").css("display","block");
			$("#idErr").css("color","#f00");
			$("#idErr").html("아이디를 입력해 주세요.");
        }else{
        	if(!regId.test($(this).val())) {
        		$("#idErr").css("display","block");
    			$("#idErr").css("color","#f00");
        		$("#idErr").html("3~10자의 영문 소문자, 숫자만 사용 가능합니다.");
        	}else{
        		var id = $(this).val();
    			$.ajax({
    				type : "POST",
    				url : "/web/member/idCheck",
    				data : "id="+id,
    				success : function(chk) {
    					if(chk == "ok"){
    						$("#idErr").css("display","block");
    						$("#idErr").css("color","#009933");
    						$("#idErr").html("사용 가능한 아이디입니다.");
    					}else{
    						$("#idErr").css("display","block");
    						$("#idErr").css("color","#f00");
    						$("#idErr").html("이미 사용중인 아이디입니다.");
    					}
    				},error:function(){
    					$("#idErr").css("display","block");
    					$("#idErr").css("color","#f00");
    					$("#idErr").html("다시 입력해 주세요.");
    				}
    			});
        	}
    	}
	}).keypress(function(){
		$("#idErr").css("display","none");
	});
	
	$("#password").focusout(function(){
		if($(this).val() == ""){
			$("#passwordErr").css("display","block");
			$("#passwordErr").html("비밀번호를 입력해 주세요.");
        }else{
        	if(!regPw.test($(this).val())) {
        		$("#passwordErr").css("display","block");
        		$("#passwordErr").html("4~10자의 영문 소문자, 숫자만 사용 가능합니다.");
        	}
        }
	}).keypress(function(){
		$("#passwordErr").css("display","none");
	});
	
	$("#password2").focusout(function(){
		if($(this).val() == ""){
			$("#password2Err").css("display","block");
			$("#password2Err").html("비밀번호 확인을 입력해 주세요.");
        }else{
        	if($(this).val() != $("#password").val()) {
        		$("#password2Err").css("display","block");
        		$("#password2Err").html("비밀번호와 일치하지 않습니다.");
        	}
        }
	}).keypress(function(){
		$("#password2Err").css("display","none");
	});
	
	$("#name").focusout(function(){
		if($(this).val() == ""){
			$("#nameErr").css("display","block");
			$("#nameErr").html("이름을 입력해 주세요.");
        }else{
        	if(!regNm.test($(this).val())) {
        		$("#nameErr").css("display","block");
        		$("#nameErr").html("한글, 영문 대소문자만 사용 가능합니다.");
        	}
        }
	}).keypress(function(){
		$("#nameErr").css("display","none");
	});
	
	$("#year").focusout(function(){
		if($(this).val() == ""){
			$("#birthErr").css("display","block");
			$("#birthErr").html("연도를 입력해 주세요.");
        }else{
        	if(!birth.test($(this).val()) || $(this).val() < 1900 || $(this).val() > 2017) {
        		$("#birthErr").css("display","block");
        		$("#birthErr").html("정확한 연도를 입력해 주세요.");
        	}
        }
	}).keypress(function(){
		$("#birthErr").css("display","none");
	});
	
	$("#tel1").focusout(function(){
		if($(this).val() == ""){
			$("#phoneErr").css("display","block");
			$("#phoneErr").html("번호를 입력해 주세요.");
	    }else{
        	if(!regPhone.test($(this).val())) {
        		$("#phoneErr").css("display","block");
        		$("#phoneErr").html("정확한 번호를 입력해 주세요.");
        	}
        }
	}).keypress(function(){
		$("#phoneErr").css("display","none");
	});
	
	$("#tel2").focusout(function(){
		if($(this).val() == ""){
			$("#phoneErr").css("display","block");
			$("#phoneErr").html("번호를 입력해 주세요.");
	    }else{
        	if(!regPhone.test($(this).val())) {
        		$("#phoneErr").css("display","block");
        		$("#phoneErr").html("정확한 번호를 입력해 주세요.");
        	}
        }
	}).keypress(function(){
		$("#phoneErr").css("display","none");
	});
	
	$("#tel3").focusout(function(){
		if($(this).val() == ""){
			$("#phoneErr").css("display","block");
			$("#phoneErr").html("번호를 입력해 주세요.");
	    }else{
        	if(!regPhone2.test($(this).val())) {
        		$("#phoneErr").css("display","block");
        		$("#phoneErr").html("정확한 번호를 입력해 주세요.");
        	}
        }
	}).keypress(function(){
		$("#phoneErr").css("display","none");
	});
	
	$("#email").focusout(function(){
		if($(this).val() == ""){
			$("#emailErr").css("display","block");
			$("#emailErr").html("이메일을 입력해주세요.");
	    }else{
        	if(!regEmail.test($(this).val())) {
        		$("#emailErr").css("display","block");
        		$("#emailErr").html("이메일 형식에 맞게 입력해 주세요.");
        	}
        }
	}).keypress(function(){
		$("#emailErr").css("display","none");
	});
	
	$("#signUpBtn").click(function(){
		if($("#id").val() == ""){
			$("#idErr").css("display","block");
			$("#idErr").css("color","#f00");
			$("#idErr").html("아이디를 입력해 주세요.");
			$("#id").focus();
			return false;
		}else{
			if(!regId.test($("#id").val())) {
				$("#idErr").css("display","block");
				$("#idErr").css("color","#f00");
	    		$("#idErr").html("3~10자의 영문 소문자, 숫자만 사용 가능합니다.");
	    		$("#id").focus();
	    		return false;
	    	}
		}
		
		if($("#password").val() == ""){
			$("#passwordErr").css("display","block");
			$("#passwordErr").html("비밀번호를 입력해 주세요.");
            $("#password").focus();
			return false;
		}else{
        	if(!regPw.test($("#password").val())) {
        		$("#passwordErr").css("display","block");
        		$("#passwordErr").html("4~10자의 영문 소문자, 숫자만 사용 가능합니다.");
        		$("#password").focus();
        		return false;
        	}
        }
		
		if($("#password2").val() == ""){
			$("#password2Err").css("display","block");
			$("#password2Err").html("비밀번호 확인을 입력해 주세요.");
            $("#password2").focus();
			return false;
		}else{
        	if($("#password2").val() != $("#password").val()) {
        		$("#password2Err").css("display","block");
        		$("#password2Err").html("비밀번호와 일치하지 않습니다.");
        		$("#password2").focus();
        		return false;
        	}
        }
		
		if($("#name").val() == ""){
            $("#nameErr").css("display","block");
			$("#nameErr").html("이름을 입력해 주세요.");
            $("#name").focus();
			return false;
		}else{
        	if(!regNm.test($("#name").val())) {
        		$("#nameErr").css("display","block");
        		$("#nameErr").html("한글, 영문 대소문자만 사용 가능합니다.");
        		$("#name").focus();
        		return false;
        	}
        }
		
		if($("#year").val() == ""){
			$("#birthErr").css("display","block");
			$("#birthErr").html("연도를 입력해 주세요.");
			$("#year").focus();
			return false;
		}else{
        	if(!birth.test($("#year").val()) || $("#year").val() < 1900 || $("#year").val() > 2017) {
        		$("#birthErr").css("display","block");
        		$("#birthErr").html("정확한 연도를 입력해 주세요.");
        		$("#year").focus();
        		return false;
        	}
        }
		
		if($("#tel1").val() == ""){
			$("#phoneErr").css("display","block");
			$("#phoneErr").html("번호를 입력해 주세요.");
			$("#tel1").focus();
			return false;
		}else{
        	if(!regPhone.test($("#tel1").val())) {
        		$("#phoneErr").css("display","block");
        		$("#phoneErr").html("정확한 번호를 입력해 주세요.");
        		$("#tel1").focus();
        		return false;
        	}
        }
		
		if($("#tel2").val() == ""){
			$("#phoneErr").css("display","block");
			$("#phoneErr").html("번호를 입력해 주세요.");
			$("#tel2").focus();
			return false;
		}else{
        	if(!regPhone.test($("#tel2").val())) {
        		$("#phoneErr").css("display","block");
        		$("#phoneErr").html("정확한 번호를 입력해 주세요.");
        		$("#tel2").focus();
        		return false;
        	}
        }
		
		if($("#tel3").val() == ""){
			$("#phoneErr").css("display","block");
			$("#phoneErr").html("번호를 입력해 주세요.");
            $("#tel3").focus();
			return false;
		}else{
        	if(!regPhone2.test($("#tel3").val())) {
        		$("#phoneErr").css("display","block");
        		$("#phoneErr").html("정확한 번호를 입력해 주세요.");
        		$("#tel3").focus();
        		return false;
        	}
        }
		
		if($("#email").val() == ""){
			$("#emailErr").css("display","block");
			$("#emailErr").html("이메일을 입력해주세요.");
            $("#email").focus();
			return false;
		}else{
        	if(!regEmail.test($("#email").val())) {
        		$("#emailErr").css("display","block");
        		$("#emailErr").html("이메일 형식에 맞게 입력해 주세요.");
        		$("#email").focus();
        		return false;
        	}
        }
		
		var pwd = $("#password").val();
	 
		//RSA 암호화 생성
		var rsa = new RSAKey();
		rsa.setPublic($("#RSAModulus").val(), $("#RSAExponent").val());
		//alert($("#RSAModulus").val()+", "+ $("#RSAExponent").val());
		
		//password를 암호화 처리
		pwd = rsa.encrypt(pwd); 
		
		$("#password").val(pwd);	
		$("#password2").val(pwd);
		$("#signUpFrm").submit();
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
	
	<div id="contentSignUp">
		<h2 class="formTitle">회원 정보 입력</h2>
		<p class="formDesc">로그인 정보 및 가입 정보를 입력하세요.</p>
		<div class="signUpForm">
			<form id="signUpFrm" name="signUpFrm" method="post" action="/web/member/signUp">
				<input type="hidden" id="RSAModulus" value="${RSAModulus}"/><!-- 서버에서 전달한 값을 세팅 -->
				<input type="hidden" id="RSAExponent" value="${RSAExponent}"/>
				<ul class="inputUl">
					<li>
						<label for="id">아이디</label>
					</li>
					<li>
						<input type="text" id="id" name="id" class="nInput" placeholder="아이디"/><br/>
						<div id="idErr" class="errDiv"></div>
					</li>	
				</ul>
				<ul class="inputUl">
					<li>
						<label for="password">비밀번호</label>
					</li>
					<li>
						<input type="password" id="password" name="password" class="nInput" placeholder="비밀번호 (4자 이상)"/><br/>
						<div id="passwordErr" class="errDiv"></div>
					</li>
				</ul>
				<ul class="inputUl">
					<li>
						<label for="password2">비밀번호 확인</label>
					</li>
					<li>
						<input type="password" id="password2" name="password2" class="nInput" placeholder="비밀번호 재확인"/><br/>
						<div id="password2Err" class="errDiv"></div>
					</li>
				</ul>
				<ul class="inputUl">
					<li>
						<label for="name">이름</label>
					</li>
					<li>
						<input type="text" id="name" name="name" class="nInput" placeholder="이름"/><br/>
						<div id="nameErr" class="errDiv"></div>
					</li>
				</ul>
				<ul class="inputUl">
					<li>
						<label for="year">생일</label>
					</li>
					<li>
						<input type="text" id="year" name="year" class="mInput" placeholder="연도(4자)"/>&nbsp;
						<select  id="month" name="month" class="sSelect">
							<optgroup label="월">
								<option value="01">1</option>
								<option value="02">2</option>
								<option value="03">3</option>
								<option value="04">4</option>
								<option value="05">5</option>
								<option value="06">6</option>
								<option value="07">7</option>
								<option value="08">8</option>
								<option value="09">9</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
							</optgroup>
						</select>&nbsp;&nbsp;
						<select id="day" name="day" class="sSelect">
							<optgroup label="일">
								<option value="01">1</option>
								<option value="02">2</option>
								<option value="03">3</option>
								<option value="04">4</option>
								<option value="05">5</option>
								<option value="06">6</option>
								<option value="07">7</option>
								<option value="08">8</option>
								<option value="09">9</option>
								<option value="10">10</option>
								<c:forEach var="i" begin="11" end="31">
									<option value="${i}">${i}</option>
								</c:forEach>
							</optgroup>
						</select>
						<div id="birthErr" class="errDiv"></div>
					</li>
				</ul>
				<ul class="inputUl">
					<li>
						<label for="gender">성별</label>
					</li>
					<li class="genderRadio">
						<input type="radio" id="genderM" class="radio-custom" name="gender" value="M" checked>
						<span>남자</span>
          				<input type="radio" id="genderF" class="radio-custom" name="gender" value="F">
          				<span>여자</span>
					</li>
				</ul>
				<ul class="inputUl">
					<li>
						<label for="tel1">휴대폰 전화</label>
					</li>
					<li>
						<input type="text" id="tel1" name="tel1" class="sInput"/>-
						<input type="text" id="tel2" name="tel2" class="sInput"/>-
						<input type="text" id="tel3" name="tel3" class="sInput"/>
						<div id="phoneErr" class="errDiv"></div>
					</li>
				</ul>
				<ul class="inputUl">
					<li>
						<label for="email">본인확인용 이메일</label>
					</li>
					<li>
						<input type="text" id="email" name="email" class="nInput" placeholder="본인확인용 이메일"/><br/>
						<div id="emailErr" class="errDiv"></div>
					</li>
				</ul>
				<ul class="inputUl">
					<li>
						<label for="sms_reception">SMS 수신 확인</label>
					</li>
					<li class="genderRadio">
						<input type="radio" id="smsY" class="radio-custom" name="sms_reception" value="Y" checked>
						<span>수신</span>
          				<input type="radio" id="smsN" class="radio-custom" name="sms_reception" value="N">
          				<span>거부</span>
					</li>
				</ul>
				
				<input type="button" id="signUpBtn" value="회원가입"/>
				<p class="frmMsg">
					로그인 페이지로 이동합니다. <a href="#">로그인</a>
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