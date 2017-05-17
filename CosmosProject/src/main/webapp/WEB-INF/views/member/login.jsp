<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
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

</script>
<script>
function setCookie(cookieName, value, exdays){
	var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
 
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1); //어제날짜를 쿠키 소멸날짜로 설정
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
 
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}

$(function(){
    //id 쿠키 저장
    var userInputId = getCookie("userInputId");
    $("input[name='id']").val(userInputId); 
     
    if($("input[name='id']").val() != ""){ 
        $("#idSaveCheck").attr("checked", true); 
        $("#pwdSaveCheck").removeAttr("disabled");
    }
     
    $("#idSaveChk").change(function(){ 
        if($("#idSaveChk").is(":checked")){                     
            var userInputId = $("input[name='id']").val();
            //setCookie("userInputId", userInputId, 365);
            setCookie("userInputId", userInputId, 1);
        }else{ 
            deleteCookie("userInputId");
        }
    });
  
    $("input[name='id']").keyup(function(){ 
        if($("#idSaveChk").is(":checked")){ 
            var userInputId = $("input[name='id']").val();
            //setCookie("userInputId", userInputId, 365);
            setCookie("userInputId", userInputId, 365);
        }
    });
    
    $("#loginBtn").click(function(){
		if($("#id").val() == ""){
			alert("아이디를 입력해 주세요.");
			return false;
		}
		
		if($("#password").val() == ""){
			alert("비밀번호를 입력해 주세요.");
			return false;
		}
		
		//var uid = $("#id").val();
		var pwd = $("#password").val();
	 
		//RSA 암호화 생성
		var rsa = new RSAKey();
		rsa.setPublic($("#RSAModulus").val(), $("#RSAExponent").val());
		//alert($("#RSAModulus").val()+", "+ $("#RSAExponent").val());
		
		//사용자 계정정보를 암호화 처리
		//uid = rsa.encrypt(uid);
		pwd = rsa.encrypt(pwd); 
		
		//$("#id").val(uid);
		$("#password").val(pwd);		
		$("#loginFrm").submit();
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
	
	<c:if test="${loginErr eq 'Y'}">
		<script>
			alert("아이디와 패스워드를 다시 한번 확인해 주세요.");
		</script>
	</c:if>

	<div class="contentLogin">
		<div class="LoginForm">
			<form id="loginFrm" name="loginFrm" method="post" action="/web/member/loginOk">
				<input type="hidden" id="RSAModulus" value="${RSAModulus}"/><!-- 서버에서 전달한 값을 세팅 -->
				<input type="hidden" id="RSAExponent" value="${RSAExponent}"/>
				<input type="text" id="id" name="id" class="loginInput" placeholder="아이디"/><br/>
				<input type="password" id="password" name="password" class="loginInput" placeholder="패스워드"/>
				<input type="button" id="loginBtn" class="loginBtn" value="로그인"/>	
				<input type="checkbox" id="idSaveChk"<c:if test="${cookie.containsKey('userInputId')}">checked="checked"</c:if>/> 아이디 저장
				<p class="frmMsg">
					아직 회원이 아니시라면 <a href="/web/signUp">회원가입</a><br/><br/>
					<a href="/web/member/idSearch">아이디 찾기</a> | <a href="/web/member/pwSearch">비밀번호 찾기</a>
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