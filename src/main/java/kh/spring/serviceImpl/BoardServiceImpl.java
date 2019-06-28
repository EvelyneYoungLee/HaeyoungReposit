package kh.spring.serviceImpl;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.oreilly.servlet.MultipartRequest;

import kh.spring.dao.BoardDAO;
import kh.spring.dto.BoardDTO;
import kh.spring.dto.ReplDTO;

@Component
public class BoardServiceImpl {
	@Autowired
	BoardDAO dao;

	public List<BoardDTO> board(int currentPage) throws Exception{
		return dao.selectBoard(currentPage);		
	}	

	public String getNavi(int currentPage) throws Exception{
		return dao.getNavi(currentPage);		
	}

	public int boardWrite(BoardDTO dto) throws Exception{
		dto.setTitle(dto.getTitle().replace("<", "%1$2#").replace(">", "!5@4#"));
		//dto.setContents(dto.getContents().replace("<", "%1$2#").replace(">", "!5@4#"));
		dto.setViewCount(1);			
		return dao.write(dto);		
	}

	@Transactional
	public BoardDTO boardShow(int no) throws Exception{
		//List<ReplDTO> replList = dao.selectRepl(no);	
		dao.viewUp(no);
		return dao.selectContents(no);		
	}

	public String imageUpload(String resourcePath, MultipartRequest multi, String id) throws Exception{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy_MM_dd");


		String date = sdf.format(System.currentTimeMillis());
		String fileName = System.currentTimeMillis()+".png";

		//		Enumeration files = multi.getFileNames();
		//		String file = (String)files.nextElement(); 
		//		String fileNamee = multi.getFilesystemName(file); 
		//		System.out.println(files + " : " + file+ " : " + fileNamee);

		File oriFile = multi.getFile("file");				
		File reName = new File(resourcePath + "/" + id + "/" + date + "/" + fileName);

		System.out.println(oriFile);
		if(!reName.exists()) {reName.mkdir();}

		if(reName.exists()) {
			if(reName.delete()) {
				FileUtils.moveFile(oriFile, reName);
			}else {
				System.out.println("파일 삭제 실패로 변경 실패");
			}
		}else {
			FileUtils.moveFile(oriFile, reName);
		}
		return id + "/" + date + "/" + fileName;
	}

	public int update(BoardDTO dto) throws Exception{	
		dto.setTitle(dto.getTitle().replace("<", "%1$2#").replace(">", "!5@4#"));
		return dao.update(dto);
	}

		public int delete(String no) throws Exception{			
			return dao.delete(no);
		}
	
	//	public List<ReplDTO> selectRepl() throws Exception{
	//
	//
	//	}
	//
	//	public int insertRepl() throws Exception{
	//
	//
	//	}
	//
	//
	//	public int updateRepl() throws Exception{
	//
	//
	//	}
	//
	//	public int delRepl() throws Exception{
	//
	//
	//	}



}
