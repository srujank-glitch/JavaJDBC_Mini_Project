<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Reservation, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Report Result | HMS</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', sans-serif; background: #f0f4f8; }
        nav {
            background: #1a3c5e; padding: 0 30px;
            display: flex; align-items: center; justify-content: space-between; height: 60px;
        }
        nav .brand { color: #fff; font-size: 20px; font-weight: bold; text-decoration: none; }
        nav a { color: #cde; text-decoration: none; margin-left: 20px; font-size: 14px; }
        nav a:hover { color: #fff; }
        .container { max-width: 1000px; margin: 40px auto; padding: 0 20px; }
        .top-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px; }
        h2 { color: #1a3c5e; font-size: 22px; }
        .btn-back {
            background: #8e44ad; color: #fff; padding: 9px 20px;
            border-radius: 8px; text-decoration: none; font-size: 14px; font-weight: 600;
        }
        .btn-back:hover { background: #7d3c98; }
        .btn-home {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 9px 18px;
            background: #fff; color: #1a3c5e;
            border: 2px solid #1a3c5e; border-radius: 8px;
            font-size: 14px; font-weight: 600; text-decoration: none;
            transition: background 0.2s, color 0.2s;
        }
        .btn-home:hover { background: #1a3c5e; color: #fff; }
        table {
            width: 100%; border-collapse: collapse; background: #fff;
            border-radius: 12px; overflow: hidden;
            box-shadow: 0 4px 16px rgba(0,0,0,0.09);
        }
        th {
            background: #1a3c5e; color: #fff; padding: 14px 16px;
            text-align: left; font-size: 13px; text-transform: uppercase;
        }
        td { padding: 13px 16px; border-bottom: 1px solid #f0f0f0; font-size: 14px; color: #333; }
        tr:last-child td { border-bottom: none; }
        tr:hover td { background: #f7faff; }
        .revenue-box {
            background: #fff; border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.09);
            padding: 40px; text-align: center;
        }
        .revenue-box .amount { font-size: 48px; font-weight: bold; color: #27ae60; margin: 16px 0; }
        .revenue-box p { color: #666; font-size: 15px; }
        .empty {
            text-align: center; padding: 40px; color: #888; font-size: 15px;
            background: #fff; border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.09);
        }
    </style>
</head>
<body>

<nav>
    <a class="brand" href="index.jsp">&#127970; HotelMS</a>
    <div>
        <a href="reservationadd.jsp">Add</a>
        <a href="DisplayReservationsServlet">View All</a>
        <a href="report_form.jsp">Reports</a>
    </div>
</nav>

<div class="container">
    <div class="top-bar">
        <h2>&#128202; <%= request.getAttribute("reportTitle") %></h2>
        <div style="display:flex; gap:10px;">
            <a href="index.jsp" class="btn-home">&#8592; Back to Home</a>
            <a class="btn-back" href="report_form.jsp">&#8592; New Report</a>
        </div>
    </div>

<%
String reportType = (String) request.getAttribute("reportType");

if ("dateRange".equals(reportType)) {
    List<Reservation> list = (List<Reservation>) request.getAttribute("reservations");
    if (list == null || list.isEmpty()) {
%>
    <div class="empty">No reservations found in this date range.</div>
<%
    } else {
%>
    <table>
        <tr>
            <th>ID</th>
            <th>Customer</th>
            <th>Room</th>
            <th>Check-In</th>
            <th>Check-Out</th>
            <th>Amount (Rs.)</th>
        </tr>
<%
        for (Reservation r : list) {
%>
        <tr>
            <td><%= r.getReservationID() %></td>
            <td><%= r.getCustomerName() %></td>
            <td><%= r.getRoomNumber() %></td>
            <td><%= r.getCheckIn() %></td>
            <td><%= r.getCheckOut() %></td>
            <td>Rs. <%= String.format("%.2f", r.getTotalAmount()) %></td>
        </tr>
<%
        }
%>
    </table>
<%
    }
} else if ("mostBooked".equals(reportType)) {
    List<String[]> roomStats = (List<String[]>) request.getAttribute("roomStats");
    if (roomStats == null || roomStats.isEmpty()) {
%>
    <div class="empty">No booking data available.</div>
<%
    } else {
%>
    <table>
        <tr>
            <th>Rank</th>
            <th>Room Number</th>
            <th>Total Bookings</th>
        </tr>
<%
        int rank = 1;
        for (String[] row : roomStats) {
%>
        <tr>
            <td><%= rank++ %></td>
            <td><%= row[0] %></td>
            <td><%= row[1] %></td>
        </tr>
<%
        }
%>
    </table>
<%
    }
} else if ("revenue".equals(reportType)) {
    Double revenue  = (Double) request.getAttribute("revenue");
    String fromDate = (String) request.getAttribute("fromDate");
    String toDate   = (String) request.getAttribute("toDate");
%>
    <div class="revenue-box">
        <p>Total Revenue from <strong><%= fromDate %></strong> to <strong><%= toDate %></strong></p>
        <div class="amount">Rs. <%= String.format("%.2f", revenue != null ? revenue : 0.0) %></div>
        <p>Based on all completed reservations in the selected period.</p>
    </div>
<%
}
%>

</div>
</body>
</html>
