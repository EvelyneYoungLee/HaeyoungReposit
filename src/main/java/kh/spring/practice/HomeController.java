package kh.spring.practice;

import java.io.File;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kh.spring.dao.MemberDAO;
import kh.spring.dao.MessageDAO;
import kh.spring.dto.BoardDTO;
import kh.spring.dto.MemberDTO;
import kh.spring.dto.MessageDTO;
import kh.spring.serviceImpl.BoardServiceImpl;
import kh.spring.serviceImpl.MemberServiceImpl;

@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private HttpSession session;

	@Autowired
	private MessageDAO mdao;

	@Autowired
	private MemberDAO dao;

	@Autowired
	private MemberServiceImpl memberSvc;

	@Autowired
	private BoardServiceImpl boardSvc;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);		
		String formattedDate = dateFormat.format(date);		
		model.addAttribute("serverTime", formattedDate);		
		return "home";
	}

	@RequestMapping(value = "toHome", method = RequestMethod.GET)
	public String toHome(Locale locale, Model model) {		
		return "redirect:/";
	}

	@RequestMapping(value = "/home2", method = RequestMethod.GET)
	public String toIHome2(Locale locale, Model model) {	
		return "home2";
	}

	@RequestMapping(value = "/inputForm", method = RequestMethod.GET)
	public String toInputForm(Locale locale, Model model) {	
		return "inputForm";
	}

	@RequestMapping(value = "/inputProc", method = RequestMethod.POST)
	public String inputProc(MessageDTO dto) {	
		System.out.println(dto.getSeq() + " : " + 
				dto.getName() + " : " + 
				dto.getMessage());
		try {
			mdao.insert(dto);
		}catch(Exception e) {
			return "redirect:/";
		}
		return "redirect:/";
	}

	@RequestMapping(value = "/outputForm", method = RequestMethod.GET)
	public String toOutputForm(Model model) {	
		try {
			List<MessageDTO> list = mdao.selectAll();
			model.addAttribute("list", list);
		}catch(Exception e) {
			return "home";
		}		
		return "outputForm";
	}

	@RequestMapping(value = "/joinForm", method = RequestMethod.GET)
	public String toJoinForm(Model model) {		
		return "joinForm";
	}

	@ResponseBody
	@RequestMapping(value = "/idDuplCheck", method = RequestMethod.POST)
	public String toDuplCheck(Model model, HttpServletRequest request) {

		String id = request.getParameter("id");
		System.out.println(id);
		try {
			String result = dao.selectId(id)+"";
			return result;
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}		
	}

	@RequestMapping(value = "/joinMember", method = RequestMethod.POST)
	public String joinMember(HttpServletRequest request) {
		String resourcePath = session.getServletContext().getRealPath("/resources");	
		System.out.println(resourcePath);

		int maxSize = 10 * 1024 * 1024;

		try {
			MultipartRequest multi = new MultipartRequest(request, resourcePath, maxSize, "utf-8", new DefaultFileRenamePolicy());			
			String id = multi.getParameter("id"); 
			File oriFile = multi.getFile("image");

			//			File uploadPath = resourcePath+"/";
			//			if(!uploadPath.exists()) {uploadPath.mkdir();}

			String fileName = id+"_profile.png";
			File reName = new File(resourcePath + "/"+fileName);
			FileUtils.moveFile(oriFile, reName);

			String pw = multi.getParameter("pw");
			String name = multi.getParameter("name");
			String phone = multi.getParameter("phone");
			String email = multi.getParameter("email");
			String zipcode = multi.getParameter("zipcode");
			String address1 = multi.getParameter("address1");
			String address2 = multi.getParameter("address2");			
			MemberDTO dto = new MemberDTO(id, pw, name, phone, email, zipcode, address1, address2, fileName);

			int result = dao.insert(dto);
			request.setAttribute("result", result);

		}catch(Exception e) {
			e.printStackTrace();
		}
		return "joinMemProc";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(String id, String pw) {	
		try {
			int result = dao.login(id, pw);
			if(result>0) {
				session.setAttribute("userId", id);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "home2";
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout() {	
		session.invalidate();
		return "redirect:/";
	}


	@RequestMapping("myInfo")
	public ModelAndView myInfo(ModelAndView mav) {
		String id = (String)session.getAttribute("userId");
		System.out.println(id);
		try {
			MemberDTO dto = dao.selectInfo(id);
			mav.addObject("dto",dto);
		}catch(Exception e) {
			e.printStackTrace();
		}
		mav.setViewName("myInfo");
		return mav;
	}

	@RequestMapping("update")
	public String update(HttpServletRequest request) {
		String id = (String)session.getAttribute("userId");

		try {
			MemberDTO dto = dao.selectInfo(id);
			request.setAttribute("dto", dto);

		}catch(Exception e) {
			e.printStackTrace();
		}
		return "updateInfo";
	}

	@RequestMapping(value = "updateProc", method = RequestMethod.POST)
	public String updateProc(HttpServletRequest request) {

		String resourcePath = session.getServletContext().getRealPath("/resources");	
		System.out.println(resourcePath);

		int maxSize = 10 * 1024 * 1024;

		try {
			MultipartRequest multi = new MultipartRequest(request, resourcePath, maxSize, "utf-8", new DefaultFileRenamePolicy());			
			String id = (String)session.getAttribute("userId");
			File oriFile = multi.getFile("image");

			String fileName = id+"_profile.png";
			File reName = new File(resourcePath + "/"+fileName);

			if(reName.exists()) {
				if(reName.delete()) {
					FileUtils.moveFile(oriFile, reName);
				}else {
					System.out.println("파일 삭제 실패로 변경 실패");
				}
			}else {
				FileUtils.moveFile(oriFile, reName);
			}

			String pw = multi.getParameter("pw");
			String name = multi.getParameter("name");
			String phone = multi.getParameter("phone");
			String email = multi.getParameter("email");
			String zipcode = multi.getParameter("zipcode");
			String address1 = multi.getParameter("address1");
			String address2 = multi.getParameter("address2");			
			MemberDTO dto = new MemberDTO(id, pw, name, phone, email, zipcode, address1, address2, fileName);

			int result = memberSvc.update(dto);
			request.setAttribute("result", result);

		}catch(Exception e) {
			e.printStackTrace();
		}

		return "updateProc";
	}

	@RequestMapping("board")
	public String board(HttpServletRequest request) {

		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		try {
			request.setAttribute("navi", boardSvc.getNavi(currentPage));
			request.setAttribute("list", boardSvc.board(currentPage));
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "board";
	}

	@RequestMapping("boardWrite")
	public String boardWrite() {
		return "boardWrite";
	}

	@RequestMapping(value="boardWriteProc", method = RequestMethod.POST)
	public String boardWriteProc(BoardDTO dto, HttpServletRequest request) {
		String id = (String)session.getAttribute("userId");
		dto.setWriter(id);
		dto.setIpAddr(request.getRemoteAddr());	
		try {
			request.setAttribute("result", boardSvc.boardWrite(dto));
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "boardWriteProc";
	}

	@RequestMapping("boardShow")
	public String boardShow(HttpServletRequest request, String no) {
		int board_seq = Integer.parseInt(no);
		try {
			request.setAttribute("dto", boardSvc.boardShow(board_seq));
			request.setAttribute("replList", "");
			request.setAttribute("no", no);
		}catch(Exception e) {
			e.printStackTrace();
		}		
		return "boardShow";
	}


	@ResponseBody
	@RequestMapping(value = "imageUpload", method = RequestMethod.POST)
	public String imageUpload(HttpServletRequest request) {
		String resourcePath = session.getServletContext().getRealPath("/resources");	
		System.out.println(resourcePath);
		int maxSize = 10 * 1024 * 1024;

		try {			
			MultipartRequest multi = new MultipartRequest(request, resourcePath, maxSize, "utf-8", new DefaultFileRenamePolicy());			
			String id = (String)session.getAttribute("userId");
			return boardSvc.imageUpload(resourcePath, multi, id);

		}catch(Exception e) {
			e.printStackTrace();
		}
		return "업로드 실패";
	}


	@RequestMapping(value = "boardEdit")
	public String boardEdit(HttpServletRequest request) {
		int no = Integer.parseInt(request.getParameter("no"));
		request.setAttribute("no", no);
		try {
			request.setAttribute("dto", boardSvc.boardShow(no));
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "boardEdit";
	}


	@RequestMapping(value = "boardEditProc", method = RequestMethod.POST)
	public String boardEditProc(BoardDTO dto, HttpServletRequest request) {
		try {
			request.setAttribute("result", boardSvc.update(dto));
			request.setAttribute("no", dto.getBoard_seq());
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "boardEditProc";
	}

	@RequestMapping("boardDelProc")
	public String boardDelProc(HttpServletRequest request) {
		String no = request.getParameter("no");
		request.setAttribute("no", no);
		try {
			request.setAttribute("result", boardSvc.delete(no));
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "boardDelProc";
	}

	@RequestMapping("webchat")
	public String webChat(Locale locale, Model model) {		
		return "webchat";
	}





}
