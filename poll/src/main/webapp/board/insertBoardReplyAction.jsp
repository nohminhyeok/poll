<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%
	// controller layer(request 분석, model 호출)
	String name = request.getParameter("name");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String pass = request.getParameter("pass");
	int ref = Integer.parseInt(request.getParameter("ref"));
	int pos = Integer.parseInt(request.getParameter("pos"));
	int depth = Integer.parseInt(request.getParameter("depth"));
	
	// Form 입력타입(DTO 사용가능)으로 묶음
	Board board = new Board();
	board.setName(name);
	board.setSubject(subject);
	board.setContent(content);
	
	// 답글에 필요한 속성
	board.setRef(ref);
	board.setPos(pos);
	board.setDepth(depth);
	
	board.setPass(pass);
	board.setIp(request.getRemoteAddr()); // 다른 API 이용하여 ip 구하는 경우가 많다.
	// board.setName(request.getParameter(name)); <<  이런식도 가능하나 값 확인을 위해
	
	
	// logging(디버깅,...)
	System.out.println(board.toString()); 
	// System.out.println(board); 오버로딩이 되어 있어서 이렇게 작성 가능
	
	BoardDao boardDao = new BoardDao();
	boardDao.insertBoardReply(board);
	
	// view 가 있다면 연결(디스패츠 / include, forward) , view 가 없다면 클라이언트에 다른 요청 강제(redirect)
	response.sendRedirect("/poll/board/boardList.jsp");
%>