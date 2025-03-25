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

            <c:set var="confirmedPassengers" value="${sessionScope.confirmedPassengers}" />

            <table class="table table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th>Passenger Name</th>
                        <th>Age</th>
                        <th>Gender</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="i" begin="0" end="${fn:length(sessionScope.passengerNames) - 1}">
                        <tr>
                            <td>
                                <input type="text" name="passengerName[]" value="${sessionScope.passengerNames[i]}" 
                                       readonly class="form-control">
                            </td>
                            <td>
                                <input type="number" name="age[]" value="${sessionScope.ages[i]}" 
                                       readonly class="form-control">
                            </td>
                            <td>
                                <select name="gender[]" class="form-select" disabled>
                                    <option value="Male" ${sessionScope.genders[i] == 'Male' ? 'selected' : ''}>Male</option>
                                    <option value="Female" ${sessionScope.genders[i] == 'Female' ? 'selected' : ''}>Female</option>
                                </select>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <p class="fw-bold">Total Fare: &#8377;${sessionScope.fare}</p>

            <div class="text-center">
                <c:choose>
                    <c:when test="${sessionScope.allConfirmed}">
                        <button disabled class="btn btn-success">Ticket Confirmed</button>
                    </c:when>
                    <c:otherwise>
                        <form id="confirmForm" action="ConfirmBookingServlet" method="POST">
                            <input type="hidden" name="bookingId" value="${sessionScope.bookingId}">
                            <button type="submit" id="confirmButton" class="btn btn-primary center-btn" onclick="disableButton(event)">Confirm Booking</button>
                        </form>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <script>
        function disableButton(event) {
            event.preventDefault(); 
            let button = document.getElementById("confirmButton");
            alert("Ticket booked successfully!");
            document.getElementById("confirmForm").submit();
            button.disabled = true;
        }

        (function preventBackNavigation() {
            history.pushState(null, null, location.href);
            window.onpopstate = function () {
                history.pushState(null, null, location.href);
            };
        })();
    </script>
</body>
</html>
