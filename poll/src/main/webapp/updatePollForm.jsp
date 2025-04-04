<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	System.out.println("tnum : "+num);

	 
    // QuestionDao와 ItemDao 객체 생성
    ItemDao itemDao = new ItemDao();
    List<Item> itemList = itemDao.selectItemsByQnum(num);

    
    // 추가적으로 QuestionDao를 통해 설문지 정보를 가져올 수 있습니다.
    QuestionDao questionDao = new QuestionDao();
    Question question = questionDao.selectQuestionByNum(num);  // 설문지 정보 가져오기
    
	int i = 1;
    /*
    String[] content = request.getParameterValues("content");
    ArrayList<String> contentList = new ArrayList<>();
    for	(Item item : itemList) {
    	
    }
    System.out.println(contentList);
    */
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
                <td rowspan="8">항목</td> 
                <%
                    // itemList를 반복하여 항목을 출력
                    for (Item item : itemList) {
                        
                %>
                        <td>
								    <input type="hidden" name="num" value='<%=num%>'>
                            <%=i%>) <input type="text" name="content" value="<%= item.getContent() %>">
                        </td>
                <%
                        // i 값이 2의 배수일 때, 테이블 행을 새로 시작
                        if (i % 2 == 0) {
                %>
                            </tr><tr> <!-- 행 끝내고 새로운 행 시작 -->
                <%
                        }
                        i++; // 항목 번호 증가
                    }

                    // 남은 항목이 있을 경우 빈 항목을 추가
                    while (i <= 8) {
                %>
                        <td><%=i%>) <input type="text" name="content"></td>
                <%
                        if (i % 2 == 0) {
                %>
                            </tr><tr> <!-- 행 끝내고 새로운 행 시작 -->
                <%
                        }
                        i++;
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
    </form>
</body>
</html>