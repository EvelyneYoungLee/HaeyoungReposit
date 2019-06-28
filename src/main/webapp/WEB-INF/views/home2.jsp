<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
<title>Index</title>
<style>
#welcome, #chatbox {
	float: left;
}
#chatbox{
	margin-left:100px;
}
#wrapper {
	overflow: hidden;
}
</style>
</head>
<body>
	<c:choose>
		<c:when test="${userId!=null }">
			<div id="wrapper">
				<div id="welcome">
					<div>${userId}님환영합니다.</div>
					<br> <input type="button" value="home으로 가기" id="toHome">
					<input type="button" value="마이페이지" id="myInfo"> <input
						type="button" value="게시판" id="toBoard"> <input type=button
						value="로그아웃" id="logout" class="in"> <br> <br>
				</div>
				<div id="chatbox">
					<iframe src="webchat" width=300px height=400px></iframe>
				</div>
			</div>
			<script>
				document.getElementById("logout").onclick = function() {
					location.href = "logout";
				}
				$("#toHome").on("click", function() {
					$(location).attr("href", "toHome")
				})
				$("#myInfo").on("click", function() {
					$(location).attr("href", "myInfo")
				})
				$("#toBoard").on("click", function() {
					$(location).attr("href", "board?currentPage=1")
				})
			</script>
		</c:when>
		<c:otherwise>
			<form action="login" method="post">
				<input type="text" placeholder="ID" name="id"><br> <input
					type="password" placeholder="Password" name="pw"><br>
				<button id="login">Login</button>
				<button type="button" id="sign">Sign Up</button>
				<input type="button" value="home으로 가기" id="toHome"> <br>
				<br>
			</form>
			<div>${msg }</div>
			<script>
				$("#sign").on("click", function() {
					$(location).attr("href", "joinForm")
				})
				$("#toHome").on("click", function() {
					$(location).attr("href", "toHome")
				})
			</script>
		</c:otherwise>
	</c:choose>

	<button id="toInput">비회원 방명록 작성</button>
	<button id="toOutput">방명록 보기</button>

	<script>
		$("#toInput").on("click", function() {
			$(location).attr("href", "inputForm")
		})
		$("#toOutput").on("click", function() {
			$(location).attr("href", "outputForm")
		})
	</script>
</body>
</html>