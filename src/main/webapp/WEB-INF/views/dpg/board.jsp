<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.js"></script>
<title>자유게시판</title>
<link rel="stylesheet" href="../resources/css/bootstrap.css">
<link rel="stylesheet" href="../resources/css/bootstrap-theme.css">
<script src="../resources/js/jquery.min.js"></script>
<script src="../resources/js/jquery-1.12.4.js"></script>
<script src="../resources/js/jquery.bxslider.js"></script>
<script src="../resources/js/bootstrap.js"></script>
<link rel="shortcut icon" type="image/x-icon"
	href="../resources/imgs/favicon.png" />
<script>
	var loginInfoNickName = "${loginInfo.nickName}";

	$(document).ready(
			function() {
				$('.bxslider').bxSlider({
					auto : true,
					speed : 300,
					pause : 2000,
					mode : 'horizontal',
					autoControlls : true,
					pager : false,
					autoHover : true,
					controls : false
				});

				var count = ${count};
				var cnt = count / 10;
				var startNum = ${startNum};
				for (var i = 0; i < cnt; i++) {
					if (startNum > 0)
						$('#previousLi').attr('href',
								"/dpg/board?startNum=" + (startNum - 10) + "");
					if ((startNum + 10) < count)
						$('#nextLi').attr('href',
								"/dpg/board?startNum=" + (startNum + 10) + "");
					$('#pageNum').find('li').last().before(
							"<li><a href='/dpg/board?startNum=" + (i * 10)
									+ "'>" + (i + 1) + "</a></li>");
				}
				;

				if (loginInfoNickName != "") {
					$('#writingAtag').attr('href',
							"/dpg/board/${loginInfo.nickName }/input?idx=0");
					$('#writingAtag').attr('data-toggle', "");
					$('#writingAtag').attr('data-target', "");
				}
			});
	$(function() {
		$('#content').keyup(function(e) {
			var content = $(this).val();
			$(this).height((((content.split('\n').length) * 0.5) - 4) + 'em');
			$('#counter').html(content.length + '/1000');
		});
		$('#content').keyup();
	});
</script>
</head>

<body>
	<jsp:include page="../template/navigation.jsp" flush="false" />
	<div class="container">
		<div class="row">
			<div class="col-sm-8">
				<ol class="breadcrumb">
					<li><h1>자유게시판</h1></li>
					<li><a href="/">Home</a></li>
					<li><a href="/dpg?startNum=0">DPG</a></li>
					<li class="active">게시판</li>
				</ol>
				<table class="table table-hover ">

					<tr>
						<th>제목</th>
						<th class="hidden-xs">작성자</th>
						<th class="hidden-xs hidden-sm">작성일</th>
						<th class="hidden-xs hidden-sm hidden-md">조회</th>
					</tr>
					
							<c:forEach items="${list}" var="bean">
								<tr>
									<td><a href="../dpg/board/${bean.dpgNum }"> <c:set
												var="text" value="${bean.dpgTitle}" /> <c:if
												test="${fn:length(text) lt 21}">
													${text }
											</c:if> <c:if test="${fn:length(text) ge 21}">
												${fn:substring(text,0,21)}...
											</c:if><!-- <span class="badge">35</span> -->
									</a></td>
									<td class="hidden-xs">${bean.dpgWriter }</td>
									<td class="hidden-xs hidden-sm">${bean.dpgNalja }</td>
									<td class="hidden-xs hidden-sm hidden-md">${bean.dpgCount }</td>
		
								</tr>
							</c:forEach> 
						
					
					<!-- <tr>
							<td></td>
							<td class="hidden-xs"></td>
							<td class="hidden-xs hidden-sm"></td>
							<td class="hidden-xs hidden-sm hidden-md"></td>
						</tr> -->
				</table>

				<nav class="col-xs-12">
					<a id="writingAtag" href="#" class="btn btn-default pull-right"
						data-toggle="modal" data-target="#login">글쓰기</a>

					<ul class="pagination" id="pageNum">
						<li><a id="previousLi" href="#">Previous</a></li>
						<li><a id="nextLi" href="#">Next</a></li>
					</ul>
				</nav>
				<form class="form-inline col-xs-12" method="post">
					<div class="form-group">
						<select class="form-control" name="utilSelect">
							<!-- <option>제목+내용</option> -->
							<option>제목</option>
							<!-- <option>내용</option> --> 
							<option>닉네임</option>
							<!-- <option>아이디</option> -->
						</select> <input type="text" class="form-control" id="exampleInputName2"
							placeholder="검색어를 입력하세요" name="utilInput">
							<input type="hidden" name="utilSubject" value="자유게시판"/>
						<button type="submit" class="btn btn-default">확인</button>
					</div>
				</form>
			</div>
			<div class="col-sm-4 hidden-xs">
				<jsp:include page="../template/bxslider.jsp" flush="false" />
			</div>
		</div>
	</div>
	<jsp:include page="../template/footer.jsp" flush="false" />
</body>
</html>