
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>

<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- 뷰포트 -->

<meta name="viewport" content="width=device-width" initial-scale="1">

<!-- 스타일시트 참조  -->

<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/custom.css">

<title>프로젝트 JSP 게시판 웹사이트</title>

</head>

<body>
	<!-- 로그인 된 사람은 로그인 정보를 담을 수 있게 만들어줌 -->
	<%
		String userID = null; //그렇지 않으면 null값
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	int bbsID = 0;
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if (bbsID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('선택한 글이 없습니다.')");
		script.println("location.href='bbs.jsp'"); //이미 로그인이 되면 또 로그인 못하게 해줌
		script.println("</script>");
	}
	Bbs bbs = new BbsDAO().getBbs(bbsID); //유효한 글이라면 bbsID가 0이아니므로 구체적인 정보를 Bbs란 인스턴스안에 담을 수 있도록 해준다.
	%>

	<!-- 네비게이션  -->

	<nav class="navbar navbar-default">

		<div class="navbar-header">

			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expaned="false">

				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>

			</button>

			<a class="navbar-brand" href="main.jsp">kihwan의 게시판</a>

		</div>

		<div class="collapse navbar-collapse"
			id="#bs-example-navbar-collapse-1">

			<ul class="nav navbar-nav">

				<li><a href="main.jsp">메인</a></li>
				<!-- <--- 현재 접속 페이지가 메인이란 걸 알려줌 -->

				<li class="active"><a href="bbs.jsp">게시판</a></li>

			</ul>
			<%
				if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">

				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>

					<ul class="dropdown-menu">

						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>

					</ul></li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">

				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>

					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
			<%
				}
			%>
		</div>

	</nav>

	<!-- 게시판 화면 -->
	<div class="container">
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3"
							style="background-color: #eeeeee; text-align: center;">게시판 글
							보기</th>
					</tr>
				</thead>
				<tbody>
					<!--특수문자 및 공백도 출력시키게 함으로써 XSS공격해킹기법을 막아줄 수 있다. -->
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ", "&nbsp").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n",
		"<br>")%></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%=bbs.getUserID()%></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%=bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시"
		+ bbs.getBbsDate().substring(14, 16) + "분"%></td>
					</tr>
					<tr>
						<!-- 특수문자 및 공백 출력시키기-->
						<td>내용</td>
						<td colspan="2">
							<div class="bbs-content"
								style="min-height: 200px; text-align: left">
								<%=bbs.getBbsContent().replaceAll(" ", "&nbsp").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n",
		"<br>")%>
							</div>
						</td>
					</tr>
					</tr>
				</tbody>
			</table>
			<!-- 목록으로 돌아갈 수 있게 버튼 만들기, 현재 글로 들어온 작성자가 본인일때   a태그를 이용한 수정 삭제 가능하게 함 -->
			<a href="bbs.jsp" class="btn btn-primary">목록</a>
			<%
				if (userID != null && userID.equals(bbs.getUserID())) {
			%>
			<a href="update.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">수정</a>
			<!-- 삭제 버튼 클릭 시 삭제하시겠습니까 메시지 띄우기 -->
			<a onclick="return confirm('삭제하시겠습니까?')"
				href="deleteAction.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">삭제</a>
			<%
				}
			%>
			<!-- 글쓰기 버튼 불필요 -->
			<!-- <input type="submit" class="btn btn-primary pull-right" value="글쓰기"></a> -->
		</div>
	</div>


	<!-- 애니매이션 담당 JQUERY -->

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

	<!-- 부트스트랩 JS  -->

	<script src="js/bootstrap.js"></script>



</body>

</html>
