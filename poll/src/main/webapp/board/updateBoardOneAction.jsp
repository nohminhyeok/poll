<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*"%>
<%@ page import="model.*"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String name = request.getParameter("name");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	int pass = Integer.parseInt(request.getParameter("pass"));

	BoardDao boardDao = new BoardDao();
	boardDao.updateBoard(name, subject, content, num, pass);
	
	response.sendRedirect("/poll/board/boardList.jsp");
%>