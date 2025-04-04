<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<!-- CSS 스타일 정의 -->
	<style>
		p{color : red;}
		#one {color : blue;}
		.one {color : blue;}
		.two {color:green;}
		.three {background-color : grey;}
	</style>
</head>
<body>
	<div>GOOD</div>
	<p>GOOD</p>
	<div id="one">GOOD</div>
	
	<div class="two">GOOD</div>
	
	<div class="two three">TEST</div>
	
	<div class="one three">TEST#</div>
</body>
</html>