package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
	
	public ArrayList<Item> deleteItem(int qnum) throws ClassNotFoundException, SQLException {
		ArrayList<Item> itemList = new ArrayList<>();
		
		Class.forName("com.mysql.cj.jdbc.Driver");

		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		PreparedStatement stmt = null;
		ResultSet rs  = null;
		
		String sql = "select * from item where qnum = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnum);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			Item item = new Item();
			item.setQnum(rs.getInt("qnum"));
			itemList.add(item);
		}
		
	    String sql1 = "DELETE FROM item WHERE qnum = ? AND count = 0";
	    stmt = conn.prepareStatement(sql1);
	    stmt.setInt(1, qnum);
	    stmt.executeUpdate();
		
		conn.close();
		return itemList;
	}
}
