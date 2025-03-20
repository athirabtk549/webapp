<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");

    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("username") == null) {
        response.sendRedirect("index.jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Form</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-image: url('images/train_pic2.jpg');
            background-position: center;
             background-repeat: no-repeat;
        }

        .container {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .passenger {
            margin-bottom: 10px;
        }

        .center-btn {
            display: block;
            width: 200px;
            margin: 0 auto;
        }

        .logo {
            display: block;
            margin: 0 auto;
            width: 75px;
            margin-bottom: 25px;
        }

        .fare-column {
            font-weight: bold;
        }

        .total-fare {
            font-size: 1.5rem;
            font-weight: bold;
        }
    </style>

</head>
<body>
    <div class="container mt-5">
        <img src="images/ticketbook.png" alt="Booking Icon" class="logo">

        <form action="BookingServlet" method="POST">
            <div class="form-row">
                <div class="col-12 col-md-6 mb-3">
                    <label for="trainNumber">Train Name</label>
<select class="form-control" name="train_number" id="trainNumber" required>
    <option value=" disabled ${empty sessionScope.trainNumber ? 'selected' : ''}">Select Train</option>
        <option value="${sessionScope.trainNumber}" selected>
            ${sessionScope.trainName}
        </option>

</select>

                </div>

                <div class="col-12 col-md-6 mb-3">
                    <label for="departure">Departure</label>
                    <select class="form-control" name="departure" id="departure" required>
    					<option value="Thiruvananthapuram" ${sessionScope.departure == 'Thiruvananthapuram' ? 'selected' : ''}>Thiruvananthapuram</option>
    					<option value="Ernakulam" ${sessionScope.departure == 'Ernakulam' ? 'selected' : ''}>Ernakulam</option>
    					<option value="Kollam" ${sessionScope.departure == 'Kollam' ? 'selected' : ''}>Kollam</option>
    					<option value="Thrissur" ${sessionScope.departure == 'Thrissur' ? 'selected' : ''}>Thrissur</option>
    					<option value="Alappuzha" ${sessionScope.departure == 'Alappuzha' ? 'selected' : ''}>Alappuzha</option>
    					<option value="Aluva" ${sessionScope.departure == 'Aluva' ? 'selected' : ''}>Aluva</option>
    					<option value="Guruvayur" ${sessionScope.departure == 'Guruvayur' ? 'selected' : ''}>Guruvayur</option>
					</select>
                </div>
            </div>

            <div class="form-row">
                <div class="col-12 col-md-6 mb-3">
                    <label for="destination">Destination</label>
                    <select class="form-control" name="destination" id="destination" required>
    					<option value="Thiruvananthapuram" ${sessionScope.destination == 'Thiruvananthapuram' ? 'selected' : ''}>Thiruvananthapuram</option>
    					<option value="Ernakulam" ${sessionScope.destination == 'Ernakulam' ? 'selected' : ''}>Ernakulam</option>
    					<option value="Kollam" ${sessionScope.destination == 'Kollam' ? 'selected' : ''}>Kollam</option>
    					<option value="Thrissur" ${sessionScope.destination == 'Thrissur' ? 'selected' : ''}>Thrissur</option>
    					<option value="Alappuzha" ${sessionScope.destination == 'Alappuzha' ? 'selected' : ''}>Alappuzha</option>
    					<option value="Aluva" ${sessionScope.destination == 'Aluva' ? 'selected' : ''}>Aluva</option>
    					<option value="Guruvayur" ${sessionScope.destination == 'Guruvayur' ? 'selected' : ''}>Guruvayur</option>
					</select>
                </div>

                <div class="col-12 col-md-6 mb-3">
                    <label for="travelClass">Travel Class</label>
                   	<select class="form-control" name="travel_class" id="travelClass" required>
    			   		<option value="3E" ${sessionScope.travelClass == '3E' ? 'selected' : ''}>3E</option>
    					<option value="1A" ${sessionScope.travelClass == '1A' ? 'selected' : ''}>1A</option>
    					<option value="2A" ${sessionScope.travelClass == '2A' ? 'selected' : ''}>2A</option>
    					<option value="3A" ${sessionScope.travelClass == '3A' ? 'selected' : ''}>3A</option>
    					<option value="CC" ${sessionScope.travelClass == 'CC' ? 'selected' : ''}>CC</option>
    					<option value="EC" ${sessionScope.travelClass == 'EC' ? 'selected' : ''}>EC</option>
    					<option value="2S" ${sessionScope.travelClass == '2S' ? 'selected' : ''}>2S</option>
    					<option value="SL" ${sessionScope.travelClass == 'SL' ? 'selected' : ''}>SL</option>
					</select>
                </div>
            </div>

            <div class="form-row">
                <div class="col-12 col-md-6 mb-3">

<input type="date" class="form-control" name="travel_date" id="travelDate" required 
       value="${sessionScope.travelDate}" min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">




                </div>
            </div>

  <div id="passengerList">
    <c:if test="${not empty sessionScope.passengerNames}">
    <c:forEach var="i" items="${sessionScope.passengerNames}" varStatus="status">
        <div class="passenger form-row">
            <div class="col-12 col-md-3 mb-3">
                <label for="passengerName">Passenger Name</label>
                <input type="text" class="form-control" name="passengerName[]" required 
                       value="${sessionScope.passengerNames[status.index]}">
            </div>
            <div class="col-12 col-md-2 mb-3">
                <label for="age">Age</label>
                <input type="number" class="form-control" name="age[]" required 
                       value="${sessionScope.ages[status.index]}">
            </div>
            <div class="col-12 col-md-2 mb-3">
                <label for="gender">Gender</label>
                <select class="form-control" name="gender[]" required>
                    <option value="Male" ${sessionScope.genders[status.index] == 'Male' ? 'selected' : ''}>Male</option>
                    <option value="Female" ${sessionScope.genders[status.index] == 'Female' ? 'selected' : ''}>Female</option>
                </select>
            </div>
        </div>
    </c:forEach>
</c:if>


</div>



            <button type="button" class="btn btn-success mb-3" onclick="addPassenger()">+ Add Passenger</button>
            
            <button type="submit" class="btn btn-primary center-btn">Proceed to Booking</button>
        </form>
    </div>

    <script>
    function addPassenger() {
        let passengerDiv = document.createElement('div');
        passengerDiv.classList.add('passenger', 'form-row');

        passengerDiv.innerHTML = `
            <div class="col-12 col-md-3 mb-3">
                <label for="passengerName">Passenger Name</label>
                <input type="text" class="form-control" name="passengerName[]" required>
            </div>
            <div class="col-12 col-md-2 mb-3">
                <label for="age">Age</label>
                <input type="number" class="form-control age" name="age[]" required>
            </div>
            <div class="col-12 col-md-2 mb-3">
                <label for="gender">Gender</label>
                <select class="form-control" name="gender[]" required>
                    <option value="" disabled selected>Select Gender</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                </select>
            </div>
        `;

        document.getElementById('passengerList').appendChild(passengerDiv);
    }


        // Booking date selection logic
        document.getElementById('travelDate').addEventListener('change', function () {
            let selectedDate = this.value;
            if (selectedDate) {
                let dateObj = new Date(selectedDate);
                let dayOfWeek = dateObj.getDay(); // Get day of the week (0 = Sunday, 1 = Monday, etc.)
                const days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
                let selectedDay = days[dayOfWeek]; // Get the corresponding day name

                // Fetch available trains for the selected day
                fetchTrains(selectedDay);
            }
        });

        function fetchTrains(dayOfWeek) {
            let params = new URLSearchParams();
            params.append("day", dayOfWeek); // Send the day to the TrainScheduleServlet

            fetch("TrainScheduleServlet?" + params.toString())
                .then(response => response.json())
                .then(data => {
                    let trainDropdown = document.getElementById('trainNumber');
                    trainDropdown.innerHTML = '<option value="" disabled selected>Select Train</option>'; // Reset dropdown

                    if (data.length === 0) {
                        alert("No trains available for this day.");
                        return;
                    }

                    // Populate the train dropdown with the available trains
                    data.forEach(train => {
                        let option = document.createElement("option");
                        option.value = train.train_number;
                        option.text = train.train_name;
                        trainDropdown.appendChild(option);
                    });
                })
                .catch(error => console.error('Error fetching train schedule:', error));
        }


        document.getElementById('departure').addEventListener('change', validateRoute);
        document.getElementById('destination').addEventListener('change', validateRoute);

        function validateRoute() {
            let departure = document.getElementById('departure').value;
            let destination = document.getElementById('destination').value;

            if (departure !== "" && destination !== "" && departure === destination) {
                alert("Departure and Destination cannot be the same!");
                document.getElementById('destination').value = ""; // Reset destination
            }
        }

    </script>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    
    
</body>
</html>