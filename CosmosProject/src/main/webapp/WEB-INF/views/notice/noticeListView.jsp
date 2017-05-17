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
<script>	
function delChk(){
	var edit = ${seNum eq vo.m_num};
	
	if(edit){
		if(confirm("글을 삭제하시겠습니까?")){
			location.href="/web/notice/noticeDel?num=${vo.n_num}";
		}
	}else{
		alert("작성자만 글을 삭제할 수 있습니다.");
	}
}
	
function editChk(){
	var edit = ${seNum eq vo.m_num};
	
	if(edit){
		location.href="/web/notice/noticeEdit?num=${vo.n_num}";
	}else{
		alert("작성자만 글을 수정할 수 있습니다.");
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
	
	<div class=contentBoard>
		<div class="boardDiv">
			<h2 class="formTitle">공지사항 / 뉴스</h2>
			<div class="boardInput viewHeight">
				<div class="col-lg-12 viewborderTop">${vo.subject}</div>
				<div class="col-lg-4 viewborder">글쓴이: ${vo.name}</div>
				<div class="col-lg-4 viewborder">작성일: ${fn:substring(vo.write_date,0,10)}</div>
				<div class="col-lg-4 viewborder">조회수: ${vo.hit}</div>
				<div class="col-lg-12 viewborderEmpty"></div>
				<div class="col-lg-12 viewborderEmpty"></div>
				<div class="col-lg-12 viewborderContent">${vo.content}</div>
				<div class="col-lg-12 viewborderEmpty"></div>
				<div class="col-lg-12 viewborderEmpty"></div>
				<div class="col-lg-2">
					<a href="/web/notice" class="btn btn-success btn-md">목록</a>
				</div>
				<div class="col-lg-offset-7 col-lg-3">
					<c:if test="${seM=='M'}">
				    	<a href="javascript:editChk()" class="btn btn-success btn-md">수정</a>
				    	<a href="javascript:delChk()" class="btn btn-warning btn-md">삭제</a>
				    </c:if>
			    </div>
			</div>
		</div>
		<div class="clear"></div>
	</div>

	<div id="footer">
		<div id="footerTxt">
			주소: 서울 금천구 가산디지털2로 123 <br/>
			전화번호: 02-123-1234
		</div>
	</div>
</body>
</html>