package kh.spring.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import kh.spring.dto.BoardDTO;
import kh.spring.dto.ReplDTO;

@Component
public class BoardDAO {

	@Autowired
	private SqlSessionTemplate sst;

	public int write(BoardDTO dto) throws Exception{
		if(dto.getPath()=="") {dto.setPath("null");}
		return sst.insert("BoardDAO.write", dto);
	}


	public List<BoardDTO> selectBoard(int currentPage) throws Exception{
		int first = (currentPage-1)*10 + 1;
		return sst.selectList("BoardDAO.selectBoard", first);
	}

	//	public List<BoardDTO> searchBoard(int currentPage, String title) throws Exception{
	//		String sql = "select board_seq,title,writer,writedate,viewcount from "
	//				+ "(select board_seq,title,writer,writedate,viewcount,rank() over(order by board_seq desc) rank from board where title = ?) where rank between ? and ?";
	//
	//		try(
	//				Connection con = this.connect();	
	//				PreparedStatement pstat = con.prepareStatement(sql);
	//				){
	//
	//			int first = (currentPage-1)*10 + 1;
	//			int last =first+9;
	//			pstat.setString(1, title);
	//			pstat.setInt(2, first);
	//			pstat.setInt(3, last);
	//			ResultSet rs = pstat.executeQuery();
	//			List<BoardDTO> list = new ArrayList<>();
	//			while(rs.next()) {			
	//				BoardDTO dto = new BoardDTO(rs.getString(1),rs.getString(2),rs.getString(3),rs.getTimestamp(4),rs.getInt(5));
	//				list.add(dto);
	//			}
	//			return list;
	//		}
	//	}

	public int viewUp(int no) throws Exception{
		return sst.update("BoardDAO.viewUp", no);
	}

	public BoardDTO selectContents(int no) throws Exception{			
		return sst.selectOne("BoardDAO.selectContents", no);
	}

	public int update(BoardDTO dto) throws Exception{
		return sst.update("BoardDAO.update", dto);
	}

	public int delete(String no)throws Exception{
		return sst.delete("BoardDAO.delete", no);
	}

	private int boardCount() throws Exception{
		return sst.selectOne("BoardDAO.boardCount");
	}

	private int boardSearchCount(String title) throws Exception{
		return sst.selectOne("BoardDAO.boardSearchCount", title);
	}

	public String getNavi(int currentPage) throws Exception{

		int recordTotalCount = this.boardCount();
		int recordCountPerPage = 10;
		int naviCountPerPage = 5;
		int pageTotalCount = 0;	
		int toNext=0;
		int toPrev=0;

		if(recordTotalCount % recordCountPerPage > 0) {
			pageTotalCount = recordTotalCount / recordCountPerPage + 1;
		}else{
			pageTotalCount = recordTotalCount / recordCountPerPage;
		}

		if(currentPage < 1) {
			currentPage = 1; 
		}else if(currentPage > pageTotalCount) {
			currentPage = pageTotalCount; 
		}

		int startNavi = ((currentPage-1) / naviCountPerPage) * naviCountPerPage + 1;
		int endNavi = startNavi + (naviCountPerPage-1);;

		if(startNavi + (naviCountPerPage-1)>pageTotalCount) {
			endNavi = pageTotalCount;
		}

		boolean needPrev = true;
		boolean needNext = true;

		if(startNavi ==1) {
			needPrev = false;
		}else {
			toPrev=startNavi-1;
		}

		if(endNavi == pageTotalCount) {
			needNext = false;
		}else {
			toNext=endNavi+1;
		}

		StringBuilder sb = new StringBuilder();

		if(needPrev) {
			sb.append("<a href='board?currentPage="+toPrev+"'><이전 </a>");
		}

		for(int i = startNavi; i<=endNavi; i++) {
			if(currentPage==i) {
				sb.append("<a href='board?currentPage="+i+"' style='font-weight:600; text-decoration-line: underline; color:purple;'>" + i + "</a>");
				sb.append(" ");
			}else {
				sb.append("<a href='board?currentPage="+i+"'>" + i + "</a>");
				sb.append(" ");
			}
		}

		if(needNext) {
			sb.append("<a href='board?currentPage="+toNext+"'>다음> </a>");
		}

		return sb.toString();
	}

	public String getNaviSearch(int currentPage, String title) throws Exception{

		int recordTotalCount = this.boardSearchCount(title);
		int recordCountPerPage = 10;
		int naviCountPerPage = 5;
		int pageTotalCount = 0;	
		int toNext=0;
		int toPrev=0;

		if(recordTotalCount % recordCountPerPage > 0) {
			pageTotalCount = recordTotalCount / recordCountPerPage + 1;
		}else{
			pageTotalCount = recordTotalCount / recordCountPerPage;
		}

		if(currentPage < 1) {
			currentPage = 1; 
		}else if(currentPage > pageTotalCount) {
			currentPage = pageTotalCount; 
		}

		int startNavi = ((currentPage-1) / naviCountPerPage) * naviCountPerPage + 1;
		int endNavi = startNavi + (naviCountPerPage-1);;

		if(startNavi + (naviCountPerPage-1)>pageTotalCount) {
			endNavi = pageTotalCount;
		}

		boolean needPrev = true;
		boolean needNext = true;

		if(startNavi ==1) {
			needPrev = false;
		}else {
			toPrev=startNavi-1;
		}

		if(endNavi == pageTotalCount) {
			needNext = false;
		}else {
			toNext=endNavi+1;
		}

		StringBuilder sb = new StringBuilder();

		if(needPrev) {
			sb.append("<a href='boardSearch?currentPage="+toPrev+"&search="+title+"'><이전 </a>");
		}

		for(int i = startNavi; i<=endNavi; i++) {
			if(currentPage==i) {
				sb.append("<a href='boardSearch?currentPage="+i+"&search="+title+"' style='font-weight:600; text-decoration-line: underline; color:purple;'>" + i + "</a>");
				sb.append(" ");
			}else {
				sb.append("<a href='boardSearch?currentPage="+i+"&search="+title+"'>" + i + "</a>");
				sb.append(" ");
			}
		}

		if(needNext) {
			sb.append("<a href='boardSearch?currentPage="+toNext+"&search="+title+"'>다음> </a>");
		}

		return sb.toString();
	}

	//	public List<ReplDTO> selectRepl(int contents_no) throws Exception{
	//		String sql = "select contents_no, repl_seq, repl_writer, repl_contents, repl_time from repl where contents_no = ?";
	//
	//		try(
	//				Connection con = this.connect();	
	//				PreparedStatement pstat = con.prepareStatement(sql);
	//				){
	//
	//			pstat.setInt(1, contents_no);
	//			ResultSet rs = pstat.executeQuery();
	//			List<ReplDTO> list = new ArrayList<>();
	//			while(rs.next()) {			
	//				ReplDTO dto = new ReplDTO(rs.getInt(1),rs.getInt(2),rs.getString(3), rs.getString(4), rs.getTimestamp(5));
	//				list.add(dto);
	//			}
	//			return list;
	//		}
	//	}

	//	public int insertRepl(int contents_no, String id, String repl_contents) throws Exception{
	//		String sql = "insert into repl values(?, repl_seq.nextval, ?, ?, sysdate)";
	//		try(
	//				Connection con = this.connect();	
	//				PreparedStatement pstat = con.prepareStatement(sql);
	//				){
	//			pstat.setInt(1, contents_no);
	//			pstat.setString(2, id);
	//			pstat.setString(3, repl_contents);
	//			int result = pstat.executeUpdate();
	//
	//			return result;
	//		}
	//	}

	//	public int updateRepl(int repl_seq, String repl_contents) throws Exception{
	//		String sql = "update repl set repl_contents=?, repl_time=sysdate where repl_seq=?";
	//		try(
	//				Connection con = this.connect();	
	//				PreparedStatement pstat = con.prepareStatement(sql);
	//				){
	//			pstat.setString(1, repl_contents);
	//			pstat.setInt(2, repl_seq);
	//
	//			int result = pstat.executeUpdate();
	//
	//			return result;
	//		}		
	//	}


	//	public int delRepl(int repl_seq) throws Exception{
	//		String sql = "delete from repl where repl_seq = ?";
	//		try(
	//				Connection con = this.connect();	
	//				PreparedStatement pstat = con.prepareStatement(sql);
	//				){
	//			pstat.setInt(1, repl_seq);
	//
	//			int result = pstat.executeUpdate();
	//
	//			return result;
	//		}		
	//	}

}
