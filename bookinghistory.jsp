<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, java.util.Map" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.welcome.DbConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Booking History</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-image: url('images/bookback.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .card {
            background-color: rgba(255, 255, 255, 0.9);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            padding: 20px;
            width: 90%;
            max-width: 900px;
            overflow: hidden;
        }
        .card-header {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 20px;
        }
        .card-header img {
            max-width: 50px;
            height: auto;
        }
        .card-header h1 {
            font-size: 24px;
            margin-left: 10px;
            color: #444;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
        td {
    white-space: nowrap; 
    overflow: hidden; 
}
        
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .remove-btn {
            color: red;
            cursor: pointer;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="card">
        <div class="card-header">
            <img src="images/history.png" alt="Booking History">
            <h1>Booking History</h1>
        </div>
<table border="1">
    <thead>
        <tr>
            <th>Booking ID</th>
            <th>Train Number</th>
            <th>Departure</th>
            <th>Destination</th>
            <th>Travel Date</th>
            <th>Passenger Name</th>
            <th>Age</th>
            <th>Gender</th>
            <th>Fare</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
    <c:choose>
        <c:when test="${not empty bookingList}">
            <c:set var="totalFare" value="0" />
            <c:set var="passengerCount" value="0" />

            <c:forEach var="booking" items="${bookingList}">
                <tr>
                    <td>${booking.booking_id}</td>
                    <td>${booking.train_number}</td>
                    <td>${booking.departure}</td>
                    <td>${booking.destination}</td>
                    <td>${booking.travel_date}</td>
                    <td>${booking.passenger_name}</td>
                    <td>${booking.age}</td>
                    <td>${booking.gender}</td>
                    <td>${booking.fare}</td>  
                    
                    <td>
                        <a href="CancelTicketsServlet?booking_id=${booking.booking_id}" 
                           class="remove-btn"
                           onclick="return confirm('Are you sure you want to cancel this ticket?');">
                           Cancel Ticket
                        </a>
                    </td> 
                </tr>
                <c:set var="totalFare" value="${totalFare + booking.fare}" />
                <c:set var="passengerCount" value="${passengerCount + 1}" />
            </c:forEach>
        </c:when>
        <c:otherwise>
            <tr>
                <td colspan="10" style="text-align:center; color:black;">
                    No bookings found for the user.
                </td>
            </tr>
        </c:otherwise>
    </c:choose>
</tbody>
</table>

    </div>
    <script>
    (function preventBackNavigation() {
        history.pushState(null, null, location.href);
        window.onpopstate = function () {
            history.pushState(null, null, location.href);
        };
    })();
</script>
    
</body>
</html>