<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/web/js_css/jquery-3.1.1.min.js"></script>
<script src="/web/js_css/bootstrap.min.js"></script>
<script src="http://d3js.org/d3.v3.min.js"></script>
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
	
	<div class="contentAdmin" style="height: 1300px">
		<ul class="nav nav-pills nav-justified">
			<li><a href="/web/admin">프로그램 정보 입력</a></li>
	    	<li><a href="/web/admin/programList">프로그램 정보 확인/수정</a></li>
	    	<li><a href="/web/admin/programTimeWrite">프로그램 시간 입력</a></li>
	    	<li><a href="/web/admin/programTimeList">프로그램 시간 정보 확인/수정</a></li>
	  	</ul> 	
	  	<ul class="nav nav-pills nav-justified">
	    	<li><a href="/web/admin/memberList">회원 정보 확인/탈퇴</a></li>
	    	<li><a href="/web/admin/reservList">예약 정보 확인/취소</a></li>
	    	<li class="active"><a href="/web/admin/statistics">예약 통계</a></li>
	  	</ul> 	
	 		
		<div class="admin">
			<h2 class="formTitle">프로그램별 예약 통계</h2>
			<div class="statistics">	
				<h3>프로그램별 예약 인원수</h3>
				<div class="chart"></div>
			</div>
			<div class="clear"></div>
			<div class="statisticsDiv">
				<ul id="statisticsList">
				<li class="programList2 plTitle">프로그램명</li>
				<li class="programList1 plTitle">어린이 인원수</li>
				<li class="programList1 plTitle">청소년 인원수</li>
				<li class="programList1 plTitle">성인 인원수</li>
				<li class="programList1 plTitle">총 인원수</li>
				
				<c:forEach var="vo" items="${list}">
					<li class="programList2">${vo.title}</li>
					<li class="programList1">${vo.child_tot}</li>
					<li class="programList1">${vo.teenager_tot}</li>
					<li class="programList1">${vo.adult_tot}</li>
					<li class="programList1">${vo.child_tot+vo.teenager_tot+vo.adult_tot}</li>
				</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	
	<script>
		var dataset = [
			<c:forEach var="vo" items="${list}" varStatus="status">
				{label:"${vo.title}", "어린이 인원수":${vo.child_tot}, "청소년 인원수":${vo.child_tot}, "성인 인원수": ${vo.adult_tot}}
				<c:if test="${not status.last }">
				,
				</c:if>
			</c:forEach>
		];
		var margin = {top: (parseInt(d3.select('.chart').style('width'), 10)/10), right: (parseInt(d3.select('.chart').style('width'), 10)/20), bottom: (parseInt(d3.select('.chart').style('width'), 10)/5), left: (parseInt(d3.select('.chart').style('width'), 10)/20)},
			width = parseInt(d3.select('.chart').style('width'), 10) - margin.left - margin.right,
			height = parseInt(d3.select('.chart').style('height'), 10) - margin.top - margin.bottom;
	
		var x0 = d3.scale.ordinal()
			.rangeRoundBands([0, width], .1);
				
		var x1 = d3.scale.ordinal();
			
		var y = d3.scale.linear()
			.range([height, 0]);
			
		var colorRange = d3.scale.category10();
		var color = d3.scale.ordinal()
			.range(colorRange.range());
			
		var xAxis = d3.svg.axis()
			.scale(x0)
			.orient("bottom");
			
		var yAxis = d3.svg.axis()
			.scale(y)
			.orient("left")
			.tickFormat(d3.format(".2s"));
			
		var svg = d3.select(".chart").append("svg")
			.attr("width", width + margin.left + margin.right)
			.attr("height", height + margin.top + margin.bottom)
			.append("g")
			.attr("transform", "translate(" + margin.left + "," + margin.top + ")");
			
		var options = d3.keys(dataset[0]).filter(function(key) { return key !== "label"; });
			
		dataset.forEach(function(d) {
			d.valores = options.map(function(name) { return {name: name, value: +d[name]}; });
			});
			
		x0.domain(dataset.map(function(d) { return d.label; }));
		x1.domain(options).rangeRoundBands([0, x0.rangeBand()]);
		y.domain([0, d3.max(dataset, function(d) { return d3.max(d.valores, function(d) { return d.value; }); })]);
			
		svg.append("g")
			.attr("class", "x axis")
			.attr("transform", "translate(0," + height + ")")
			.call(xAxis);
			
		svg.append("g")
			.attr("class", "y axis")
			.call(yAxis)
			.append("text")
			.attr("transform", "rotate(-90)")
			.attr("y", 6)
			.attr("dy", ".71em")
			.style("text-anchor", "end")
			.text("인원(명)");
			
		var bar = svg.selectAll(".bar")
			.data(dataset)
			.enter().append("g")
			.attr("class", "rect")
			.attr("transform", function(d) { return "translate(" + x0(d.label) + ",0)"; });
			
		bar.selectAll("rect")
			.data(function(d) { return d.valores; })
			.enter().append("rect")
			.attr("width", x1.rangeBand())
			.attr("x", function(d) { return x1(d.name); })
			.attr("y", function(d) { return y(d.value); })
			.attr("value", function(d){return d.name;})
			.attr("height", function(d) { return height - y(d.value); })
			.style("fill", function(d) { return color(d.name); });
			
		var legend = svg.selectAll(".legend")
			.data(options.slice())
			.enter().append("g")
			.attr("class", "legend")
			.attr("transform", function(d, i) { return "translate(0," + i * 20 + ")"; });
			
		legend.append("rect")
			.attr("x", width - 18)
			.attr("width", 18)
			.attr("height", 18)
			.style("fill", color);
			
		legend.append("text")
			.attr("x", width - 24)
			.attr("y", 9)
			.attr("dy", ".35em")
			.style("text-anchor", "end")
			.text(function(d) { return d; });
	</script>
	
	<div id="footer">
		<div id="footerTxt">
			주소: 서울 금천구 가산디지털2로 123 <br/>
			전화번호: 02-123-1234
		</div>
	</div>
</body>
</html>