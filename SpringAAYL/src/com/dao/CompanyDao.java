package com.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCountCallbackHandler;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository
public class CompanyDao {
	@Autowired
	JdbcTemplate jdbcTemplate;

	public CompanyDao() {
	}

	public CompanyDao(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public String validateLogin(String email, String passWord) {
		System.out.println("entered password" + passWord);
		try {
			String sql = "select password from users_16329 where email='" + email + "'";
			String pass = jdbcTemplate.queryForObject(sql, String.class);
			String sql1 = "select firstname from users_16329 where email='" + email + "'";
			String name = jdbcTemplate.queryForObject(sql1, String.class);
			System.out.println("namedasg" + name);
			System.out.println("password" + pass);
			if (pass.equals(passWord)) {
				return name;
			} else {
				return null;
			}
		} catch (Exception e) {
			return null;
		}
	}

	public String changePassWord(String user, String opass, String npass) {
		System.out.println("inside changepassword");
		System.out.println("new password" + npass);
		String sql = "select password from users_16329 where email='" + user + "'";
		String pass = jdbcTemplate.queryForObject(sql, String.class);
		if (pass.equals(opass)) {
			String sql1 = "update users_16329 set password=? where email=?";
			int bl = jdbcTemplate.update(sql1, npass, user);
			System.out.println("b1:" + bl);
			if (bl > 0)
				return "Successfully updated";
			else
				return "Unsuccessful update";

		} else
			return "failure";
	}

	public String register(String email, String passWord, String firstName, String lastName, String mobileNumber) {
		System.out.println("inside register");
		String sql = "insert into users_16329 values(?,?,?,?,?)";
		try {
			int b1 = jdbcTemplate.update(sql, firstName, lastName, email, mobileNumber, passWord);

			if (b1 > 0)
				return "Registration Successful";
			else
				return "Registration unsuccessful";
		} catch (DuplicateKeyException e) {
			return "Duplicate email id";
		} catch (EmptyResultDataAccessException e) {
			return "Duplicate email id2";
		}
	}

	public List<Map> getCompanyAddress(String user) {
		System.out.println("inside getcomapanyaddress");
		String sql = "select * from users_16329_details where email='" + user + "'";
		return jdbcTemplate.query(sql, new RowMapper<Map>() {
			@Override
			public Map mapRow(ResultSet rs, int rownumber) throws SQLException {
				Map map = new HashMap();
				map.put("f1", rs.getString(2));
				map.put("f2", rs.getString(3));
				map.put("f3", rs.getString(4));
				return map;
			}
		});
	}

	public String selectAddress(String name) {
		System.out.println("name:" + name);
		String sql = "select baddress from users_16329_details where cname like '" + name + "%'";
		System.out.println(sql);
		String str1 = "";
		try {
			return jdbcTemplate.queryForObject(sql, String.class);
		} catch (Exception e) {
			return "No data found";
		}
	}

	public List<String> getCompanyList(String user) {
		System.out.println("inside getcomanylist");
		String sql = "select cname from users_16329_details where email != '"+user+"'";
		List<String> lt = jdbcTemplate.queryForList(sql, String.class);
		return lt;
	}

	public List<String> getItemsList() {
		System.out.println("inside getItemsList");
		String sql = "select iname from users_16329_items";
		List<String> l1 = jdbcTemplate.queryForList(sql, String.class);
		System.out.println("list1" + l1);
		return l1;
	}

	public String setAnswerForSec(String user, String answer) {
		System.out.println("inside set answer");
		String sql = "select answer from users_16329_forgot where email='" + user + "'";
		String str = jdbcTemplate.queryForObject(sql, String.class);
		if (str == null) {
			System.out.println("inside if");
			String sql1 = "insert into users_16329_forgot values(?,?)";
			if (jdbcTemplate.update(sql1, user, answer) > 0) {
				return "Successful updation";
			} else
				return "Can not insert";
		} else {
			System.out.println("inside else");
			String sql2 = "update users_16329_forgot set answer=? where email='" + user + "'";
			if (jdbcTemplate.update(sql2, answer) > 0)
				return "Answer updated";
			else
				return "Can not update the answer";
		}
	}

	public String setDetails(String user, String cname, String caddress, String baddress) {
		System.out.println("inside setDetails");
		try {
			String sql1 = "insert into users_16329_details values(?,?,?,?)";
			if (jdbcTemplate.update(sql1, user, cname, caddress, baddress) > 0) {
				return "Successful updation";
			} else
				return "Can not insert11";
		} catch (Exception e) {
			e.printStackTrace();
			return "Details may be already inserted";
		}
	}

	public String selectPrice(String item) {
		System.out.println("item" + item);
		String sql = "select price from users_16329_items where iname like '" + item + "%'";
		System.out.println(sql);
		String str1 = "";
		try {
			return jdbcTemplate.queryForObject(sql, String.class);
		} catch (Exception e) {
			return "No data found";
		}
	}

	public String resetPass(String email, String answer, String npass) {
		String sql = "select answer from users_16329_forgot where email='" + email + "'";
		try {
			String str = jdbcTemplate.queryForObject(sql, String.class);
			if (str.equals(answer)) {
				String sql1 = "update users_16329 set password=? where email=?";
				if (jdbcTemplate.update(sql1, npass, email) > 0){
					String fname = jdbcTemplate.queryForObject("select firstname from users_16329 where email='"+email+"'", String.class);
					return fname;
				
				}
			}
			return "Unsuccessful";
		} catch (Exception e) {
			e.printStackTrace();
			return "Unsuccessful";
		} 

	}

	public String saveInvoiceDetails(String user, int id, String date, String caddress, String baddress, int totalprice) {
		String sql = "insert into users_16329_invoices values(?,?,?,?,?,?)";
		System.out.println("iddd value" + totalprice);
		try {
			if (jdbcTemplate.update(sql,user, id, date,caddress,baddress,totalprice) > 0) {
				return "success";
			}
			return "failed";
		} catch (Exception e) {
			e.printStackTrace();
			return "exception";
		}
	}

	public int getInvoiceId() {
		String sql = "select nvl(max(id),0) from users_16329_invoices";
		int i = jdbcTemplate.queryForObject(sql, Integer.class);
		System.out.println("value of i" + i);
		return i;
	}

}
