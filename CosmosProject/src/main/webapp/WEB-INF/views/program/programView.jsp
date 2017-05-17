<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/web/js_css/jquery-3.1.1.min.js"></script>
<link href="/web/js_css/programStyle.css" rel="stylesheet" type="text/css"/>
<title>가산스타천문대</title>
<script>
var adultPrice = ${vo.adult};
var teenPrice = ${vo.teenager};
var childPrice = ${vo.child};
var discountNum = ${vo.discount_min};
var discountRate = ${vo.discount_rate};
var	discountX = 1-(parseInt(discountRate)/100);
var adultNum = 0;
var teenNum = 0;
var childNum = 0;
var totalNum = 0;
var totalPrice = 0;

$(function(){
	$("select[name=child_tot]").change(function(){
		priceCalculation();
	});
	
	$("select[name=teenager_tot]").change(function(){
		priceCalculation();
	});
	
	$("select[name=adult_tot]").change(function(){
		priceCalculation();
	});
	
	$("#programViewBtn").click(function(){
		if(totalNum == 0){
			alert("1명 이상 선택하셔야 예약을 진행할 수 있습니다.");
			return false;
		}
				
		$("#programViewFrm").submit();
    });
	
});

function priceCalculation(){
	adultNum = parseInt($("select[name=adult_tot]").val());
	teenNum = parseInt($("select[name=teenager_tot]").val());
	childNum = parseInt($("select[name=child_tot]").val());
	
	totalNum = adultNum + teenNum + childNum;
	totalPrice = adultPrice*adultNum + teenPrice*teenNum + childPrice*childNum;
	
	if(totalNum>=discountNum){
		totalPrice = totalPrice*discountX;
		$("#discount").css("display","block");
	}else{
		$("#discount").css("display","none");
	}
	$("#amount").html(totalPrice.toLocaleString('en'));
	
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

	<div id="contentProgramView">
		<div id="programViewTitle">
			<h1>프로그램 예약</h1>
		</div>
			
		<div id="programView">
			<h2 class="viewTitle">${vo.title}</h2>
			<div class="viewImg">
				<img src="${pageContext.request.contextPath}/img/viewImg.jpg"/>
			</div>
			<div id="viewDetail">
				<h2 class="viewTitle">프로그램 체험 내용</h2>
				<div id="detail1">
					<h3 id="desc1">${vo.title}</h3>
					<p id="desc2">${vo.description}</p>
					<div id="desc3">
						<ul class="descOption">
							<li>
								<span class="optionTitle">대&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;상</span>
								<span class="optionAns">${vo.recommend}</span>
							</li>
							<li>
								<span class="optionTitle">이&nbsp;용&nbsp;요&nbsp;금</span>
								<span class="optionAns">
									어린이 요금: <fmt:formatNumber value="${vo.child}" pattern="#,###"/>원<br/>
								</span>
							</li>
							<li>
								<span class="optionTitle"></span>
								<span class="optionAns">
									청소년 요금: <fmt:formatNumber value="${vo.teenager}" pattern="#,###"/>원<br/>
									성인 요금: <fmt:formatNumber value="${vo.adult}" pattern="#,###"/>원
								</span>
							</li>
							<li>
								<span class="optionTitle">단체 할인 가능 인원</span>
								<span class="optionAns">${vo.discount_min}명</span>
							</li>
						</ul>
					</div>
				</div>
				<div id="detail2">
					<form id="programViewFrm" name="programViewFrm" method="post" action="/web/program/programReservation">
						<ul id="programTimeUl">
							<li>
								<select name="pd_num">
									<optgroup label="예약일 / 시간">
										<c:forEach var="vo" items="${pd_list}">
											<option value="${vo.pd_num}">
												<fmt:parseDate value="${vo.start_date}" var="start_date" pattern="yyyymmdd" scope="page"/>												
												<fmt:formatDate value="${start_date}" pattern="yyyy-mm-dd"/>
											 	/ ${vo.start_time}
											 </option>
										</c:forEach>
									</optgroup>
								</select>						
							</li>
						</ul>
						<ul id="programNumUl">
							<li>
								<span class="programNumTxt">어린이(13세 미만): </span>
								<select name="child_tot">
									<optgroup label="어린이 신청인원">
										<c:forEach var="i" begin="0" end="${vo.total_num_of_applicants}">
											<option value="${i}">${i}</option>
										</c:forEach>
									</optgroup>
								</select>
							</li>
							<li>
								<span class="programNumTxt">청소년(14~19세 미만): </span>
								<select name="teenager_tot">
									<optgroup label="청소년 신청인원">
										<c:forEach var="i" begin="0" end="${vo.total_num_of_applicants}">
											<option value="${i}">${i}</option>
										</c:forEach>
									</optgroup>
								</select>
							</li>
							<li>
								<span class="programNumTxt">성인(20세 이상): </span>
								<select name="adult_tot">
									<optgroup label="성인 신청인원">
										<c:forEach var="i" begin="0" end="${vo.total_num_of_applicants}">
											<option value="${i}">${i}</option>
										</c:forEach>
									</optgroup>
								</select>
							</li>
						</ul>
						
						<div id="totalAmount">
							<div class="totTxt">총 금액:</div>
							<div class="totAmount">
								<span id="amount">0</span>&nbsp;원<br/>
								<span id="discount">(${vo.discount_min}인 이상 ${vo.discount_rate}% 할인)</span>
							</div>
							<input type="button" id="programViewBtn" class="rpBtn" value="예&nbsp;&nbsp;&nbsp;약"/>
							<div id="hiddenDiv">
								<input type="hidden" name="p_num" value="${vo.p_num}"/>
							</div>
						</div>
					</form>
				</div>
			</div>
			
			<div class="paymentInfo">	
				<h2 class="paymentInfoTitle">결제 및 환불 안내</h2>
				<div class="paymentInfoDesc">	
					<span class="paymentInfoTxt">천문대 프로그램 결제 및 환불 안내입니다.</span>			
					<ul>
						<li>천문대 프로그램은 신청인원에 따라 10인 미만시 인원미달로 프로그램이 폐강될 수 있습니다.</li>
						<li>천문대 프로그램은 기상에 따라 관측을 못할 수 있으며, 관측을 못하신 경우 재관측권을 드립니다.</li>
						<li>초등학교 저학년 3인 이상 신청시 다른 참가자분들을 위해 학부모님 대표자 한 분도 반드시 참가신청 해주세요.</li>
						<li>만일의 경우를 대비하여 환불계좌도 받고자 하오니 정확한 계좌번호/은행명/예금주명을 작성해주시기 바랍니다.</li>
						<li>반드시 환불정책 규정을 살펴보신 후 신청하시길 바랍니다.</li>
						<li>무통장입금은 24시간 이내에 입금해야 하며, 그렇지 않을 경우 자동으로 취소될 수 있습니다.</li>
					</ul>
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