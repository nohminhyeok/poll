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
	
	ItemDao itemDao = new ItemDao();
	
	QuestionDao questionDao = new QuestionDao();
	ArrayList<HashMap<String, Object>> list = questionDao.selectQuestionList(paging);

	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pollList</title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div>
	<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
	<h1>설문리스트</h1>
	<table class="table table-dark table-hover">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>시작일</th>
			<th>종료일</th>
			<th>복수투표</th>
			<th>총 투표횟수</th>
			<th>투표</th>
			<th>삭제</th>
			<th>수정</th>
			<th>종료일자 수정</th>
			<th>결과</th>
		</tr>
		<%
			for(HashMap<String, Object> map : list){
				// HashMap에서 데이터를 추출
	            int num = (Integer) map.get("num");
	            String title = (String) map.get("title");
	            String startdate = (String) map.get("startdate");
	            String enddate = (String) map.get("enddate");
	            int type = (Integer) map.get("type");
	            int cnt = (Integer) map.get("cnt");
	
	            String getTypestr = (type == 1) ? "가능" : "불가능";
                
                // 시작일과 종료일을 Date 객체로 변환
                Date startDateObj = sdf.parse(startdate);
                Date endDateObj = sdf.parse(enddate);
                Date todayDate = sdf.parse(today); // 오늘 날짜를 Date 객체로 변환
				
                
		%>
			<tr>
				<td><%=num%></td>
				<td><%=title%></td>
				<td><%=startdate%></td>
				<td><%=enddate%></td>
				<td><%=type%></td>
				<td><%=cnt%></td>
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
						<a href="/poll/updateItemForm.jsp?qnum=<%=num%>">투표하기</a>
					<%
					}
					%>     					
				</td>
				<td><a href="/poll/deletePollAction.jsp?qnum=<%=num%>&num=<%=num%>">삭제</a></td>
				<td><a href="/poll/updatePollForm.jsp?num=<%=num%>">수정</a></td>
				<td>
					<%
													
						if (endDateObj.equals(todayDate) || endDateObj.after(todayDate)){
					%>
						<a href="/poll/updateQuestionEnddateForm.jsp?qnum=<%=num%>&num=<%=num%>">종료일자 수정</a>
					<%
						}
					%>							
				</td>
				<td>
					<%
						if (endDateObj.before(todayDate)){
					%>
					<a href='/poll/questionOneResult.jsp?qnum=<%=num%>'>결과보기</a>
					<%
						} else {
					%>
						투표 진행중
					<%		
						}
					%>							
				</td>
			</tr>
		<%
			}
		%>		

	</table>
	<button type="submit"><a href="/poll/insertPollForm.jsp">설문 작성하기</a></button>
</body>
</html>