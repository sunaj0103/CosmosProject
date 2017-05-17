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
			<div class="boardInput">
				<ul id="noticeBoardList">
					<li class="noticeList1 boardTitle">NO</li>
					<li class="noticeList2 boardTitle">제목</li>
					<li class="noticeList1 boardTitle">글쓴이</li>
					<li class="noticeList1 boardTitle">작성일</li>
					<li class="noticeList1 boardTitle">조회수</li>
						
					<c:forEach var="vo" items="${n_list}">
						<li class="noticeList1 noticeTop">공지</li>
						<li class="noticeList2"><a href="/web/notice/noticeListView?num=${vo.n_num}">${vo.subject}</a></li>
						<li class="noticeList1">${vo.name}</li>
						<li class="noticeList1">${fn:substring(vo.write_date,0,10)}</li>
						<li class="noticeList1">${vo.hit}</li>
					</c:forEach>
					
					<c:forEach var="vo" items="${list}">
						<li class="noticeList1">${vo.n_num}</li>
						<li class="noticeList2"><a href="/web/notice/noticeListView?num=${vo.n_num}">${vo.subject}</a></li>
						<li class="noticeList1">${vo.name}</li>
						<li class="noticeList1">${fn:substring(vo.write_date,0,10)}</li>
						<li class="noticeList1">${vo.hit}</li>
					</c:forEach>					
				</ul>
				<div id="page">
					<ul class="pagination">
						<c:if test="${pageVo.currentPage>1}">
							<li><a href="/web/notice?currentPage=${pageVo.currentPage-1}">&#60;</a></li>
						</c:if>
						<c:forEach var="p" begin="${pageVo.startPageNum }" end="${pageVo.startPageNum+pageVo.onePageCount-1}">
							<c:if test="${p<=pageVo.totalPageCount}">
								<c:if test="${pageVo.currentPage==p }">
									<li class="active"><a href="/web/notice?currentPage=${p}">${p}</a></li>
							    </c:if>
							    <c:if test="${pageVo.currentPage!=p }">
									<li><a href="/web/notice?currentPage=${p}">${p}</a></li>
							    </c:if>
						    </c:if>
						</c:forEach>
						<c:if test="${pageVo.currentPage!=pageVo.totalPageCount}">
							<li><a href="/web/notice?currentPage=${pageVo.currentPage+1}">&#62;</a></li>
						</c:if>
					</ul>
				</div>
				<div class="form-group"> 
					<div class="col-sm-offset-11 col-sm-1">
						<c:if test="${seM=='M'}">
							<a href="/web/notice/noticeWrite" class="btn btn-success btn-md">글쓰기</a>
						</c:if>
			    	</div>
				</div>
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