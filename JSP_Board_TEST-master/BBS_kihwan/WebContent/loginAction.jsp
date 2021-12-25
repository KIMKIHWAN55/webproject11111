<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="board.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="board" class="board.Board" scope="page" />
<jsp:setProperty name="board" property="userID" />
<jsp:setProperty name="board" property="userPassword" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<title>프로젝트 게시판 웹사이트</title>

</head>

<body>
	<%
		String userID = null; //로그인이 된 유저는 로그인, 회원가입 페이지에 못들어오게 해야함
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID"); //해당 세션값 넣어줌 
	}
	if (userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어 있습니다.')");
		script.println("location.href='main.jsp'"); //이미 로그인이 되면 또 로그인 못하게 해줌
		script.println("</script>");
	}
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(board.getUserID(), board.getUserPassword());
	if (result == 1) {
		session.setAttribute("userID", board.getUserID());
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	} else if (result == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀렸습니다.')");
		script.println("history.back()"); //이전 페이지 즉 로그인페이지로 돌아가게 만듬
		script.println("</script>");
	} else if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다.')");
		script.println("history.back()"); //이전 페이지 즉 로그인페이지로 돌아가게 만듬
		script.println("</script>");
	} else if (result == -2) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('오류가 발생했습니다.')");
		script.println("history.back()"); //이전 페이지 즉 로그인페이지로 돌아가게 만듬
		script.println("</script>");
	}
	%>

</body>

</html>
