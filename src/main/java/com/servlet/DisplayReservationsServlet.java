package com.servlet;

import com.dao.ReservationDAO;
import com.model.Reservation;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class DisplayReservationsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ReservationDAO dao = new ReservationDAO();
        List<Reservation> reservations = dao.getAllReservations();

        request.setAttribute("reservations", reservations);
        RequestDispatcher rd = request.getRequestDispatcher("reservationdisplay.jsp");
        rd.forward(request, response);
    }
}