<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Read Attendance</title>
    <style>
body {
    background-image: url('https://th.bing.com/th/id/OIP.Zzhl66kLn8kF2miVAiuKtwHaLH?w=640&h=960&rs=1&pid=ImgDetMain');
    background-size: cover; /* Cover the entire background */
    background-position: center; /* Center the background image */
    background-repeat: no-repeat; /* Prevent repeating of background image */
    background-color: #f2f2f2; /* Fallback background color */
    font-family: Arial, sans-serif;
    text-align: center;
    margin: 0;
    overflow: hidden; /* Hide any overflow content */
    height: 100vh; /* Ensure full viewport height */
}
        table {
            margin: 0 auto;
            border-collapse: collapse;
            width: 80%;
        }
        table, th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>Read Attendance</h1>

    <table>
        <tr>
            <th>Date</th>
            <th>Roll No. 1</th>
            <th>Roll No. 2</th>
            <th>Roll No. 3</th>
            <th>Roll No. 4</th>
            <th>Roll No. 5</th>
        </tr>
        <%
            String url = "jdbc:mysql://localhost:3306/attendance";
            String user = "root";
            String password = "6362";

            Connection con = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(url, user, password);

                if (request.getMethod().equals("POST")) {
                    String readOption = request.getParameter("readOption");

                    if (readOption.equals("complete")) {
                        String query = "SELECT * FROM attendance";
                        pstmt = con.prepareStatement(query);
                        rs = pstmt.executeQuery();

                        while (rs.next()) {
                            out.print("<tr>");
                            out.print("<td>" + rs.getDate("date") + "</td>");
                            out.print("<td>" + rs.getString("r1") + "</td>");
                            out.print("<td>" + rs.getString("r2") + "</td>");
                            out.print("<td>" + rs.getString("r3") + "</td>");
                            out.print("<td>" + rs.getString("r4") + "</td>");
                            out.print("<td>" + rs.getString("r5") + "</td>");
                            out.print("</tr>");
                        }
                    } else if (readOption.equals("date")) {
                        String dateToRead = request.getParameter("dateToRead");

                        String query = "SELECT * FROM attendance WHERE date = ?";
                        pstmt = con.prepareStatement(query);
                        pstmt.setDate(1, java.sql.Date.valueOf(dateToRead));
                        rs = pstmt.executeQuery();

                        if (rs.next()) {
                            out.print("<tr>");
                            out.print("<td>" + rs.getDate("date") + "</td>");
                            out.print("<td>" + rs.getString("r1") + "</td>");
                            out.print("<td>" + rs.getString("r2") + "</td>");
                            out.print("<td>" + rs.getString("r3") + "</td>");
                            out.print("<td>" + rs.getString("r4") + "</td>");
                            out.print("<td>" + rs.getString("r5") + "</td>");
                            out.print("</tr>");
                        } else {
                            out.print("<tr><td colspan='6'>No attendance recorded for this date.</td></tr>");
                        }
                    }
                }
            } catch (ClassNotFoundException | SQLException e) {
                out.print("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
            } finally {
                try {
                    if (rs != null) {
                        rs.close();
                    }
                    if (pstmt != null) {
                        pstmt.close();
                    }
                    if (con != null) {
                        con.close();
                    }
                } catch (SQLException e) {
                    out.print("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
                }
            }
        %>
    </table>

    <form action="read.jsp" method="post">
        <input type="radio" name="readOption" value="complete" id="complete" onclick="document.getElementById('date-fields').style.display = 'none';">
        <label for="complete">Complete Attendance</label><br>
        <input type="radio" name="readOption" value="date" id="date" onclick="document.getElementById('date-fields').style.display = 'block';">
        <label for="date">Attendance on a Particular Date:</label>
        <div id="date-fields" class="additional-fields" style="display: none;">
            <label for="dateToRead">Select Date:</label>
            <input type="date" name="dateToRead" id="dateToRead">
        </div><br>
        <button type="submit">Read</button>
    </form>
    <a href="Index.jsp" class="button">Back to Home</a>
</body>
</html>
