package kh.spring.aspect;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class PerformanceAdvices {

	@Pointcut("execution(* kh.spring.practice.HomeController.*(..))")
	public void pointcut() {}

	@Autowired
	HttpSession session;
	
	@Around("pointcut()")
	public Object perfCheck(ProceedingJoinPoint pjp) {
		long startTime = System.currentTimeMillis();
		Object retVal = null;
		try {
			retVal = pjp.proceed();
		}catch(Throwable e) {
			e.printStackTrace();
		}

		long endTime = System.currentTimeMillis();
		String id = (String)session.getAttribute("userId") == null ? "익명" : (String)session.getAttribute("userId");
		System.out.println(id + " 님이 로그인하여 "+pjp.getSignature().getName()+" 메소드를 "+(endTime - startTime)/1000.0 + " 초 간 수행");
		return retVal;
	}

}
