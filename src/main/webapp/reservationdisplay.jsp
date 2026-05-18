<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Reservation, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Reservations | HMS</title>
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
        .container { max-width: 1100px; margin: 40px auto; padding: 0 20px; }
        .top-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        h2 { color: #1a3c5e; font-size: 24px; }
        .btn-add {
            background: #27ae60; color: #fff; padding: 10px 20px;
            border-radius: 8px; text-decoration: none; font-size: 14px; font-weight: 600;
        }
        .btn-add:hover { background: #1e8449; }
        .alert-success { background: #d4edda; color: #155724; padding: 10px 14px; border-radius: 8px; margin-bottom: 16px; }
        .alert-error   { background: #ffe0e0; color: #c0392b; padding: 10px 14px; border-radius: 8px; margin-bottom: 16px; }
        table { width: 100%; border-collapse: collapse; background: #fff; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 16px rgba(0,0,0,0.09); }
        th { background: #1a3c5e; color: #fff; padding: 14px 16px; text-align: left; font-size: 13px; text-transform: uppercase; }
        td { padding: 13px 16px; border-bottom: 1px solid #f0f0f0; font-size: 14px; color: #333; }
        tr:last-child td { border-bottom: none; }
        tr:hover td { background: #f7faff; }
        .btn-edit   { background: #2980b9; color: #fff; padding: 6px 14px; border-radius: 6px; text-decoration: none; font-size: 13px; margin-right: 6px; }
        .btn-delete { background: #e74c3c; color: #fff; padding: 6px 14px; border-radius: 6px; text-decoration: none; font-size: 13px; }
        .btn-edit:hover   { background: #1a5e8a; }
        .btn-delete:hover { background: #c0392b; }
        .empty { text-align: center; padding: 40px; color: #888; font-size: 15px; }
        .back-btn {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 9px 18px;
            background: #fff; color: #1a3c5e;
            border: 2px solid #1a3c5e; border-radius: 8px;
            font-size: 14px; font-weight: 600; text-decoration: none;
            transition: background 0.2s, color 0.2s;
        }
        .back-btn:hover { background: #1a3c5e; color: #fff; }
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
        <h2>&#128203; All Reservations</h2>
        <div style="display:flex; gap:10px;">
            <a href="index.jsp" class="back-btn">&#8592; Back to Home</a>
            <a class="btn-add" href="reservationadd.jsp">&#10133; New Reservation</a>
        </div>
    </div>
    <% String msg = request.getParameter("msg");
       if (msg != null) { %><div class="alert-success">&#9989; <%= msg %></div><% } %>
    <% String err = request.getParameter("error");
       if (err != null) { %><div class="alert-error">&#10060; <%= err %></div><% } %>
    <%
    List<Reservation> list = (List<Reservation>) request.getAttribute("reservations");
    if (list == null || list.isEmpty()) { %>
        <div class="empty">No reservations found. <a href="reservationadd.jsp">Add one now!</a></div>
    <% } else { %>
    <table>
        <tr>
            <th>ID</th>
<th>Customer</th>
<th>Room</th>
<th>Check-In</th>
<th>Check-Out</th>
<th>Amount (Rs.)</th>
<th>Guests</th>   <%-- 👈 add this --%>
<th>Actions</th>
        </tr>
        <% for (Reservation r : list) { %>
        <tr>
            <td><%= r.getReservationID() %></td>
            <td><%= r.getCustomerName() %></td>
            <td><%= r.getRoomNumber() %></td>
            <td><%= r.getCheckIn() %></td>
            <td><%= r.getCheckOut() %></td>
            <td>Rs. <%= String.format("%.2f", r.getTotalAmount()) %></td>
            <td><%= r.getNoOfGuests() %></td>   <%-- 👈 add this --%>
            <td>
                <a class="btn-edit"   href="UpdateReservationServlet?id=<%= r.getReservationID() %>">Edit</a>
                <a class="btn-delete" href="DeleteReservationServlet?id=<%= r.getReservationID() %>"
                   onclick="return confirm('Cancel this reservation?')">Cancel</a>
            </td>
        </tr>
        <% } %>
    </table>
    <% } %>
</div>
</body>
</html>
