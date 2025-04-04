package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.Item;
import dto.Question;

// 역할은 아이템 테이블의 CRUD
public class ItemDao {
	public void insertItem(Item item) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		// 입력이지만 키값을 받아올때 사용
		String sql = "insert into item(qnum, inum, content) values (?,?,?)";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, item.getQnum());
		stmt.setInt(2, item.getInum());
		stmt.setString(3, item.getContent());
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("ItemDao.insertItem - 입력성공");
		} else {
		
			System.out.println("ItemDao.insertItem - 입력실패");
		}
		conn.close();
	}
	
	public void deleteItem(int qnum) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "delete from item where qnum = ?";
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnum);
		stmt.executeUpdate();
				
		conn.close();
	}
	
    public Item selectItemByQnum(int qnum) throws ClassNotFoundException, SQLException {
        Item item = null;

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
        
        String sql = "SELECT * FROM item WHERE qnum = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, qnum);

        
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
        	item = new Item();
        	item.setQnum(rs.getInt("qnum"));
        	item.setInum(rs.getInt("inum"));
        	item.setContent(rs.getString("content"));
        }
        
        conn.close();
        return item;
    }
    
    public List<Item> selectItemsByQnum(int qnum) throws SQLException {
        List<Item> itemList = new ArrayList<>();
        String sql = "select qnum, inum, content, count from item where qnum = ? order by inum asc";
        
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, qnum);
        
        ResultSet rs = stmt.executeQuery();
        
        while (rs.next()) {
            Item item = new Item();
            item.setQnum(rs.getInt("qnum"));
            item.setInum(rs.getInt("inum"));
            item.setContent(rs.getString("content"));
            item.setCount(rs.getInt("count"));
            
            itemList.add(item);
        }
        
        conn.close(); // 연결 종료
        return itemList;
    }
    
    public int updateItem(int qnum, int inum, String content) throws ClassNotFoundException, SQLException {
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    
	    String sql = "UPDATE item SET content = ? WHERE qnum = ? AND inum = ?";
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
	    
	    stmt = conn.prepareStatement(sql);
	    stmt.setString(1, content);
	    stmt.setInt(2, qnum);
	    stmt.setInt(3, inum);
	    
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
    
    public void updateItemCountPlus(int inum, int qnum) throws ClassNotFoundException, SQLException {
    	Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    
	    String sql = "UPDATE item SET count = count+1 where inum = ? and qnum = ?";
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
	    
	    stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, inum);
	    stmt.setInt(2, qnum);
	    int row = stmt.executeUpdate();
	    if(row == 1) {
	    	System.out.println("ItemDao.updateItemCountPlus : 입력 성공");
	    } else {
	    	System.out.println("ItemDao.updateItemCountPlus : 입력 실패");
	    }
	}
    
    public int selectItemCountByQnum(int qnum) throws ClassNotFoundException, SQLException {
    	int count = 0;
    	Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		PreparedStatement stmt = null;
		ResultSet rs  = null;
		
		String sql = "select sum(count) cnt from item group by qnum having qnum = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnum);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			count = rs.getInt("cnt");
		}
		return count;
    	
    }
}