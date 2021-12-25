
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="board.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<title>프로젝트 게시판 웹사이트</title>

</head>

<body>
<!-- 로그아웃  -->
	<%
		session.invalidate();
	%>
	<script>
		location.href = 'main.jsp';  //로그아웃시에 main.jsp로 이동하게 해줌
	</script>
</body>

</html>
