package com.servlet;
import com.dao.ReservationDAO;
import com.model.Reservation;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

public class UpdateReservationServlet extends HttpServlet {

    // GET: Load existing reservation data into the update form
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        ReservationDAO dao = new ReservationDAO();
        Reservation r = dao.getReservationById(id);
        request.setAttribute("reservation", r);
        RequestDispatcher rd = request.getRequestDispatcher("reservationupdate.jsp");
        rd.forward(request, response);
    }

    // POST: Save updated data
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int    id           = Integer.parseInt(request.getParameter("reservationID"));
        String customerName = request.getParameter("customerName");
        String roomNumber   = request.getParameter("roomNumber");
        String checkIn      = request.getParameter("checkIn");
        String checkOut     = request.getParameter("checkOut");
        double totalAmount  = Double.parseDouble(request.getParameter("totalAmount"));
        int    noOfGuests   = Integer.parseInt(request.getParameter("noOfGuests")); // 👈 new

        Reservation r = new Reservation();
        r.setReservationID(id);
        r.setCustomerName(customerName);
        r.setRoomNumber(roomNumber);
        r.setCheckIn(Date.valueOf(checkIn));
        r.setCheckOut(Date.valueOf(checkOut));
        r.setTotalAmount(totalAmount);
        r.setNoOfGuests(noOfGuests); // 👈 new

        ReservationDAO dao = new ReservationDAO();
        boolean success = dao.updateReservation(r);

        if (success) {
            response.sendRedirect("reservationdisplay.jsp?msg=Reservation+Updated+Successfully!");
        } else {
            response.sendRedirect("reservationupdate.jsp?error=Update+Failed.");
        }
    }
}