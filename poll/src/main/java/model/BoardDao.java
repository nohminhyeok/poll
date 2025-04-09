package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import dto.Board;
import dto.Paging;

public class BoardDao {
	public ArrayList<Board> selectBoardList(Paging p, String searchWord) throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select * from board where subject like ? order by ref desc, pos asc limit ?, ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+searchWord+"%");
		stmt.setInt(2, p.getBeginRow());
		stmt.setInt(3, p.getRowPerPage());
		rs = stmt.executeQuery();
		
		ArrayList<Board> list = new ArrayList<>();
		// rs -> list
		while(rs.next()) {
			Board b = new Board();
			b.setNum(rs.getInt("num"));
			b.setName(rs.getString("name"));
			b.setSubject(rs.getString("subject"));
			b.setPos(rs.getInt("pos"));
			b.setRef(rs.getInt("ref"));
			b.setDepth(rs.getInt("depth"));
			b.setCount(rs.getInt("count"));
			list.add(b);
		}
		conn.close();
		return list;
	}
	// 새글 입력
	public void insertBoard(Board b) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null; // 입력 직후 pk값을 반환받기 위해
		String sql = "insert into board(name, subject, content, ref, pass, ip) values(?,?,?,?,?,?)";
	
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		conn.setAutoCommit(false); //executeUpdate()시에 자동 커밋기능을 false
		
		stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); 
		stmt.setString(1, b.getName());
		stmt.setString(2, b.getSubject());
		stmt.setString(3, b.getContent());
		stmt.setInt(4, b.getRef());
		stmt.setString(5, b.getPass());
		stmt.setString(6, b.getIp());
		
		
		// ref==0이면 입력직후 pk를 반환받기 위해
		int row = stmt.executeUpdate(); 
		
		rs = stmt.getGeneratedKeys();
		int pk = 0;
		if(rs.next()) {
			pk = rs.getInt(1);
		}
		System.out.println("BoardDao.insertBoard#pk :" +pk);
		

		// ref ==0 이면 입력 직후에 pk값을 받아서 ref값을 동일하게
		PreparedStatement stmt2 = null;
		String sql2 = "update board set ref = ? where num = ?";
		
		stmt2 = conn.prepareStatement(sql2);
		// update 쿼리가 실패하면 이전의 insert도 롤백 : conn.rollback();
		
		stmt2.setInt(1, pk);
		stmt2.setInt(2, pk);
		stmt2.executeUpdate();
			
		conn.commit(); // con.setAutoCommit(false); 코드때문에 필요함
		conn.close();
	}
	
	// 답글 입력
	public Board selectBoardOne(int num) throws ClassNotFoundException, SQLException {
		Board b = null;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select * from board where num = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		rs = stmt.executeQuery();
		
		ArrayList<Board> list = new ArrayList<>();
		// rs -> list
		if(rs.next()) {	
			b = new Board();
			b.setNum(rs.getInt("num"));
			b.setName(rs.getString("name"));
			b.setSubject(rs.getString("subject"));
			b.setContent(rs.getString("content"));
			b.setPos(rs.getInt("pos"));
			b.setRef(rs.getInt("ref"));
			b.setDepth(rs.getInt("depth"));
			b.setRegdate(rs.getString("regdate"));
			b.setIp(rs.getString("ip"));
			b.setCount(rs.getInt("count"));
		}
		conn.close();
		return b;
	}
	
	public void insertBoardReply(Board b) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		// 트랜잭션(2개 이상의(CUD)쿼리를 한 묶음처럼 처리하고 싶을때
		conn.setAutoCommit(false); //executeUpdate()시에 자동 커밋기능을 false
		// ref가 같고 pos값이 현재 글보다 크거나 같다면 pos = pos+1
		PreparedStatement stmt2 = null;
		
		
		String sql2 = "update board set pos = pos+1 where ref=? and pos >= ?";
		stmt2=conn.prepareStatement(sql2);
		stmt2.setInt(1, b.getRef());
		stmt2.setInt(2, b.getPos());
		int row2 = stmt2.executeUpdate();

		
		//답글 입력
		String sql = "insert into board(name, subject, content, ref, pos, depth, pass, ip) values(?,?,?,?,?,?,?,?)";
		PreparedStatement stmt = null;		
		stmt = conn.prepareStatement(sql); 
		stmt.setString(1, b.getName());
		stmt.setString(2, b.getSubject());
		stmt.setString(3, b.getContent());
		
		stmt.setInt(4, b.getRef());
		stmt.setInt(5, b.getPos());
		stmt.setInt(6, b.getDepth());
		
		stmt.setString(7, b.getPass());
		stmt.setString(8, b.getIp());
		
		int row = stmt.executeUpdate(); 
		
		
		conn.commit(); // con.setAutoCommit(false); 코드때문에 필요함
		conn.close();
	}
	
	public void deleteBoard(int num) throws ClassNotFoundException, SQLException {
	    Class.forName("com.mysql.cj.jdbc.Driver");

	    // 연결 객체 선언
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
	    PreparedStatement stmt1 = null;
	    PreparedStatement stmt2 = null;

	    // 트랜잭션 시작
	    conn.setAutoCommit(false);

	    // 1. DELETE 쿼리: 특정 num에 해당하는 게시글 삭제
	    String sql1 = "DELETE FROM board WHERE num = ?";
	    stmt1 = conn.prepareStatement(sql1);
	    stmt1.setInt(1, num);
	    stmt1.executeUpdate();

	    // 2. UPDATE 쿼리: 삭제된 부모글(ref)과 같은 ref를 가진 다른 게시글들의 content를 변경
	    String sql2 = "UPDATE board SET subject = '게시글이 삭제된 답글입니다.' WHERE ref = ?";
	    stmt2 = conn.prepareStatement(sql2);
	    stmt2.setInt(1, num); // 삭제된 부모글의 ref 값을 사용
	    stmt2.executeUpdate();

	    // 트랜잭션 커밋
	    conn.commit();

	    // 자원 해제
	    stmt1.close();
	    stmt2.close();
	    conn.close();
	}
	
	public int updateBoard(String name, String subject, String content, int num , int pass) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		String sql = "update board set name = ?, subject = ?, content =? where num = ? and pass = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, name);
		stmt.setString(2, subject);
		stmt.setString(3, content);
		stmt.setInt(4, num);
		stmt.setInt(5, pass);
		
	    int rowsUpdated = stmt.executeUpdate(); // 수정된 행의 개수 반환
	    
	    // 업데이트된 행이 있다면
	    if (rowsUpdated > 0) {
	        System.out.println("질문 정보가 성공적으로 업데이트되었습니다.");
	    } else {
	        System.out.println("수정에 실패하였습니다. 비밀번호를 확인해주세요.");
	    }
	    
	    // 연결 종료
	    conn.close();
		return rowsUpdated;
	}
	
	public int getTotalCount(String searchWord) throws ClassNotFoundException, SQLException {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		
		String sql = " SELECT COUNT(*) as cnt FROM board WHERE subject LIKE ?";
		
		stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, "%"+searchWord+"%");
		
		rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt(1);
		}
		
		conn.close();
		
		return row;
	}
	
}
