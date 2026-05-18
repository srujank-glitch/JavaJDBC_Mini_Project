<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Hotel Management System</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', sans-serif; background: #f0f4f8; color: #333; }
        nav {
            background: #1a3c5e; padding: 0 30px;
            display: flex; align-items: center; justify-content: space-between; height: 60px;
        }
        nav .brand { color: #fff; font-size: 20px; font-weight: bold; text-decoration: none; }
        nav a { color: #cde; text-decoration: none; margin-left: 20px; font-size: 14px; }
        nav a:hover { color: #fff; }
        .hero {
            background: linear-gradient(135deg, #1a3c5e, #2e7d9c);
            color: white; text-align: center; padding: 70px 20px 50px;
        }
        .hero h1 { font-size: 38px; margin-bottom: 12px; }
        .hero p  { font-size: 16px; opacity: 0.85; }
        .cards {
            display: flex; flex-wrap: wrap; justify-content: center;
            gap: 24px; padding: 50px 30px; max-width: 1100px; margin: 0 auto;
        }
        .card {
            background: #fff; border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.09);
            width: 220px; text-align: center; padding: 32px 20px 28px;
            text-decoration: none; color: #333;
            transition: transform .2s, box-shadow .2s;
        }
        .card:hover { transform: translateY(-5px); box-shadow: 0 8px 24px rgba(0,0,0,0.14); }
        .card .icon { font-size: 42px; margin-bottom: 14px; }
        .card h3 { font-size: 16px; font-weight: 600; margin-bottom: 8px; }
        .card p  { font-size: 13px; color: #666; }
        .card.add    { border-top: 4px solid #27ae60; }
        .card.view   { border-top: 4px solid #2980b9; }
        .card.report { border-top: 4px solid #8e44ad; }
        footer {
            text-align: center; padding: 18px;
            background: #1a3c5e; color: #aac; font-size: 13px; margin-top: 40px;
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
<div class="hero">
    <h1>&#127970; Hotel Management System</h1>
    <p>Manage reservations, rooms, and billing from one place.</p>
</div>
<div class="cards">
    <a class="card add" href="reservationadd.jsp">
        <div class="icon">&#10133;</div>
        <h3>Add Reservation</h3>
        <p>Book a new room for a customer</p>
    </a>
    <a class="card view" href="DisplayReservationsServlet">
        <div class="icon">&#128203;</div>
        <h3>View Reservations</h3>
        <p>See all current and past bookings</p>
    </a>
    <a class="card report" href="report_form.jsp">
        <div class="icon">&#128202;</div>
        <h3>Reports</h3>
        <p>Date range, top rooms and revenue</p>
    </a>
</div>
<footer>Hotel Management System &copy; 2024 | Dynamic Web Project</footer>
</body>
</html>
