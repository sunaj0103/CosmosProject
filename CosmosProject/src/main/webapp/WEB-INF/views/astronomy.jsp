<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/web/js_css/jquery-3.1.1.min.js"></script>
<link href="/web/js_css/subStyle.css" rel="stylesheet" type="text/css"/>
<title>가산스타천문대</title>
<script>
$(function() {
	$("#sunTitle").on("click",function(){
		$(".planetDesc").css("display","none");
		$("#sunDesc").css("display","block");
	});
	$("#mercuryTitle").on("click",function(){
		$(".planetDesc").css("display","none");
		$("#mercuryDesc").css("display","block");
	});
	$("#venusTitle").on("click",function(){
		$(".planetDesc").css("display","none");
		$("#venusDesc").css("display","block");
	});
	$("#earthTitle").on("click",function(){
		$(".planetDesc").css("display","none");
		$("#earthDesc").css("display","block");
	});
	$("#marsTitle").on("click",function(){
		$(".planetDesc").css("display","none");
		$("#marsDesc").css("display","block");
	});
	$("#jupiterTitle").on("click",function(){
		$(".planetDesc").css("display","none");
		$("#jupiterDesc").css("display","block");
	});
	$("#saturnTitle").on("click",function(){
		$(".planetDesc").css("display","none");
		$("#saturnDesc").css("display","block");
	});
	$("#uranusTitle").on("click",function(){
		$(".planetDesc").css("display","none");
		$("#uranusDesc").css("display","block");
	});
	$("#neptuneTitle").on("click",function(){
		$(".planetDesc").css("display","none");
		$("#neptuneDesc").css("display","block");
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

	<div id="contentAstronomy">
		<div id="solarSystemCon">
			<div id="solarSystem">
				<div id="sun" class="sun"></div>
	
				<div class="path" id="mercury_p"></div>
				<div id="mercury_orbit">
					<div id="mercury"></div>
				</div>
	
				<div class="path" id="venus_p"></div>
				<div id="venus_orbit">
					<div id="venus"></div>
				</div>
	
				<div class="path" id="earth_p"></div>
				<div id="earth_orbit">
					<div id="earth">
						<div id="moon"></div>
						<div class="cont" id="n_am"></div>
						<div class="cont" id="s_am"></div>
					</div>
				</div>
	
				<div class="path" id="mars_p"></div>
				<div id="mars_orbit">
					<div id="mars"></div>
				</div>
	
				<div class="path" id="jupiter_p"></div>
				<div id="jupiter_orbit">
					<div id="jupiter">
						<div id="jstorm"></div>
					</div>
				</div>
	
				<div class="path" id="saturn_p"></div>
				<div id="saturn_orbit">
					<div id="saturn">
						<div id="s_rings"></div>
					</div>
				</div>
	
				<div class="path" id="uranus_p"></div>
				<div id="uranus_orbit">
					<div id="uranus">
						<div id="u_rings"></div>
					</div>
				</div>
	
				<div class="path" id="neptune_p"></div>
				<div id="neptune_orbit">
					<div id="neptune"></div>
				</div>
			</div>
	
			<div id="solarSystemTitle">
				태양계 Solar System
			</div>
	
			<div class="solarSystemDesc">
				<h2>태양계 Solar System</h2>
				<p>태양계에는 항성인 태양과 그 가까이로부터 수성, 금성, 지구, 화성, 즉 지구형 행성이 순서대로 나열되어 있으며
					그 다음에 유성대(asteroid belt)가 존재한다. 이후 목성, 토성, 천왕성, 해왕성으로 구성된 목성형 행성이
					나열되어서 총 8개의 행성이 존재한다. 그 바깥에는 얼음덩어리들과 미행성들로 구성된 카이퍼 띠(Kuiper belt),
					원반대역(scattered disk)이 있으며, 가장 바깥쪽에는 오르트구름(Oort cloud)이 있다. 유성체, 혜성과
					성간 물질 등은 SSSB(small solar system bodies)로 분류된다.</p>
				<p class="refRight">
					<span>[출처:두산백과]</span>
				</p>
			</div>
	
			<div class="planetTitle">
				<div id="sunTitle">태양</div>
				<div id="mercuryTitle">수성</div>
				<div id="venusTitle">금성</div>
				<div id="earthTitle">지구</div>
				<div id="marsTitle">화성</div>
				<div id="jupiterTitle">목성</div>
				<div id="saturnTitle">토성</div>
				<div id="uranusTitle">천왕성</div>
				<div id="neptuneTitle">해왕성</div>
			</div>
	
			<div id="sunDesc" class="planetDesc">
				<h2>태양 sun</h2>
				<p>
					지구에서 평균거리 1억 4960만km에 있으나, 지구가 근일점(近日點)을 지나는 1월 초에는 이보다 250만km(평균거리의
					1.7%)가 가까워지고 원일점(遠日點)을 지나는 7월 초에는 마찬가지로 250만km 더 멀어진다. 태양의 지름은 약
					139만km로 지구의 지름의 109배, 따라서 부피는 지구의 130만 배, 질량은 약 2×10<sup>33</sup>g로
					지구의 33만 배, 평균 밀도는 지구의 1cm<sup>3</sup>당 5.52g에 대해서 약 1/4인 1.41g/cm<sup>3</sup>이다.<br />
					이처럼 태양의 밀도가 지구보다 작은 까닭은, 태양이 지구처럼 고체의 껍질을 가진 것이 아니라, 전체가 거대한 고온의 기체의
					공이기 때문이다. 태양의 기체를 이루는 원소는 그 스펙트럼(태양스펙트럼)으로부터, 대부분이 수소 H, 다음이 헬륨
					He이고, 이 밖에 극히 적은 양의 나트륨 Na, 마그네슘 Mg, 철 Fe 등 지구상에서 알려진 원소 약 70종이
					기체상태로 존재하는 것이 확인되었다.
				</p>
				<p class="refRight">
					<span>[출처:두산백과]</span>
				</p>
			</div>
			<div id="mercuryDesc" class="planetDesc">
				<h2>수성 Mercury</h2>
				<p>
					태양계에서 태양과 가장 가까운 행성.<br /> 궤도긴반지름은 0.387AU, 궤도의 이심률은 0.2056이다. 태양계의
					행성 중 태양에 가장 가까운 궤도를 돌며, 태양에 가깝기 때문에 한밤중에 보이는 일은 없고 초저녁의 서쪽 하늘에서나 새벽의
					동쪽 하늘에서만 잠깐 동안 보인다. 고대 그리스에서는 저녁에 보일 때에는 헤르메스, 새벽에 보일 때에는 아폴로라 하여
					2개의 다른 별로 생각한 적도 있다. 한국과 중국에서는 진성(辰星)이라 하였다. 밝기는 지구로부터의 거리에 따라 달라 약
					－1.8~4등 사이에서 변한다. 공전주기는 87.97일이고, 115.88일의 회합주기(會合週期)마다 지구와 가까워진다.
					지구에서 보아 수성이 태양의 동쪽(저녁별)이나 서쪽(새벽별)으로 가장 멀리 떨어질 때를 각각 동방최대이각과
					서방최대이각이라고 하는데, 그 각도는 18°∼28°가 된다.
				</p>
				<p class="refRight">
					<span>[출처:두산백과]</span>
				</p>
			</div>
			<div id="venusDesc" class="planetDesc">
				<h2>금성 Venus</h2>
				<p>
					서양에서는 로마 신화에 나오는 미(美)의 여신의 이름을 따서 비너스라고 부른다.<br /> 지름 1만 2,100km로 지구
					지름보다 644km가 작다. 금성은 지구에 가장 가까이 다가오는 행성으로, 가장 가까울 때에는 약 4140만km까지
					접근한다. 금성은 하루가 약 243일, 1년이 224일로 자전을 하는 데 걸리는 시간이 공전을 하는데 걸리는 시간보다
					길다. 금성은 지구에서 볼 때 태양, 달 다음으로 세 번째로 밝은 천체이다. 금성은 일 년 중 한동안은 초저녁 무렵 서쪽
					하늘에서 가장 먼저 나타난다. 또 다른 때는 아침 동쪽 하늘에서 그 어떤 행성이나 별보다 늦게까지 보이기도 한다. 금성이
					가장 밝은 곳에 있을 때는 대낮에도 육안으로 볼 수 있다. 새벽에 동쪽 하늘에서 보이는 금성을 '샛별' 또는 '계명성'이라
					부르고 저녁에 서쪽 하늘에서 보이는 금성을 '저녁별'이나 '개밥바라기' 또는 '태백성'이라고 부른다.
				</p>
				<p class="refRight">
					<span>[출처:두산백과]</span>
				</p>
			</div>
			<div id="earthDesc" class="planetDesc">
				<h2>지구 earth</h2>
				<p>
					태양계의 행성 중 하나로 인류가 살고 있는 천체를 말한다. 태양으로부터 세 번째 궤도를 돌며, 달을 위성으로 가지고 있다.
					또한 엷은 대기층으로 둘러싸여 있고, 특유한 지구자기를 가지고 있다.<br /> 태양계의 행성 중 하나인 지구는 자신의
					위성인 달을 동반하고 태양의 둘레를 공전한다. 그 궤도는 태양으로부터 수성 ·금성 다음으로 세번째로 가까이 있다. 지구는
					고등생물이 서식하고 있는 점에서 다른 행성들과 다른 존재이지만, 가스와 고체의 구(球)라는 점에서는 다른 행성들과 공통점을
					가지고 있다. 태양계의 행성은 지구를 비롯하여 수성 ·금성 ·화성의 지구형 행성과 목성 ·토성 ·천왕성 ·해왕성의 목성형
					행성으로 나눌 수 있다.
				</p>
				<p class="refRight">
					<span>[출처:두산백과]</span>
				</p>
			</div>
			<div id="marsDesc" class="planetDesc">
				<h2>화성 Mars</h2>
				<p>
					태양계에서 4번째 궤도를 돌고 있는 행성.<br /> 붉은 빛을 띠고 있어, 예로부터 전쟁이나 재앙(災殃)과 결부시켜
					생각한 민족이 많다. 영어명 마르스(Mars)는 로마 신화에 나오는 군신(軍神)의 이름이다. 중국에서는 형혹(熒惑)이라고
					불렀다. 화성의 적도반지름은 3,390km로 지구의 반 정도이며, 지구에서 본 시(視)반지름은 약 12″이다. 질량은
					지구의 0.107배, 밀도는 3.94g/cm<sup>3</sup>, 편평도는 0.0052. 적도에서의 중력은 지구의
					0.38배이다. 자전주기는 24<sup>h</sup> 37<sup>m</sup> 23<sup>s</sup>로 지구보다 약간
					길고, 자전축이 약 25° 기울어 있어 4계절이 있다. 밝기는 보통 때는 －2.0등 정도이지만 대접근 무렵에는 약
					-2.8등이 된다.
				</p>
				<p class="refRight">
					<span>[출처:두산백과]</span>
				</p>
			</div>
			<div id="jupiterDesc" class="planetDesc">
				<h2>목성 Jupiter</h2>
				<p>
					태양계 내에 있는 행성 중에서 가장 큰 행성으로 행성의 순서 중 5번째에 위치하고 있다.<br /> 목성의 궤도는 이심률이
					작으며(0.0489), 궤도면은 황도면에 대하여 1.30도만큼 기울어져 있다. 공전 주기는 11.86년이며, 자전 주기는
					9시간 55.5분이다. 목성의 밀도는 1.33g/㎤밖에 안 되는데 이는 목성형 행성의 공통적인 특징이며, 화학 조성이
					수소, 헬륨 같은 가벼운 원소로 이루어져 있다는 것을 의미한다. 목성을 보면 커다란 붉은 점을 볼 수 있는데 이를
					대적반(大赤斑)이라고 하며 19세기 이래로 계속 유지되고 있다. 크기는 가로길이 약 50,000km, 세로길이 약
					20,000km로 지구보다도 크다. 목성의 적도에는 평행한 검고 밝은 줄무늬들이 번갈아 보이는데, 검은 줄무늬를
					검은’띠(belt)’라고 일컬으며, 밝은 줄무늬를 ‘대(zone)’이라고 부른다. 적외선 관측 결과에 의하면 대는 띠보다
					온도가 낮다. 대기의 온도는 고도가 클수록 떨어지기 때문에 대는 띠보다 더 높은 상층에 위치한다. 곧 대는 고압의 상승
					영역의 상단, 띠는 저압의 하강 영역이기 때문에 온도의 차가 나는 것으로 보고 있다
				</p>
				<p class="refRight">
					<span>[출처:두산백과]</span>
				</p>
			</div>
			<div id="saturnDesc" class="planetDesc">
				<h2>토성 Saturn</h2>
				<p>
					태양계에 속하는 6번째 행성.<br /> 약 1등성의 밝기로 태양빛을 반사하여 황색으로 빛난다. 망원경이 발명되기 이전에
					옛사람들이 알고 있던 5개의 행성(동양에서의 五星) 가운데 가장 바깥쪽에 있는 행성으로, 동양에서는 진성(鎭星)으로
					불렸다. 궤도의 긴반지름은 9.54천문단위(AU), 공전주기는 29.46년, 이심률은 0.056이다. 토성은 행성 중에서
					목성 다음으로 커서 적도반지름은 약 6만 km(지구의 약 9.5배), 질량은 지구의 약 95배인데, 편율(扁率)은 약
					1/10로 행성 중 가장 크다. 이것은 자전이 빠르고 표면이 두꺼운 유체로 덮여 있음을 암시한다.<br /> 평균밀도는
					0.71g/cm<sup>3</sup>으로 행성 중 가장 작고 물보다도 작다. 토성의 표면에는 띠 모양의 무늬가 보이는데,
					이것이 때에 따라 달라지므로 자전주기는 스펙트럼선의 도플러효과를 이용해서 얻어진다. 그 값은 적도에서 10시간 14분, 극
					근방에서 10시간 38분으로 측정된다. 이처럼 위도에 따라 자전주기가 다른 것은 표면이 고체가 아니기 때문이다.
				</p>
				<p class="refRight">
					<span>[출처:두산백과]</span>
				</p>
			</div>
			<div id="uranusDesc" class="planetDesc">
				<h2>천왕성 Uranus</h2>
				<p>
					태양계에 속하는 태양의 일곱 번째 행성.<br /> 궤도의 긴반지름은 19.19천문단위(AU)이고, 궤도의 이심률은
					0.046이다. 태양으로부터의 거리는 근일점에서 17억 3000만km, 원일점에서 29억 9000만km이다. 태양주위
					공전주기는 84.02년이다.<br /> 적도반지름은 2만 5600km이고, 극반지름은 이보다 약 18분의 1이 작다.
					평균광도는 5.9로 육안으로 겨우 보인다. 망원경으로 보면 시지름이 3.6초(평균 최근거리)인 녹색의 원반 모양을 하고
					있다. 천왕성의 자전주기는 17시간 14분이다. 천왕성의 적도면은 궤도면과 98° 경사를 이루고 있다. 자전축이 황도면과
					거의 일치하여 공전에 수직인 방향으로 자전한다. 즉, 공전궤도면과 거의 평행으로 누운 모습으로 자전과 공전을 하고 있다.
					위성에 작용하는 인력으로부터 구한 천왕성의 질량은 지구의 14.56배이다. 비중은 1.3으로 지구보다는 아주 작고 태양과
					비슷하다.
				</p>
				<p class="refRight">
					<span>[출처:두산백과]</span>
				</p>
			</div>
			<div id="neptuneDesc" class="planetDesc">
				<h2>해왕성 Neptune</h2>
				<p>
					태양계에 속하는 태양의 8번째 행성.<br /> 태양에서부터의 평균거리는 30.13천문단위(1천문단위=1.496×10<sup>8</sup>km),
					궤도의 이심률은 0.00786(금성을 제외한 어느 행성보다도 작다), 자전주기 0.583일, 공전주기 164.79년,
					지구와의 회합주기 367.5일이다. 또 적도반지름은 2만 4764km로 지구의 3.883배이다. 편율(扁率)은 0.02,
					부피는 지구의 60배, 질량은 17.239배, 비중은 1.6, 적도중력은 지구의 1.11배, 태양에서 받는 복사량은 적어서
					지구의 0.0011배이다.<br /> 또 반사능(反射能)은 0.71이고, 지구에서 본 극대광도는 7.9등급으로 맨눈에는
					보이지 않는다. 스펙트럼은 천왕성보다 강한 메탄 CH<sub>4</sub>의 흡수대(吸收帶)가 보인다. 대기 중에는 고체
					암모니아 NH<sub>3</sub>와 고체 메탄이 있고, 성분은 수소와 헬륨으로 추정된다. 위성은 트리톤(Triton)과
					네레이드(Nereid) 등 13개이고, 트리톤은 행성의 공전방향과 반대방향으로 공전하는 역행(逆行) 위성이다.
				</p>
				<p class="refRight">
					<span>[출처:두산백과]</span>
				</p>
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