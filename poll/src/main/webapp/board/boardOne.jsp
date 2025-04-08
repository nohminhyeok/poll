<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="dto.*" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	
	BoardDao boardDao = new BoardDao();
	Board b = boardDao.selectBoardOne(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<h1>board One</h1>
	<table class="table table-dark table-hover table-striped">
		<tr>
			<td>NUM</td>
			<td><%=b.getName()%></td>
		</tr>
		<tr>
			<td>NAME</td>
			<td><%=b.getName()%></td>
		</tr>
		<tr>
			<td>SUBJECT</td>
			<td><%=b.getSubject()%></td>
		</tr>
		<tr>
			<td>content</td>
			<td><%=b.getContent()%></td>
		</tr>
		<tr>
			<td>POS</td>
			<td><%=b.getPos()%></td>
		</tr>
		<tr>
			<td>REF</td>
			<td><%=b.getRef()%></td>
		</tr>
		<tr>
			<td>DEPTH</td>
			<td><%=b.getDepth()%></td>
		</tr>
		<tr>
			<td>REGDATE</td>
			<td><%=b.getRegdate()%></td>
		</tr>
		<tr>
			<td>IP</td>
			<td><%=b.getIp()%></td>
		</tr>
		<tr>
			<td>COUNT</td>
			<td><%=b.getCount()%></td>
		</tr>
	</table>
	<a href="/poll/board/updateBoardOneForm.jsp?num=<%=b.getNum()%>">수정</a>
	<a href="/poll/board/deleteBoardOneAction.jsp?num=<%=b.getNum()%>">삭제</a>
	<a href="/poll/board/insertBoardReplyForm.jsp?ref=<%=b.getRef()%>&pos=<%=b.getPos()%>&depth=<%=b.getDepth()%>">답글달기</a>
</body>
</html>