package com.servlet;

import com.dao.ReservationDAO;
import com.model.Reservation;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ReportServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String reportType = (String) request.getAttribute("reportType");
        String fromDate   = (String) request.getAttribute("fromDate");
        String toDate     = (String) request.getAttribute("toDate");

        // Fallback if called directly via GET with params
        if (reportType == null) reportType = request.getParameter("reportType");
        if (fromDate   == null) fromDate   = request.getParameter("fromDate");
        if (toDate     == null) toDate     = request.getParameter("toDate");

        ReservationDAO dao = new ReservationDAO();

        switch (reportType) {
            case "dateRange":
                List<Reservation> byDate = dao.getReservationsByDateRange(fromDate, toDate);
                request.setAttribute("reportTitle", "Reservations from " + fromDate + " to " + toDate);
                request.setAttribute("reservations", byDate);
                request.setAttribute("reportType", "dateRange");
                break;

            case "mostBooked":
                List<String[]> roomStats = dao.getMostBookedRooms();
                request.setAttribute("reportTitle", "Most Frequently Booked Rooms");
                request.setAttribute("roomStats", roomStats);
                request.setAttribute("reportType", "mostBooked");
                break;

            case "revenue":
                double revenue = dao.getTotalRevenue(fromDate, toDate);
                request.setAttribute("reportTitle", "Total Revenue from " + fromDate + " to " + toDate);
                request.setAttribute("revenue", revenue);
                request.setAttribute("reportType", "revenue");
                request.setAttribute("fromDate", fromDate);
                request.setAttribute("toDate", toDate);
                break;

            default:
                request.setAttribute("reportTitle", "Unknown Report");
                break;
        }

        RequestDispatcher rd = request.getRequestDispatcher("report_result.jsp");
        rd.forward(request, response);
    }
}