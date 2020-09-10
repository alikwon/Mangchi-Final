<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<link rel="stylesheet"
	href="<c:url value='/resources/css/member/mypage.css'/>">
	
<link rel="stylesheet" href="<c:url value="/resources/css/jin.css"/>">	
<style>
	
</style>

</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div class="w3-container container">
		<h2>${loginInfo.mNick}님의 요청리스트</h2>
		<hr>
		<div class="w3-cell-row">
			<div class="w3-cell" style="width: 25%">
				<div id="profile-menu" class="active">
					<a href="requestListForm">요청 리스트</a> 
					<a href="lendingListForm">대여리스트</a>
					<a href="reviewListForm">나의 리뷰</a> 
					<a href="commentListForm">나의 댓글</a> 
					<a href="mypageForm">나의 정보</a> 
					<a href="distSetForm">거리 설정</a>
					<a href="keywordSetForm">키워드 설정</a>
				</div>
			</div>
			<div class="w3-cell" style="width: 75%">
				<div id="requestList" style="margin-right: 10%"></div>
				<div id="page"></div>
			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<script>
		
		var page = 1;
		var pageStart = 1; // 페이지 시작 수 
		var pageEnd = 1; // 페이지 끝 수   
		
		function listpage(data) {
			page = data;
			list();
		}
		
		//이전 페이지
		function prev(data){
			page = data - 1;
			
			if(page > 1){
				pageStart = pageStart-2;
				pageEnd = pageEnd-2;
			}else{
				pageStart = 1;
				pageEnd = 2;
			}
			
			if(page == 0){
				console.log('현재 페이지 '+page);
				alert('첫 페이지 입니다.');
			}else{
				list();
			}
		}
		//마지막 페이지
		function next(data,totalCnt){
			page = data + 1;
			
			if(page > totalCnt){
				alert('마지막 페이지 입니다.');			
			}else{
				if(page > pageEnd){
					pageStart = pageStart+2;
					pageEnd = pageEnd+2;
				}
				list();
			}
		}
		
		function detail(reqIdx,calDistance,reqCount){
			 var form = $('<form></form>');
			    form.attr('action', '/mangh/request/requestDetail');
			    form.attr('method', 'post');
			    form.appendTo('body');
			    var idx = $("<input type='hidden' value="+reqIdx+" name='idx'>"); //게시글 번호
			    var distance = $("<input type='hidden' value="+calDistance+" name='distance'>"); //게시글 상태 
			    var count = $("<input type='hidden' value="+reqCount+" name='count'>"); //게시글 상태 
			    form.append(idx);
			    form.append(distance);
			    form.append(count);
			    form.submit(); 
		}
		
		
		// 요청리스트 출력
		var type = "request";

		function list() {
			$.ajax({
						url : 'http://ec2-52-79-249-25.ap-northeast-2.compute.amazonaws.com:8080/rl/mypage/'+ '${loginInfo.mNick}',
						type : 'GET',
						data : {
							type : type,
							page : page
						},
						success : function(data) {

							var html = '';
							html += '<table style="table-layout: fixed" >';
							html += '	<tr>';
							html += '	<th>번호</th>';
							html += '	<th>글 제목</th>';
							//html += '	<th>지역</th>';
							html += '	<th>상태</th>';
							html += '	<th>작성자</th>';
							html += '	<th>조회수</th>';
							html += '	<th>등록날짜</th>';
							html += '	</tr>';

							if (data.pageTotalCount > 0) {
								for (var i = 0; i < data.requestReg.length; i++) {
									html += '<tr>';
									html += ' <td>' + (i + data.startRow + 1) + '</td>';
							
									html += '<td><div onclick="detail('+data.requestReg[i].reqIdx+','+data.requestReg[i].calDistance+','+data.requestReg[i].reqCount+')">'+data.requestReg[i].reqTitle+'</div></td>';		
													
									//html += ' <td>' + data.requestReg[i].reqAddr+ '</td>';
									var status, color;
									if (data.requestReg[i].reqStatus == 0) {
										status = '대기중';
										color = 'red';
									} else if (data.requestReg[i].reqStatus == 1) {
										status = '요청 완료';
										color = 'gray';
									}
									html += '	<td style="color: '+color+'">';
									html += '		' + status + '';
									html += '</td>';
									html += ' <td>' + data.requestReg[i].reqWriter
											+ '</td>';
									html += ' <td>' + data.requestReg[i].reqCount
											+ '</td>';
									html += ' <td>' + data.requestReg[i].reqDateTime
											+ '</td>';
									html += '</tr>';
								}
								} else {
								//	html +='<tr>';
									html += '<td colspan="5">작성된 리뷰가 없습니다.</td>';
								/* 	html +='<td></td>';
									html +='<td></td>';
									html +='<td></td>';
									html +='<td>작성 된 요청이 없습니다.</td>';
									html +='<td></td>';
									html +='<td></td>'; */
								//	html +='</tr>';
								}
							html += '</table>';
							
							 if (data.pageTotalCount > 0) {
								
								 var paging ='';
								 	
									paging += '<span id="page_number"><button id="page_btn" onclick="prev('+page+')"><</button></span>';
//									for (var m = 1; m <= data.pageTotalCount; m++) {
									for (var m = pageStart; m <= pageEnd ; m++) {
										paging += '<span id="page_number">';
										paging += '	<button id="page_btn" ';
										if(page == m){
											paging += 'class="listlink"';
										}
										paging += ' href="#" onclick="listpage('+m+')" value="'+m+'">';
										paging +=  m ;
										paging += '	</button>';
										paging +='</span>';
									}
									paging += '<span id="page_number"><button id="page_btn" onclick="next('+page+','+data.pageTotalCount+')">></button></span>';
								 $('#page').html(paging);
								 $('#requestList').html(html);
							} else{
								
								/* alert('검색 결과가 없습니다.');
								page = 1;
								history.go(0); */
								alert('게시글이 없습니다.');
								
							}

						}
					});

		}

		$(document).ready(function() {
			list();
		});
	</script>
</body>
</html>