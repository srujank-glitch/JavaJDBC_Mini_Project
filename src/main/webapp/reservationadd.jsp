<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Reservation | HMS</title>
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
        .container { max-width: 600px; margin: 50px auto; padding: 0 20px; }
        h2 { margin-bottom: 24px; color: #1a3c5e; font-size: 24px; }
        .card {
            background: #fff; border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.09); padding: 36px;
        }
        .form-group { margin-bottom: 20px; }
        label { display: block; font-size: 13px; font-weight: 600; color: #555; margin-bottom: 6px; }
        input[type=text], input[type=number], input[type=date] {
            width: 100%; padding: 10px 14px; border: 1px solid #ddd;
            border-radius: 8px; font-size: 14px; color: #333; outline: none;
        }
        input:focus { border-color: #2e7d9c; }
        .btn {
            width: 100%; padding: 12px; background: #27ae60; color: #fff;
            border: none; border-radius: 8px; font-size: 15px; cursor: pointer;
            font-weight: 600;
        }
        .btn:hover { background: #1e8449; }
        .alert-error { background: #ffe0e0; color: #c0392b; padding: 10px 14px; border-radius: 8px; margin-bottom: 16px; }
        .back-btn {
            display: inline-flex; align-items: center; gap: 6px;
            margin-bottom: 20px; padding: 9px 18px;
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
    <a href="index.jsp" class="back-btn">&#8592; Back to Home</a>
    <h2>&#10133; Add New Reservation</h2>
    <% String error = request.getParameter("error");
       if (error != null) { %>
        <div class="alert-error"><%= error %></div>
    <% } %>
    <div class="card">
        <form action="AddReservationServlet" method="post">
            <div class="form-group">
                <label>Customer Name</label>
                <input type="text" name="customerName" placeholder="Enetr your name" required />
            </div>
            <div class="form-group">
                <label>Room Number</label>	
                <input type="text" name="roomNumber" placeholder="e.g. 101" required />
            </div>
            <div class="form-group">
                <label>Check-In Date</label>
                <input type="date" name="checkIn" required />
            </div>
            <div class="form-group">
                <label>Check-Out Date</label>
                <input type="date" name="checkOut" required />
            </div>
            <div class="form-group">
    <label>Number of Guests</label>
    <input type="number" name="noOfGuests" placeholder="e.g. 2" min="1" max="10" required />
</div>
            <div class="form-group">
                <label>Total Amount (Rs.)</label>
                <input type="number" name="totalAmount" placeholder="e.g. 5000" step="0.01" min="0" required />
            </div>
            <%-- Gender field (demo only - not saved to database)
<div class="form-group">
    <label>Gender</label>
    <select name="Gender" style="width: 100%; padding: 10px 14px; border: 1px solid #ddd; border-radius: 8px; font-size: 14px; color: #333; outline: none; background: #fff;">
        <option value="" disabled selected>Choose Gender</option>
        <option value="Male">Male</option>
        <option value="Female">Female</option>
    </select>
</div>  --%>
            <button type="submit" class="btn">Book Reservation</button>
        </form>
    </div>
</div>
</body>
</html>
