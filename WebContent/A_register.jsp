<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page import="java.net.URLEncoder"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<style>
			.mytable { 
				border-collapse:collapse;
				}  
			.mytable th, .mytable td { 
				border:1px solid black; 
				padding: 10;
				}
		</style>
		<script>
		function validate(){
			var re_name = /^[가-힣]{1,10}$/;
			var name = document.getElementById("hname");
			
			if (insert.name.value == "") { // 이름칸이 비어있을 때
		         alert("이름을 입력하세요.");
		         insert.name.focus();
		         return false;
		      }
			
			if (!check(re_name, name, "이름은 10자이내의 한글로 입력하세요")) {
		         return false;
		      }				
		}
		function check(re, what, message) {
		      if (re.test(what.value)) {
		         return true;
		      }
		      alert(message);
		      what.value = "";
		      what.focus();
		}
		</script>
		<%
		try{
		//DB연결
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo14","root","ykj0112");
		Statement stmt = conn.createStatement();	
		
		//값 읽어오기
		ResultSet rset = stmt.executeQuery("select * from hubotable;");
		
		%>	
	</head>
	<body>
		<h3 align=center>-*-*-*-*-*-*-　　후보자 등록 및 삭제　　-*-*-*-*-*-*-</h3>
		<table class=mytable align=center>
			<tr>
				<td bgcolor=#9999ff><p align=center>기호 번호</p></td>
				<td bgcolor=#9999ff><p align=center>후보자명</p></td>
				<td bgcolor=#9999ff><p align=center>선택사항</p></td>
			</tr>
	
		<%
			//삭제부분
		while(rset.next()){
			out.println("<form method=post action='A_02_delete.jsp'>");
			out.println("<tr>");
			out.println("<td><input type=hidden name=huboID value="+rset.getInt(1)+">기호 "+rset.getInt(1)+"번</td>");
			out.println("<td><input type=hidden value="+rset.getString(2)+">"+rset.getString(2)+"</td>");
			out.println("<td align=center><input type=submit value=삭제></td>");
			out.println("</tr></form>");
		}		
			rset.close();
			
			//등록부분
			out.println("<form method=post onsubmit='return validate();' name=insert action='A_01_registration.jsp'>");
			out.println("<tr>");
			out.println("<td><input type=number min=1 max=100 name=huboID></td>");
			out.println("<td><input type=text id=hname name=huboName></td>");
			out.println("<td align=center><input type=submit value=등록></td>");
			out.println("</tr></form>");
			
			stmt.close();
			conn.close();
		}catch(Exception e){
			out.println("<p align=center>등록된 후보가 없습니다.</p>");
		}
		%>
		</table>
	</body>
</html>