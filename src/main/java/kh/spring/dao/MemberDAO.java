package kh.spring.dao;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import kh.spring.dto.MemberDTO;
import kh.spring.dto.MessageDTO;

@Component
public class MemberDAO {

	@Autowired
	private SqlSessionTemplate sst;
	
	public int login(String id, String pw) throws Exception{
		MemberDTO dto = new MemberDTO();
		dto.setId(id);
		dto.setPw(this.testSHA256(pw));
		int result = sst.selectOne("MemberDAO.login", dto);
		return result;
	}

	public int selectId(String id) throws Exception{
		int result = sst.selectOne("MemberDAO.selectId", id);
		return result;
	}

	public MemberDTO selectInfo(String id) throws Exception{
		MemberDTO dto = sst.selectOne("MemberDAO.selectInfo", id);				
		return dto;
	}	

	public int insert(MemberDTO dto) throws Exception{				
		dto.setPw(this.testSHA256(dto.getPw()));
		int result = sst.insert("MemberDAO.insert", dto);
		return result;
	}

	public int delId(String id, String pw) throws Exception{
		MemberDTO dto = new MemberDTO();
		dto.setId(id);
		dto.setPw(this.testSHA256(dto.getPw()));
		int result = sst.delete("MemberDAO.delId",dto);

		return result;
	}

	public int updateAll(MemberDTO dto) throws Exception{
		dto.setPw(this.testSHA256(dto.getPw()));
		int result = sst.update("MemberDAO.updateAll", dto);
		return result;
	}

	public int updateNotPw(MemberDTO dto) throws Exception{
		int result = sst.update("MemberDAO.updateAll", dto);
		return result;
	}
	
	public static String testSHA256(String str){
		String SHA = ""; 
		try{
			MessageDigest sh = MessageDigest.getInstance("SHA-512"); 
			sh.update(str.getBytes()); 
			byte byteData[] = sh.digest();
			StringBuffer sb = new StringBuffer(); 
			for(int i = 0 ; i < byteData.length ; i++){
				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
			}
			SHA = sb.toString();
		}catch(NoSuchAlgorithmException e){
			e.printStackTrace(); 
			SHA = null; 
		}
		return SHA;
	}
}


