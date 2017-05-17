<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/web/js_css/jquery-3.1.1.min.js"></script>
<link href="/web/js_css/subStyle.css" rel="stylesheet" type="text/css"/>
<link href='/web/js_css/simplelightbox.min.css' rel='stylesheet' type='text/css'>
<script src="/web/js_css/simple-lightbox.js" type="text/javascript"></script>
<title>가산스타천문대</title>
<style>
#contentGallery {
	width: 1000px;
	margin: 80px auto;
}

.container {
	max-width: 1000px;
	width: 100%;
	padding-right: 15px;
	padding-left: 15px;
	margin-right: auto;
	margin-left: auto;
}

.clear {
	clear: both;
	float: none;
	width: 100%;
}

.container .gallery a img {
	float: left;
	width: 20%;
	height: auto;
	border: 2px solid #fff;
	-webkit-transition: -webkit-transform .15s ease;
	-moz-transition: -moz-transform .15s ease;
	-o-transition: -o-transform .15s ease;
	-ms-transition: -ms-transform .15s ease;
	transition: transform .15s ease;
	position: relative;
}

.container .gallery a:hover img {
	-webkit-transform: scale(1.05);
	-moz-transform: scale(1.05);
	-o-transform: scale(1.05);
	-ms-transform: scale(1.05);
	transform: scale(1.05);
	z-index: 5;
}

.container .gallery a.big img {
	width: 40%;
}

.imageRef {
	color: #222;
	font-size: 13px;
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
</style>
<script>
$(function(){
	var $gallery = $('.gallery a').simpleLightbox();
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

	<div id="contentGallery">
		<div class="container">
		<div class="gallery">
			<c:forEach var="vo" items="${list}">
				<a href="${pageContext.request.contextPath}/gallery/${vo.file_name}"><img src="${pageContext.request.contextPath}/gallery/${vo.file_name}"/></a>
			</c:forEach>
			<div class="clear"></div>
		</div>
		<br><br>
		<c:if test="${seM=='M'}">
			<a class="galleryBtn" href="/web/gallery/galleryUpload">이미지 올리기</a>
			<a class="galleryBtn" href="/web/gallery/galleryDel">이미지 삭제</a>
		</c:if>
		<br><br>
		<p class="imageRef">이미지 출처: http://www.spacetelescope.org</p>
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