package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import dto.Paging;
import dto.Question;

// Table : question crud
public class QuestionDao {
	
	public ArrayList<Question> selectQuestionList(Paging p) throws ClassNotFoundException, SQLException {
		ArrayList<Question> list = new ArrayList<>();
	       
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
        
        String sql = "SELECT * FROM question ORDER BY num LIMIT ?, ?";
        PreparedStatement stmt = conn.prepareStatement(sql);

        stmt.setInt(1, p.getBeginRow());
        stmt.setInt(2, p.getRowPerPage()); 
        
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            Question question = new Question();
            question.setNum(rs.getInt("num"));
            question.setTitle(rs.getString("title"));
            question.setStartdate(rs.getString("startdate"));
            question.setEnddate(rs.getString("enddate"));
            question.setType(rs.getInt("type"));
            list.add(question);
        }
        conn.close();
        return list;
    }
	
	
	// 입력 후 자동으로 생성된 키값을 반환값
	public int insertQuestion(Question question) throws ClassNotFoundException, SQLException {
		int pk = 0;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		// 입력이지만 키값을 받아올때 사용
		ResultSet rs = null;
		String sql = "insert into question(title, startdate, enddate, type) values(?,?,?,?)";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		// Statement.RETURN_GENERATED_KEYS 옵션 : insert 후 select max(pk) from ... 실행
		stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		stmt.setString(1, question.getTitle());
		stmt.setString(2, question.getStartdate());
		stmt.setString(3, question.getEnddate());
		stmt.setInt(4, question.getType());
		int row = stmt.executeUpdate(); // insert
		rs = stmt.getGeneratedKeys(); // select max(num) from question
		if(rs.next()) {
			pk = rs.getInt(1);
		}
		conn.close();
		return pk;
	}
	
	public void deleteQuestion(int num) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		// 입력이지만 키값을 받아올때 사용
		ResultSet rs = null;
		String sql = "delete from question where num = ? ";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		stmt = conn.prepareStatement(sql);	
		stmt.setInt(1, num);
	    stmt.executeUpdate();
		conn.close();
	}
	
	public int updateQuestion(int num, String title, String startDate, String endDate, int type) throws ClassNotFoundException, SQLException {

	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    
	    String sql = "UPDATE question SET title = ?, startdate = ?, enddate = ?, type = ? WHERE num = ?";
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
	    
	    // UPDATE 쿼리 실행
	    stmt = conn.prepareStatement(sql);
	    stmt.setString(1, title);
	    stmt.setString(2, startDate);
	    stmt.setString(3, endDate);
	    stmt.setInt(4, type);
	    stmt.setInt(5, num);
	    
	    int rowsUpdated = stmt.executeUpdate(); // 수정된 행의 개수 반환
	    
	    // 업데이트된 행이 있다면
	    if (rowsUpdated > 0) {
	        System.out.println("질문 정보가 성공적으로 업데이트되었습니다.");
	    } else {
	        System.out.println("업데이트된 질문이 없습니다. num 값을 확인해보세요.");
	    }
	    
	    // 연결 종료
	    conn.close();
		return rowsUpdated;
	}
	
    public Question selectQuestionByNum(int num) throws ClassNotFoundException, SQLException {
        Question question = null;

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
        
        String sql = "SELECT * FROM question WHERE num = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, num);
        
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            question = new Question();
            question.setNum(rs.getInt("num"));
            question.setTitle(rs.getString("title"));
            question.setStartdate(rs.getString("startdate"));
            question.setEnddate(rs.getString("enddate"));
            question.setType(rs.getInt("type"));
        }
        
        conn.close();
        return question;
    }
    
    public int updateQuestion2(int num, String endDate) throws ClassNotFoundException, SQLException {

	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    
	    String sql = "UPDATE question SET enddate = ? WHERE num = ?";
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
	    
	    // UPDATE 쿼리 실행
	    stmt = conn.prepareStatement(sql);
	    stmt.setString(1, endDate);
	    stmt.setInt(2, num);
	    
	    int rowsUpdated = stmt.executeUpdate(); // 수정된 행의 개수 반환
	    
	    // 업데이트된 행이 있다면
	    if (rowsUpdated > 0) {
	        System.out.println("질문 정보가 성공적으로 업데이트되었습니다.");
	    } else {
	        System.out.println("업데이트된 질문이 없습니다. num 값을 확인해보세요.");
	    }
	    
	    // 연결 종료
	    conn.close();
		return rowsUpdated;
	}
}