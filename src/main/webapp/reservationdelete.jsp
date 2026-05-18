<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cancel Reservation | HMS</title>
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
        .container { max-width: 500px; margin: 80px auto; text-align: center; padding: 0 20px; }
        .card {
            background: #fff; border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.09); padding: 40px;
        }
        .icon { font-size: 52px; margin-bottom: 16px; }
        h2 { color: #c0392b; margin-bottom: 10px; }
        p  { color: #555; margin-bottom: 28px; font-size: 15px; }
        .buttons { display: flex; gap: 12px; justify-content: center; }
        .btn-cancel {
            background: #e74c3c; color: #fff; padding: 11px 28px;
            border-radius: 8px; text-decoration: none; font-weight: 600;
        }
        .btn-back {
            background: #95a5a6; color: #fff; padding: 11px 28px;
            border-radius: 8px; text-decoration: none; font-weight: 600;
        }
        .btn-cancel:hover { background: #c0392b; }
        .btn-back:hover   { background: #7f8c8d; }
        .btn-home {
            display: inline-flex; align-items: center; gap: 6px;
            margin-bottom: 24px; padding: 9px 18px;
            background: #fff; color: #1a3c5e;
            border: 2px solid #1a3c5e; border-radius: 8px;
            font-size: 14px; font-weight: 600; text-decoration: none;
            transition: background 0.2s, color 0.2s;
        }
        .btn-home:hover { background: #1a3c5e; color: #fff; }
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
    <div class="card">
        <a href="index.jsp" class="btn-home">&#8592; Back to Home</a>
        <div class="icon">&#9888;</div>
        <h2>Cancel Reservation?</h2>
        <p>Are you sure you want to cancel Reservation ID
           <strong><%= request.getParameter("id") %></strong>?<br/>This action cannot be undone.</p>
        <div class="buttons">
            <a class="btn-cancel" href="DeleteReservationServlet?id=<%= request.getParameter("id") %>">Yes, Cancel It</a>
            <a class="btn-back"   href="DisplayReservationsServlet">Go Back</a>
        </div>
    </div>
</div>
</body>
</html>
