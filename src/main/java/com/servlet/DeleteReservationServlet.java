package com.servlet;

import com.dao.ReservationDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class DeleteReservationServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        ReservationDAO dao = new ReservationDAO();
        boolean success = dao.deleteReservation(id);

        if (success) {
            response.sendRedirect("reservationdisplay.jsp?msg=Reservation+Cancelled+Successfully!");
        } else {
            response.sendRedirect("reservationdisplay.jsp?error=Cancellation+Failed.");
        }
    }
}