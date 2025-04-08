<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	BoardDao boardDao = new BoardDao();
	Board b = boardDao.selectBoardOne(num);
%>
<!DOCTYPE html>
<html>
<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>수정하세염</h1>
	<form method="post" action="/poll/board/updateBoardOneAction.jsp">
		<table class="table table-dark table-hover table-striped">
			<tr>
				<td>num</td>
				<td><input type="text" name="num" value="<%=b.getNum()%>" readonly></td>
			</tr>
			<tr>
				<td>name</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>subject</td>
				<td><input type="text" name="subject"></td>
			</tr>
			<tr>
				<td>content</td>
				<td><input type="text" name="content"></td>
			</tr>
			<tr>
				<td>비밀번호 확인</td>
				<td><input type="password" name="pass"></td>
			</tr>
		</table>
		<button type="submit">수정하기</button>
	</form>
</body>
</html>