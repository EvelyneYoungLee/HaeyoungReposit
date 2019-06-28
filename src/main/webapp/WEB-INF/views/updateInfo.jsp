<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.4.0.min.js"></script>
<title>UpdateInfo</title>
<style>
.butt {
	margin-left: 50%;
}

.info {
	width: 98%;
	height: 100%;
	margin: none;
	padding: none;
}
</style>
</head>
<body>
	<form action="updateProc" id="update" method="post" enctype="multipart/form-data">
		<table border=1 align=center>
			<tr>
				<th>프로필사진
				<td><img id="newImg" src="/resources/${dto.profileImg}"></td>
				<td><input type=file id="updateImg" name="image"> 
				<input type=hidden value="${dto.profileImg}">
			<tr>
			<tr>
				<th>ID
				<td id="idtd" colspan=2><input type=text value="${dto.id}"
					class="info" id="id" name="id" readonly></td>
			<tr>
				<th>PW
				<td id="pwtd"><input type=text value="********" class="info"
					id="pw" name="pw" required readonly></td>
				<td><input type=button id="updatePw" value="수정하기">
			<tr>
				<th>Name
				<td id="nametd"><input type=text value="${dto.name}"
					class="info" name="name" id="name" required readonly></td>
				<td><input type=button id="updateName" value="수정하기">
			<tr>
				<Th>Phone
				<td id="phonetd"><input type=text value="${dto.phone}"
					class="info" name="phone" id="phone"
					pattern="^(01)[0-9]-[0-9]{3,4}-[0-9]{4}$" required readonly></td>
				<td><input type=button id="updatePhone" value="수정하기">
			<tr>
				<th>Email
				<td id="emailtd"><input type=text value="${dto.email}"
					class="info" name="email" id="email" flag="true"
					pattern=".+@.+\..+" required readonly></td>
				<td><input type=button id="updateEmail" value="수정하기">
			<tr>
				<th>우편번호
				<td id="zipcodetd"><input type=text value="${dto.zipcode}"
					class="info" name="zipcode" id="postcode" readonly></td>
				<td><input type=button id="search" value="수정하기">
			<tr>
				<th>주소
				<td id="addr1td" colspan=2><input type=text
					value="${dto.address1}" class="info" name="address1" id="address1"
					readonly></td>
			<tr>
				<th>상세 주소
				<td id="addr2td"><input type=text value="${dto.address2}"
					class="info" name="address2" id="address2" readonly></td>
				<td><input type=button id="updateAddr2" value="수정하기">
			<tr>
				<th>가입일시
				<td colspan=2>${dto.joinDate}</td>
		</table>
		<br> <input type=submit value="수정 완료" id="confirm" class="butt">
		<input type=button value="초기화" id="reNew">
	</form>

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

		$("#updateImg").change(function() {
			readURL(this);
		});

		document.getElementById("reNew").onclick = function() {
			location.href = "update";
		}
		document.getElementById("updatePw").onclick = function() {
			document.getElementById("pw").setAttribute("value", "");
			document.getElementById("pw").readOnly = false;
		}
		document.getElementById("updateName").onclick = function() {
			document.getElementById("name").setAttribute("value", "");
			document.getElementById("name").readOnly = false;
		}
		document.getElementById("updatePhone").onclick = function() {
			document.getElementById("phone").setAttribute("value", "");
			document.getElementById("phone").readOnly = false;
		}
		document.getElementById("updateEmail").onclick = function() {
			document.getElementById("email").setAttribute("value", "");
			document.getElementById("email").readOnly = false;
		}

		document.getElementById("updateAddr2").onclick = function() {
			document.getElementById("addr2").setAttribute("value", "");
			document.getElementById("addr2").readOnly = false;
		}
	</script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script>
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