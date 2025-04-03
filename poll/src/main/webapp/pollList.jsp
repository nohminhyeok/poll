<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.*" %>
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
			<th>복수투표</th>
			<th>투표</th>
			<th>삭제</th>
			<th>수정</th>
			<th>종료일자 수정</th>
			<th>결과</th>
		</tr>
		<%
			for(Question question : list){
                String startdate = question.getStartdate(); // 시작일
                String enddate = question.getEnddate(); // 종료일
                int getType = question.getType();
                String getTypestr = "";
                if(getType == 1) {
                	getTypestr = "가능";
                } else if (getType == 0) {
                	getTypestr = "불가능";
                }
                
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
				<td><%=getTypestr%></td>
				<td>
					<%  // 투표 시작 전: 오늘 날짜가 시작일 이전일 경우 (내일 시작하는 투표도 포함)
						if (startDateObj.after(todayDate)) {  // 시작일이 오늘 이후일 경우
					%>
						<a>시작전</a>
					<%
						// 투표 종료: 오늘 날짜가 종료일 이전일 경우
						} else if (endDateObj.before(todayDate)) {  // 종료일이 오늘 이전일 경우
					%>
						<a>투표종료</a>
					<%
						// 투표하기: 오늘 날짜가 시작일과 종료일 사이일 경우
						} else if ((startDateObj.before(todayDate) || startDateObj.equals(todayDate)) 
						           && (endDateObj.after(todayDate) || endDateObj.equals(todayDate))) 
						{ 
					%>                
						<a href="votePage.jsp?questionId=<%=question.getNum()%>">투표하기</a>
					<%
					}
					%>     					
				</td>
				<td><a href="/poll/deletePollAction.jsp?qnum=<%=question.getNum()%>&num=<%=question.getNum()%>">삭제</a></td>
				<td><a href="/poll/updatePollForm.jsp?qnum=<%=question.getNum()%>&num=<%=question.getNum()%>">수정</a></td>
				<td>
					<%
						if (endDateObj.equals(todayDate) || endDateObj.after(todayDate)){
					%>
						<a href="/poll/updateQuestionEnddateForm.jsp">종료일자 수정</a>
					<%
						}
					%>							
				</td>
				<td>
					<%
						if (endDateObj.before(todayDate)){
					%>
					<a href="">결과보기</a>
					<%
						}
					%>							
				</td>
			</tr>
		<%
			}
		%>		

	</table>
</body>
</html>