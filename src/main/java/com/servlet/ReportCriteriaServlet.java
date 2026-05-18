package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class ReportCriteriaServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String reportType = request.getParameter("reportType");
        String fromDate   = request.getParameter("fromDate");
        String toDate     = request.getParameter("toDate");

        // Pass parameters forward to ReportServlet
        request.setAttribute("reportType", reportType);
        request.setAttribute("fromDate", fromDate);
        request.setAttribute("toDate", toDate);

        RequestDispatcher rd = request.getRequestDispatcher("ReportServlet");
        rd.forward(request, response);
    }
}