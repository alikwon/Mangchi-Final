<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<style>
body {
	margin: 0;
	padding: 0;
}

.memberList {
	width: 20%;
	display: block;
	margin: 0;
}

div.card {
	width: 25%;
	border: 1px solid #DDD;
	display: unset;
}

div.card>ul>li {
	list-style: none;
	font-size: 12px;
}

.haha {
	width: 50%;
	display: block;
	margin: 0;
}

#profile-menu {
	top: 90px;
	margin-left: 40px;
	width: 220px;
	display: block;
	background: #fff;
	-webkit-box-shadow: 0 0 1px 0 rgba(0, 0, 0, 0.1);
	box-shadow: 0 0 1px 0 rgba(0, 0, 0, 0.1);
	-webkit-transform: translateY(-400px);
	-moz-transform: translateY(-400px);
	-o-transform: translateY(-400px);
	-ms-transform: translateY(-400px);
	transform: translateY(-400px);
	-webkit-transition: -webkit-transform .3s;
	-moz-transition: -moz-transform .3s;
	-o-transition: -o-transform .3s;
	-ms-transition: -ms-transform .3s;
	transition: transform .3s;
	-moz-transform: translateY(-400px);
	-o-transform: translateY(-400px);
	-ms-transform: translateY(-400px);
	transform: translateY(-400px);
	background: #fff;
}

#profile-menu.active {
	-webkit-transform: translateY(0);
	-moz-transform: translateY(0);
	-o-transform: translateY(0);
	-ms-transform: translateY(0);
	transform: translateY(0)
}

#profile-menu:before {
	width: 0;
	height: 0;
	border-style: solid;
	border-width: 0 9px 9px 9px;
	border-color: transparent transparent #fff transparent;
	content: '';
	display: block;
	position: absolute;
	top: -9px;
	left: 18px
}

#profile-menu a {
	background: #fff;
	display: block;
	padding: 18px 0 18px 25px;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
	text-decoration: none;
	font-size: 16px;
	color: #333;
	border: 1px solid #e8e8e8;
	margin-top: -1px;
}

#profile-menu a:hover {
	background: #f3f3f3
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div class="w3-container">
		<h2>나의 리뷰</h2>
		<hr>

		<div class="w3-cell-row">
			<div class="w3-cell">
				<div id="profile-menu" class="active">
					<a href="requestListForm">요청 리스트</a> <a href="lendingListForm">대여리스트</a>
					<a href="reviewListForm">나의 리뷰</a> <a href="commentListForm">나의
						댓글</a> <a href="mypageForm">나의 정보</a> <a href="distSetForm">거리 설정</a>
					<a href="keywordSetForm">키워드 설정</a>
				</div>
			</div>
			<div class="w3-cell">
				<div id="reviewList"></div>
			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />




	<script>
		function listpage(data) {
			page = data;
			list();
		}

		var page = 1;
		// 요청리스트 출력

		function list() {
			$
					.ajax({
						url : 'http://localhost:8080/rl/review/'
								+ '${loginInfo.mNick}',
						type : 'GET',
						data : {
							page : page
						},
						success : function(data) {

							var html = '';
							html += '<table class="w3-table w3-border w3-hoverable">';
							html += '	<tr class="w3-hover-grayscale">';
							html += '	<th>번호</th>';
							html += '	<th>상대방</th>';
							html += '	<th>작성자</th>';
							html += '	<th>내용 ?</th>';
							html += '	</tr>';

							for (var i = 0; i < data.reviewList.length; i++) {
								html += '<tr>';
								html += ' <td>' + (i + data.startRow + 1)
										+ '</td>';

								html += '</td>';
								html += ' <td>' + data.reviewList[i].receiver
										+ '</td>';

								html += ' <td>' + data.reviewList[i].writer
										+ '</td>';

								html += ' <td>' + data.reviewList[i].text
										+ '</td>';
										
								html += '</tr>';
							}
							html += '</table>';
							if (data.pageTotalCount > 0) {
								for (var m = 1; m <= data.pageTotalCount; m++) {
									html += '<a id="listlink" ';
									html += 'href="#" onclick="listpage(' + m
											+ ')"';
									html += ">";
									html += '[' + m + ']';
									html += '</a>';
								}
							}

							html += ' <div>평점 ' + data.avg +'</div>';
							$('#reviewList').html(html);

						}
					});

		}

		$(document).ready(function() {
			list();
		});
	</script>

</body>
</html>