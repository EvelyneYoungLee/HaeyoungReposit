<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Document</title>
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<style>
#wrapper {
	margin-top: 50px;
}

div {
	box-sizing: border-box;
	text-align: center;
}

#write {
	margin: 0px;
}

#footer {
	text-align: right;
	padding: 0px;
}

#text {
	height: 600px;
	line-height: 600px;
}

.titleLink {
	border: none;
	background-color: white;
}

#noInput {
	border: none;
	width: 90%;
}

#writer {
	word-wrap: break-word;
}

#searchDiv {
	height: 50px;
}

#select, #search, #searchButt {
	height: 30px;
	margin-left: 10px;
	margin-top: 10px;
}
</style>
</head>
<body>
	<div class="container border border-secondary" id="wrapper">
		<header>
			<div class="row border border-secondary">
				<div
					class=" logo col-lg-12 col-md-12 col-sm-12 border border-secondary">
					<h4>자유 게시판</h4>
				</div>
			</div>
		</header>
		<div class="row border border-secondary" id="searchDiv">
			<form action="BoardSearch.board">
				<select id="select" name="select"><option>제목</option>
					<option>작성자</option></select> <input type="text" id="search" name="search">
				<input type="text" id="hide" name="currentPage" value="1">
				<button id="searchButt">검색</button>
				<input type="button" value="전체 글 보기" id="showAll">
			</form>
		</div>
		<navi>
		<div class="row border border-secondary">
			<div
				class="col-lg-1 col-md-1 col-sm-2 col-2 order-lg-1 order-md-1 order-sm-2 order-2 border border-secondary">No
			</div>
			<div
				class="col-lg-5 col-md-5 col-sm-12 col-12 order-lg-2 order-md-2 order-sm-1 order-1 border border-secondary">Title
			</div>
			<div
				class="col-lg-2 col-md-2 col-sm-4 col-4 order-md-2 order-sm-2 order-2 border border-secondary">Writer
			</div>
			<div
				class="col-lg-3 col-md-3 col-sm-4 col-4 order-md-2 order-sm-2 order-2 border border-secondary">Date
			</div>
			<div
				class="col-lg-1 col-md-1 col-sm-2 col-2 order-md-2 order-sm-2 order-2 border border-secondary">조회수
			</div>
		</div>
		</navi>

		<main id="main"> <c:forEach var="dto" items="${list}"
			varStatus="stat">
			<form action="boardShow" id="formContents">
				<div class="row border border-secondary">
					<div class="col-lg-12 col-md-12 col-sm-12 border border-secondary">
						<div class="row list">
							<div
								class="col-lg-1 col-md-1 col-sm-2 col-2 order-lg-1 order-md-1 order-sm-2 order-2 border border-secondary"
								id="no">
								<input type="text" id="noInput" name="no"
									value="${dto.board_seq}" readonly>
							</div>
							<div
								class="col-lg-5 col-md-5 col-sm-12 col-12 order-lg-2 order-md-2 order-sm-1 order-1 border border-secondary">
								<c:choose>
									<c:when test="${stat.count%2==0}">
										<div class="ml-5" style="text-align: left;">
											<c:if test="${dto.path!='null'}">
												<span class="mr-5"><img src="/resources/${dto.path}"
													style="width: 50px; height: 50px;"></span>
											</c:if>
											<button class="titleLink ml-5">${dto.title}</button>
										</div>
									</c:when>
									<c:otherwise>
										<div class="ml-5" style="text-align: left;">
											<button class="titleLink mr-5">${dto.title}</button>
											<c:if test="${dto.path!='null'}">
												<span class="ml-5"><img src="/resources/${dto.path}"
													style="width: 50px; height: 50px;"></span>
											</c:if>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
							<div
								class="col-lg-2 col-md-2 col-sm-4 col-4 order-md-2 order-sm-2 order-2 border border-secondary"
								id="writer">${dto.writer}</div>
							<div
								class="col-lg-3 col-md-3 col-sm-4 col-4 order-md-2 order-sm-2 order-2 border border-secondary">${dto.writeDate}
							</div>
							<div
								class="col-lg-1 col-md-1 col-sm-2 col-2 order-md-2 order-sm-2 order-2 border border-secondary"
								id="viewCount">${dto.viewCount}</div>
						</div>
					</div>
				</div>
			</form>
		</c:forEach> </main>
		<footer>
			<div class="row border border-secondary">
				<div class="col-lg-12 col-md-12 col-sm-12 border border-secondary">
					${navi }</div>
			</div>
			<div class="row border border-secondary">
				<div class="col-lg-12 col-md-12 col-sm-12 border border-secondary"
					id="footer">
					<input type="button" id="write" value="글쓰기"> <input
						type="button" id="goMain" value="Home">
				</div>
			</div>
		</footer>
	</div>
	<script>
		$("#hide").hide();
		$("#showAll").hide();
		if ("${showAll}" == "showAll") {
			$("#showAll").show();
			$("#showAll").on("click", function() {
				location.href = "Board.board?currentPage=1";
			})
		}
		document.getElementById("write").onclick = function() {
			location.href = "boardWrite"
		}
		document.getElementById("goMain").onclick = function() {
			location.href = "home2"
		}
	</script>
</body>
</html>