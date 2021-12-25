
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
<jsp:setProperty name="board" property="userName" />
<jsp:setProperty name="board" property="userGender" />
<jsp:setProperty name="board" property="userEmail" />
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
	if (board.getUserID() == null || board.getUserPassword() == null || board.getUserName() == null
			|| board.getUserGender() == null || board.getUserEmail() == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 되지 않은 사항이 있습니다.')");
		script.println("history.back()"); //이전 페이지 즉 로그인페이지로 돌아가게 만듬
		script.println("</script>");
	} else {
		UserDAO userDAO = new UserDAO();
		int result = userDAO.join(board); //각 변수를 입력받은걸 가지고 만들어진 하나의 board라는 인스턴스가 join함수를 수행하도록 매개변수로 들어감
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다.')");
			script.println("history.back()"); //이전 페이지 즉 로그인페이지로 돌아가게 만듬
			script.println("</script>");
		} else {
			session.setAttribute("userID", board.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
	}
	%>

</body>

</html>
