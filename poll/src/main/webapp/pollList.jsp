<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%
	// question 테이블 리스트 -> 페이징 -> title 링크(startdate <= 오늘날짜 <= enddate) -> 투표프로그램
	// QuestionDao.selectQuestionList(Paging)
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String today = sdf.format(new Date());
	System.out.println(today);

 	
    
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	

	Paging paging = new Paging();
	paging.setCurrentPage(currentPage);
	paging.setRowPerPage(rowPerPage);

	int totalRows = 0;
    
    int totalPages = paging.getLastPage(totalRows);
	
    
	
	QuestionDao questionDao = new QuestionDao();
	ArrayList<Question> list = questionDao.selectQuestionList(paging);

	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pollList</title>
</head>
<body>
	<h1>설문리스트</h1>
	<table border="1">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>시작일</th>
			<th>종료일</th>
			<th>type</th>
			<th>투표하기</th>
		</tr>
		<%
			for(Question question : list){
                String startdate = question.getStartdate(); // 시작일
                String enddate = question.getEnddate(); // 종료일
                
                // 시작일과 종료일을 Date 객체로 변환
                Date startDateObj = sdf.parse(startdate);
                Date endDateObj = sdf.parse(enddate);
                Date todayDate = sdf.parse(today); // 오늘 날짜를 Date 객체로 변환
		%>
			<tr>
				<td><%=question.getNum()%></td>
				<td><%=question.getTitle()%></td>
				<td><%=question.getStartdate()%></td>
				<td><%=question.getEnddate()%></td>
				<td><%=question.getType()%></td>
				<td>
         			 <%
                        // 투표 시작 전: 오늘 날짜가 시작일 이전일 경우
                        if (startDateObj.after(todayDate)) { 
                    %>
                        <a>투표 시작 전</a>
                    <%
                        // 투표 종료: 오늘 날짜가 종료일 이후일 경우
                        } else if (endDateObj.before(todayDate)) {
                    %>
                        <a>투표 종료</a>
                    <%
                        // 투표하기: 오늘 날짜가 시작일과 종료일 사이일 경우
                        } else {
                    %>                
                        <a href="">투표하기</a>
                    <%
                        }
                    %>  					
				</td>
			</tr>
		<%
			}
		%>		

	</table>
	<!-- foreach문 ArrayList<Question> list 출력 title 
	링크(startdate <= 오늘날짜 <= enddate) 투표시작전, 투표종료, 투표하기 -->
</body>
</html>