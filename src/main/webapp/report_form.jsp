<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reports | HMS</title>
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
        .container { max-width: 640px; margin: 50px auto; padding: 0 20px; }
        h2 { color: #1a3c5e; font-size: 24px; margin-bottom: 24px; }
        .card {
            background: #fff; border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.09); padding: 36px;
        }
        .form-group { margin-bottom: 20px; }
        label { display: block; font-size: 13px; font-weight: 600; color: #555; margin-bottom: 6px; }
        select, input[type=date] {
            width: 100%; padding: 10px 14px; border: 1px solid #ddd;
            border-radius: 8px; font-size: 14px; color: #333; outline: none; background: #fff;
        }
        select:focus, input:focus { border-color: #8e44ad; }
        .date-row { display: flex; gap: 14px; }
        .date-row .form-group { flex: 1; }
        #dateSection { display: none; }
        .btn {
            width: 100%; padding: 12px; background: #8e44ad; color: #fff;
            border: none; border-radius: 8px; font-size: 15px; cursor: pointer; font-weight: 600;
        }
        .btn:hover { background: #7d3c98; }
        .note { font-size: 12px; color: #999; margin-top: 8px; }

        /* Back Button */
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
    <script>
        function toggleDateSection() {
            var type = document.getElementById("reportType").value;
            var sec  = document.getElementById("dateSection");
            sec.style.display = (type === "dateRange" || type === "revenue") ? "block" : "none";
            var inputs = sec.querySelectorAll("input[type=date]");
            inputs.forEach(function(inp) { inp.required = sec.style.display === "block"; });
        }
    </script>
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
    <!-- Back to Home Button -->
    <a href="index.jsp" class="back-btn">&#8592; Back to Home</a>

    <h2>&#128202; Generate Report</h2>
    <div class="card">
        <form action="ReportCriteriaServlet" method="post">
            <div class="form-group">
                <label>Select Report Type</label>
                <select id="reportType" name="reportType" onchange="toggleDateSection()" required>
                    <option value="">-- Choose a Report --</option>
                    <option value="dateRange">Reservations in a Date Range</option>
                    <option value="mostBooked">Most Frequently Booked Rooms</option>
                    <option value="revenue">Total Revenue Over a Period</option>
                </select>
            </div>
            <div id="dateSection">
                <div class="date-row">
                    <div class="form-group">
                        <label>From Date</label>
                        <input type="date" name="fromDate" />
                    </div>
                    <div class="form-group">
                        <label>To Date</label>
                        <input type="date" name="toDate" />
                    </div>
                </div>
                <p class="note">Select the date range for the report.</p>
            </div>
            <button type="submit" class="btn">Generate Report</button>
        </form>
    </div>
</div>
</body>
</html>
