
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
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
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.')");
		script.println("location.href='login.jsp'"); //이미 로그인이 되면 또 로그인 못하게 해줌
		script.println("</script>");
	} else {
		if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 되지 않은 사항이 있습니다.')");
			script.println("history.back()"); //이전 페이지 즉 로그인페이지로 돌아가게 만듬
			script.println("</script>");
		} else {
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent()); //
			if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('글 작성에 실패했습니다.')");
		script.println("history.back()"); //이전 페이지 즉 로그인페이지로 돌아가게 만듬
		script.println("</script>");
			} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='bbs.jsp'");
		script.println("</script>");
			}
		}

	}
	%>

</body>

</html>
