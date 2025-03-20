<%@ page import="java.util.List, com.welcome.Ticket" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%
    List<Ticket> cancelledTickets = (List<Ticket>) request.getAttribute("cancelledTickets");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cancelled Tickets</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
    body {
            background-image: url('images/train_pic3.jpg'); 
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            min-height: 100vh;
        }
    </style>
</head>
<body>

    <div class="container mt-4">
        <h2 class="text-center" style="color: white;">Your Cancelled Tickets</h2>
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th>Booking ID</th>
                    <th>Train Number</th>
                    <th>Source</th>
                    <th>Destination</th>
                    <th>Journey Date</th>
                    <th>Travel Class</th>                  
                </tr>
            </thead>
            <tbody>
                <% if (cancelledTickets != null && !cancelledTickets.isEmpty()) { %>
                    <% for (Ticket ticket : cancelledTickets) { %>
                        <tr>
                            <td><%= ticket.getBookingId() %></td>
                            <td><%= ticket.getTrainNumber() %></td>
                            <td><%= ticket.getDeparture() %></td>
                            <td><%= ticket.getDestination() %></td>
                            <td><%= ticket.getTravelDate() %></td>
                            <td><%= ticket.getTravelClass() %></td>
                        </tr>
                    <% } %>
                <% } else { %>
                    <tr><td colspan="7" class="text-center">No cancelled tickets found.</td></tr>
                <% } %>
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
