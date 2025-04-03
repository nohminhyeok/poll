package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

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
		
	
}