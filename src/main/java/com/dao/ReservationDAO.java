package com.dao;

import com.model.Reservation;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    // ─── DB Connection Details ──────────────────────────────────────────────
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL    = "jdbc:mysql://localhost:3306/hotel_db";
    private static final String USER   = "root";
    private static final String PASS   = "srujan"; // Change to your MySQL password

    // ─── Get Connection ─────────────────────────────────────────────────────
    private Connection getConnection() throws Exception {
        Class.forName(DRIVER);
        return DriverManager.getConnection(URL, USER, PASS);
    }

    // ─── ADD Reservation ────────────────────────────────────────────────────
    public boolean addReservation(Reservation r) {
        if (!isRoomAvailable(r.getRoomNumber(), r.getCheckIn(), r.getCheckOut())) {
            return false;
        }
        String sql = "INSERT INTO Reservations (CustomerName, RoomNumber, CheckIn, CheckOut, TotalAmount, NoOfGuests) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, r.getCustomerName());
            ps.setString(2, r.getRoomNumber());
            ps.setDate(3, r.getCheckIn());
            ps.setDate(4, r.getCheckOut());
            ps.setDouble(5, r.getTotalAmount());
            ps.setInt(6, r.getNoOfGuests()); // 👈
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    // ─── UPDATE Reservation ─────────────────────────────────────────────────
    public boolean updateReservation(Reservation r) {
        String sql = "UPDATE Reservations SET CustomerName=?, RoomNumber=?, CheckIn=?, CheckOut=?, TotalAmount=?, NoOfGuests=? WHERE ReservationID=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, r.getCustomerName());
            ps.setString(2, r.getRoomNumber());
            ps.setDate(3, r.getCheckIn());
            ps.setDate(4, r.getCheckOut());
            ps.setDouble(5, r.getTotalAmount());
            ps.setInt(6, r.getNoOfGuests()); // 👈
            ps.setInt(7, r.getReservationID());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ─── DELETE Reservation ─────────────────────────────────────────────────
    public boolean deleteReservation(int id) {
        String sql = "DELETE FROM Reservations WHERE ReservationID=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isRoomAvailable(String roomNumber, Date checkIn, Date checkOut) {
        String sql = "SELECT COUNT(*) FROM Reservations WHERE RoomNumber = ? " +
                     "AND (CheckIn < ? AND CheckOut > ?)";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, roomNumber);
            ps.setDate(2, checkOut);
            ps.setDate(3, checkIn);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("DEBUG >> Room: " + roomNumber + " | Count: " + count); // 👈 add this
                return count == 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    // ─── GET All Reservations ────────────────────────────────────────────────
    public List<Reservation> getAllReservations() {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM Reservations ORDER BY CheckIn DESC";
        try (Connection con = getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ─── GET Single Reservation by ID ────────────────────────────────────────
    public Reservation getReservationById(int id) {
        String sql = "SELECT * FROM Reservations WHERE ReservationID=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ─── REPORT 1: Reservations in a Date Range ──────────────────────────────
    public List<Reservation> getReservationsByDateRange(String fromDate, String toDate) {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM Reservations WHERE CheckIn >= ? AND CheckOut <= ? ORDER BY CheckIn";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, fromDate);
            ps.setString(2, toDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ─── REPORT 2: Most Frequently Booked Rooms ──────────────────────────────
    public List<String[]> getMostBookedRooms() {
        List<String[]> list = new ArrayList<>();
        String sql = "SELECT RoomNumber, COUNT(*) AS BookingCount FROM Reservations GROUP BY RoomNumber ORDER BY BookingCount DESC";
        try (Connection con = getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new String[]{rs.getString("RoomNumber"), rs.getString("BookingCount")});
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ─── REPORT 3: Total Revenue in a Period ─────────────────────────────────
    public double getTotalRevenue(String fromDate, String toDate) {
        String sql = "SELECT SUM(TotalAmount) FROM Reservations WHERE CheckIn >= ? AND CheckOut <= ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, fromDate);
            ps.setString(2, toDate);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getDouble(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    // ─── Helper: Map ResultSet Row to Reservation Object ─────────────────────
    private Reservation mapRow(ResultSet rs) throws SQLException {
        Reservation r = new Reservation();
        r.setReservationID(rs.getInt("ReservationID"));
        r.setCustomerName(rs.getString("CustomerName"));
        r.setRoomNumber(rs.getString("RoomNumber"));
        r.setCheckIn(rs.getDate("CheckIn"));
        r.setCheckOut(rs.getDate("CheckOut"));
        r.setTotalAmount(rs.getDouble("TotalAmount"));
        r.setNoOfGuests(rs.getInt("NoOfGuests")); // 👈
        return r;
    }
}