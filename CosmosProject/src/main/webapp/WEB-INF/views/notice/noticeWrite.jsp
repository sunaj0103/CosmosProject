<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page errorPage="isErrorPage.jsp" buffer="1kb" autoFlush="true"%>
<%@ page session="true" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/web/js_css/jquery-3.1.1.min.js"></script>
<script src="/web/resources/ckeditor.js"></script>
<script src="/web/js_css/bootstrap.min.js"></script>
<link href="/web/js_css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="/web/resources/samples/css/samples.css" rel="stylesheet"/>
<link href="/web/js_css/subStyle.css" rel="stylesheet" type="text/css"/>
<title>가산스타천문대</title>
<script>
$(function(){
	$("#noticeBoardBtn").click(function(){
		if($("#subject").val() == ""){
			alert("제목을 입력해 주세요.");
			return false;
		}
		
		var content = CKEDITOR.instances['content'].getData();
		
		if(content == ""){
			alert("내용을 입력해 주세요.");
			return false;
		}
				
		$("#noticeWriteFrm").submit();
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
	
	<div class="contentBoard">
		<div class="boardDiv">
			<h2 class="formTitle">공지사항 / 뉴스</h2>
			<div class="boardInput">
				<form class="form-horizontal" id="noticeWriteFrm" name="noticeWriteFrm" method="post" action="/web/notice/noticeWriteOk">
					<input type="hidden" name="m_num" value="${seNum}"/>
					<div class="form-group">
						<label for="name" class="control-label col-sm-2">작성자 </label>
						<div class="col-sm-10">
							<input type="text" class="form-control" name="name" id="name" value="${seName}" readonly/>
						</div>
					</div>
					<div class="form-group">
						<label for="subject" class="control-label col-sm-2">제목 </label>
						<div class="col-sm-10">
							<input type="text" class="form-control" name="subject" id="subject"/>
						</div>
					</div>
					<div class="form-group">
						<label for="content" class="control-label col-sm-2">내용 </label>
						<div class="col-sm-10">
							<textarea class="ckeditor" cols="1" name="content" id="content" rows="15"></textarea>
						</div>
					</div>
					<div class="form-group">
						<label for="notice" class="control-label col-sm-2">중요 공지 </label> 
						<div class="col-sm-10">
							<label class="radio-inline"><input type="radio"	name="notice" value="Y">중요</label>
							<label class="radio-inline"><input type="radio" name="notice" value="N" checked>일반</label>
						</div>
					</div>
					<div class="form-group"></div>
					<div class="form-group"> 
			    		<div class="col-sm-offset-2 col-sm-10">
							<input type="button" id="noticeBoardBtn" value="등록" class="btn btn-success btn-md"/>
							<input type="reset" value="다시쓰기" class="btn btn-warning btn-md"/>
						</div>
					</div>
					<div class="form-group"> 
						<div class="col-sm-offset-10 col-sm-1">
			    			<a href="/web/notice" class="btn btn-success btn-md">목록</a>
			    		</div>
					</div>
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