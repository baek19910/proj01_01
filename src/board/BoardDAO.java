package board;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import user.DBConnectionMgr;

public class BoardDAO {
	private DBConnectionMgr pool;
	private static final String  SAVEFOLDER = "E:/JAVA/pradi/JSP/Proj_JSP03_03/WebContent/fileupload";
	private static final String ENCTYPE = "utf-8";
	private static int MAXSIZE = 5*1024*1024;

	public BoardDAO() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 게시판 리스트
	public Vector<BoardBean> getBoardList(String keyField, String keyWord,
			int start, int end) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BoardBean> vlist = new Vector<BoardBean>();
		try {
			con = pool.getConnection();
			if (keyWord.equals("null") || keyWord.equals("")) {
				sql = "select * from memfreelist order by ref desc, pos limit ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);//0
				pstmt.setInt(2, end);//10
			} else {
				sql = "select * from  memfreelist where " + keyField + " like ? ";
				sql += "order by ref desc, pos limit ? , ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BoardBean bean = new BoardBean();
				bean.setNo(rs.getInt("no"));
				bean.setName(rs.getString("name"));
				bean.setSubject(rs.getString("subject"));
				bean.setPos(rs.getInt("pos"));//계층형게시판 답글에 필요
				bean.setRef(rs.getInt("ref"));//계층형게시판 답글에 필요
				bean.setDepth(rs.getInt("depth"));//계층형게시판 답글에 필요
				bean.setRegdate(rs.getString("regdate"));
				bean.setIpcount(rs.getInt("ipcount"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}   
	
	// 메인에 게시판 뿌리기
		public Vector<BoardBean> getBoardList2() {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<BoardBean> vlist = new Vector<BoardBean>();
			try {
				con = pool.getConnection();
					sql = "select * from memfreelist order by no desc;";
					pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					BoardBean bean = new BoardBean();
					bean.setNo(rs.getInt("no"));
					bean.setName(rs.getString("name"));
					bean.setSubject(rs.getString("subject"));
					vlist.add(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}   
	
	//총 게시물수
	public int getTotalCount(String keyField, String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if (keyWord.equals("null") || keyWord.equals("")) {
				sql = "select count(no) from memfreelist";
				pstmt = con.prepareStatement(sql);
			} else {
				sql = "select count(no) from  memfreelist where " + keyField + " like ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	
	// 게시물 입력
	@SuppressWarnings("resource")
	public void insertBoard(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MultipartRequest multi = null;
		int filesize = 0;
		String filename = null;
		try {
			con = pool.getConnection();
			sql = "select max(no)  from memfreelist";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int ref = 1;
			if (rs.next())
				ref = rs.getInt(1) + 1;
			File file = new File(SAVEFOLDER);
			if (!file.exists())
				file.mkdirs();
			multi = new MultipartRequest(req, SAVEFOLDER,MAXSIZE, ENCTYPE,
					new DefaultFileRenamePolicy());

			if (multi.getFilesystemName("filename") != null) {
				filename = multi.getFilesystemName("filename");
				filesize = (int) multi.getFile("filename").length();
			}
			String content = multi.getParameter("content");
			if (multi.getParameter("contentType").equalsIgnoreCase("TEXT")) {
				content = UtilMgr.replace(content, "<", "&lt;");//text로 입력하면  <기호가 &lt로 바뀌어 저장되어 적용이 안되지만, html로 설정하여 저장하면 
				                                                                    //태그가 사용된다. ex) <h1>가희</h1>을 입력하면 text= &lth1>가희&lt/h1>으로 나오고
				                                                                                           // html은 태그가 적용되어 나온다.
			}
			sql = "insert memfreelist(writerid,name,nickname,content,subject,ref,pos,depth,regdate,pass,ip,ipcount,filename,filesize)";
			sql += "values(?,?,?,?,?,?,0,0,now(), ?, ?, 0, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("writerid"));
			pstmt.setString(2, multi.getParameter("name"));
			pstmt.setString(3, multi.getParameter("nickname"));
			pstmt.setString(4, content);
			pstmt.setString(5, multi.getParameter("subject"));
			pstmt.setInt(6, ref);
			pstmt.setString(7, multi.getParameter("pass"));
			pstmt.setString(8, multi.getParameter("ip"));
			pstmt.setString(9, filename);
			pstmt.setInt(10, filesize);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	// 답변에 위치값 증가
		public void replyUpBoard(int ref, int pos) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "update memgallerylist set pos = pos + 1 where ref=? and pos > ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, pos);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
		}
	
	// 게시물 리턴
	public BoardBean getBoard(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		BoardBean bean = new BoardBean();
		try {
			con = pool.getConnection();
			sql = "select * from memfreelist where no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setNo(rs.getInt("no"));
				bean.setWriterid(rs.getString("writerid"));
				bean.setName(rs.getString("name"));
				bean.setNickname(rs.getString("nickname"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setPos(rs.getInt("pos"));
				bean.setRef(rs.getInt("ref"));
				bean.setDepth(rs.getInt("depth"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setPass(rs.getString("pass"));
				bean.setIp(rs.getString("ip"));
				bean.setIpcount(rs.getInt("ipcount"));
				bean.setFilename(rs.getString("filename"));
				bean.setFilesize(rs.getInt("filesize"));
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}

	// 조회수 증가
	public void upCount(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update memfreelist set ipcount=ipcount+1 where no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// 게시물 삭제
	@SuppressWarnings("resource")
	public void deleteBoard(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			sql = "select filename from memfreelist where no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if (rs.next() && rs.getString(1) != null) {
				if (!rs.getString(1).equals("")) {
					File file = new File(SAVEFOLDER + "/" + rs.getString(1));
					if (file.exists())
						UtilMgr.delete(SAVEFOLDER + "/" + rs.getString(1));
				}
			}

			sql = "delete from memfreelist where no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}

	// 게시물 수정
	public void updateBoard(BoardBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update memfreelist set name=?,subject=?,content=? where no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getSubject());
			pstmt.setString(3, bean.getContent());
			pstmt.setInt(4, bean.getNo());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	// 게시물 답변
	public void replyBoard(BoardBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert memfreelist (writerid,name,nickname,content,subject,ref,pos,depth,regdate,pass,ipcount,ip)";
			sql += "values(?,?,?,?,?,?,?,?,now(),?,0,?)";
			int depth = bean.getDepth() + 1;
			int pos = bean.getPos() + 1;
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getWriterid());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getNickname());
			pstmt.setString(4, bean.getContent());
			pstmt.setString(5, bean.getSubject());
			pstmt.setInt(6, bean.getRef());
			pstmt.setInt(7, pos);
			pstmt.setInt(8, depth);
			pstmt.setString(9, bean.getPass());
			pstmt.setString(10, bean.getIp());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}

	//파일 다운로드
		public void downLoad(HttpServletRequest req, HttpServletResponse res,
				JspWriter out,PageContext pageContext) {
			try {
				//요청객체인 req에서 다운로드 파일명을 문자열로 리턴 받는다.
				String filename = req.getParameter("filename");
				//저장된 경로와 다운로드 파일명을 합쳐서 File 객체를 생성한다. 
				File file = new File(UtilMgr.con(SAVEFOLDER + File.separator+ filename));
				//파일의 용량 크기 만큼 byte 배열을 선언한다. 
				byte b[] = new byte[(int) file.length()];
				//응답 객체 res 헤더필드에 Accept-Ranges에 bytes 단위로 설정한다.
				res.setHeader("Accept-Ranges", "bytes");
				//요청객체인 req에서 클라이언트의 User-Agent 정보를 리턴 받는다.
				String strClient = req.getHeader("User-Agent");
				//브라우저의 버전과 정보를 구분해서 각각 res 헤더필드와 contentType을 설정한다.
				if (strClient.indexOf("MSIE6.0") != -1) {
					res.setContentType("application/smnet;charset=utf-8");
					res.setHeader("Content-Disposition", "filename=" + filename + ";");
				} else {
					res.setContentType("application/smnet;charset=utf-8");
					res.setHeader("Content-Disposition", "attachment;filename="+ filename + ";");
				}
				out.clear();
				out=pageContext.pushBody();
				//파일 존재 여부에 따라 스트링 방식으로 브라우저로 파일을 전송한다.
				if (file.isFile()) {
					BufferedInputStream fin = new BufferedInputStream(
							new FileInputStream(file));
					BufferedOutputStream outs = new BufferedOutputStream(
							res.getOutputStream());
					int read = 0;
					while ((read = fin.read(b)) != -1) {
						outs.write(b, 0, read);
					}
					outs.close();
					fin.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	
	//페이징 및 블럭 테스트를 위한 게시물 저장 메소드 
	public void post1000(){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert memfreelist(name,content,subject,ref,pos,depth,regdate,pass,ip,ipcount,filename,filesize)";
			sql+="values('aaa', 'bbb', 'ccc', 0, 0, 0, now(), '1111',0, '127.0.0.1', null, 0);";
			pstmt = con.prepareStatement(sql);
			for (int i = 0; i < 1000; i++) {
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	

}
