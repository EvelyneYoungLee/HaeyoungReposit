<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
<title>OutputForm</title>
<style>
table, tr, td, th {
	border: 1px solid dodgerblue;
	color: white;
	text-shadow: 2px 1px 1px gray;
}

td, th {
	background-color: dodgerblue;
}

#toHome {
	margin-top: 10px;
}
</style>
</head>
<body>
	<table>
		<tr>
			<th>번호</th>
			<th>이름</th>
			<th>메세지</th>
		</tr>
		<c:forEach var="dto" items="${list}">
			<tr>
				<td>${dto.seq}
				<td>${dto.name}
				<td>${dto.message}
			</tr>
		</c:forEach>
	</table>
	<input type="button" value="home으로 돌아가기" id="toHome">
	<script>
		$("#toHome").on("click", function() {
			$(location).attr("href", "/")
		})
	</script>
</body>
</html>