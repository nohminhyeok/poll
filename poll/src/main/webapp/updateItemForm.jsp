<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "model.*" %>
<%@ page import = "dto.*" %>
<%@ page import = "java.util.*" %>
<%
	
	// 문제에 대한 Item, Question 출력
	// type = 1 이면 복수투표 가능 (checkbox)
	// type = 0 이면 복수투표 불가능 (radio)
	int qnum = Integer.parseInt(request.getParameter("qnum"));
	
	// Controller Layer(request분석 + medel Layer 호출/반환)
	// 1) QuestionOne
	QuestionDao questionDao = new QuestionDao();
	Question question = questionDao.selectQuestionByNum(qnum);
	// 2) QuestionOne의 Itemlist
	ItemDao itemDao = new ItemDao();
	List<Item> itemList = itemDao.selectItemsByQnum(qnum);
%>

<!-- view Layer -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>투표하기</title>
</head>
<body>
	<form action="/poll/updateItemAction.jsp" method="post">
		<input type="hidden" name="qnum" value="<%=qnum%>">
		<table border="1">
			<tr>
				<td>
					Q : <%=question.getTitle()%>
					(<%=question.getType() == 1 ? "복수투표 가능" : "복수투표 불가능" %>)
				</td>
			</tr>
			<tr>
				<td>
					<%
						for(Item i : itemList) {
					%>
							<div>
								<%
									if(question.getType()==0){ // type = radio
								%>
										<input type="radio" name="inum" value="<%=i.getInum()%>">									
								<%
									} else { // type = checkbox
								%>
										<input type="checkbox" name="inum" value="<%=i.getInum()%>">
								<%
									}
								%>										
								<%=i.getContent()%>
								<hr>
							</div>
					<%
						}
					%>							
				</td>
			</tr>
		</table>
		<button type="submit">투표</button>
	</form>
</body>
</html>