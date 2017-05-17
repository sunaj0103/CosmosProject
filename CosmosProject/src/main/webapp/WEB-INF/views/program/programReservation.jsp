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

var appNum = ${vo.num_of_applicants};
var maxNum = ${vo.total_num_of_applicants};

$(function(){
	var regNm = /^[가-힣]{2,15}|[a-zA-Z]{2,15}\s[a-zA-Z]{2,15}$/; // 이름 유효성 검사식
	var regTel = /^\d{3}-\d{3,4}-\d{4}$/; //연락처 유효성 검사식
	
	priceCalculation();
	
	$("select[name=child_tot]").change(function(){
		priceCalculation();
	});
	
	$("select[name=teenager_tot]").change(function(){
		priceCalculation();
	});
	
	$("select[name=adult_tot]").change(function(){
		priceCalculation();
	});
	
	$("#payBtn").click(function(){
		if(totalNum == 0){
			alert("1명 이상 선택하셔야 예약을 진행할 수 있습니다.");
			return false;
		}
		
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
		
		payment();
    });
	
	$("#payModalCancel").click(function(){
		$("#payModal").css("display", "none");
		$('#mask').hide();
    });
	
	$(".modalClose").click(function(){
		$("#payModal").css("display", "none");
		$('#mask').hide();
    });
	
	$("#payModalOk").click(function(){
		$("#payModal").css("display", "none");
		$("#paymentFrm").submit();
		$('#mask').hide();
    });
	
});

function priceCalculation(){
	adultNum = parseInt($("select[name=adult_tot]").val());
	teenNum = parseInt($("select[name=teenager_tot]").val());
	childNum = parseInt($("select[name=child_tot]").val());
	
	totalNum = adultNum + teenNum + childNum;
	totalPrice = adultPrice*adultNum + teenPrice*teenNum + childPrice*childNum;
	
	if(totalNum>=discountNum){
		$("input[name=total_payment]").val(totalPrice);
		//$("#hiddenDiv").append("<input type=\'hidden\' name=\'total_payment\' value=\'"+totalPrice+"\'/>");
		totalPrice = totalPrice*discountX;
		$("#discount").css("display","block");
		$("input[name=discount]").val("Y");
		//$("#hiddenDiv").append("<input type=\'hidden\' name=\'discount\' value=\'Y\'/>");
	}else{
		$("input[name=total_payment]").val(totalPrice);
		//$("#hiddenDiv").append("<input type=\'hidden\' name=\'total_payment\' value=\'"+totalPrice+"\'/>");
		$("#discount").css("display","none");
		$("input[name=discount]").val("N");
		//$("#hiddenDiv").append("<input type=\'hidden\' name=\'discount\' value=\'N\'/>");
	}
	$("input[name=final_payment]").val(totalPrice);
	//$("#hiddenDiv").append("<input type=\'hidden\' name=\'final_payment\' value=\'"+totalPrice+"\'/>");
	$("#amount").html(totalPrice.toLocaleString('en'));
}

function payment(){
	var leftNum = maxNum-appNum
	if(totalNum>leftNum){
		alert("정원이 초과되었습니다.\n"+leftNum+"명만 신청 가능합니다.");
		return false;
	}else{
		var payMethodChk = $('input[name=payment]:checked').val();
		
		$("#modalPayChkNum").html(totalNum);
		$("#modalPayChkAmount").html(totalPrice.toLocaleString('en'));
		
		if (payMethodChk == "D") {
			$("#modalPayChkpayMethod").html("무통장입금");
			//alert("무통장입금 부탁드립니다.");
			
		}
		if (payMethodChk == "C") {
			$("#modalPayChkpayMethod").html("신용카드");
			//alert("신용카드 결제가 완료 되었습니다.");
		}
		$("#payModal").css({opacity: 0.3, "display":"block"}).animate({opacity: 1.0}, 500);
		$('#test').show(); 
		wrapWindowByMask();

		//$("#payModal").css("display", "block");
	}
}

function wrapWindowByMask(){ //화면의 높이와 너비를 구함
	var maskHeight = $(document).height(); 
	var maskWidth = $(window).width(); //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채움 
	$('#mask').css({'width':maskWidth, 'height':maskHeight}); //마스크의 투명도 처리 
	$('#mask').fadeTo("slow", 0.8); 
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

	<div id="contentProgramView2">
		<form id="paymentFrm" name="paymentFrm" method="post" action="/web/program/programReservationOk">
			<div id="programViewTitle2">
				<h1>프로그램 예약</h1>
			</div>

			<div id="programView2">
				<h2 class="viewTitle">예약정보</h2>
				<span>선택하신 프로그램의 예약일과 예약시간을 확인하신 후 예약해주세요.</span>

				<div id="reservationChk">
					<ul class="reservationChkUl">
						<li style="border-top: 1px solid #004ea2">
							<span class="chkTitle">프로그램명</span>
							<span class="chkAns">${vo.title}</span>
						</li>
						<li>
							<span class="chkTitle1">예약일</span> 
							<span class="chkAns1">
								<fmt:parseDate value="${vo.start_date}" var="start_date" pattern="yyyymmdd" scope="page"/>												
								<fmt:formatDate value="${start_date}" pattern="yyyy-mm-dd"/>
							</span>
							<span class="chkTitle2">예약시간</span> <span class="chkAns2">${vo.start_time}~${vo.end_time}</span>
						</li>
						<li>
							<span class="chkTitle">신청자</span> <span class="chkAns">${seName}</span>
						</li>
						<li>
							<span class="chkTitle">연락처</span> 
							<span class="chkAns">
								<input type="text" id="tel" name="tel" class="lInput" value="${mVo.phone}">&nbsp;&nbsp;
								<input type="text" id="contact_person" name="contact_person" class="mInput" value="${seName}">
							</span>
						</li>
						<li>
							<span class="chkTitle">환불계좌</span>
							<span class="chkAns">
								입금주&nbsp;<input type="text" name="account_holder" class="mInput">&nbsp;
								은행명&nbsp;<input type="text" name="bank_name" class="mInput">&nbsp;
								계좌번호&nbsp;<input type="text" name="account_number" class="lInput">
							</span>
						</li>
						<li style="border-bottom: 1px solid #004ea2">
							<span class="chkTitle">신청인원</span>
							<span class="chkAns">
								<span class="programNumTxt">어린이(13세 미만): </span>
								<select name="child_tot">
									<optgroup label="어린이 신청인원">
										<c:forEach var="i" begin="0" end="${vo.total_num_of_applicants}">
											<option value="${i}" <c:if test="${child_tot==i}">selected</c:if>>${i}</option>
										</c:forEach>
									</optgroup>
								</select>&nbsp;&nbsp;&nbsp;
								<span class="programNumTxt">청소년(14~19세 미만): </span>
								<select name="teenager_tot">
									<optgroup label="청소년 신청인원">
										<c:forEach var="i" begin="0" end="${vo.total_num_of_applicants}">
											<option value="${i}" <c:if test="${teenager_tot==i}">selected</c:if>>${i}</option>
										</c:forEach>
									</optgroup>
								</select>&nbsp;&nbsp;&nbsp;
								<span class="programNumTxt">성인(20세 이상): </span>
								<select name="adult_tot">
									<optgroup label="성인 신청인원">
										<c:forEach var="i" begin="0" end="${vo.total_num_of_applicants}">
											<option value="${i}" <c:if test="${adult_tot==i}">selected</c:if>>${i}</option>
										</c:forEach>
									</optgroup>
								</select>&nbsp;&nbsp;&nbsp;
							</span>
						</li>
					</ul>
				</div>

				<div id="viewDetail2">
					<div id="detail3">
						<div class="Payment Method">
							<h2 class="viewTitle">결제정보</h2>
							<p>결제방법을 선택하세요.</p>

							<ul id="payMethodSelect">
								<li>
									<input id="payRadio1" type="radio" name="payment" value="D" checked />
									<label for="payRadio1">무통장입금</label>
									<div class="radioChk"><div class="inside"></div></div>
								</li>
								<li>
									<input id="payRadio2" type="radio" name="payment" value="C"/>
									<label for="payRadio2">신용카드</label>
									<div class="radioChk"><div class="inside"></div></div>
								</li>
							</ul>
						</div>
						<div id="payment">
							<div class="totTxt">결제금액: </div> 
							<div class="totAmount">
								<span id="amount">0</span>&nbsp;원
								<span id="discount">(${vo.discount_min}인 이상 ${vo.discount_rate}% 할인)</span>
							</div>
							<input type="button" id="payBtn" class="rpBtn" value="결제하기"/>
							<div id="hiddenDiv">
								<input type="hidden" name="p_num" value="${vo.p_num}"/>
								<input type="hidden" name="pd_num" value="${vo.pd_num}"/>
								<input type="hidden" name="m_num" value="${seNum}"/>
								<input type="hidden" name="discount" value="N"/>
								<input type="hidden" name="final_payment" value="0"/>
								<input type="hidden" name="total_payment" value="0"/>
							</div>
						</div>
					</div>
				</div>

				<div class="paymentInfo">
					<h2 class="paymentInfoTitle">결제 및 환불 안내</h2>
					<div class="paymentInfoDesc">
						<span class="paymentInfoTxt">천문대 프로그램 결제 및 환불 안내입니다.</span>
						<ul>
							<li>천문대 프로그램은 신청인원에 따라 10인 미만시 인원미달로 프로그램이 폐강될 수 있습니다.</li>
							<li>천문대 프로그램은 기상에 따라 관측을 못할 수 있으며, 관측을 못하신 경우 재관측권을 드립니다.</li>
							<li>초등학교 저학년 3인 이상 신청시 다른 참가자분들을 위해 학부모님 대표자 한 분도 반드시 참가신청
								해주세요.</li>
							<li>만일의 경우를 대비하여 환불계좌도 받고자 하오니 정확한 계좌번호/은행명/예금주명을 작성해주시기
								바랍니다.</li>
							<li>반드시 환불정책 규정을 살펴보신 후 신청하시길 바랍니다.</li>
							<li>무통장입금은 24시간 이내에 입금해야 하며, 그렇지 않을 경우 자동으로 취소될 수 있습니다.</li>
						</ul>
					</div>
				</div>
			</div>
		</form>
	</div>
	
	<div id="mask"></div> 
	
	<div id="payModal">
		<label class="modalClose">&#x2715;</label>
		<div class="payModalContent">
		    <h2>결제하기</h2>
		    <hr/>
		    <div id="modalPayChk">
		    	<span class="modalPayTitle">${vo.title}</span><br/>
		    	<p class="modalPayTxt">예약일: ${vo.title}
		    	예약시간: ${vo.start_time}~${vo.end_time}<br/>
		    	신청인원: 총 <span id="modalPayChkNum"></span>명 <br/>
		    	결제금액: <span id="modalPayChkAmount"></span>원 <br/>
		    	결제방법: <span id="modalPayChkpayMethod"></span>
		    	</p>
		    </div>
		    <div class="modalBtnDiv">
		    	<p class="payChkMsg">결제를 하시겠습니까?</p> 
			    <button id="payModalOk" class="modalOkBtn">결&nbsp;&nbsp;제</button>   
			    <button id="payModalCancel" class="modalCancelBtn">취&nbsp;&nbsp;소</button> 
		    </div> 
		</div>
  	</div>
  	
  	<!-- <div id="CompletePayModal">
		<label class="modalClose">&#x2715;</label>
		<div class="cPayModalContent">
			<h2>결제완료</h2>
		    <hr/>
		    <p>결제가 완료되었습니다.</p>
		    <div class="modalBtnDiv">
			    <button id="CompletePayModallOk" class="modalOkBtn">확인</button>   
		    </div> 
		</div>
  	</div> -->
	
	<div id="footer">
		<div id="footerTxt">
			주소: 서울 금천구 가산디지털2로 123 <br/>
			전화번호: 02-123-1234
		</div>			
	</div>
</body>
</html>