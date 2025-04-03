<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.*"%>
<%
    // 요청 파라미터 받아오기
    int num = Integer.parseInt(request.getParameter("num"));  // 질문 번호
    String title = request.getParameter("title");
    String startdate = request.getParameter("startdate");
    String enddate = request.getParameter("enddate");
    int type = Integer.parseInt(request.getParameter("type"));
    String content = request.getParameter("content");
    int qnum = Integer.parseInt(request.getParameter("qnum"));
    int inum = Integer.parseInt(request.getParameter("inum"));
    
    // Question 객체 생성 후 값 설정
    Question question = new Question();
    question.setTitle(title);
    question.setStartdate(startdate);
    question.setEnddate(enddate);
    question.setType(type);
    
    
    Item item = new Item();
    item.setContent(content);
    item.setQnum(qnum);
    item.setInum(inum);
    // QuestionDao 객체 생성하여 업데이트 메소드 호출 후 qnum 반환
    QuestionDao questionDao = new QuestionDao();
    questionDao.updateQuestion(num, title, startdate, enddate, type);  // qnum 반환값 처리
    ItemDao itemDao = new ItemDao();
	itemDao.updateItem(qnum, inum, content);    
    // 수정 완료 후 pollList.jsp로 리다이렉트
    response.sendRedirect("/poll/pollList.jsp");
%>