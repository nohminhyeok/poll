<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
    // qnum 파라미터를 통해 해당 설문 번호를 가져옴
    int qnum = Integer.parseInt(request.getParameter("qnum"));
	int num = Integer.parseInt(request.getParameter("num"));


	 
    // QuestionDao와 ItemDao 객체 생성
    ItemDao itemDao = new ItemDao();
    List<Item> itemList = itemDao.selectItemsByQnum(qnum);
    // qnum에 해당하는 항목들 가져오기
	int maxInum = itemList.stream().mapToInt(Item::getInum).max().orElse(Integer.MIN_VALUE);
	System.out.println("Max Inum: " + maxInum);
    
    // 추가적으로 QuestionDao를 통해 설문지 정보를 가져올 수 있습니다.
    QuestionDao questionDao = new QuestionDao();
    Question question = questionDao.selectQuestionByNum(num);  // 설문지 정보 가져오기
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>설문지 수정</title>
</head>
<body>
    <h1>설문지 수정</h1>
    <form method="post" action="/poll/updatePollAction.jsp">
        <table border="1">
            <tr>
                <td>질문</td>			
                <td colspan="2">
                    <input type="text" name="title" value="<%= question.getTitle() %>">
                </td>			
            </tr>    
			<tr>
			    <td rowspan="<%=maxInum + 1%>">항목</td> <!--  if문 쓰고 max를 다른 값으로 넣어서 해보자 -->
			    <%
			    	for	(Item item : itemList) {
			    %>
			</tr>
			    <tr>
			    	<td>
			        <input type="hidden" name="qnum" value="<%=item.getQnum()%>">
			        <input type="hidden" name="inum" value="<%=item.getInum()%>">
			    	<input type="text" name="content" value="<%= item.getContent()%>">
			    	<input type="text">
			    	</td>
				<%
			    	}
				%>  
			    </tr>
            <tr>
                <td>시작일</td>
                <td><input type="date" name="startdate" value="<%=question.getStartdate()%>"></td>
            </tr>
            <tr>
                <td>종료일</td>
                <td><input type="date" name="enddate" value="<%=question.getEnddate()%>" readonly></td>
            </tr>
            <tr>
                <td>복수투표</td>
                <td>
                    <input type="radio" name="type" value="1" <%=question.getType() == 1 ? "checked" : "" %>> yes
                    <input type="radio" name="type" value="0" <%=question.getType() == 0 ? "checked" : "" %>> no
                </td>
            </tr>
        </table>
        <button type="submit">수정하기</button>
        <input type="hidden" name="num" value="<%=question.getNum()%>">
    </form>
</body>
</html>