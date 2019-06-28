package kh.spring.aspect;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

@Component
@Aspect
public class LogAdvices {

	@Autowired
	HttpSession session;
	
	@Autowired
	HttpServletRequest request;

	@Pointcut("execution(* kh.spring.practice.HomeController.myInfo(..))")
	public void myInfo() {}
	
	@Pointcut("execution(* kh.spring.practice.HomeController.boardWrite(..))")
	public void boardWrite() {}

	@Around("boardWrite()")
	public Object writeLog(ProceedingJoinPoint pjp) {
		String id = (String)session.getAttribute("userId");

		if(id==null) {			
			request.setAttribute("msg", "글쓰기는 로그인이 필요합니다.");
			return "home2";
		}else {	
			try {
				return pjp.proceed();
			}catch(Throwable e) {
				e.printStackTrace();
				return "error";
			}
		}

	}
	
	@Around("myInfo()")
	public Object infoLog(ProceedingJoinPoint pjp) throws Throwable{
		String id = (String)session.getAttribute("userId");

		if(id==null) {			
			ModelAndView mav = new ModelAndView();
			mav.addObject("msg","로그인을 먼저 진행해주세요.");
			mav.setViewName("home2");
			return mav;
		}else {	
			try {
				return pjp.proceed();
			}catch(Throwable e) {
				e.printStackTrace();
				return "error";
			}
		}

	}




}
