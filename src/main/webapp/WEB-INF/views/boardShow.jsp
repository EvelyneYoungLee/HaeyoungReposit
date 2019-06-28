<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
<style>
#wrapper {
	margin-top: 50px;
}

div {
	box-sizing: border-box;
	text-align: center;
}

#upload, #toList {
	margin: 0px;
}

#footer {
	text-align: right;
	padding: 0px;
}

#text {
	height: 500px;
}

#contents {
	margin: 0px;
	padding: 20px;
	width: 100%;
	height: 100%;
	overflow: auto;
}

#repl {
	margin: 0px;
	padding: 10px;
	width: 90%;
}

#replButt {
	width: 10%;
}

#title {
	margin-left: 10px;
	width: 80%;
}

#writer, #writeDate {
	margin-left: 10px;
	margin-top: 5px;
	margin-bottom: 5px;
	width: 80%;
}

.titleWrapper {
	margin-top: 10px;
	margin-bottom: 10px;
}

#titlerow {
	margin-top: 30px;
}

#writerrow, #daterow {
	margin-top: 8px;
}

#replHeader {
	margin-top: 30px;
	width: 50px;
}

#replContentsBox {
	margin-bottom: 100px;
}

#repl_writer {
	word-wrap: break-word;
}

#repl_time {
	word-wrap: break-word;
}

#replButts {
	text-align: right;
	padding: 0px;
}

#eachRepl {
	margin-top: 20px;
}

#repl_text {
	width: 100%;
	border: none;
	text-aligh: center;
}
</style>
</head>
<body>

	<div class="container" id="wrapper">
		<header>
			<div class="row border border-secondary">
				<div class="col-lg-8 col-md-8 col-sm-8 col-8 titleWrapper"
					id="titlerow">
					제목 : <input type="text" id="title" readonly value="${dto.title}">
				</div>
				<div class="col-lg-4 col-md-4 col-sm-4 col-4 titleWrapper">
					<div class="row">
						<div class="col-lg-4 d-none d-lg-block" id="writerrow">글쓴이 :</div>
						<div class="col-lg-8 col-md-12 col-sm-12 col-12">
							<input type="text" id="writer" readonly value="${dto.writer}">
						</div>
					</div>
					<div class="row">
						<div class="col-lg-4 d-none d-lg-block" id="daterow">작성일시 :</div>
						<div class="col-lg-8 col-md-12 col-sm-12 col-12">
							<input type="text" id="writeDate" readonly
								value="${dto.writeDate}">
						</div>
					</div>
				</div>
			</div>
		</header>

		<main id="main">
		<div class="row" id="text">
			<div id="contents" name="contents" class="border border-secondary">${dto.contents}</div>
		</div>
		</main>
		<footer>
			<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 border border-secondary"
					id="footer">

					<c:if test="${userId==dto.writer}">
						<input type="button" id="modify" value="수정하기">
						<input type="button" id="delete" value="글 삭제">
					</c:if>
					<input type="button" id="showReplBox" value="댓글달기"> <input
						type="button" id="toList" value="목록으로">

				</div>
			</div>
		</footer>
		<form action="Reply.board" id="replForm">
			<div class="row border border-secondary" id="replBox">
				<input type="text" value="${no}" name="contents_no" id="contents_no">
				<textarea id="repl" name="repl_contents"></textarea>
				<input type="button" id="replButt" value="등록하기">
			</div>
		</form>
		<div id="replHeader">
			<h4>댓글</h4>
		</div>
		<div id="replContentsBox">
			<c:forEach var="repldto" items="${replList}">
				<form action="ReplEdit.board">
					<div class="row" id="eachRepl">
						<div
							class="col-lg-2 col-md-2 col-sm-2 col-2 border border-secondary"
							id="repl_writer">${repldto.repl_writer}</div>
						<div
							class="col-lg-8 col-md-8 col-sm-8 col-8 border border-secondary">
							<input type="text" id="repl_text" name="repl_contents"
								value="${repldto.repl_contents}" readonly> <input
								type="text" class="hide" name="contents_no"
								value="${repldto.contents_no}"> <input type="text"
								class="hide" name="repl_seq" value="${repldto.repl_seq}">
						</div>

						<div
							class="col-lg-2 col-md-2 col-sm-2 col-2 border border-secondary"
							id="repl_time">${repldto.repl_time}</div>
					</div>
					<c:if test="${userId==repldto.repl_writer }">
						<div class="row">
							<div class="col-lg-12 col-md-12 col-sm-12 col-12" id="replButts">
								<input type="submit" class="replEditCompl" value="수정완료"
									style="margin-right: 4px;"><input type="button"
									value="수정" class="modiRepl"> <input type="button"
									value="삭제" class="delRepl">
							</div>
						</div>
					</c:if>
				</form>
				<script>
				$(".replEditCompl").hide();
				$(".hide").hide();
				
				if(${userId==repldto.repl_writer }){
					$(".modiRepl").on("click",function(){
						document.getElementById("repl_text").readOnly=false;
						$(this).parent().find("input:nth-child(1)").show();
						$(this).parent("div").parent("div").parent("form").find("div").find("div:nth-child(2)").find("input:nth-child(1)").focus();
					})
					$(".delRepl").on("click",function(){
						location.href = "ReplDelete.board?repl_seq="+${repldto.repl_seq}+"&contents_no="+${repldto.contents_no};
					})
				}
				</script>
			</c:forEach>
		</div>
	</div>
	<script>
	$("#contents_no").hide();
	$("#replBox").hide();
	$("#showReplBox").on("click",function(){
		$("#replBox").slideDown(500,"");
	})
	$("#replButt").on("click",function(){
		if($("#repl").val()==""){
			alert("댓글을 입력해주세요.");
		}else{
			$("#replForm").submit();
		}
	})
	
		document.getElementById("toList").onclick = function() {
			location.href = "board?currentPage=1";
		}	
		
		if(${userId==dto.writer }){
		document.getElementById("modify").onclick = function() {
			location.href = "boardEdit?no="+${no};
		}
		document.getElementById("delete").onclick = function() {
			var result = confirm("정말 삭제하시겠습니까?");
			if (result) {
				location.href = "boardDelProc?no="+${no};
			}
		}
		}
	</script>
</body>
</html>