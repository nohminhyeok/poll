<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "model.*" %>
<%@ page import = "dto.*" %>
<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	
	ImageDao imageDao = new ImageDao();
	Paging p = new Paging();
	p.setCurrentPage(currentPage);
	p.setRowPerPage(10);
	ArrayList<Image> list = imageDao.selectImageList(p);
	
	int totalRows = 0;
  
 	int totalPages = p.getLastPage(totalRows);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<%
		for(Image i : list) {
	%>
			<table border="1">
				<tr>
					<td><%=i.getMemo()%></td>
				</tr>
				<tr>
					<td>
						<img src="/poll/upload/<%=i.getFilename()%>">
					</td>				
				</tr>
				<tr>
					<td>
						<a href="/poll/imageBoard/deleteImage.jsp?num=<%=i.getNum()%>&filename=<%=i.getFilename()%>">삭제</a>
					</td>
				</tr>
			</table>
			<hr>
	<%		
		}
	%>
</body>
</html>