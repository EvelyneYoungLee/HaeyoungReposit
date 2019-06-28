<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#goBack {
	text-aligh: center;
	margin-left: 5%;
}
</style>
</head>
<body>
	<table border=1 align=center>
		<tr>
			<th>프로필사진
			<td><img src="/resources/${dto.profileImg}"></td>
		<tr>
		<tr>
			<th>ID
			<td>${dto.id}</td>
		<tr>
			<th>Name
			<td>${dto.name}</td>
		<tr>
			<Th>Phone
			<td>${dto.phone}</td>
		<tr>
			<th>Email
			<td>${dto.email}</td>
		<tr>
			<th>우편번호
			<td>${dto.zipcode}</td>
		<tr>
			<th>주소
			<td>${dto.address1}</td>
		<tr>
			<th>상세 주소
			<td>${dto.address2}</td>
		<tr>
			<th>가입일시
			<td>${dto.joinDate}</td>
	</table>
	<br>
	<input type=button id="goBack" value="뒤로가기">
	<input type=button id="update" value="정보 수정">
	<script>
		document.getElementById("goBack").onclick = function() {
			location.href = "home2";
		}
		document.getElementById("update").onclick = function() {
			location.href = "update";
		}
	</script>
</body>
</html>