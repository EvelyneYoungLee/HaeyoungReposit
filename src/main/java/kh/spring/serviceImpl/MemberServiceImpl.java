package kh.spring.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import kh.spring.dao.MemberDAO;
import kh.spring.dto.MemberDTO;
import kh.spring.service.MemberService;

@Component
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberDAO dao;	

	@Transactional("txManager")
	public int update(MemberDTO dto) throws Exception{
		int result;

		if(dto.getPw().equals("********")){
			System.out.println(dto.getPw());
			result = dao.updateNotPw(dto);

		}else{

			result = dao.updateAll(dto);

		}

		return result;
	}


}
