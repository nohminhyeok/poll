<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.*" %>
<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currertPage"));
	}
	
	BoardDao boardDao = new BoardDao();
	Paging p = new Paging();
	p.setCurrentPage(currentPage);
	p.setRowPerPage(10);
	
	ArrayList<Board> list = boardDao.selectBoardList(p);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>
</head>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="container">
	<h1>BoardList</h1>
	<!-- nav.jsp 인클루드 -->
	<div>
	<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
	
	<!-- boardList table.... -->
	
	<table class="table table-dark table-hover table-striped">
		<thead>
		<tr>
			<td>num</td>
			<td>subject</td>
		</tr>
		</thead>
		<tbody>
			<%
				for(Board b : list) {
			%>
					<tr>
						<td><%=b.getNum()%></td>
						<td>
							<%
								for(int i=0; i<=b.getDepth(); i++){
							%>
									&nbsp;&nbsp;&nbsp;&nbsp;
							<%		
								}
							%>
								<a href="/poll/board/boardOne.jsp?num=<%=b.getNum()%>">
									<%=b.getSubject()%>
							</a>	
						</td>
					</tr>
			<%	
				}
			%>
		</tbody>
	</table>
</body>
</html>