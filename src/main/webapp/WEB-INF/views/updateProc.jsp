<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<Script>
		if (
	${result}
		> 0) {
			alert("회원 정보 수정이 완료되었습니다.");
			location.href = "toHome";

		} else {
			alert("회원 정보 수정을 실패했습니다.");
			location.href = "toHome";

		}
	</script>
</body>
</html>