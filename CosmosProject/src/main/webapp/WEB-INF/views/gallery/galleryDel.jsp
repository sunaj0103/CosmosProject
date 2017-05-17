<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="true" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/web/js_css/jquery-3.1.1.min.js"></script>
<script src="/web/js_css/bootstrap.min.js"></script>
<link href="/web/js_css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="/web/js_css/subStyle.css" rel="stylesheet" type="text/css"/>
<title>가산스타천문대</title>
<style>
.galleryListImg {
	height: 100px;
}

.galleryBtn {
	width: 100px;
	padding: 5px 10px;
	margin: 20px 10px;
	text-align: center;
	color: #fff;
	font-size: 15px;
	text-decoration: none;
	background-color: #007fff;
	border: 0 none;
	border-radius: 3px;
	-moz-border-radius: 3px;
	-webkit-border-radius: 3px;
	cursor: pointer;
	transition: all 60ms ease-in-out;
}

.galleryBtn:hover {
	text-decoration: none;
	transition: all 60ms ease;
	opacity: .85;
}

.galleryBtn:active {
	text-decoration: none;
	transition: all 60ms ease;
	opacity: .75;
}

.galleryBtn:focus {
	text-decoration: none;
	outline: 1px dotted #959595;
	outline-offset: -4px;
}

.galleryList li {
	float: left;
	height: 120px;
	line-height: 120px;
	border-top: 1px solid #ddd;
	border-bottom: 1px solid #ddd;
}

.galleryList1 {
	width: 15%;
}

.galleryList2 {
	width: 50%;
}

.clear {
	clear: both;
	float: none;
	width: 100%;
}
</style>
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
			<h2 class="formTitle">갤러리 업로드</h2>
			<div class="boardInput">
				<ul class="galleryList">
					<c:forEach var="vo" items="${list}">
						<li class="galleryList1">${vo.g_num}</li>
						<li class="galleryList2"><img class="galleryListImg" src="${pageContext.request.contextPath}/gallery/${vo.file_name}"/></li>
						<li class="galleryList1">${fn:substring(vo.write_date,0,10)}</li>
						<li class="galleryList1">
							<a class="galleryBtn" href="/web/gallery/galleryDelOk?num=${vo.g_num}">삭제</a>
						</li>
					</c:forEach>
				</ul>
				<div class="clear"></div>
				<br/><br/>
				<a class="galleryBtn" href="/web/gallery">갤러리</a>
				<br/><br/>
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