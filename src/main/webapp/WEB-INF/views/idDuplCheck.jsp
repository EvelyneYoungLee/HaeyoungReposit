<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디 중복확인</title>
</head>
<body>
	<div id="wrapper">
		<c:choose>
			<c:when test="${result==0}">"${id }"는 사용가능한 아이디입니다.</c:when>
			<c:otherwise>"${id }"는 이미 사용중인 아이디입니다.</c:otherwise>
		</c:choose>
		<br> <input type=button id="close">
	</div>
	<script>
		if (${result== 0}) {
			document.getElementById("close").value = "확인";
			opener.document.getElementById("id").setAttribute("distinct",
					"true");
		} else {
			document.getElementById("close").value = "닫기";
		}

		document.getElementById("close").onclick = function() {
			if (${result== 1}) {
				opener.document.getElementById("id").value = "";
			}
			window.close();
		}
	</script>
</body>

</html>