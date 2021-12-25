
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
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
	Bbs bbs = new BbsDAO().getBbs(bbsID);
	if (!userID.equals(bbs.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이 글에 대한 권한이 없습니다.')");
		script.println("location.href='bbs.jsp'"); //이미 로그인이 되면 또 로그인 못하게 해줌
		script.println("</script>");
	} 
	//권한이 있을 때 성공적으로 넘어온다음 bbsTitle로 매개변수로써 넘어온 값들을 체크하는 과정(제목과 내용이 null인지 같은지)
	else {
		if (request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null
		|| request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 되지 않은 사항이 있습니다.')");
			script.println("history.back()"); //이전 페이지 즉 로그인페이지로 돌아가게 만듬
			script.println("</script>");
		} else {
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.update(bbsID,request.getParameter("bbsTitle"),request.getParameter("bbsContent")); //
			if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('글 수정에 실패했습니다.')");
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
