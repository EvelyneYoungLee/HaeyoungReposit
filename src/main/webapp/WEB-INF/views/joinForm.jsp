<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
<script>
	$(function() {

		$("#pwConfirm").on("input", function() {
			if ($("#pw").val() == $("#pwConfirm").val()) {
				$("#result").text("비밀번호가 일치합니다.");
				$("#result").css("color", "dodgerblue");
				$("#pwConfirm").attr("flag", "true")
			} else {
				$("#result").text("비밀번호가 불일치합니다.");
				$("#result").css("color", "red");
				$("#pwConfirm").attr("flag", "false")
			}
		});

		$("#id").on(
				"input",
				function() {
					var idCheck = /[a-z0-9]{8,}$/g;
					if (idCheck.exec($("#id").val()) != null) {
						$("#id").attr("flag", "true");
						$.ajax({
							url : "idDuplCheck",
							type : "post",
							data : {
								id : $("#id").val()
							}
						}).done(
								function(resp) {
									if (resp == 0) {
										$("#idDuplCheck").text(
												$("#id").val()
														+ "은 사용가능한 아이디입니다.");
										$("#idDuplCheck").css("color",
												"dodgerblue");
										$("#id").attr("distinct", "true")
									} else {
										$("#idDuplCheck").text(
												$("#id").val()
														+ "은 이미 사용중인 아이디입니다.");
										$("#idDuplCheck").css("color", "red");
										$("#id").attr("distinct", "false")
									}
								});
					} else if ($("#id").val() == "") {
						$("#idDuplCheck").text("아이디를 입력해주세요.");
						$("#idDuplCheck").css("color", "red");
						$("#id").attr("flag", "false");
					} else {
						$("#idDuplCheck").text("아이디를 요청한 형식에 맞춰주세요.");
						$("#idDuplCheck").css("color", "hotpink");
						$("#id").attr("flag", "false");
					}
				});

		$("#reNew").on("click", function() {
			$("#result").text("");
			$("#idDuplCheck").text("");
		});

		$("#signUp").on(
				"click",
				function() {
					var idCheck = /[a-z0-9]{8,}$/g;
					var phoneCheck = /^(01)[0-9]-[0-9]{3,4}-[0-9]{4}$/g;
					var emailCheck = /.+@.+\..+/g;

					if (idCheck.exec($("#id").val()) != null) {
						$("#id").attr("flag", "true");
					} else {
						$("#id").focus();
						alert("아이디를 요청한 형식에 맞춰주세요.");
						return false;
					}
					if ($("#id").attr("distinct") != "true") {
						$("#id").attr("flag", "false")
						$("#id").focus();
						alert("아이디 중복을 확인해주세요.");
						return false;
					}

					if ($("#pw").val() != "") {
						$("#pw").attr("flag", "true")
					} else {
						$("#pw").focus();
						alert("비밀번호를 입력해주세요.");
						return false;
					}

					if ($("#pwConfirm").val() == "") {
						$("#pw").focus();
						alert("비밀번호 확인을 입력해주세요.");
						return false;
					}

					if ($("#pw").val() != $("#pwConfirm").val()) {
						$("#pwConfirm").focus();
						alert("비밀번호 확인을 일치시켜주세요.");
						return false;
					}

					if ($("#name").val() != "") {
						$("#name").attr("flag", "true")
					} else {
						$("#name").focus();
						alert("이름을 입력해주세요.");
						return false;
					}
					if (phoneCheck.exec($("#phone").val()) != null) {
						$("#phone").attr("flag", "true")
					} else {
						$("#phone").focus();
						alert("전화번호 형식을 맞춰주세요.");
						return false;
					}
					if (emailCheck.exec($("#email").val()) != null) {
						$("#email").attr("flag", "true")
					} else {
						$("#email").focus();
						alert("이메일 형식을 맞춰주세요.");
						return false;
					}

					if ($("#id").attr("flag") == "true"
							&& $("#pw").attr("flag") == "true"
							&& $("#pwConfirm").attr("flag") == "true"
							&& $("#name").attr("flag") == "true"
							&& $("#phone").attr("flag") == "true"
							&& $("#email").attr("flag") == "true") {
						$("#signForm").submit();
					}
				})
	})
</script>
<style>
.menu {
	text-align: right;
}

#buttons {
	text-align: center;
}

.phone {
	width: 20%;
}

button {
	border-radius: 3px;
}
</style>
</head>
<body>
	<form action="joinMember" id="signForm" method="post"
		enctype="multipart/form-data">
		<table border=1px solid black width=800px>
			<tr>
				<th colspan=2>회원 가입 정보
			</tr>

			<tr>
				<td class="menu" width=25%>*프로필사진 :
				<td><input type=file name="image" id="imageInp" required>
			</tr>

			<tr>
				<td class="menu" width=25%>*선택된 사진 :
				<td><img id="newImg" src="#" alt="프로필 이미지 미설정" />
			</tr>

			<tr>
				<td class="menu" width=25%>*아이디 :
				<td><input type=text name="id" id="id" flag="false"
					distinct="false" placeholder="8자 이상,알파벳 소문자/숫자" required><span
					id="idDuplCheck"></span>
			</tr>

			<tr>
				<td class="menu" width=25%>*비밀번호 :
				<td><input type=password id="pw" name="pw" flag="false"
					required>
			</tr>

			<tr>
				<td class="menu" width=25%>*비밀번호 확인:
				<td><input type=password id="pwConfirm" flag="false" required><span
					id="result"></span>
			</tr>

			<tr>
				<td class="menu" width=25%>*이름 :
				<td><input type=text name="name" id="name" flag="false"
					required>
			</tr>

			<tr>
				<td class="menu" width=25%>*전화번호 :
				<td><input type=text name="phone" id="phone"
					placeholder="핸드폰 번호 (- 포함)" flag="false" required> <!-- <select name="phoneLoc">
						<option>02</option>
						<option>031</option>
						<option selected>010</option>
						<option>011</option>
						<option>019</option>
				</select> - <input type=text class="phone" name="phone1"> - <input
					type=text class="phone" name="phone2"> -->
			</tr>

			<tr>
				<td class="menu" width=25%>*이메일 :
				<td><input type=text name="email" id="email"
					placeholder="예시 : xxxx@yyyy.com" flag="false" required>
			</tr>

			<tr>
				<td class="menu" width=25%>우편번호 :
				<td><input type=text name="zipcode" id="postcode"
					placeholder="우편번호" readonly> <input type=button value="찾기"
					id="search">
			</tr>

			<tr>
				<td class="menu" width=25%>주소1 :
				<td><input type=text name="address1" id="address1"
					placeholder="주소" readonly> <span id="guide"
					style="color: #999; display: none"></span>
			</tr>

			<tr>
				<td class="menu" width=25%>주소2 :
				<td><input type=text name="address2" id="address2"
					placeholder="상세주소">
			</tr>

			<tr>
				<td colspan=2 id="buttons"><input type=button value="회원가입"
					id="signUp"> <input type=reset value="다시 입력" id="reNew">
					<input type="button" value="home으로 가기" id="toHome">
			</tr>
		</table>
	</form>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script>
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#newImg').attr('src', e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
		}

		$("#imageInp").change(function() {
			readURL(this);
		});

		$("#toHome").on("click", function() {
			$(location).attr("href", "toHome")
		})
		document.getElementById("search").onclick = searchaddress;
		function searchaddress() {
			new daum.Postcode({
				oncomplete : function(data) {

					var roadAddr = data.roadAddress; // 도로명 주소 변수
					var extraRoadAddr = ''; // 참고 항목 변수

					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraRoadAddr += data.bname;
					}
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraRoadAddr += (extraRoadAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
					if (extraRoadAddr !== '') {
						extraRoadAddr = ' (' + extraRoadAddr + ')';
					}

					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					document.getElementById('postcode').value = data.zonecode;
					document.getElementById("address1").value = roadAddr;

				}
			}).open();
		}
	</script>
</body>
</html>