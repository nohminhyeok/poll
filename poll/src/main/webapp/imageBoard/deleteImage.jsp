<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "model.*" %>
<%@ page import = "dto.*" %>
<%@ page import = "java.io.*" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String filename = request.getParameter("filename");
	
	// db 삭제
	ImageDao imageDao = new ImageDao();
	imageDao.deleteImage(num);
	
	
	
	// 파일 삭제
	String path = request.getServletContext().getRealPath("upload");
	File file = new File(path, filename); // new File 경로에 파일이 없으면 빈파일을 생성
	
	// int row = 1이면 삭제
	if(file.exists()){ // 빈 파일이 아니라면
		file.delete(); // 삭제
	}
	
	response.sendRedirect("/poll/imageBoard/imageList.jsp");
%>