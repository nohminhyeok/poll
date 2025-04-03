<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));	
	System.out.println("num : "+num);
	int qnum = Integer.parseInt(request.getParameter("qnum"));
	System.out.println("qnum : "+qnum);

	ItemDao itemDao = new ItemDao();
	itemDao.deleteItem(qnum);

	QuestionDao questionDao = new QuestionDao();
	questionDao.deleteQuestion(num);
	
	response.sendRedirect("/poll/pollList.jsp");
%>