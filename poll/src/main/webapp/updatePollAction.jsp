<%@ page import="model.*"%>
<%@ page import="dto.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	System.out.println("tnum2 :"+num);
	String title = request.getParameter("title");
	String startDate = request.getParameter("startdate");
	String endDate = request.getParameter("enddate");
	int type = Integer.parseInt(request.getParameter("type"));
	
	String[] content = request.getParameterValues("content");
	ArrayList<String> contentList = new ArrayList<>();
	for (String c : content) {
		if (!c.equals("")) {
			contentList.add(c);
		}
	}
	
	Question question = new Question();
	question.setNum(num);
	question.setTitle(title);
	question.setStartdate(startDate);
	question.setEnddate(endDate);
	question.setType(type);
	
	QuestionDao questionDao = new QuestionDao();
	questionDao.updateQuestion(num, title, startDate, endDate, type);
	
	ArrayList<Item> list = new ArrayList<>();
	int i = 1;
	for (String c : contentList) {
		Item item = new Item();
		item.setQnum(num);
		item.setInum(i++);
		item.setContent(c);
		
		list.add(item);
	}
	
	ItemDao itemDao = new ItemDao();
	itemDao.deleteItem(num);
	
	for (Item item : list) {
		itemDao.insertItem(item);
	}
	
	response.sendRedirect("/poll/pollList.jsp");
%>