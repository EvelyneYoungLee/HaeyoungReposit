<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.css"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.js"></script>
<style>
#wrapper {
	margin-top: 50px;
	padding: 0px;
}

footer {
	padding-left: 15px;
	padding-right: 15px;
}

header {
	padding-left: 15px;
	padding-right: 15px;
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
	height: 600px;
}

#contents {
	margin: 0px;
	padding: 20px;
	width: 100%;
	height: 100%;
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
</style>
</head>
<body>
	<form action="boardEditProc" id="formEdit" method="post">
		<div class="container border border-secondary" id="wrapper">
			<header>
				<div class="row border border-secondary">
					<div class="col-lg-8 col-md-8 col-sm-8 col-8 titleWrapper"
						id="titlerow">
						제목 : <input type="text" id="title" value="${dto.title}"
							name="title" required>
					</div>
					<div class="col-lg-4 col-md-4 col-sm-4 col-4 titleWrapper">
						<div class="row">
							<div class="col-lg-4 d-none d-lg-block" id="writerrow">글쓴이
								:</div>
							<div class="col-lg-8 col-md-12 col-sm-12 col-12">
								<input type="text" id="writer" readonly value="${dto.writer}"
									name="writer">
							</div>
						</div>
						<div class="row">
							<div class="col-lg-4 d-none d-lg-block" id="daterow">작성일시 :</div>
							<div class="col-lg-8 col-md-12 col-sm-12 col-12">
								<input type="text" id="writeDate" readonly
									value="${dto.writeDate}"> <input type="text"
									name="board_seq" id="no" readonly value="${no}">
							</div>
						</div>
					</div>
				</div>
			</header>

			<main id="main">
			<div class="border border-secondary" id="text">
				<textarea id="contents" name="contents" required>${dto.contents}</textarea>
			</div>
			</main>
			<footer>
				<div class="row border border-secondary">
					<div
						class=" logo col-lg-12 col-md-12 col-sm-12 border border-secondary"
						id="footer">

						<input type="button" id="complete" value="수정완료"> <input
							type="button" id="toList" value="목록으로">
					</div>
				</div>
			</footer>
		</div>
	</form>
	<script>
		document.getElementById("toList").onclick = function() {
			location.href = "board?currentPage=1";
		}
		$("#no").hide();
		$(function() {
			$("#contents").summernote({
				placeholder : '글을 입력해주세요.',
				tabsize : 2,
				height : 100, // 기본 높이값
				minHeight : 545, // 최소 높이값(null은 제한 없음)
				maxHeight : 545, // 최대 높이값(null은 제한 없음)
				focus : true, // 페이지가 열릴때 포커스를 지정함
				lang : 'ko-KR',
				//onlmageUpload callback함수 -> 미설정시 data형태로 에디터 그대로 삽입
				callbacks : {
					onImageUpload : function(files, editor, welEditable) {
						for (var i = 0; i < files.length; i++) {
							sendFile(files[i], this);
						}
					}
				}
			});

			function sendFile(file, editor) {
				var data = new FormData();
				data.append('file', file);
				$
						.ajax({
							url : "imageUpload",
							type : "POST",
							data : data,
							cache : false,
							contentType : false,
							enctype : "multipart/form-data",
							processData : false,
							success : function(resp) {
								$(".note-editable")
										.append(
												"<img src='/resources/"+resp+"' width='480' height='auto'>");
								$("#path").val(resp);
							},
							fail : function(resp) {
								console.log(resp.url);
							}
						});

			}

			$("#complete").on(
					"click",
					function() {
						$("#contents").val($(".note-editable").html());
						if ($("#contents").val() == "<p><br></p>") {
							alert("게시글을 작성해주세요.");
						} else if ($("#title").val() == "") {
							alert("제목을 작성해주세요.");
						} else if ($("#contents").val() != "<p><br></p>"
								&& $("#title").val() != "") {
							$("#formEdit").submit();
						}
					})

		});
	</script>
</body>
</html>