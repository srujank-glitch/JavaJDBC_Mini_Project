package com.model;

import java.sql.Date;

public class Reservation {

    private int reservationID;
    private String customerName;
    private String roomNumber;
    private Date checkIn;
    private Date checkOut;
    private double totalAmount;
    private int noOfGuests; // 👈 new field

    public Reservation() {}

    public Reservation(int reservationID, String customerName, String roomNumber,
                       Date checkIn, Date checkOut, double totalAmount, int noOfGuests) {
        this.reservationID = reservationID;
        this.customerName = customerName;
        this.roomNumber = roomNumber;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.totalAmount = totalAmount;
        this.noOfGuests = noOfGuests; // 👈
    }

    public int getReservationID() { return reservationID; }
    public void setReservationID(int reservationID) { this.reservationID = reservationID; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getRoomNumber() { return roomNumber; }
    public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }

    public Date getCheckIn() { return checkIn; }
    public void setCheckIn(Date checkIn) { this.checkIn = checkIn; }

    public Date getCheckOut() { return checkOut; }
    public void setCheckOut(Date checkOut) { this.checkOut = checkOut; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public int getNoOfGuests() { return noOfGuests; }         // 👈
    public void setNoOfGuests(int noOfGuests) { this.noOfGuests = noOfGuests; } // 👈
}