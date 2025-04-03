<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%	
	int num = Integer.parseInt(request.getParameter("num"));
	QuestionDao questionDao = new QuestionDao();
	Question question = questionDao.selectQuestionByNum(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>종료일자 수정</h1>
	<form method="post" action="/poll/updateQuestionEnddateAction.jsp">
	<table border="1">
		<tr>
			<td>종료일</td>
			<td><input type="date" name="enddate" value="<%= question.getEnddate() %>"></td>
		</tr>
	</table>
	<button type="submit">수정하기</button>
    <input type="hidden" name="num" value="<%=question.getNum()%>">
    <% System.out.println("test : "+question.getNum());%>
	</form>
</body>
</html>