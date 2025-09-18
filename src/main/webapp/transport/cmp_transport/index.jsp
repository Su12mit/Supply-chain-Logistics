
<%@ page import="java.sql.*"%>
<%@ page import="com.scm.db.PostgresConnection"%>
<%@ page import= "com.scm.Transport.LoginId" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.Arrays, java.util.List" %>
<% 
int loginId = LoginId.getLoginId(request.getSession()); // Pass session directly
session.setAttribute("loginId", loginId);
%>
<%
String company_name;
int company_contact;
String company_email;
String company_address;
int activeCount = 0;
int pendingCount = 0;
int deliveredCount = 0;
int fleetCount = 0;
double activepercentage = 0.0;
double pendingpercentage = 0.0;
double deliveredpercentage = 0.0;
int totalShipments = 0;
int delayedShipments = 0;
double delayedPercentage = 0.0;
int onTimeCount = 0;
int earlyCount = 0;
double onTimePercentage = 0.0;
double earlyPercentage = 0.0;
int nooftrucks = 0;
int nooftankers = 0;
int noofvans = 0;
int noofcars = 0;
double truckpercentage =0.0;
double tankerpercentage =0.0;
double vanpercentage = 0.0;
double carpercentage = 0.0;
double totalRevenue = 0.0;
double pendingAmount = 0.0;
int pendingInvoices = 0;
double completedAmount = 0.0;
int completedTransactions = 0;
double outstandingAmount = 0.0;
int overdueInvoices = 0;
int failedCount = 0;
double failedpercentage = 0.0;
%>
 <%
 	
      try (Connection conn = PostgresConnection.getConnection()) {
    	// For Company Details 
  	String snamesql = "SELECT t.transport_name, t.address, t.transport_contact, l.email FROM transport.transport t JOIN transport.login l ON t.transport_id= l.login_id  WHERE t.transport_id="+loginId;
    	Statement stmtsname = conn.createStatement();
   	ResultSet rs_company = stmtsname.executeQuery(snamesql);
   	if (rs_company.next()) {
   		company_name = rs_company.getString("transport_name");
          request.setAttribute("company_name", company_name);
          company_contact = rs_company.getInt("transport_contact");
          request.setAttribute("company_contact", company_contact);
          company_address = rs_company.getString("address");
          request.setAttribute("company_address", company_address);
          company_email = rs_company.getString("email");
          request.setAttribute("company_email", company_email);
      }
   	 
   		//Query for Total nu of Fleets
   		String totalfleets = "SELECT COUNT(*) FROM transport.fleets WHERE transport_id = ?";
   	    PreparedStatement fleetStmt = conn.prepareStatement(totalfleets);
   	 	fleetStmt.setInt(1, loginId);
   	    ResultSet fleets = fleetStmt.executeQuery();
   		 fleets.next();
   	     fleetCount = fleets.getInt(1);
   	     
   	// Query for Total Shipments
   	   	String totalShipmentsQuery = "SELECT COUNT(*) FROM transport.shipment WHERE transport_id = ?";
   	   	PreparedStatement totalShipmentsStmt = conn.prepareStatement(totalShipmentsQuery);
   	   	totalShipmentsStmt.setInt(1, loginId);
   	   	ResultSet totalShipmentsRs = totalShipmentsStmt.executeQuery();
   	   	totalShipmentsRs.next();
   	    totalShipments = totalShipmentsRs.getInt(1);
   	  
   	    // Query for Active Transport
   	    String activeQuery = "SELECT COUNT(*) FROM transport.fleets WHERE status='Active' AND transport_id = ?";
   	    PreparedStatement activeStmt = conn.prepareStatement(activeQuery);
   	    activeStmt.setInt(1, loginId);
   	    ResultSet activeRs = activeStmt.executeQuery();
   	    activeRs.next();
   	     activeCount = activeRs.getInt(1);
   	  	request.setAttribute("activeCount", activeCount);
   	  
   	// Query for Pending Transport
   	 String pendingQuery = "SELECT COUNT(*) FROM transport.shipment WHERE status='Pending' AND transport_id = ?";
   	 PreparedStatement pendingStmt = conn.prepareStatement(pendingQuery);
   	 pendingStmt.setInt(1, loginId); // Assuming `loginId` is relevant for this query
   	 ResultSet pendingRs = pendingStmt.executeQuery();
   	 pendingRs.next();
   	 pendingCount = pendingRs.getInt(1);
   	 request.setAttribute("pendingCount", pendingCount);

  // Query for Failed Transport
   	 String failedQuery = "SELECT COUNT(*) FROM transport.shipment WHERE status='Failed' AND transport_id = ?";
   	 PreparedStatement faliedStmt = conn.prepareStatement(failedQuery);
   	faliedStmt.setInt(1, loginId); // Assuming `loginId` is relevant for this query
   	 ResultSet failedRs = faliedStmt.executeQuery();
   	failedRs.next();
   	 failedCount = failedRs.getInt(1);
   	
   	failedpercentage = ((double)failedCount / totalShipments) * 100;
    request.setAttribute("failedpercentage", failedpercentage);
   	 
   	 // Query for Delivered Today
   	 String deliveredQuery = "SELECT COUNT(*) FROM transport.delivery_tracking WHERE status='Delivered' AND CAST(delivery_date AS DATE) = CURRENT_DATE AND transport_id = ?";
   	 PreparedStatement deliveredStmt = conn.prepareStatement(deliveredQuery);
   	 deliveredStmt.setInt(1, loginId); // Assuming `loginId` applies here
   	 ResultSet deliveredRs = deliveredStmt.executeQuery();
   	 deliveredRs.next();
   	 deliveredCount = deliveredRs.getInt(1);
   	 request.setAttribute("deliveredCount", deliveredCount);
   	 
  // Now For Percentage
   	// Ensure floating-point division by casting fleetCount to double
activepercentage = ((double)activeCount / fleetCount) * 100;
pendingpercentage = ((double) pendingCount / fleetCount) * 100;
deliveredpercentage = ((double) deliveredCount / fleetCount) * 100;
	request.setAttribute("activepercentage", activepercentage);
   	request.setAttribute("pendingpercentage", pendingpercentage);
   	request.setAttribute("deliveredpercentage", deliveredpercentage);
   	
 

   	// Query for Delayed Shipments
   	String delayedShipmentsQuery = "SELECT COUNT(*) FROM transport.shipment WHERE status IN ('Delayed', 'Pending') AND transport_id = ?";
	PreparedStatement delayedShipmentsStmt = conn.prepareStatement(delayedShipmentsQuery);
	delayedShipmentsStmt.setInt(1, loginId);
	ResultSet delayedShipmentsRs = delayedShipmentsStmt.executeQuery();
	delayedShipmentsRs.next();
	 delayedShipments = delayedShipmentsRs.getInt(1);
   
	 // Calculate Delayed Percentage
   	delayedPercentage = ((double) delayedShipments / totalShipments) * 100;
   	request.setAttribute("totalShipments", totalShipments);
   	request.setAttribute("delayedShipments", delayedShipments);
   	request.setAttribute("delayedPercentage", delayedPercentage);
   	
 // Query for On Time Deliveries
   	String onTimeQuery = "SELECT COUNT(*) FROM transport.shipment WHERE status='In Transit' AND transport_id = ?";
   	PreparedStatement onTimeStmt = conn.prepareStatement(onTimeQuery);
   	onTimeStmt.setInt(1, loginId);
   	ResultSet onTimeRs = onTimeStmt.executeQuery();
   	onTimeRs.next();
   	 onTimeCount = onTimeRs.getInt(1);

   	// Query for Early Deliveries
   	String earlyQuery = "SELECT COUNT(*) FROM transport.shipment WHERE status='Early' AND transport_id = ?";
   	PreparedStatement earlyStmt = conn.prepareStatement(earlyQuery);
   	earlyStmt.setInt(1, loginId);
   	ResultSet earlyRs = earlyStmt.executeQuery();
   	earlyRs.next();
    earlyCount = earlyRs.getInt(1);


   	// Calculate Percentages
   	
   	 onTimePercentage = ((double) onTimeCount / totalShipments) * 100;
   	earlyPercentage = ((double) earlyCount / totalShipments) * 100;
   
   	request.setAttribute("onTimeCount", onTimeCount);
   	request.setAttribute("onTimePercentage", onTimePercentage);
   	request.setAttribute("earlyPercentage", earlyPercentage);
   	
 // Query for Transport Utilization
   	String FleetQuery = "SELECT vehicle_type FROM transport.fleets WHERE  transport_id = ?";
	PreparedStatement fleettypeStmt = conn.prepareStatement(FleetQuery);
	fleettypeStmt.setInt(1, loginId);
	ResultSet fleettypeRs = fleettypeStmt.executeQuery();

   	while(fleettypeRs.next()){
   	    String vehicleType = fleettypeRs.getString("vehicle_type"); // Retrieve type correctly

   	    if(vehicleType.equals("Truck")) {
   	    	nooftrucks++;
   	    } else if(vehicleType.equals("Tanker")) {
   	    	nooftankers++;
   	    } else if(vehicleType.equals("Van")) {
   	    	noofvans++;
   	    } else if(vehicleType.equals("Car")) {
   	    	noofcars++;
   	    }
   	}
   	truckpercentage = ((double) nooftrucks / fleetCount) * 100;
   	tankerpercentage = ((double) nooftankers / fleetCount) * 100;
   	carpercentage = ((double) noofcars / fleetCount) * 100;
   	vanpercentage = ((double) noofvans / fleetCount) * 100;
   	
   	request.setAttribute("truckpercentage", truckpercentage);
   	request.setAttribute("tankerpercentage", tankerpercentage);
   	request.setAttribute("carpercentage", carpercentage);
   	request.setAttribute("vanpercentage", vanpercentage);
 
   	// Total Revenue (This Month)
   	String totalRevenueQuery = "SELECT SUM(amount) FROM transport.invoices WHERE EXTRACT(MONTH FROM tr_date_time) = EXTRACT(MONTH FROM CURRENT_DATE) AND transport_id = ?";
   	PreparedStatement totalRevenueStmt = conn.prepareStatement(totalRevenueQuery);
   	totalRevenueStmt.setInt(1, loginId);
   	ResultSet totalRevenueRs = totalRevenueStmt.executeQuery();
   	totalRevenueRs.next();
   	totalRevenue = totalRevenueRs.getDouble(1);

   	// Pending Payments (Due This Week)
   	String pendingPaymentsQuery = "SELECT SUM(amount), COUNT(*) FROM transport.invoices WHERE status='Pending' AND EXTRACT(MONTH FROM tr_date_time) = EXTRACT(MONTH FROM CURRENT_DATE)   AND transport_id = ?";
   	PreparedStatement pendingPaymentsStmt = conn.prepareStatement(pendingPaymentsQuery);
   	pendingPaymentsStmt.setInt(1, loginId);
   	ResultSet pendingPaymentsRs = pendingPaymentsStmt.executeQuery();
   	pendingPaymentsRs.next();
    pendingAmount = pendingPaymentsRs.getDouble(1);
   	pendingInvoices = pendingPaymentsRs.getInt(2);

   	// Completed Payments (This Month)
   	String completedPaymentsQuery = "SELECT SUM(amount), COUNT(*) FROM transport.invoices WHERE status='Paid' AND EXTRACT(MONTH FROM tr_date_time) = EXTRACT(MONTH FROM CURRENT_DATE) AND transport_id = ?";
   	PreparedStatement completedPaymentsStmt = conn.prepareStatement(completedPaymentsQuery);
   	completedPaymentsStmt.setInt(1, loginId);
   	ResultSet completedPaymentsRs = completedPaymentsStmt.executeQuery();
   	completedPaymentsRs.next();
   	completedAmount = completedPaymentsRs.getDouble(1);
   	completedTransactions = completedPaymentsRs.getInt(2);

   	// Outstanding Balance (Overdue Payments)
   	String outstandingBalanceQuery = "SELECT SUM(amount), COUNT(*) FROM transport.invoices WHERE status='Overdue' AND transport_id = ?";
   	PreparedStatement outstandingBalanceStmt = conn.prepareStatement(outstandingBalanceQuery);
   	outstandingBalanceStmt.setInt(1, loginId);
   	ResultSet outstandingBalanceRs = outstandingBalanceStmt.executeQuery();
   	outstandingBalanceRs.next();
   	outstandingAmount = outstandingBalanceRs.getDouble(1);
   	overdueInvoices = outstandingBalanceRs.getInt(2);

   	// Set attributes for JSP rendering
   	request.setAttribute("totalRevenue", String.format("%.2f", totalRevenue));
   	request.setAttribute("pendingAmount", String.format("%.2f", pendingAmount));
   	request.setAttribute("pendingInvoices", pendingInvoices);
   	request.setAttribute("completedAmount", String.format("%.2f", completedAmount));
   	request.setAttribute("completedTransactions", completedTransactions);
   	request.setAttribute("outstandingAmount", String.format("%.2f", outstandingAmount));
   	request.setAttribute("overdueInvoices", overdueInvoices);
   	
} catch (Exception e) {
    request.setAttribute("errorMessage", e.getMessage());
    request.getRequestDispatcher("/error.jsp").forward(request, response);
}
      %>
<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
   <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
      <meta name="description" content="Comprehensive transport management dashboard for supply chain and logistics operations featuring real-time analytics, shipment tracking, payment management, and delivery performance metrics.">
      <meta name="theme-color" content="#ffffff">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="robots" content="">

      <!-- Alpine.js - Load first -->
      <script src="https://cdnjs.cloudflare.com/ajax/libs/alpinejs/3.13.3/cdn.min.js"></script>
      
      
<style>

h1, h2, h3, h4, h5, h6 {
  font-family: "Inter", sans-serif !important; /* Changed to Inter */
}

body, div, p {
  font-family: "Inter", sans-serif !important; /* Changed to Inter */
}
</style>
      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

      <title>Transport Hub - Supply Chain & Logistics Analytics Dashboard</title>
      <!-- SEO Description -->
      <meta name="description" content="Comprehensive transport management dashboard for supply chain and logistics operations featuring real-time analytics, shipment tracking, payment management, and delivery performance metrics.">

      <!-- Performance optimization: Preload critical resources -->
      <link rel="preload" href="https://cdn.tailwindcss.com" as="script">
      
      <!-- Header Scripts -->
      <script id="header-scripts">
        // This script tag will be replaced with actual scripts.head content
        if (window.scripts && window.scripts.head) {
          document.getElementById('header-scripts').outerHTML = window.scripts.head;
        }
      </script>

      <!-- Core CSS -->
      <script src="https://cdn.tailwindcss.com"></script>
      <script>
      // render the settings object
      //console.log('settings', [object Object]);
      document.addEventListener('DOMContentLoaded', function() {
        tailwind.config = {
          theme: {
            extend: {
              colors: {
                primary: {
                  DEFAULT: '#000000',
                  50: '#f8f8f8',
                  100: '#e8e8e8', 
                  200: '#d3d3d3',
                  300: '#a3a3a3',
                  400: '#737373',
                  500: '#525252',
                  600: '#404040',
                  700: '#262626',
                  800: '#171717',
                  900: '#0a0a0a',
                  950: '#030303',
                },
                secondary: {
                  DEFAULT: '#000000',
                  50: '#f8f8f8',
                  100: '#e8e8e8',
                  200: '#d3d3d3', 
                  300: '#a3a3a3',
                  400: '#737373',
                  500: '#525252',
                  600: '#404040',
                  700: '#262626',
                  800: '#171717',
                  900: '#0a0a0a',
                  950: '#030303',
                },
                accent: {
                  DEFAULT: '',
                  50: '#f8f8f8',
                  100: '#e8e8e8',
                  200: '#d3d3d3',
                  300: '#a3a3a3', 
                  400: '#737373',
                  500: '#525252',
                  600: '#404040',
                  700: '#262626',
                  800: '#171717',
                  900: '#0a0a0a',
                  950: '#030303',
                },
              },
              fontFamily: {
                sans: ['Inter', 'system-ui', '-apple-system', 'BlinkMacSystemFont', 'Segoe UI', 'Helvetica Neue', 'Arial', 'sans-serif'],
                heading: ['Inter', 'system-ui', 'sans-serif'],
                body: ['Inter', 'system-ui', 'sans-serif'],
              },
              spacing: {
                '18': '4.5rem',
                '22': '5.5rem',
                '30': '7.5rem',
              },
              maxWidth: {
                '8xl': '88rem',
                '9xl': '96rem',
              },
              animation: {
                'fade-in': 'fadeIn 0.5s ease-out',
                'slide-up': 'slideUp 0.5s ease-out',
                'pulse-once': 'pulseOnce 1s ease-in-out',
              },
              keyframes: {
                fadeIn: {
                  '0%': { opacity: '0' },
                  '100%': { opacity: '1' },
                },
                slideUp: {
                  '0%': { transform: 'translateY(20px)', opacity: '0' },
                  '100%': { transform: 'translateY(0)', opacity: '1' },
                },
                pulseOnce: {
                  '0%, 100%': { opacity: '1' },
                  '50%': { opacity: '0.7' },
                }
              },
              aspectRatio: {
                'portrait': '3/4',
                'landscape': '4/3',
                'ultrawide': '21/9',
              },
            },
          },
          variants: {
            extend: {
              opacity: ['disabled'],
              cursor: ['disabled'],
              backgroundColor: ['active', 'disabled'],
              textColor: ['active', 'disabled'],
            },
          },
        }
      });
      </script>

      <!-- Utilities and Components -->
      <script src="https://cdnjs.cloudflare.com/ajax/libs/apexcharts/3.45.1/apexcharts.min.js"></script>
      
      <!-- Optimized Font Loading -->
      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
      
      <!-- Icons -->
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" 
            xintegrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />

      <!-- Dynamic Meta Tags -->
      <meta name="description" content="">
      <meta name="keywords" content="">
      <meta name="robots" content="">
      <meta name="google-site-verification" content="">
      <meta name="baidu-verification" content="">
      <meta name="yandex-verification" content="">
      <meta name="bing-verification" content="">
      <meta property="og:title" content="">
      <meta property="og:description" content="">
      <meta property="og:image" content="">
      <meta property="og:type" content="website">
      <meta property="og:locale" content="en_US">
      <meta property="og:site_name" content="Transport Hub - Supply Chain Analytics Dashboard">
      <meta name="twitter:card" content="summary_large_image">
      <meta name="twitter:title" content="">
      <meta name="twitter:description" content="">
      <meta name="twitter:image" content="">
    
      
      <!-- Font Links -->
     
      <link rel="icon" type="image/x-icon" href="">

      <!-- FAQ Accordion Styles -->
      <style>
        /* Base font for all elements */
        h1, h2, h3, h4, h5, h6 {
          font-family: 'Inter', sans-serif;
        }
        body {
          font-family: 'Inter', sans-serif;
        }
        
        /* FAQ Accordion Styling (kept for compatibility) */
        .faq-item {
          margin-bottom: 0.75rem;
        }
        .faq-item button {
          width: 100%;
          text-align: left;
          border: none;
          outline: none;
        }
        .faq-item button:focus {
          outline: 2px solid rgba(255, 255, 255, 0.2);
        }
        .faq-item button[aria-expanded="true"] {
          border-radius: 0.75rem 0.75rem 0 0;
        }
        .faq-content {
          max-height: 0;
          overflow: hidden;
          transition: max-height 0.5s cubic-bezier(0.16, 1, 0.3, 1);
        }
        .faq-content.active {
          max-height: 1000px;
        }
        .faq-toggle-icon {
          transition: transform 0.4s cubic-bezier(0.16, 1, 0.3, 1);
        }
        [aria-expanded="true"] .faq-toggle-icon {
          transform: rotate(45deg);
        }

        /* Custom styles for professional look */
        .card-hover-effect {
            transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
        }
        .card-hover-effect:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.15);
        }
        .progress-bar-container {
            background-color: #e0e0e0;
            border-radius: 9999px; /* Full rounded */
            overflow: hidden;
            height: 10px; /* Slightly thicker */
            margin-top: 8px;
        }
        .progress-bar {
            height: 100%;
            border-radius: 9999px; /* Full rounded */
            transition: width 0.8s ease-out; /* Slower, smoother transition for progress */
            animation: pulseOnce 1.5s ease-in-out; /* Animation on load */
        }
      </style>
   </head>
   <body class="antialiased text-gray-800 min-h-screen flex flex-col">
      <!-- Skip to main content link for accessibility -->
      <a href="#main-content" 
         class="sr-only focus:not-sr-only focus:absolute focus:top-0 focus:left-0 focus:z-50 focus:p-4 focus:bg-white focus:text-black">
         Skip to main content
      </a>

      <!-- Main content area -->
      <main id="main-content" class="flex-1 relative h-full">
        <div id="RolloutPageContent"><element id="2955a61f-4db2-4ee0-9551-5c7c3427d04f" data-section-id="2955a61f-4db2-4ee0-9551-5c7c3427d04f">

                
                <htmlcode id="el-egozllw0">



    <meta charset="UTF-8" id="el-azrcvrmr">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" id="el-eo0gntw3">
    <title id="el-a0onarku">Transport Hub - Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script defer="" src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>
    <style>
        [x-cloak] { display: none !important; }
        .no-scrollbar::-webkit-scrollbar {
            display: none;
        }
        .no-scrollbar {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }
        html {
            scroll-behavior: smooth;
        }
        .active-link {
            background-color: #4B5563; /* Darker gray for active link */
            color: white;
        }
    </style>


    <div id="root" class="flex">
        <div x-data="{ isOpen: false }" class="relative" id="el-076c4ij6">
            <nav class="h-screen bg-gray-900 text-gray-100 w-64 fixed top-0 left-0 lg:translate-x-0 transform transition-transform duration-200 -translate-x-full shadow-lg" :class="{'translate-x-0': isOpen, '-translate-x-full': !isOpen}" id="el-i3ch1p26">
                <div class="p-4 border-b border-gray-700" id="el-briomtuy">
                    <h1 class="text-2xl font-bold text-white">Transport Hub</h1>
                </div>
                <div class="py-4">
                    <a href="#dashboard" class="flex items-center px-4 py-3 text-gray-300 hover:bg-gray-700 hover:text-white transition-colors duration-200 active-link rounded-md mx-2 my-1">
                        <i class="fas fa-tachometer-alt w-5 h-5 mr-3"></i>
                        Dashboard
                    </a>
                    <a href="#transport" class="flex items-center px-4 py-3 text-gray-300 hover:bg-gray-700 hover:text-white transition-colors duration-200 rounded-md mx-2 my-1">
                        <i class="fas fa-truck w-5 h-5 mr-3"></i>
                        Transport
                    </a>
                    <a href="#shipments" class="flex items-center px-4 py-3 text-gray-300 hover:bg-gray-700 hover:text-white transition-colors duration-200 rounded-md mx-2 my-1">
                        <i class="fas fa-box w-5 h-5 mr-3"></i>
                        Shipments
                    </a>
                    <a href="#payments" class="flex items-center px-4 py-3 text-gray-300 hover:bg-gray-700 hover:text-white transition-colors duration-200 rounded-md mx-2 my-1">
                        <i class="fas fa-dollar-sign w-5 h-5 mr-3"></i>
                        Payments
                    </a>
                    <a href="#delivery" class="flex items-center px-4 py-3 text-gray-300 hover:bg-gray-700 hover:text-white transition-colors duration-200 rounded-md mx-2 my-1">
                        <i class="fas fa-shipping-fast w-5 h-5 mr-3"></i>
                        Delivery
                    </a>
                    <a href="#settings" class="flex items-center px-4 py-3 text-gray-300 hover:bg-gray-700 hover:text-white transition-colors duration-200 rounded-md mx-2 my-1">
                        <i class="fas fa-cog w-5 h-5 mr-3"></i>
                        Settings
                    </a>
                </div>
                <div class="absolute bottom-0 w-full p-4 border-t border-gray-700">
                    <div class="flex items-center">
                        <img src="https://avatar.iran.liara.run/public" alt="Profile" class="w-10 h-10 rounded-full border border-gray-500 shadow-sm">
                        <div class="ml-3">
                            <p class="text-sm font-medium text-white">${company_name}</p>
                            <p class="text-xs text-gray-400">${company_email}</p>
                        </div>
                    </div>
                </div>
            </nav>

            <!-- Mobile menu button -->
            <button type="button" class="lg:hidden fixed top-4 left-4 inline-flex items-center justify-center p-2 rounded-md text-gray-700 hover:text-white hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-white z-50" @click="isOpen = !isOpen" aria-controls="mobile-menu" :aria-expanded="isOpen">
                <span class="sr-only">Open main menu</span>
                <svg x-show="!isOpen" class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
                </svg>
                <svg x-show="isOpen" class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true" style="display: none;">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                </svg>
            </button>
        </div>

        <main class="flex-1 lg:ml-64 min-h-screen overflow-y-auto bg-gray-50">
            <header class="bg-white border-b border-gray-200 fixed right-0 left-0 lg:left-64 z-30 shadow-sm">
                <div class="flex justify-between items-center px-6 h-16">
                    <div class="flex items-center">
                        <h2 class="text-xl font-semibold text-gray-900">Dashboard</h2>
                    </div>
                  
                    <div class="flex items-center space-x-4">
                        <span class="text-gray-700 font-medium">${company_name}</span>
                        <form method="post">
                            <button type="submit"
                                class="bg-red-600 hover:bg-red-700 text-white font-medium py-2 px-6 rounded-lg shadow-md hover:shadow-lg transition-all duration-200">
                                Sign Out
                            </button>
                        </form>
                        <%
                            if ("POST".equalsIgnoreCase(request.getMethod())) {
                                session.invalidate(); // Destroy session
                                response.sendRedirect(request.getContextPath() + "/index.jsp"); // Redirect to home page dynamically
                            }
                        %>
                    </div>
                  </div>
            </header>
              
            <div id="52406aea-3b79-4f96-bca8-fa1499c3a74a" data-section_id="52406aea-3b79-4f96-bca8-fa1499c3a74a" class="page_sectionHighlight__ahPeD sectionCode">
                <htmlcode id="el-uclx8qf3">
<section id="dashboard" class="pt-20 px-6 animate-fade-in" style="background-color: #f9fafb;">
    <!-- Stats Overview -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">
        <!-- Active Transport -->
        <div class="bg-white p-6 rounded-xl shadow-lg border border-gray-100 card-hover-effect animate-slide-up">
            <div class="flex justify-between items-center mb-4">
                <h3 class="text-gray-700 font-semibold text-lg">Active Transport</h3>
                <div class="bg-green-100 px-3 py-1 rounded-full">
                    <span class="text-green-700 text-sm font-medium">+${String.format("%.1f", activepercentage)}%</span>
                </div>
            </div>
            <p class="text-4xl font-extrabold text-gray-900"> ${activeCount} </p>
            <p class="text-sm text-gray-500 mt-2">Currently on route</p>
        </div>

        <!-- Pending Transport -->
        <div class="bg-white p-6 rounded-xl shadow-lg border border-gray-100 card-hover-effect animate-slide-up delay-100">
            <div class="flex justify-between items-center mb-4">
                <h3 class="text-gray-700 font-semibold text-lg">Pending Transport</h3>
                <div class="bg-yellow-100 px-3 py-1 rounded-full">
                    <span class="text-yellow-700 text-sm font-medium">+${String.format("%.1f", pendingpercentage)}%</span>
                </div>
            </div>
            <p class="text-4xl font-extrabold text-gray-900">${pendingCount}</p>
            <p class="text-sm text-gray-500 mt-2">Awaiting dispatch</p>
        </div>

        <!-- Delivered Today -->
        <div class="bg-white p-6 rounded-xl shadow-lg border border-gray-100 card-hover-effect animate-slide-up delay-200">
            <div class="flex justify-between items-center mb-4">
                <h3 class="text-gray-700 font-semibold text-lg">Delivered Today</h3>
                <div class="bg-blue-100 px-3 py-1 rounded-full">
                    <span class="text-blue-700 text-sm font-medium">+${String.format("%.1f", deliveredpercentage)}%</span>
                </div>
            </div>
            <p class="text-4xl font-extrabold text-gray-900">${deliveredCount}</p>
            <p class="text-sm text-gray-500 mt-2">Successfully completed</p>
        </div>
    </div>
    <!-- New Delivery Request Filters -->
    <h2 class="text-2xl font-semibold text-gray-800 mb-4">New Delivery Request</h2>
    <div class="bg-white p-6 rounded-xl shadow-lg border border-gray-100 mb-8 animate-fade-in">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Order ID</label>
                <input type="text" placeholder="Enter Order Id..." class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500 shadow-sm">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Status</label>
                <select class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500 shadow-sm">
                    <option>All Types</option>
                    <option>Pending</option>
                    <option>Accepted</option>
                    <option>Rejected</option>
                </select>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Date Range</label>
                <input type="date" class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500 shadow-sm">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Search</label>
                <button 
                    type="button" 
                    class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded-lg flex items-center justify-center w-full shadow-md hover:shadow-lg transition-all duration-200"
                    aria-label="Search"
                >
                    <i class="fas fa-search w-5 h-5"></i>
                </button>
            </div>
        </div>
    </div>

    <!-- NEW DELIVERY List -->
    <div class="bg-white rounded-xl shadow-lg border border-gray-100 overflow-hidden mb-8 animate-fade-in delay-300">
        <div class="p-4 border-b border-gray-200 bg-gray-50">
            <h3 class="text-lg font-semibold text-gray-800">New Delivery Requests</h3>
        </div>
        <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ORDER ID</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">CUSTOMER NAME</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">DATE</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">DESTINATION</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">STATUS</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    <%
                    try (Connection conn = PostgresConnection.getConnection()){
                        String newdeliverysql = "SELECT delivery_request_id, customer_id, request_date, delivery_address, status FROM transport.delivery_request WHERE transport_id = ? AND status IN ('Accepted', 'Pending')";
                        PreparedStatement ps = conn.prepareStatement(newdeliverysql);
                        ps.setInt(1, loginId);
                        ResultSet rs_newdelivery = ps.executeQuery();
                        while (rs_newdelivery.next()) {
                    %>
                    <tr class="hover:bg-gray-50 transition-colors duration-150">
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">#ORD-<%= rs_newdelivery.getInt("delivery_request_id") %></td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <div class="flex items-center">
                                <span class="text-sm text-gray-900">#CUST-<%= rs_newdelivery.getInt("customer_id") %></span>
                            </div>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <span class="text-sm text-gray-900"><%= rs_newdelivery.getDate("request_date") %></span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><%= rs_newdelivery.getString("delivery_address") %></td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full
                                <%= rs_newdelivery.getString("status").equals("Accepted") ? "bg-green-100 text-green-800" :
                                     rs_newdelivery.getString("status").equals("Rejected") ? "bg-red-100 text-red-800" :
                                     "bg-yellow-100 text-yellow-800" %>">
                                <%= rs_newdelivery.getString("status") %>
                            </span>
                        </td>
                        <td>
                            <%
                            String status = rs_newdelivery.getString("status");
                            int deliveryRequestId = rs_newdelivery.getInt("delivery_request_id");
                            %>

                            <% if (!"Accepted".equals(status)) { %>
                                <a href="waybill.jsp?delivery_request_id=<%= deliveryRequestId %>">
                                    <button class="text-blue-600 hover:text-blue-800 mr-3">View</button>
                                </a>
                            <% } %>

                            <form method="post" action="/Supply-chain-and-Logistic/DeleteAllServlet" style="display:inline;" onsubmit="return confirmCancel('<%= status %>');">
                                <input type="hidden" name="delivery_request_id" value="<%= rs_newdelivery.getInt("delivery_request_id") %>">
                                <button type="submit" name="action" class="text-red-600 hover:text-red-800">Cancel</button>
                            </form>
                        </td>
                    </tr>
                    <%
                        }
                    } catch (Exception e) {
                        request.setAttribute("errorMessage", e.getMessage());
                        request.getRequestDispatcher("/error.jsp").forward(request, response);
                    }
                    %>
                </tbody>
            </table>
        </div>
        <!-- Pagination -->
        <div class="bg-white px-4 py-3 border-t border-gray-200 sm:px-6">
            <div class="flex items-center justify-between">
                <div class="flex-1 flex justify-between sm:hidden">
                    <button class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">Previous</button>
                    <button class="ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">Next</button>
                </div>
                <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
                    <div>
                        <p class="text-sm text-gray-700">
                            Showing <span class="font-medium">1</span> to <span class="font-medium">3</span> of <span class="font-medium">12</span> results
                        </p>
                    </div>
                    <div>
                        <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                            <button class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">Previous</button>
                            <button class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">1</button>
                            <button class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">2</button>
                            <button class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">3</button>
                            <button class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">Next</button>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Performance Metrics -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">
        <!-- Delayed Shipments -->
        <div class="bg-white p-6 rounded-xl shadow-lg border border-gray-100 animate-fade-in delay-400">
            <h3 class="text-lg font-semibold text-gray-800 mb-4">Delayed Shipments</h3>
            <div class="relative h-64 flex items-center justify-center">
                <div class="w-full max-w-md">
                    <div class="progress-bar-container">
                        <div class="progress-bar bg-red-500" style="width: ${String.format("%.1f", delayedPercentage)}%"></div>
                    </div>
                    <div class="flex justify-between text-sm text-gray-600 mt-2">
                        <span>Total Shipments: ${totalShipments}</span>
                        <span>Delayed: ${delayedShipments} (${String.format("%.1f", delayedPercentage)}%)</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Delivery Performance -->
        <div class="bg-white p-6 rounded-xl shadow-lg border border-gray-100 animate-fade-in delay-500">
            <h3 class="text-lg font-semibold text-gray-800 mb-4">Delivery Performance</h3>
            <div class="relative h-64 flex items-center justify-center">
                <div class="w-full max-w-md">
                    <div class="mb-4">
                        <div class="flex justify-between mb-1">
                            <span class="text-sm text-gray-700">On Time</span>
                            <span class="text-sm font-medium text-gray-900">${String.format("%.1f", onTimePercentage)}%</span>
                        </div>
                        <div class="progress-bar-container">
                            <div class="progress-bar bg-green-500" style="width: ${String.format("%.1f", onTimePercentage)}%"></div>
                        </div>
                    </div>
                    <div class="mb-4">
                        <div class="flex justify-between mb-1">
                            <span class="text-sm text-gray-700">Early</span>
                            <span class="text-sm font-medium text-gray-900">${String.format("%.1f", earlyPercentage)}%</span>
                        </div>
                        <div class="progress-bar-container">
                            <div class="progress-bar bg-blue-500" style="width: ${String.format("%.1f", earlyPercentage)}%"></div>
                        </div>
                    </div>
                    <div>
                        <div class="flex justify-between mb-1">
                            <span class="text-sm text-gray-700">Late</span>
                            <span class="text-sm font-medium text-gray-900">${String.format("%.1f", delayedPercentage)}%</span>
                        </div>
                        <div class="progress-bar-container">
                            <div class="progress-bar bg-red-500" style="width: ${String.format("%.1f", delayedPercentage)}%"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Transport Utilization -->
    <div class="bg-white p-6 rounded-xl shadow-lg border border-gray-100 mb-8 animate-fade-in delay-600">
        <h3 class="text-lg font-semibold text-gray-800 mb-4">Transport Utilization</h3>
        <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
            <div class="p-4 border border-gray-200 rounded-lg">
                <h4 class="text-sm text-gray-600 mb-2">Trucks</h4>
                <div class="flex items-center">
                    <div class="progress-bar-container w-full">
                        <div class="progress-bar bg-blue-500" style="width: ${String.format("%.1f", truckpercentage)}%"></div>
                    </div>
                    <span class="text-sm font-medium ml-2">${String.format("%.1f", truckpercentage)}%</span>
                </div>
            </div>
            <div class="p-4 border border-gray-200 rounded-lg">
                <h4 class="text-sm text-gray-600 mb-2">Vans</h4>
                <div class="flex items-center">
                    <div class="progress-bar-container w-full">
                        <div class="progress-bar bg-green-500" style="width: ${String.format("%.1f", vanpercentage)}%"></div>
                    </div>
                    <span class="text-sm font-medium ml-2">${String.format("%.1f", vanpercentage)}%</span>
                </div>
            </div>
            <div class="p-4 border border-gray-200 rounded-lg">
                <h4 class="text-sm text-gray-600 mb-2">Cars</h4>
                <div class="flex items-center">
                    <div class="progress-bar-container w-full">
                        <div class="progress-bar bg-yellow-500" style="width:${String.format("%.1f", carpercentage)}%"></div>
                    </div>
                    <span class="text-sm font-medium ml-2">${String.format("%.1f", carpercentage)}%</span>
                </div>
            </div>
            <div class="p-4 border border-gray-200 rounded-lg">
                <h4 class="text-sm text-gray-600 mb-2">Tankers</h4>
                <div class="flex items-center">
                    <div class="progress-bar-container w-full">
                        <div class="progress-bar bg-purple-500" style="width: ${String.format("%.1f", tankerpercentage)}%"></div>
                    </div>
                    <span class="text-sm font-medium ml-2">${String.format("%.1f", tankerpercentage)}%</span>
                </div>
            </div>
        </div>
    </div>
</section>
</htmlcode>
            </div>
                  
            <div id="7f01d585-a5b0-4c0a-9d53-72eb5fd79c92" data-section_id="7f01d585-a5b0-4c0a-9d53-72eb5fd79c92" class="page_sectionHighlight__ahPeD sectionCode">
                <htmlcode id="el-l768s10h">
<section id="transport" class="pt-20 px-6 animate-fade-in" style="background-color: #f9fafb;">
    <!-- Transport Management Header -->
    <div class="flex justify-between items-center mb-6">
        <h2 class="text-2xl font-semibold text-gray-800">Transport Management</h2>
        <a href="new_transport.jsp">
            <button class="bg-blue-600 text-white px-5 py-2 rounded-lg hover:bg-blue-700 transition-colors shadow-md hover:shadow-lg">
                Add New Transport
            </button>
        </a>
    </div>

    <!-- Transport Filters -->
    <div class="bg-white p-6 rounded-xl shadow-lg border border-gray-100 mb-8 animate-fade-in delay-100">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Status</label>
                <select class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500 shadow-sm">
                    <option>All Status</option>
                    <option>Active</option>
                    <option>In Transit</option>
                    <option>Completed</option>
                    <option>Delayed</option>
                </select>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Vehicle Type</label>
                <select class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500 shadow-sm">
                    <option>All Types</option>
                    <option>Truck</option>
                    <option>Van</option>
                    <option>Car</option>
                    <option>Bike</option>
                </select>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Date Range</label>
                <input type="date" class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500 shadow-sm">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Search</label>
                <button 
                    type="button" 
                    class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded-lg flex items-center justify-center w-full shadow-md hover:shadow-lg"
                    aria-label="Search"
                >
                    <i class="fas fa-search w-5 h-5"></i>
                </button>
            </div>
        </div>
    </div>

    <!-- Transport List -->
    <div class="bg-white rounded-xl shadow-lg border border-gray-100 overflow-hidden mb-8 animate-fade-in delay-200">
        <div class="p-4 border-b border-gray-200 bg-gray-50">
            <h3 class="text-lg font-semibold text-gray-800">Available Transport</h3>
        </div>
        <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Vehicle</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Route</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Driver</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ETA</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                
            <%
    try (Connection conn = PostgresConnection.getConnection()){
    	String fleetsql = "SELECT fleet_id, vehicle_type, vehicle_number, driver_name, status, route, \"ETA\" FROM transport.fleets WHERE transport_id= ?";
         PreparedStatement ps = conn.prepareStatement(fleetsql);
         ps.setInt(1, loginId);
         ResultSet rs_fleet = ps.executeQuery();

        while (rs_fleet.next()) {
%>
                    <tr class="hover:bg-gray-50 transition-colors duration-150">
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">#TRN-<%= rs_fleet.getInt("fleet_id") %></td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <div class="flex items-center">
                                <span class="text-sm text-gray-900"><%= rs_fleet.getString("vehicle_type") %> - <%= rs_fleet.getString("vehicle_number") %></span>
                            </div>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <span class="text-sm text-gray-900"><%= rs_fleet.getString("route") %></span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full
                                <%= rs_fleet.getString("status").equals("Active") ? "bg-green-100 text-green-800" :
                                     rs_fleet.getString("status").equals("Delayed") ? "bg-yellow-100 text-yellow-800" :
                                     "bg-blue-100 text-blue-800" %>">
                                <%= rs_fleet.getString("status") %>
                            </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><%= rs_fleet.getString("driver_name") %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><%= rs_fleet.getString("ETA") %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                            <a href="checkTransport.jsp?fleet_id=<%= rs_fleet.getInt("fleet_id") %>">
                                <button class="text-blue-600 hover:text-blue-800 mr-3">View</button>
                            </a>
                            <% if ("Active".equals(rs_fleet.getString("status"))) { %>
                                <button class="text-red-600 hover:text-red-800"
                                        onclick="console.log('The vehicle is in transit mode');">
                                    Delete
                                </button>
                            <% } else { %>
                                <form method="post" action="/Supply-chain-and-Logistic/DeleteAllServlet" style="display:inline;">
                                    <input type="hidden" name="fleet_id" value="<%= rs_fleet.getInt("fleet_id") %>">
                                    <button type="submit" name="action" class="text-red-600 hover:text-red-800" value ="Fleetdelete">Delete</button>
                                </form>
                            <% } %>
                        </td>
                    </tr>
                    <%
                        }
                    } catch (Exception e) {
                        request.setAttribute("errorMessage", e.getMessage());
                        request.getRequestDispatcher("/error.jsp").forward(request, response);
                    }
                    %>
                </tbody>
            </table>
        </div>
        <!-- Pagination -->
        <div class="bg-white px-4 py-3 border-t border-gray-200 sm:px-6">
            <div class="flex items-center justify-between">
                <div class="flex-1 flex justify-between sm:hidden">
                    <button class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">Previous</button>
                    <button class="ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">Next</button>
                </div>
                <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
                    <div>
                        <p class="text-sm text-gray-700">
                            Showing <span class="font-medium">1</span> to <span class="font-medium">3</span> of <span class="font-medium">12</span> results
                        </p>
                    </div>
                    <div>
                        <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                            <button class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">Previous</button>
                            <button class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">1</button>
                            <button class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">2</button>
                            <button class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">3</button>
                            <button class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">Next</button>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</htmlcode>
            </div>
                  
            <div id="c8b195ef-b7d4-439e-8800-82131c8b865f" data-section_id="c8b195ef-b7d4-439e-8800-82131c8b865f" class="page_sectionHighlight__ahPeD sectionCode">
                <htmlcode id="el-sihaqvw1">
<section id="shipments" class="pt-20 px-6 animate-fade-in" style="background-color: #f9fafb;">
    <!-- Shipment Tracking Header -->
    <div class="flex justify-between items-center mb-6">
        <h2 class="text-2xl font-semibold text-gray-800">Shipment Tracking</h2>
    </div>

    <!-- Tracking Search -->
    <div class="bg-white p-6 rounded-xl shadow-lg border border-gray-100 mb-8 animate-fade-in delay-100">
        <div class="max-w-xl mx-auto">
            <label class="block text-sm font-medium text-gray-700 mb-2">Track Shipment</label>
            <div class="flex gap-4">
                <input type="text" placeholder="Enter tracking number" class="flex-1 border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500 shadow-sm">
                <button class="bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700 transition-colors shadow-md hover:shadow-lg">
                    Track
                </button>
            </div>
        </div>
    </div>
    
    <!-- Recent Shipments -->
    <div class="bg-white rounded-xl shadow-lg border border-gray-100 overflow-hidden mb-8 animate-fade-in delay-200">
        <div class="p-4 border-b border-gray-200 bg-gray-50">
            <h3 class="text-lg font-semibold text-gray-800">Recent Shipments</h3>
        </div>
        <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tracking ID</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Origin</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Destination</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Last Updated</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                <%
    try (Connection conn = PostgresConnection.getConnection()){
    	String shipmentsql = "SELECT s.shipment_id,  s.status, s.last_updated, f.route FROM transport.shipment s JOIN transport.fleets f ON s.fleet_id = f.fleet_id WHERE s.transport_id=? AND s.status IN ('Pending','In Transit','Delivered')";
         PreparedStatement ps = conn.prepareStatement(shipmentsql);
         ps.setInt(1, loginId);
         ResultSet rs_shipment = ps.executeQuery();

        while (rs_shipment.next()) {
%>
                    <tr class="hover:bg-gray-50 transition-colors duration-150">
                        <td class="px-6 py-4 whitespace-nowrap">
                            <div class="flex items-center">
                                <div class="text-sm font-medium text-gray-900"><%= "SHP-" + rs_shipment.getInt("shipment_id") %></div>
                            </div>
                        </td>
                        
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
   							 <%= rs_shipment.getString("route").split(" to ")[0] %>
						</td>
						<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
   							 <%= rs_shipment.getString("route").split(" to ")[1] %>
						</td>
						<td>
                        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full
   							 <%= rs_shipment.getString("status").equals("In Transit") ? "bg-green-100 text-green-800" :
        							 rs_shipment.getString("status").equals("Pending") ? "bg-yellow-100 text-yellow-800" :
         								"bg-red-100 text-red-800" %>">
   								 <%= rs_shipment.getString("status") %>
						</span>
						</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"> <%= rs_shipment.getString("last_updated") %></td>
                        <td>
                        <a href="invoice.jsp?shipment_id=<%= rs_shipment.getInt("shipment_id") %>">
    							<button class="text-blue-600 hover:text-blue-800">View Details</button>
						</a>
						</td>
						</tr>
						<%
        }
    } catch (Exception e) {
        request.setAttribute("errorMessage", e.getMessage());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
%>
                </tbody>
            </table>
        </div>
         <!-- Pagination -->
        <div class="bg-white px-4 py-3 border-t border-gray-200 sm:px-6">
            <div class="flex items-center justify-between">
                <div class="flex-1 flex justify-between sm:hidden">
                    <button class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">Previous</button>
                    <button class="ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">Next</button>
                </div>
                <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
                    <div>
                        <p class="text-sm text-gray-700">
                            Showing <span class="font-medium">1</span> to <span class="font-medium">3</span> of <span class="font-medium">12</span> results
                        </p>
                    </div>
                    <div>
                        <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                            <button class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">Previous</button>
                            <button class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">1</button>
                            <button class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">2</button>
                            <button class="relative inline-flex items-center px-4 py-2 border border-gray-300 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50">3</button>
                            <button class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">Next</button>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</htmlcode>
            </div>
                  
            <div id="fc78d5fb-9d64-472a-a52b-af809a8b04ea" data-section_id="fc78d5fb-9d64-472a-a52b-af809a8b04ea" class="page_sectionHighlight__ahPeD sectionCode">
                <htmlcode id="el-4ozadvnv">
<section id="payments" class="pt-20 px-6 animate-fade-in" style="background-color: #f9fafb;">
    <!-- Payment Analytics Header -->
    <div class="flex justify-between items-center mb-6">
        <h2 class="text-2xl font-semibold text-gray-800">Payment Analytics</h2>
        <div class="flex space-x-4">
            <button class="bg-blue-600 text-white px-5 py-2 rounded-lg hover:bg-blue-700 transition-colors shadow-md hover:shadow-lg">
                Download Report
            </button>
        </div>
    </div>

    <!-- Payment Overview Cards -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <!-- Total Revenue -->
        <div class="bg-white p-6 rounded-xl shadow-lg border border-gray-100 card-hover-effect animate-slide-up">
            <div class="flex justify-between items-center">
                <h3 class="text-gray-700 font-semibold text-lg">Total Revenue</h3>
                <span class="bg-green-100 text-green-700 text-sm px-3 py-1 rounded-full">+8.5%</span>
            </div>
            <p class="text-4xl font-extrabold text-gray-900 mt-2">${totalRevenue}</p>
            <p class="text-sm text-gray-500 mt-1">This month</p>
        </div>

        <!-- Pending Payments -->
        <div class="bg-white p-6 rounded-xl shadow-lg border border-gray-100 card-hover-effect animate-slide-up delay-100">
            <div class="flex justify-between items-center">
                <h3 class="text-gray-700 font-semibold text-lg">Pending Payments</h3>
                <span class="bg-yellow-100 text-yellow-700 text-sm px-3 py-1 rounded-full">${pendingInvoices} invoices</span>
            </div>
            <p class="text-4xl font-extrabold text-gray-900 mt-2">${pendingAmount }</p>
            <p class="text-sm text-gray-500 mt-1">Due this Month</p>
        </div>

        <!-- Completed Payments -->
        <div class="bg-white p-6 rounded-xl shadow-lg border border-gray-100 card-hover-effect animate-slide-up delay-200">
            <div class="flex justify-between items-center">
                <h3 class="text-gray-700 font-semibold text-lg">Completed Payments</h3>
                <span class="bg-blue-100 text-blue-700 text-sm px-3 py-1 rounded-full">${completedTransactions} transactions</span>
            </div>
            <p class="text-4xl font-extrabold text-gray-900 mt-2">${completedAmount}</p>
            <p class="text-sm text-gray-500 mt-1">This month</p>
        </div>

        <!-- Outstanding Balance -->
        <div class="bg-white p-6 rounded-xl shadow-lg border border-gray-100 card-hover-effect animate-slide-up delay-300">
            <div class="flex justify-between items-center">
                <h3 class="text-gray-700 font-semibold text-lg">Outstanding Balance</h3>
                <span class="bg-red-100 text-red-700 text-sm px-3 py-1 rounded-full">${overdueInvoices} overdue</span>
            </div>
            <p class="text-4xl font-extrabold text-gray-900 mt-2">${outstandingAmount}</p>
            <p class="text-sm text-gray-500 mt-1">Total pending</p>
        </div>
    </div>

    <!-- Recent Transactions -->
    <div class="bg-white rounded-xl shadow-lg border border-gray-100 overflow-hidden mb-8 animate-fade-in delay-400">
        <div class="p-4 border-b border-gray-200 bg-gray-50 flex justify-between items-center">
            <h3 class="text-lg font-semibold text-gray-800">Recent Transactions</h3>
            <button class="text-blue-600 hover:text-blue-800 text-sm">View All</button>
        </div>
        <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Invoice ID</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Client</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Amount</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Due Date</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                
              <%
    try (Connection conn = PostgresConnection.getConnection()){
    	String paymentsql = "SELECT invoice_id,  customer_name, tr_amount, status, due_date FROM transport.invoices WHERE transport_id=?";
         PreparedStatement ps = conn.prepareStatement(paymentsql);
         ps.setInt(1, loginId);
         ResultSet rs_payment = ps.executeQuery();

        while (rs_payment.next()) {
%>
                    <tr class="hover:bg-gray-50 transition-colors duration-150">
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><%= "#INV-" + rs_payment.getInt("invoice_id") %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><%= rs_payment.getString("customer_name") %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><%= "Rs " + rs_payment.getInt("tr_amount") %></td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full
   												 <%= rs_payment.getString("status").equals("Paid") ? "bg-green-100 text-green-800" :
        										 rs_payment.getString("status").equals("Pending") ? "bg-yellow-100 text-yellow-800" :
         											"bg-red-100 text-red-800" %>">
    						<%= rs_payment.getString("status") %>
						</span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%=  rs_payment.getString("due_date") %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
    <a href="pay-slip.jsp?invoice_id=<%= rs_payment.getInt("invoice_id") %>">
        <button class="text-blue-600 hover:text-blue-800">View</button>
    </a>

    <% if (!"Paid".equalsIgnoreCase(rs_payment.getString("status"))) { %>
         <form method="post" action="/Supply-chain-and-Logistic/DeleteAllServlet" style="display:inline;">
       
        <input type="hidden" name="invoice_id" value="<%= rs_payment.getInt("invoice_id") %>">
        <button type="submit" name = "action" class="text-gray-600 hover:text-gray-800"> | Send</button>
    </form>
    <% } %>
</td>
                    </tr>
                    <%
        }
    } catch (Exception e) {
        request.setAttribute("errorMessage", e.getMessage());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
%>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Payment Analytics Charts (kept for potential future use) -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <!-- Monthly Revenue -->
        

        <!-- Payment Status Distribution -->
        
    </div>
</section>
</htmlcode>
    
            </div>
                  
            <div id="602e89d2-d64e-4d7c-b168-0f9adaf0c2d2" data-section_id="602e89d2-d64e-4d7c-b168-0f9adaf0c2d2" class="page_sectionHighlight__ahPeD sectionCode">
                <htmlcode id="el-c7g9nihv">
<section id="delivery" class="pt-20 px-6 animate-fade-in" style="background-color:#f9fafb;">
    <!-- Delivery Monitoring Header -->
    <div class="flex justify-between items-center mb-6">
        <h2 class="text-2xl font-semibold text-gray-800">Delivery Monitoring</h2>
    </div>

    <!-- Delivery Stats -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <!-- On-Time Deliveries -->
        <div class="bg-white p-6 rounded-xl shadow-lg border border-gray-100 card-hover-effect animate-slide-up">
            <div class="flex items-center justify-between mb-4">
                <h3 class="text-gray-700 font-semibold text-lg">On-Time Deliveries</h3>
                <span class="bg-green-100 text-green-700 text-sm px-3 py-1 rounded-full">${String.format("%.1f", onTimePercentage)}%</span>
            </div>
            <p class="text-4xl font-extrabold text-gray-900">${onTimeCount}</p>
            <p class="text-sm text-gray-500 mt-1">Last 24 hours</p>
        </div>

        <!-- Delayed Deliveries -->
        <div class="bg-white p-6 rounded-xl shadow-lg border border-gray-100 card-hover-effect animate-slide-up delay-100">
            <div class="flex items-center justify-between mb-4">
                <h3 class="text-gray-700 font-semibold text-lg">Delayed Deliveries</h3>
                <span class="bg-red-100 text-red-700 text-sm px-3 py-1 rounded-full">${String.format("%.1f", delayedPercentage)}%</span>
            </div>
            <p class="text-4xl font-extrabold text-gray-900">${delayedShipments }</p>
            <p class="text-sm text-gray-500 mt-1">Requires attention</p>
        </div>

        <!-- Average Delivery Time -->
        <div class="bg-white p-6 rounded-xl shadow-lg border border-gray-100 card-hover-effect animate-slide-up delay-200">
            <div class="flex items-center justify-between mb-4">
                <h3 class="text-gray-700 font-semibold text-lg">Avg Delivery Time</h3>
                <span class="bg-blue-100 text-blue-700 text-sm px-3 py-1 rounded-full">-2%</span>
            </div>
            <p class="text-4xl font-extrabold text-gray-900">2.5 hrs</p>
            <p class="text-sm text-gray-500 mt-1">This week</p>
        </div>

        <!-- Active Deliveries -->
        <div class="bg-white p-6 rounded-xl shadow-lg border border-gray-100 card-hover-effect animate-slide-up delay-300">
            <div class="flex items-center justify-between mb-4">
                <h3 class="text-gray-700 font-semibold text-lg">Active Deliveries</h3>
                <span class="bg-yellow-100 text-yellow-700 text-sm px-3 py-1 rounded-full">Live</span>
            </div>
            <p class="text-4xl font-extrabold text-gray-900">${activeCount}</p>
            <p class="text-sm text-gray-500 mt-1">In progress</p>
        </div>
    </div>

    <!-- Live Delivery Tracking -->
    <div class="bg-white rounded-xl shadow-lg border border-gray-100 overflow-hidden mb-8 animate-fade-in delay-400">
        <div class="p-4 border-b border-gray-200 bg-gray-50">
            <h3 class="text-lg font-semibold text-gray-800">Live Delivery Tracking</h3>
        </div>
        <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Delivery ID</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Vehicle Number</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Location</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ETA</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                
              <%
    try (Connection conn = PostgresConnection.getConnection()){
    	String deliverysql = "SELECT  dt.delivery_id, dt.location, dt.eta,  dt.status, f.vehicle_number FROM transport.delivery_tracking dt JOIN transport.fleets f ON dt.fleet_id = f.fleet_id WHERE dt.transport_id=? AND dt.status IN('Order Placed','Order Confirmed','Packed','Ready','Shipped','Out for Delivery','Delivered')";
         PreparedStatement ps = conn.prepareStatement(deliverysql);
         ps.setInt(1, loginId);
         ResultSet rs_delivery = ps.executeQuery();

        while (rs_delivery.next()) {
%>
                    <tr class="hover:bg-gray-50 transition-colors duration-150">
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><%= "#DEL-" + rs_delivery.getInt("delivery_id") %></td>
                        <td class="px-6 py-4 whitespace-nowrap">
                          <%= rs_delivery.getString("vehicle_number") %>  
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <span class="text-sm text-gray-900"><%= rs_delivery.getString("location") %></span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= rs_delivery.getString("eta") %></td>
                        <%
    					List<String> greenStatuses = Arrays.asList("Order Placed", "Order Confirmed", "Order Packed");
    					List<String> yellowStatuses = Arrays.asList("Packed","Ready", "Shipped","Out for Delivery");
    					String statusClass = "bg-red-100 text-red-800"; // Default color

    					String status = rs_delivery.getString("status");

   					 if (greenStatuses.contains(status)) {
        				statusClass = "bg-green-100 text-green-800";
    				} else if (yellowStatuses.contains(status)) {
       				 statusClass = "bg-yellow-100 text-yellow-800";
   						 }
					%>

					<td class="px-6 py-4 whitespace-nowrap">
   						 <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full <%= statusClass %>">
       				 <%= status %>
   				 </span>
				<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
    <% if (rs_delivery.getString("status").equals("Delivered")) { %>
        
          <div class="flex items-center gap-2">
            <!-- Invoice Button -->
            <button class="px-3 py-1 rounded-md text-sm font-medium bg-gray-600 text-white hover:bg-gray-700"
                    onclick="console.log('Customer received invoice.');">
                Invoice
            </button>

            <!-- Remove Button inside Form -->
            <form action="/Supply-chain-and-Logistic/UpdatesServlet" method="post">
                <input type="hidden" name="deliveryID" value="<%= rs_delivery.getInt("delivery_id") %>">
                <input type="hidden" name="complete" value="Order Completed">
                <button class="px-3 py-1 text-red-600 hover:text-red-800 text-sm font-medium">
                    Remove
                </button>
            </form>
        </div>
       
    <% } else { %>
        <div class="flex space-x-2">
            <button class="px-3 py-1 rounded-md text-sm font-medium bg-blue-600 text-white hover:bg-blue-700"
                    onclick="console.log('Sorry, Order is not Delivered Yet!');">
                In Transit
            </button>
            <a href="OrderTracking.jsp?delivery_id=<%= rs_delivery.getInt("delivery_id") %>">
                <button class="px-3 py-1 rounded-md text-sm font-medium bg-green-600 text-white hover:bg-green-700">
                    Track
                </button>
            </a>
             <a href="UpdateStatus.jsp?delivery_id=<%= rs_delivery.getInt("delivery_id") %>">
                <button class="px-3 py-1 text-gray-600 hover:text-gray-800">
                    Update
                </button>
            </a>
        </div>
    <% } %>
</td>
            </tr>
                <%
        }
    } catch (Exception e) {
        request.setAttribute("errorMessage", e.getMessage());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
%>    
                </tbody>
            </table>
        </div>
    </div>

    <!-- Delivery Performance -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <!-- Daily Delivery Volume -->
        <div class="bg-white p-6 rounded-xl shadow-lg border border-gray-100 animate-fade-in delay-500">
            <h3 class="text-lg font-semibold text-gray-800 mb-4">Daily Delivery Volume</h3>
            <div class="h-80 flex items-end space-x-2">
                <div class="flex-1 bg-blue-200 rounded-t-lg hover:bg-blue-300 transition-colors h-3/4"></div>
                <div class="flex-1 bg-blue-200 rounded-t-lg hover:bg-blue-300 transition-colors h-5/6"></div>
                <div class="flex-1 bg-blue-200 rounded-t-lg hover:bg-blue-300 transition-colors h-2/3"></div>
                <div class="flex-1 bg-blue-200 rounded-t-lg hover:bg-blue-300 transition-colors h-11/12"></div>
                <div class="flex-1 bg-blue-200 rounded-t-lg hover:bg-blue-300 transition-colors h-4/5"></div>
                <div class="flex-1 bg-blue-200 rounded-t-lg hover:bg-blue-300 transition-colors h-7/10"></div>
                <div class="flex-1 bg-blue-200 rounded-t-lg hover:bg-blue-300 transition-colors h-full"></div>
            </div>
        </div>

        <!-- Delivery Success Rate -->
        <div class="bg-white p-6 rounded-xl shadow-lg border border-gray-100 animate-fade-in delay-600">
            <h3 class="text-lg font-semibold text-gray-800 mb-4">Delivery Success Rate</h3>
            <div class="relative h-80 flex items-center justify-center">
                <div class="w-full max-w-md">
                    <div class="mb-4">
                        <div class="flex justify-between mb-1">
                            <span class="text-sm text-gray-700">Successful</span>
                            <span class="text-sm font-medium text-gray-900">${String.format("%.1f", deliveredpercentage)}%</span>
                        </div>
                        <div class="progress-bar-container">
                            <div class="progress-bar bg-green-500" style="width: ${String.format("%.1f", deliveredpercentage)}%"></div>
                        </div>
                    </div>
                    <div class="mb-4">
                        <div class="flex justify-between mb-1">
                            <span class="text-sm text-gray-700">Delayed</span>
                            <span class="text-sm font-medium text-gray-900">${String.format("%.1f", delayedPercentage)}%</span>
                        </div>
                        <div class="progress-bar-container">
                            <div class="progress-bar bg-yellow-500" style="width: ${String.format("%.1f", delayedPercentage)}%"></div>
                        </div>
                    </div>
                    <div>
                        <div class="flex justify-between mb-1">
                            <span class="text-sm text-gray-700">Failed</span>
                            <span class="text-sm font-medium text-gray-900">${String.format("%.1f", failedpercentage)}%</span>
                        </div>
                        <div class="progress-bar-container">
                            <div class="progress-bar bg-red-500" style="width: ${String.format("%.1f", failedpercentage)}%"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</htmlcode>
            </div>
                  
            <div id="0fd1bf6a-0544-4d97-83ee-c5d52768cb36" data-section_id="0fd1bf6a-0544-4d97-83ee-c5d52768cb36" class="page_sectionHighlight__ahPeD sectionCode">
                <htmlcode id="el-ak3kk3va">
<section id="settings" class="pt-20 px-6 animate-fade-in" style="background-color:#f9fafb;">
    <!-- Settings Header -->
    <div class="flex justify-between items-center mb-6">
        <h2 class="text-2xl font-semibold text-gray-800">Settings &amp; Configuration</h2>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <!-- Main Content Area -->
        <div class="lg:col-span-3 space-y-6">
            <!-- Profile Settings -->
            <div class="bg-white rounded-xl shadow-lg border border-gray-100 p-6 animate-slide-up">
                <h3 class="text-lg font-semibold text-gray-900 mb-4">Profile Settings</h3>
                <div class="space-y-4">
                    <div class="flex items-center">
                        <img src="https://avatar.iran.liara.run/public" alt="Profile" class="w-24 h-24 rounded-full border-4 border-gray-200 shadow-md">
                        <div class="ml-6">
                            <button class="bg-gray-700 text-white px-5 py-2 rounded-lg hover:bg-gray-800 transition-colors flex items-center gap-2 shadow-md hover:shadow-lg">
                                <i class="fas fa-edit"></i>
                                Edit Profile
                            </button>
                        </div>
                    </div>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Company Name</label>
                            <input type="text" class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500 shadow-sm" value="${company_name}" readonly>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Company Address</label>
                            <input type="text" class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500 shadow-sm" value="${company_address}" readonly>
                        </div>
                       
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Email</label>
                            <input type="email" class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500 shadow-sm" value="${company_email}" readonly>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Phone</label>
                            <input type="tel" class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500 shadow-sm" value="${company_contact}" readonly>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Security Settings -->
            <div class="bg-white rounded-xl shadow-lg border border-gray-100 p-6 animate-slide-up delay-100">
                <h3 class="text-lg font-semibold text-gray-900 mb-4">Security Settings</h3>
                <div class="space-y-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">New Password</label>
                        <input type="password" class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500 shadow-sm">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Confirm New Password</label>
                        <input type="password" class="w-full border border-gray-300 rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500 shadow-sm">
                    </div>
                    <button class="bg-blue-600 text-white px-5 py-2 rounded-lg hover:bg-blue-700 transition-colors shadow-md hover:shadow-lg">
                        Update Password
                    </button>
                </div>
            </div>
        </div>
    </div>
</section>
</htmlcode>
            </div>
                  
            <div id="5edc3b8d-ba81-4a00-8ba8-6b939cb09b63" data-section_id="5edc3b8d-ba81-4a00-8ba8-6b939cb09b63" class="page_sectionHighlight__ahPeD sectionCode">
                <htmlcode id="el-e5g86ogk">

</htmlcode>
            </div>
                  

<script>
document.addEventListener('DOMContentLoaded', function() {
    const links = document.querySelectorAll('nav a');
    
    function setActiveLink() {
        const hash = window.location.hash || '#dashboard';
        links.forEach(link => {
            link.classList.remove('active-link');
            if(link.getAttribute('href') === hash) {
                link.classList.add('active-link');
            }
        });
    }

    window.addEventListener('hashchange', setActiveLink);
    setActiveLink();

    // Handle window resize for mobile menu
    window.addEventListener('resize', () => {
        if (window.innerWidth > 1024) {
            // Access Alpine.js state directly for the mobile menu
            const alpineRoot = document.querySelector('[x-data]');
            if (alpineRoot && alpineRoot.__x && alpineRoot.__x.$data) {
                alpineRoot.__x.$data.isOpen = false;
            }
        }
    });

    // Replace alert/confirm with console.log as per instructions
    window.showAlert = function() {
        console.log("Sorry, Order is not Delivered Yet!");
        // In a real application, you would show a custom modal here.
    };

    window.invoiceAlert = function() {
        console.log("Customer received invoice.");
        // In a real application, you would show a custom modal here.
    };

    window.confirmCancel = function(status) {
        if (status === 'Accepted') {
            console.log("You can't cancel this order.");
            // In a real application, you would show a custom modal here.
            return false;
        }
        console.log("Do you want to cancel this order request?");
        // In a real application, you would show a custom confirmation modal here.
        return true; // For now, allow cancellation to proceed in the demo
    };
});
</script>
              </main></div>
            
      
      </htmlcode>
              
</element><element id="52406aea-3b79-4f96-bca8-fa1499c3a74a" data-section-id="52406aea-3b79-4f96-bca8-fa1499c3a74a">

                
                      <htmlcode id="el-uclx8qf3">

</htmlcode>
                    
              
</element><element id="7f01d585-a5b0-4c0a-9d53-72eb5fd79c92" data-section-id="7f01d585-a5b0-4c0a-9d53-72eb5fd79c92">

                
                      <htmlcode id="el-l768s10h">

</htmlcode>
                    
              
</element><element id="c8b195ef-b7d4-439e-8800-82131c8b865f" data-section-id="c8b195ef-b7d4-439e-8800-82131c8b865f">

                
                      <htmlcode id="el-sihaqvw1">

</htmlcode>
                    
              
</element></div>
      </main>
      
      <!-- FAQ Accordion JavaScript -->
      <script>
        document.addEventListener('DOMContentLoaded', function() {
          try {
            // Utility function to safely access properties of potentially undefined objects
            function safeAccess(obj, prop) {
              return obj && typeof obj === 'object' && prop in obj ? obj[prop] : undefined;
            }

            // Utility function to check if an element exists and is of a certain type
            function isValidElement(el, type) {
              try {
                return el && el.nodeType === 1 && (!type || el.nodeName.toLowerCase() === type.toLowerCase());
              } catch (error) {
                console.error('Error checking element type:', error);
                return false;
              }
            }

            // Initialize all FAQ accordions on the page
            initializeFAQs();
          } catch (error) {
            console.error('Failed to initialize FAQs:', error);
          }
          
          // Helper function to initialize FAQs
          function initializeFAQs() {
            try {
              // Look for FAQ sections with various possible class names/structures
              const faqButtons = document.querySelectorAll('.faq-item button, .accordion-item button, .accordion-header button, [data-accordion-toggle], .accordion button');
              
              if (faqButtons && faqButtons.length > 0) {
                faqButtons.forEach(button => {
                  if (button) {
                    try {
                      setupAccordionButton(button);
                    } catch (err) {
                      console.error('Error setting up accordion button:', err);
                    }
                  }
                });
              } else {
                // Look for elements that might be FAQs even if they don't have the expected structure
                const possibleFaqElements = document.querySelectorAll('.faq, .faqs, .accordion, .accordions, .faq-section, #faq, #faqs');
                
                if (possibleFaqElements && possibleFaqElements.length > 0) {
                  possibleFaqElements.forEach(element => {
                    if (!element) return;
                    
                    try {
                      const questions = element.querySelectorAll('button, [role="button"], .accordion-item, .faq-item, h3');
                      
                      if (questions && questions.length > 0) {
                        questions.forEach(question => {
                          if (!question) return;
                          
                          try {
                            if (!question.hasAttribute('aria-expanded')) {
                              // Turn this into a proper accordion button
                              question.setAttribute('aria-expanded', 'false');
                              const content = question.nextElementSibling;
                              
                              if (content) {
                                const id = 'accordion-content-' + Math.random().toString(36).substr(2, 9);
                                content.id = id;
                                question.setAttribute('aria-controls', id);
                                content.classList.add('faq-content');
                                
                                // Add rotation icon if not present
                                if (!question.querySelector('.faq-toggle-icon')) {
                                  // Find any SVG or icon element that might already be there
                                  const existingIcon = question.querySelector('svg, i, .icon, img[class*="icon"]');
                                  
                                  if (existingIcon) {
                                    existingIcon.classList.add('faq-toggle-icon');
                                  } else {
                                    // Create and append a plus icon if none exists
                                    const icon = document.createElement('span');
                                    icon.innerHTML = '+';
                                    icon.classList.add('faq-toggle-icon', 'ml-auto', 'text-xl', 'font-medium');
                                    
                                    // Find where to append the icon (usually at the end of the button)
                                    const container = question.querySelector('div');
                                    
                                    if (container) {
                                      container.style.display = 'flex';
                                      container.style.justifyContent = 'space-between';
                                      container.style.alignItems = 'center';
                                      container.appendChild(icon);
                                    } else if (question) {
                                      question.style.display = 'flex';
                                      question.style.justifyContent = 'space-between';
                                      question.style.alignItems = 'center';
                                      question.appendChild(icon);
                                    }
                                  }
                                }
                                
                                setupAccordionButton(question);
                              }
                            }
                          } catch (err) {
                            console.error('Error processing question element:', err);
                          }
                        });
                      }
                    } catch (err) {
                      console.error('Error processing FAQ section:', err);
                    }
                  });
                }
              }

              // Additional fallback for specific FAQ structures found on the site
              try {
                // Find the FAQ section by its heading
                const faqHeading = Array.from(document.querySelectorAll('h2, h3')).find(h => 
                  h.textContent && h.textContent.toLowerCase().includes('frequently asked questions')
                );

                if (faqHeading) {
                  const faqSection = faqHeading.closest('section') || faqHeading.parentElement;
                  if (faqSection) {
                    const questionElements = faqSection.querySelectorAll('h3:not(:first-child), .faq-question, .question, .accordion-title');
                    
                    questionElements.forEach(question => {
                      try {
                        if (!question.hasAttribute('aria-expanded') && question.nextElementSibling) {
                          question.classList.add('faq-question');
                          question.setAttribute('role', 'button');
                          question.setAttribute('aria-expanded', 'false');
                          
                          const content = question.nextElementSibling;
                          const id = 'faq-content-' + Math.random().toString(36).substr(2, 9);
                          content.id = id;
                          question.setAttribute('aria-controls', id);
                          content.classList.add('faq-content');
                          
                          setupAccordionButton(question);
                        }
                      } catch (error) {
                        console.error('Error processing FAQ question element:', error);
                      }
                    });
                  }
                }
              } catch (error) {
                console.error('Error in FAQ fallback processing:', error);
              }
            } catch (error) {
              console.error('Error in initializeFAQs:', error);
            }
          }
          
          function setupAccordionButton(button) {
            if (!button) return;
            
            try {
              if (!button.hasAttribute('data-accordion-initialized')) {
                button.setAttribute('data-accordion-initialized', 'true');
                
                button.addEventListener('click', function(event) {
                  try {
                    // Prevent event bubbling if needed
                    event.stopPropagation();
                    
                    const isExpanded = button.getAttribute('aria-expanded') === 'true';
                    const contentId = button.getAttribute('aria-controls');
                    const content = contentId && document.getElementById(contentId) ? 
                                   document.getElementById(contentId) : 
                                   button.nextElementSibling;
                    
                    if (content) {
                      if (isExpanded) {
                        button.setAttribute('aria-expanded', 'false');
                        content.classList.remove('active');
                      } else {
                        button.setAttribute('aria-expanded', 'true');
                        content.classList.add('active');
                      }
                    }
                  } catch (err) {
                    console.error('Error in accordion click handler:', err);
                  }
                });
              }
            } catch (error) {
              console.error('Error in setupAccordionButton:', error);
            }
          }
        });



      </script>

      <!-- {bodyScripts} -->
   </body>
</html>
