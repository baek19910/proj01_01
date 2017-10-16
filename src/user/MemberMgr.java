package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import com.mysql.fabric.xmlrpc.base.Member;
public class MemberMgr {

	private DBConnectionMgr pool;

	public MemberMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	// ID 중복확인
	public boolean checkId(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select id from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			flag = pstmt.executeQuery().next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	// Nickname 중복확인
		public boolean checknick(String nickname) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "select nickname from member where nickname=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, nickname);
				flag = pstmt.executeQuery().next();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return flag;
		}

	// 회원가입
	public boolean insertMember(String id, String pw, String name, String nickname, String gender, String phon, String email, String zipcode, String address) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean result = false;
		try {

			con = pool.getConnection();
			sql = "insert into member (id,pw,name,nickname,gender,email,zipcode,address,phon,jointime)"
					+ "values(?,?,?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,id);
			pstmt.setString(2, pw);
			pstmt.setString(3, name);
			pstmt.setString(4, nickname);
			pstmt.setString(5, gender);
			pstmt.setString(6, email);
			pstmt.setString(7, zipcode);
			pstmt.setString(8, address);
			pstmt.setString(9, phon);
			pstmt.executeUpdate();
			result = true;
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return result;
	}

	// /로그인
	public boolean loginMember(String id, String pw) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select id from member where id=? and pw=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}

	/*************
	 * ch16 필요한 메소드
	 ************/

	// 회원정보가져오기
	public Vector<MemberBean> getMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector<MemberBean> vlist = new Vector<MemberBean>();
		try {
			con = pool.getConnection();
			String sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				MemberBean bean = new MemberBean();
				bean.setId(rs.getString("id"));
				bean.setPw(rs.getString("pw"));
				bean.setName(rs.getString("name"));
				bean.setNickname(rs.getString("nickname"));
				bean.setGender(rs.getString("gender"));
				bean.setEmail(rs.getString("email"));
				bean.setZipcode(rs.getString("zipcode"));
				bean.setAddress(rs.getString("address"));
				bean.setPhon(rs.getString("phon"));
				bean.setJointime(rs.getString("jointime"));
				bean.setAdmin(rs.getString("admin"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return vlist;
	}

	// 회원정보수정
	public boolean updateMember(MemberBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean result = false;
		try {
			con = pool.getConnection();
			String sql = "update member set pw=?,nickname=?, email=?,zipcode=?,address=?,phon=? where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getPw());
			pstmt.setString(2, bean.getNickname());
			pstmt.setString(3, bean.getEmail());
			pstmt.setString(4, bean.getZipcode());
			pstmt.setString(5, bean.getAddress());
			pstmt.setString(6, bean.getPhon());
			pstmt.setString(7, bean.getId());
			pstmt.executeUpdate();
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return result;
	}

	////////////// 회원 목록 시작 //////////////
	public Vector<MemberBean> mtdList() {
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MemberBean> vlist = new Vector<MemberBean>();
		try {
			con = pool.getConnection();
			sql = "select * from member order by no desc;";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				MemberBean bean = new MemberBean();
				bean.setNo(rs.getInt(1));
				bean.setId(rs.getString(2));
				bean.setPw(rs.getString(3));
				bean.setName(rs.getString(4));
				bean.setNickname(rs.getString(5));
				bean.setGender(rs.getString(6));
				bean.setEmail(rs.getString(7));
				bean.setZipcode(rs.getString(8));
				bean.setAddress(rs.getString(9));
				bean.setPhon(rs.getString(10));
				bean.setJointime(rs.getString(11));
				bean.setAdmin(rs.getString(12));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, stmt, rs);
		}
		return vlist;
	}
	////////////// 회원 목록 끝 //////////////
	
	
	public Vector<MemberBean> newList() {
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MemberBean> vlist = new Vector<MemberBean>();
		try {
			con = pool.getConnection();
			sql = "select * from member order by jointime desc limit 3;";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				MemberBean bean = new MemberBean();
				bean.setNo(rs.getInt(1));
				bean.setId(rs.getString(2));
				bean.setPw(rs.getString(3));
				bean.setName(rs.getString(4));
				bean.setNickname(rs.getString(5));
				bean.setGender(rs.getString(6));
				bean.setEmail(rs.getString(7));
				bean.setZipcode(rs.getString(8));
				bean.setAddress(rs.getString(9));
				bean.setPhon(rs.getString(10));
				bean.setJointime(rs.getString(11));
				bean.setAdmin(rs.getString(12));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, stmt, rs);
		}
		return vlist;
	}

	@SuppressWarnings("resource")
	public boolean deleteMember(String id, String pw) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		String dbpw = null;
		ResultSet rs = null;
		MemberBean bean=null;
		boolean result = false;
		try {
			con = pool.getConnection();
			sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {

				dbpw = rs.getString("pw");
				if (dbpw.equals(pw)) {
					String delsql = "delete from member where id=?";
					pstmt = con.prepareStatement(delsql);
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					mtdIns2(bean);
					result = true;
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return result;
	}
	
//////////////탈퇴 회원 목록 시작 //////////////
public Vector<DrawBean> mtdWithdraw() {
Connection con = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
Vector<DrawBean> vlist = new Vector<DrawBean>();
try {
	con = pool.getConnection();
	sql = "select * from memdraw order by no asc;";
	stmt = con.createStatement();
	rs = stmt.executeQuery(sql);
	while (rs.next()) {
		DrawBean bean = new DrawBean();
		bean.setNo(rs.getInt(1));
		bean.setId(rs.getString(2));
		bean.setPw(rs.getString(3));
		bean.setName(rs.getString(4));
		bean.setNickname(rs.getString(5));
		bean.setGender(rs.getString(6));
		bean.setEmail(rs.getString(7));
		bean.setZipcode(rs.getString(8));
		bean.setAddress(rs.getString(9));
		bean.setPhon(rs.getString(10));
		bean.setAdmin(rs.getString(11));
		bean.setJointime(rs.getString(12));
		bean.setDrawtime(rs.getString(13));
		vlist.add(bean);
	}
} catch (Exception e) {
	e.printStackTrace();
} finally {
	pool.freeConnection(con, stmt, rs);
}
return vlist;
}
////////////// 탈퇴 회원 목록 끝 //////////////
	
//////////////회원 뷰 보기 시작 //////////////
public Vector<MemberBean>  mtdInfo2(String id) {
Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String sql = null;
Vector<MemberBean> vlist = new Vector<MemberBean>();

try {
	con = pool.getConnection();
	sql = "select * from member where id = ?;";
	pstmt = con.prepareStatement(sql);
	pstmt.setString(1, id);
	rs = pstmt.executeQuery();
	if (rs.next()) {
		MemberBean bean = new MemberBean();
		bean.setNo(rs.getInt(1));
		bean.setId(rs.getString(2));
		bean.setPw(rs.getString(3));
		bean.setName(rs.getString(4));
		bean.setNickname(rs.getString(5));
		bean.setGender(rs.getString(6));
		bean.setEmail(rs.getString(7));
		bean.setZipcode(rs.getString(8));
		bean.setAddress(rs.getString(9));
		bean.setPhon(rs.getString(10));
		bean.setJointime(rs.getString(11));
		vlist.add(bean);
	}
} catch (Exception e) {
	e.printStackTrace();
} finally {
	pool.freeConnection(con, pstmt, rs);
}
return vlist;
}

 //회원탈퇴
public boolean mtdOut(String id2) {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	MemberBean beans = null;
	boolean flag = false;

	try {
		con = pool.getConnection();
		sql = "select * from member where id = ?;";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id2);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			beans = new MemberBean();
			beans.setId(rs.getString(2));
			beans.setPw(rs.getString(3));
			beans.setName(rs.getString(4));
			beans.setNickname(rs.getString(5));
			beans.setGender(rs.getString(6));
			beans.setEmail(rs.getString(7));
			beans.setZipcode(rs.getString(8));
			beans.setAddress(rs.getString(9));
			beans.setPhon(rs.getString(10));
			beans.setJointime(rs.getString(11));
			
			mtdDel(id2);
			mtdIns2(beans);
			
			flag = true;
			
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		pool.freeConnection(con, pstmt, rs);
	}
	return flag;
}

public void mtdDel(String id2) {
	Connection con = null;
	PreparedStatement pstmt = null;
	String sql = null;
	try {

		con = pool.getConnection();
		sql = "delete from member where id=?;";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id2);			
		pstmt.executeUpdate();
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		pool.freeConnection(con, pstmt);
	}
	
}

public void mtdIns2(MemberBean beans) {
	Connection con = null;
	PreparedStatement pstmt = null;
	String sql = null;
	try {

		con = pool.getConnection();
		sql = "insert into memdraw (id,pw,name,nickname,Gender,email,zipcode,Address,Phon,joinTime,drawtime)"
				+ "values(?,?,?,?,?,?,?,?,?,?,now())";
		pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, beans.getId());
		pstmt.setString(2, beans.getPw());
		pstmt.setString(3, beans.getName());
		pstmt.setString(4, beans.getNickname());
		pstmt.setString(5, beans.getGender());
		pstmt.setString(6, beans.getEmail());
		pstmt.setString(7, beans.getZipcode());
		pstmt.setString(8, beans.getAddress());
		pstmt.setString(9, beans.getPhon());
		pstmt.setString(10, beans.getJointime());
		pstmt.executeUpdate();
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		pool.freeConnection(con, pstmt);
	}
	
	
}


	
}


