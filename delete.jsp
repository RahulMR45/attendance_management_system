<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Attendance</title>
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

        .message {
            margin: 20px auto;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            font-weight: bold;
            border-radius: 5px;
            width: 50%;
        }
    </style>
</head>
<body>
    <h1>Delete Attendance</h1>

    <div class="message">
        <%
            String url = "jdbc:mysql://localhost:3306/attendance";
            String user = "root";
            String password = "6362";

            Connection con = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(url, user, password);

                if (request.getMethod().equals("POST")) {
                    String dateToDelete = request.getParameter("dateToDelete");

                    String query = "DELETE FROM attendance WHERE date=?";
                    pstmt = con.prepareStatement(query);
                    pstmt.setDate(1, java.sql.Date.valueOf(dateToDelete));
                    int rowsAffected = pstmt.executeUpdate();

                    if (rowsAffected > 0) {
                        out.print("<p>Attendance deleted successfully.</p>");
                    } else {
                        out.print("<p>No attendance found for the specified date.</p>");
                    }
                }
            } catch (ClassNotFoundException | SQLException e) {
                out.print("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (pstmt != null) {
                        pstmt.close();
                    }
                    if (con != null) {
                        con.close();
                    }
                } catch (SQLException e) {
                    out.print("<p>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>

    <form action="delete.jsp" method="post">
        <label for="dateToDelete">Select Date to Delete Attendance:</label>
        <input type="date" name="dateToDelete" id="dateToDelete" required>
        <button type="submit">Delete</button>
    </form>
    <a href="Index.jsp" class="button">Back to Home</a>
</body>
</html>
