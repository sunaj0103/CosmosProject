<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	$("#noticeEditBtn").click(function(){
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
				<form class="form-horizontal" name="noticeEditForm" method="post" action="/web/notice/noticeEditOk">
					<input type="hidden" name="n_num" value="${vo.n_num}"/>
					<div class="form-group">
						<label for="name" class="control-label col-sm-2">작성자 </label>
						<div class="col-sm-10">
							<input type="text" class="form-control" name="name" id="name" value="${vo.name}" readonly/>
						</div>
					</div>
					<div class="form-group">
						<label for="subject" class="control-label col-sm-2">제목 </label>
						<div class="col-sm-10">
							<input type="text" class="form-control" name="subject" id="subject" value="${vo.subject}"/>
						</div>
					</div>
					<div class="form-group">
						<label for="content" class="control-label col-sm-2">내용 </label>
						<div class="col-sm-10">
							<textarea class="ckeditor" cols="1" name="content" id="content" rows="15">${vo.content}</textarea>
						</div>
					</div>
					<div class="form-group">
						<label for="notice" class="control-label col-sm-2">중요 공지 </label> 
						<div class="col-sm-10">
							<label class="radio-inline"><input type="radio"	name="notice" value="Y" <c:if test="${vo.notice=='Y'}">checked="checked"</c:if>>중요</label>
							<label class="radio-inline"><input type="radio" name="notice" value="N" <c:if test="${vo.notice=='N'}">checked="checked"</c:if>>일반</label>
						</div>
					</div>
					<div class="form-group"></div>
					<div class="form-group"> 
			    		<div class="col-sm-offset-2 col-sm-10">
							<input type="button" id="noticeEditBtn" value="수정" class="btn btn-success btn-md"/>
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