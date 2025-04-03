<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.*"%>
<%
	String enddate = request.getParameter("enddate");
	int num = Integer.parseInt(request.getParameter("num"));
	
    Question question = new Question();
    question.setEnddate(enddate);
    
    QuestionDao questionDao = new QuestionDao();
    questionDao.updateQuestion2(num, enddate);
    
    response.sendRedirect("/poll/pollList.jsp");
%>