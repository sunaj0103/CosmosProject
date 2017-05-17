<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/web/js_css/jquery-3.1.1.min.js"></script>
<script src="/web/js_css/bootstrap.min.js"></script>
<link href="/web/js_css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="/web/js_css/subStyle.css" rel="stylesheet" type="text/css"/>
<title>가산스타천문대</title>
<script>
var cancel = '${vo.canceled}';

function delChk(){
	if(cancel=='Y'){
		alert("취소된 예약입니다.");
	}else{
		if(confirm("정말로 예약을 취소하시겠습니까?")){
			location.href="/web/member/reservCancel?num=${vo.r_num}";
		}
	}
}

	function submitChk(){
		var regNm = /^[가-힣]{2,15}|[a-zA-Z]{2,15}\s[a-zA-Z]{2,15}$/; // 이름 유효성 검사식
		var regTel = /^\d{3}-\d{3,4}-\d{4}$/; //연락처 유효성 검사식
		
		if($("#contact_person").val() == ""){
			alert("연락받으실 분 성함을 입력해 주세요.");
			return false;
        }else{
        	if(!regNm.test($("#contact_person").val())) {
        		alert("한글, 영문 대소문자만 사용 가능합니다.");
        		return false;
        	}
        }
		
		if($("#tel").val() == ""){
			alert("연락처를 입력해 주세요.");
			return false;
        }else{
        	if(!regTel.test($("#tel").val())) {
        		alert("연락처는 숫자와 -만 사용 가능합니다.");
        		return false;
        	}
        }
				
		$("#reservEditFrm").submit();
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

	<div class="contentMyPage">
		<div class="myPageTop">
			<h1>마이페이지</h1>
		</div>	
		
		<ul class="nav nav-pills nav-justified">
			<li class="active"><a href="/web/member/myPage">예약 내역 확인</a></li>
		    <li><a href="/web/member/myPageInfo">개인 정보 확인/수정</a></li>
		</ul>
		<div class="admin">
			<div class="adminListView">
				<form id="reservEditFrm" name="reservEditFrm" method="post" action="/web/member/reservEditOk">
					<input type="hidden" name="r_num" value="${vo.r_num}"/>
					<ul>
						<li class="viewTitle">프로그램명</li>
						<li class="viewText">${vo.title}</li>
					</ul>
					<ul>
						<li class="viewTitle">예약 일시</li>
						<li class="viewText">${vo.start_date} ${vo.start_time}~${vo.end_time}</li>
					</ul>
					<ul>
						<li class="viewTitle">예약인원</li>
						<li class="viewText">
							총 ${vo.child_tot+vo.teenager_tot+vo.adult_tot}명(어린이: ${vo.child_tot}명, 청소년: ${vo.teenager_tot}명, 성인: ${vo.adult_tot}명)
						</li>
					</ul>
					<ul>
						<li class="viewTitle">단체할인</li>
						<li class="viewText">
							<c:if test="${vo.discount=='Y'}">단체할인 적용 (${vo.discount_rate}%)</c:if>
							<c:if test="${vo.discount=='N'}">-</c:if>
						</li>
					</ul>
					<ul>
						<li class="viewTitle">금액</li>
						<li class="viewText">${vo.final_payment}원</li>
					</ul>
					<ul>
						<li class="viewTitle">결제방법</li>
						<li class="viewText">
							<c:if test="${vo.payment=='C'}">신용카드</c:if>
							<c:if test="${vo.payment=='D'}">무통장입금</c:if>
						</li>
					</ul>
					<ul>
						<li class="viewTitle">신청자</li>
						<li class="viewText">${seName}</li>
					</ul>
					<ul>
						<li class="viewTitle viewHeight1">연락받으실 분</li>
						<li class="viewText viewHeight1">
							<input type="text" id="contact_person" name="contact_person" class="slInput" value="${vo.contact_person}">
						</li>
					</ul>
					<ul>
						<li class="viewTitle viewHeight1">연락처</li>
						<li class="viewText viewHeight1">
							<input type="text" id="tel" name="tel"  class="slInput" value="${vo.tel}">
						</li>
					</ul>
					<ul>
						<li class="viewTitle viewHeight2">환불계좌</li>
						<li class="viewText viewHeight2">
							입금주&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="account_holder" class="slInput" value="${vo.account_holder}"><br/>
							은행명&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="bank_name" class="slInput" value="${vo.bank_name}"><br/>
							계좌번호&nbsp;<input type="text" name="account_number" class="slInput" value="${vo.account_number}">
						</li>
					</ul>
					<ul>
						<li class="viewTitle">예약일</li>
						<li class="viewText">${fn:substring(vo.reservation_date,0,10)}</li>
					</ul>
					<ul class="viewbtnUl">
						<li>
							<a href="javascript:submitChk()">변경</a>
							<a href="javascript:delChk()">취소</a>
						</li>
					</ul>
				</form>
			</div>
		</div>
	</div>
	<div class="clearDiv"></div>
	
	<div id="footer">
		<div id="footerTxt">
			주소: 서울 금천구 가산디지털2로 123 <br/>
			전화번호: 02-123-1234
		</div>
	</div>
</body>
</html>