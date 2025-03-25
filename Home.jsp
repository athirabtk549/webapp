<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Train Ticket Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            background-color: black;
            font-family: 'Inter', sans-serif;
            margin: 0;
            height: 100vh;
            overflow: hidden;
        }

        .container-fluid {
            height: 100vh;
            padding: 0;
        }

        .row {
            height: 100%;
            margin: 0;
        }

        .sidebar {
            background: linear-gradient(180deg, #333333, black);
            color: white;
            height: 100%;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            padding: 20px 10px;
        }

        .sidebar .profile {
            text-align: center;
            margin-bottom: 30px;
        }

        .profile .photo {
            width: 100px;
            height: 100px;
            background-color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto;
            border: 4px solid #fff;
        }

        .profile .photo i {
            font-size: 2.5rem;
            color: black;
        }

        .profile .name {
            font-weight: bold;
            font-size: 1.2rem;
            margin-top: 10px;
        }

        .nav-links a {
            display: block;
            color: white;
            text-decoration: none;
            padding: 10px 15px;
            border-radius: 5px;
            font-weight: bold;
            margin-bottom: 10px;
            transition: all 0.3s ease-in-out;
            font-size: 0.85em;
        }

        .nav-links a:hover {
            background-color: #1e7e34;
            color: white;
        }

        .nav-links a.active {
            background-color: #1e7e34;
            color: white;
        }

        .content {
            height: 100%;
            padding: 0;
            background-color: rgba(255, 255, 255, 0.9);
        }

        iframe {
            width: 100%;
            height: 100%;
            border: none;
        }

        @media (max-width: 768px) {
            .sidebar {
                height: auto;
                padding-bottom: 20px;
            }

            .profile .photo {
                width: 80px;
                height: 80px;
            }

            .profile .name {
                font-size: 1rem;
            }

            .nav-links a {
                font-size: 0.9rem;
            }
            
            .logout-btn {
        		font-size: 8px;  
        		padding: 1px 4px; 
        		border-radius: 2px; 
    }
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2 sidebar">
                <div class="profile">
                    <div class="photo">
                        <i class="fas fa-user"></i>
                    </div>
                    <%
                        String loggedInUser = (String) session.getAttribute("username");
                        if (loggedInUser == null) {
                            response.sendRedirect("index.jsp"); 
                            return;
                        }
                    %>
                    <div class="name"><%= loggedInUser %></div>
                </div>

                <div class="nav-links">
    				<a href="booking.jsp" target="content-frame" data-src="booking.jsp" class="small">Book Now</a>
    				<a href="BookingHistoryServlet" target="content-frame" data-src="BookingHistoryServlet" class="small">Your Bookings</a>
    				<a href="CancelledTicketsServlet" target="content-frame" data-src="CancelledTicketsServlet" class="small">Cancelled Tickets</a>
    				<a href="#" class="text-white text-decoration-none d-block mt-3 small" data-bs-toggle="modal" data-bs-target="#contactModal">Contact Us</a>
    				<a href="LogoutServlet" class="btn btn-danger logout-btn mt-3">Logout</a>
				</div>

            </div>

            <div class="col-md-10 content">
                <iframe
                    name="content-frame"
                    src="booking.jsp"
                    id="content-frame"
                ></iframe>
            </div>
        </div>
    </div>
    
<div class="modal fade" id="contactModal" tabindex="-1" aria-labelledby="contactModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="contactModalLabel">Contact Us</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <h6>For Railway tickets booked through Indian Railway</h6>
        <p><strong>Customer Care Numbers:</strong> 12345 / 0804463478 / 08035790481</p>
        <p><strong>Enhanced Interface for Queries:</strong> <a href="https://equery.rail.co.in/" target="_blank">equery.rail.co.in</a></p>
        
        <h6>General Information</h6>
        <p><strong>I-tickets/e-tickets:</strong> <a href="https://equery.rail.co.in" target="_blank">https://equery.rail.co.in</a></p>
        <p><strong>For Cancellation of E-tickets:</strong> <a href="mailto:etickets@rail.co.in">etickets@rail.co.in</a></p>
        <p><strong>For Other Queries:</strong> Email: <a href="mailto:loyaltyprogram@irail.co.in">loyaltyprogram@irail.co.in</a></p>

        <h6>Registered Office - Corporate Office</h6>
        <p>Indian Railway Catering and Tourism Corporation Ltd.,<br>
        4th Floor, Tower-D, World Trade Centre,<br>
        Nauroji Nagar, New Delhi-110029</p>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    (function preventBackNavigation() {
        history.pushState(null, null, location.href);
        window.onpopstate = function () {
            history.pushState(null, null, location.href);
        };
    })();
    
    const iframe = document.getElementById('content-frame');
    const links = document.querySelectorAll('.nav-links a');

    const updateActiveLink = () => {
        const currentSrc = iframe.contentWindow.location.href || iframe.src;
        links.forEach(link => {
            link.classList.remove('active');
            if (currentSrc.includes(link.dataset.src)) {
                link.classList.add('active');
            }
        });
    };

    iframe.addEventListener('load', updateActiveLink);
    updateActiveLink();
</script>

</body>
</html>
