<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
if(${result==1}){
	alert("회원가입이 완료되었습니다.");
	location.href = "toHome";
}else{
	alert("회원가입에 실패했습니다.");
	location.href = "toHome";
}
</script>
</body>
</html>