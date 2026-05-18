package com.servlet;
import com.dao.ReservationDAO;
import com.model.Reservation;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

public class AddReservationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String customerName = request.getParameter("customerName");
        String roomNumber   = request.getParameter("roomNumber");
        String checkIn      = request.getParameter("checkIn");
        String checkOut     = request.getParameter("checkOut");
        double totalAmount  = Double.parseDouble(request.getParameter("totalAmount"));
        int noOfGuests      = Integer.parseInt(request.getParameter("noOfGuests")); // 👈

        Reservation r = new Reservation();
        r.setCustomerName(customerName);
        r.setRoomNumber(roomNumber);
        r.setCheckIn(Date.valueOf(checkIn));
        r.setCheckOut(Date.valueOf(checkOut));
        r.setTotalAmount(totalAmount);
        r.setNoOfGuests(noOfGuests); // 👈

        ReservationDAO dao = new ReservationDAO();
        boolean success = dao.addReservation(r);

        if (success) {
            response.sendRedirect("reservationdisplay.jsp?msg=Reservation+Added+Successfully!");
        } else {
            response.sendRedirect("reservationadd.jsp?error=Room+" + roomNumber + "+is+already+booked+for+the+selected+dates!");
        }
    }
}