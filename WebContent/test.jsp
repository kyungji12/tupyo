<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*"%>
<html>
	<head>

		<title>득표율화면</title>
		
		<%
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo14","root","ykj0112");
			Statement stmt = conn.createStatement();
			
			ResultSet rset = stmt.executeQuery("SELECT a.id, b.name, a.counting "+
					"from(SELECT id, COUNT(id) AS counting FROM tupyotable group BY id) AS a "+
					"join(SELECT  id, name FROM hubotable) AS b "+
					"ON a.id = b.id;");
		%>
		
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    	<script type="text/javascript">
		 google.charts.load('current', {'packages':['corechart']});
		 google.charts.setOnLoadCallback(drawChart);
			 
			function drawChart() {
			      var data = google.visualization.arrayToDataTable([
			        ['기호','link', '득표수'],
		        <%
					while(rset.next()){
						out.println("['"+rset.getInt(1)+"번 "+rset.getString(2)+"','./C_02_result.jsp?huboid="+rset.getInt(1)+"',"+rset.getInt(3)+"]");
						if(rset.isLast())break;
			            out.print(",");  
					}
		        %>
			      ]);
			  //퍼센트값 보이게하는 부분    
		      var groupData = google.visualization.data.group(
		    		    data,
		    		    [{column: 0, modifier: function () {return 'total'}, type:'string'}],
		    		    [{column: 2, aggregation: google.visualization.data.sum, type: 'number'}]
		    		  );

		    		  var formatPercent = new google.visualization.NumberFormat({
		    		    pattern: '#,##0.0%'
		    		  });

		    		  var formatShort = new google.visualization.NumberFormat({
		    		    pattern: 'short'
		    		  });

			      
		      	var view = new google.visualization.DataView(data);
			        //view.setColumns([0, 2]);
			         view.setColumns([0, 2, {
    				 calc: function (dt, row) {
     				 //var amount =  formatShort.formatValue(dt.getValue(row, 2));
     				 var percent = formatPercent.formatValue(dt.getValue(row, 2) / groupData.getValue(0, 1));
 				     return ' (' + percent + ')';
   					 },
				    type: 'string',
				    role: 'annotation'
				  }]);
			 
		        var options = {//annotations: {
			            //alwaysOutside: true},
			            'title':'후보 별 득표율','width':800,'height':600};
			 
		      	var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
			      	chart.draw(view, options);
			      	
		      	var selectHandler = function(e) {
			          window.location = data.getValue(chart.getSelection()[0]['row'], 1 );
			         }
		        google.visualization.events.addListener(chart, 'select', selectHandler);
			    }
	   </script>
	</head>
	
	<body>
		<h3 align=center>-*-*-*-*-*-*-　　후보자별 득표수　　-*-*-*-*-*-*-</h3>	
	    <div style="text-align:center;" id="chart_div">로딩중...</div>
	   		
		<%
			out.println("<form align=center method=post action='intro.jsp'>");
			out.println("<tr>");
			out.println("<td align=center><input type=submit value=홈으로></td>");
			out.println("</tr></form>");
			rset.close();
			stmt.close();
			conn.close();
		}catch(Exception e){
			out.println("오류가 발생하였습니다.");
		}
		%>
	</body>
</html>