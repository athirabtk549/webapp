<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }
        .container {
            margin-top: 50px;
        }
        .card {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .confirmed-message {
            font-weight: bold;
            color: green;
            text-align: center;
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card p-4">
            <h4>Train Details</h4>
            <p>Train Number: ${sessionScope.trainNumber}</p>
            <p>Departure: ${sessionScope.departure}</p>
            <p>Destination: ${sessionScope.destination}</p>
            <p>Travel Date: ${sessionScope.travelDate}</p>
            <p>Class: ${sessionScope.travelClass}</p>
            <p>Fare: &#8377;${sessionScope.fare}</p>

            <table class="table table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th>Passenger Name</th>
                        <th>Age</th>
                        <th>Gender</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="confirmedPassengers" value="${sessionScope.confirmedPassengers}" />

                    <c:forEach var="i" begin="0" end="${fn:length(sessionScope.passengerNames) - 1}">
                        <tr>
                            <td>
                                <input type="text" name="passengerName[]" value="${sessionScope.passengerNames[i]}" 
                                       ${confirmedPassengers.contains(sessionScope.passengerNames[i]) ? 'readonly' : ''} class="form-control">
                            </td>
                            <td>
                                <input type="number" name="age[]" value="${sessionScope.ages[i]}" 
                                       ${confirmedPassengers.contains(sessionScope.passengerNames[i]) ? 'readonly' : ''} class="form-control">
                            </td>
                            <td>
                                <select name="gender[]" class="form-select" 
                                        ${confirmedPassengers.contains(sessionScope.passengerNames[i]) ? 'disabled' : ''}>
                                    <option value="Male" ${sessionScope.genders[i] == 'Male' ? 'selected' : ''}>Male</option>
                                    <option value="Female" ${sessionScope.genders[i] == 'Female' ? 'selected' : ''}>Female</option>
                                </select>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${confirmedPassengers.contains(sessionScope.passengerNames[i])}">
                                        <button disabled class="btn btn-success">Ticket Confirmed</button>
                                    </c:when>
                                    <c:otherwise>
                                        <form action="ConfirmBookingServlet" method="POST">
                                            <input type="hidden" name="bookingId" value="${sessionScope.bookingId}">
                                            <button type="submit" class="btn btn-success" 
                                                    ${confirmedPassengers.contains(sessionScope.passengerNames[i]) ? 'disabled' : ''}>Confirm Booking</button>
                                        </form>
                                      <a href="booking.jsp?edit=true" class="btn btn-warning">Edit</a>


                                        
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <p class="fw-bold">Total Fare: &#8377;${sessionScope.fare}</p>
        </div>
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
