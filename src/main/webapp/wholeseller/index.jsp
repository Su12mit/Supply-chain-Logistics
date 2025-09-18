<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setDateHeader("Expires", 0); // Proxies.
%>

<%@ page import="java.sql.*"%>
<%@ page import="com.scm.db.PostgresConnection"%>
<%@ page import= "com.scm.Transport.LoginId" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<% 
int loginId = LoginId.getLoginId(request.getSession()); // Pass session directly
session.setAttribute("loginId", loginId);


if (session.getAttribute("loginId") == null) {
    response.sendRedirect("/Supply-chain-and-Logistic/All_login.jsp");
    return;
}
%>


<%
    
    // Initialize metrics variables
    int totalProducts = 0;
    int purchaseOrdersCount = 0;
    int proformaCount = 0;
    int totalInvoices = 0;
    int lowStockItems = 0;
    int outOfStockItems = 0;
    int totalOrders = 0;
    int pendingOrders = 0;
    int processingOrders = 0;
    int completedOrders = 0;
    double totalRevenue = 0.0;
    double pendingPayments = 0.0;
    double overduePayments = 0.0;
    int paidInvoices = 0;
    int totalFeedback = 0;
    double averageRating = 0.0;
    String email ="";
    int improvementSuggestions = 0;
    int pinvoices =0;
    int oinvoices =0;
    String sname = ""; // Initialize sname

    try (Connection conn = PostgresConnection.getConnection()){

        PreparedStatement ps = null;
        ResultSet rs = null;
		PreparedStatement ps1 = null;
        ResultSet rs1 = null;

        ps = conn.prepareStatement("SELECT email FROM wholeseller.login WHERE login_id = ?");
    	ps.setInt(1, loginId);
    	rs = ps.executeQuery();
    	if (rs.next()) {
    	    email = rs.getString("email");
    	    request.setAttribute("email", email);
    	}
    	rs.close();
        ps.close();
        
        // Get shop name
        String snamesql = "SELECT shop_name FROM wholeseller.wholeseller WHERE wholeseller_id=?";
        ps = conn.prepareStatement(snamesql);
        ps.setInt(1, loginId);
        rs = ps.executeQuery();
        if (rs.next()) {
            sname = rs.getString("shop_name");
            request.setAttribute("sname", sname);
        }
        rs.close();
        ps.close();
        
        // 1. Total Products
        ps = conn.prepareStatement("SELECT COUNT(*) FROM wholeseller.stock WHERE wholeseller_id = ?");
        ps.setInt(1, loginId);
        rs = ps.executeQuery();
        if (rs.next()) {
            totalProducts = rs.getInt(1);
            request.setAttribute("totalProducts", totalProducts);
        }
        rs.close();
        ps.close();
        
        // 2. Purchase Orders Count
        ps = conn.prepareStatement("SELECT COUNT(*) FROM wholeseller.order_request WHERE wholeseller_id = ?");
        ps.setInt(1, loginId);
        rs = ps.executeQuery();
        if (rs.next()) {
            purchaseOrdersCount = rs.getInt(1);
            request.setAttribute("purchaseOrdersCount", purchaseOrdersCount);
        }
        rs.close();
        ps.close();
        
        // 3. Proforma Count (Hardcoded as 89 in HTML, keeping as is)
        
     // 4. Total Invoices Count
        ps = conn.prepareStatement("SELECT COUNT(*) FROM wholeseller.invoice WHERE wholeseller_id = ?");
        ps.setInt(1, loginId);
        rs = ps.executeQuery();
        if (rs.next()) {
            totalInvoices = rs.getInt(1);
            request.setAttribute("totalInvoices", totalInvoices);
        }
        rs.close();
        ps.close();
        
        // 5. Low Stock Items (assuming quantity < 30 and > 0)
        ps = conn.prepareStatement("SELECT COUNT(*) FROM wholeseller.stock WHERE wholeseller_id = ? AND quantity < 30 AND quantity > 0");
        ps.setInt(1, loginId);
        rs = ps.executeQuery();
        if (rs.next()) {
            lowStockItems = rs.getInt(1);
            request.setAttribute("lowStockItems", lowStockItems);
        }
        rs.close();
        ps.close();
        
     // 6. Out of Stock Items (quantity = 0)
        ps = conn.prepareStatement("SELECT COUNT(*) FROM wholeseller.stock WHERE wholeseller_id = ? AND quantity = 0");
        ps.setInt(1, loginId);
        rs = ps.executeQuery();
        if (rs.next()) {
            outOfStockItems = rs.getInt(1);
            request.setAttribute("outOfStockItems", outOfStockItems);
        }
        rs.close();
        ps.close();
        
     // 7. Orders: Total, Pending, Processing, Completed
        ps = conn.prepareStatement(
            "SELECT COUNT(*) AS total, " +
            "SUM(CASE WHEN status = 'Pending' THEN 1 ELSE 0 END) AS pending, " +
            "SUM(CASE WHEN status = 'Processing' THEN 1 ELSE 0 END) AS processing, " +
            "SUM(CASE WHEN status = 'Completed' THEN 1 ELSE 0 END) AS completed " +
            "FROM wholeseller.order_request WHERE wholeseller_id = ?"
        );
        ps.setInt(1, loginId);
        rs = ps.executeQuery();
        if (rs.next()) {
            totalOrders = rs.getInt("total");
            pendingOrders = rs.getInt("pending");
            processingOrders = rs.getInt("processing");
            completedOrders = rs.getInt("completed");
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("pendingOrders", pendingOrders);
            request.setAttribute("processingOrders", processingOrders);
            request.setAttribute("completedOrders", completedOrders);
        }
        rs.close();
        ps.close();
        

        // 8. Total Revenue: Sum of total_amount for paid invoices
        ps = conn.prepareStatement("SELECT COALESCE(SUM(amount), 0) FROM wholeseller.invoice WHERE wholeseller_id = ? AND payment_status = 'Paid'");
        ps.setInt(1, loginId);
        rs = ps.executeQuery();
        if (rs.next()) {
            totalRevenue = rs.getDouble(1);
            request.setAttribute("totalRevenue", totalRevenue);
        }
        rs.close();
        ps.close();
        
     // 9. Pending Payments: Total unpaid amount in pending invoices
        ps = conn.prepareStatement("SELECT COALESCE(SUM(amount), 0) FROM wholeseller.invoice WHERE wholeseller_id = ? AND payment_status = 'Unpaid'");
        ps.setInt(1, loginId);
        rs = ps.executeQuery();
        ps1 = conn.prepareStatement("SELECT COUNT(*) FROM wholeseller.invoice WHERE wholeseller_id = ? AND payment_status = 'Unpaid'");
        ps1.setInt(1, loginId);
        rs1 = ps1.executeQuery();
        if (rs.next() && rs1.next()) {
            pendingPayments = rs.getDouble(1);
            pinvoices = rs1.getInt(1);
            request.setAttribute("pendingPayments", pendingPayments);
            request.setAttribute("pinvoices", pinvoices);
        }
        rs.close();
        ps.close();
        
     // 10. Overdue Payments: Based on due_date (and status not paid)
        ps = conn.prepareStatement("SELECT COALESCE(SUM(amount), 0) FROM wholeseller.invoice WHERE wholeseller_id = ? AND invoice_date < CURRENT_DATE AND payment_status <> 'Paid'");
        ps.setInt(1, loginId);
        rs = ps.executeQuery();
        ps1 = conn.prepareStatement("SELECT COUNT(*) FROM wholeseller.invoice WHERE wholeseller_id = ? AND payment_status = 'Overdue'");
        ps1.setInt(1, loginId);
        rs1 = ps1.executeQuery();
        if (rs.next() && rs1.next()) {
            overduePayments = rs.getDouble(1);
            oinvoices = rs1.getInt(1);
            request.setAttribute("overduePayments", overduePayments);
            request.setAttribute("oinvoices", oinvoices);
        }
        rs.close();
        ps.close();
        
        // 11. Paid Invoices Count
        ps = conn.prepareStatement("SELECT COUNT(*) FROM wholeseller.invoice WHERE wholeseller_id = ? AND payment_status = 'Paid'");
        ps.setInt(1, loginId);
        rs = ps.executeQuery();
        
        if (rs.next()) {
            paidInvoices = rs.getInt(1);
            request.setAttribute("paidInvoices", paidInvoices);
        }
        rs.close();
        ps.close();
        
     // 12. Total Feedback Count
        ps = conn.prepareStatement("SELECT COUNT(*) FROM wholeseller.feedback WHERE wholeseller_id = ?");
        ps.setInt(1, loginId);
        rs = ps.executeQuery();
        if (rs.next()) {
            totalFeedback = rs.getInt(1);
            request.setAttribute("totalFeedback", totalFeedback);
        }
        rs.close();
        ps.close();

        // 13. Average Rating from feedback
        ps = conn.prepareStatement("SELECT COALESCE(AVG(rating), 0) FROM wholeseller.feedback WHERE wholeseller_id = ?");
        ps.setInt(1, loginId);
        rs = ps.executeQuery();
        if (rs.next()) {
            averageRating = rs.getDouble(1);
            request.setAttribute("averageRating", averageRating);
        }
        rs.close();
        ps.close();

        // 15. Improvement Suggestions Count
        ps = conn.prepareStatement("SELECT COUNT(*) FROM wholeseller.feedback WHERE wholeseller_id = ? AND rating < 3");
        ps.setInt(1, loginId);
        rs = ps.executeQuery();
        if (rs.next()) {
            improvementSuggestions = rs.getInt(1);
            request.setAttribute("improvementSuggestions", improvementSuggestions);
        }
        rs.close();
        ps.close();
        
    } catch (Exception e) {
        request.setAttribute("errorMessage", e.getMessage());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
%>
<!DOCTYPE html>
<html lang="en" class="scroll-smooth h-full">

   <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <meta name="description" content="Wholesaler Dashboard for Supply Chain and Logistics Management">
      <meta name="theme-color" content="#ffffff">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="robots" content="index, follow">
      
      <title>Wholesaler Dashboard</title>
      <!-- SEO Description -->
      <meta name="description" content="Manage your stock, orders, payments, and feedback efficiently with our comprehensive wholesaler dashboard.">

      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100..900;1,100..900&family=Source+Code+Pro:ital,wght@0,200..900;1,200..900&display=swap" rel="stylesheet">
      <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:ital,wght@0,100..800;1,100..800&display=swap" rel="stylesheet">

      <!-- Performance optimization: Preload critical resources -->
      <link rel="preload" href="https://cdn.tailwindcss.com" as="script">
      
      <!-- Core CSS -->
      <script src="https://cdn.tailwindcss.com"></script>
      <script>
      document.addEventListener('DOMContentLoaded', function() {
        tailwind.config = {
          theme: {
            extend: {
              colors: {
                primary: {
                  DEFAULT: '#008080', /* Teal-like color */
                  50: '#e0f2f2',
                  100: '#b2d8d8',
                  200: '#84c0c0',
                  300: '#55a8a8',
                  400: '#269090',
                  500: '#008080',
                  600: '#006666',
                  700: '#004d4d',
                  800: '#003333',
                  900: '#001a1a',
                  950: '#000d0d',
                },
                secondary: {
                  DEFAULT: '#4b5563', /* Gray-700 */
                  50: '#f9fafb',
                  100: '#f3f4f6',
                  200: '#e5e7eb',
                  300: '#d1d5db',
                  400: '#9ca3af',
                  500: '#6b7280',
                  600: '#4b5563',
                  700: '#374151',
                  800: '#1f2937',
                  900: '#111827',
                  950: '#030712',
                },
                accent: {
                  DEFAULT: '#10b981', /* Emerald-500 (for success states) */
                  50: '#ecfdf5',
                  100: '#d1fae5',
                  200: '#a7f3d0',
                  300: '#6ee7b7',
                  400: '#34d399',
                  500: '#10b981',
                  600: '#059669',
                  700: '#047857',
                  800: '#065f46',
                  900: '#064e3b',
                  950: '#022c22',
                },
              },
              fontFamily: {
                sans: ['Roboto', 'system-ui', '-apple-system', 'BlinkMacSystemFont', 'Segoe UI', 'Helvetica Neue', 'Arial', 'sans-serif'],
                heading: ['Roboto', 'system-ui', 'sans-serif'],
                body: ['Roboto', 'system-ui', 'sans-serif'],
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
                'fade-in': 'fadeIn 0.5s ease-in',
                'fade-out': 'fadeOut 0.5s ease-out',
                'slide-up': 'slideUp 0.5s ease-out',
                'slide-down': 'slideDown 0.5s ease-out',
                'slide-left': 'slideLeft 0.5s ease-out',
                'slide-right': 'slideRight 0.5s ease-out',
                'scale-in': 'scaleIn 0.5s ease-out',
                'scale-out': 'scaleOut 0.5s ease-out',
                'spin-slow': 'spin 3s linear infinite',
                'pulse-slow': 'pulse 3s cubic-bezier(0.4, 0, 0.6, 1) infinite',
                'bounce-slow': 'bounce 3s infinite',
                'float': 'float 3s ease-in-out infinite',
              },
              keyframes: {
                fadeIn: {
                  '0%': { opacity: '0' },
                  '100%': { opacity: '1' },
                },
                fadeOut: {
                  '0%': { opacity: '1' },
                  '100%': { opacity: '0' },
                },
                slideUp: {
                  '0%': { transform: 'translateY(20px)', opacity: '0' },
                  '100%': { transform: 'translateY(0)', opacity: '1' },
                },
                slideDown: {
                  '0%': { transform: 'translateY(-20px)', opacity: '0' },
                  '100%': { transform: 'translateY(0)', opacity: '1' },
                },
                slideLeft: {
                  '0%': { transform: 'translateX(20px)', opacity: '0' },
                  '100%': { transform: 'translateX(0)', opacity: '1' },
                },
                slideRight: {
                  '0%': { transform: 'translateX(-20px)', opacity: '0' },
                  '100%': { transform: 'translateX(0)', opacity: '1' },
                },
                scaleIn: {
                  '0%': { transform: 'scale(0.9)', opacity: '0' },
                  '100%': { transform: 'scale(1)', opacity: '1' },
                },
                scaleOut: {
                  '0%': { transform: 'scale(1.1)', opacity: '0' },
                  '100%': { transform: 'scale(1)', opacity: '1' },
                },
                float: {
                  '0%, 100%': { transform: 'translateY(0)' },
                  '50%': { transform: 'translateY(-10px)' },
                },
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

      <!-- Icons -->
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" 
            xintegrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />
      
      <link rel="icon" type="image/x-icon" href="/favicon.ico">
      
      <style>
        /* Custom styles for the yellowish theme */
        .active-nav-link { 
            @apply bg-primary-200 text-primary-800; 
        }
        html, body { height: 100%; margin: 0; }
        body {
            display: flex;
            flex-direction: column;
            font-family: 'Roboto', sans-serif; /* Ensure Roboto is applied */
        }

        /* Custom styles for status badges */
        .status-proceed { @apply bg-primary-100 text-primary-800; }
        .status-cancelled { @apply bg-red-100 text-red-800; }
        .status-in-transit { @apply bg-blue-100 text-blue-800; }
        .status-pending { @apply bg-yellow-100 text-yellow-800; }
        .status-completed, .status-paid, .status-in-stock { @apply bg-accent-100 text-accent-800; } /* Using accent for completed/paid/in-stock */
        .status-low-stock { @apply bg-yellow-100 text-yellow-800; }
        .status-out-of-stock, .status-overdue { @apply bg-red-100 text-red-800; }
        .status-high-demand { @apply bg-red-100 text-red-800; }
        .status-moderate { @apply bg-yellow-100 text-yellow-800; }
        .status-accepted { @apply bg-primary-100 text-primary-800; } /* Using primary for accepted */
        .status-processing { @apply bg-blue-100 text-blue-800; }
      </style>
   </head>
   <body class="antialiased text-gray-900 min-h-screen flex flex-col bg-primary-50" x-data="{ isOpen: false }">
      <!-- Skip to main content link for accessibility -->
      <a href="#main-content" 
         class="sr-only focus:not-sr-only focus:absolute focus:top-0 focus:left-0 focus:z-50 focus:p-4 focus:bg-white focus:text-black">
         Skip to main content
      </a>

      <!-- Header -->
      <header class="fixed top-0 left-0 w-full z-50 bg-primary-700 text-white shadow-md h-16">
        <div class="container mx-auto px-4 py-4 flex justify-between items-center">
            <div class="flex items-center">
                <i class="fas fa-store text-2xl mr-3"></i>
                <h1 class="text-xl font-bold">Wholesaler Dashboard</h1>
            </div>
            <div class="flex items-center space-x-4">
                <span class="text-sm">Welcome, <%= email %></span>
                <a href="logout.jsp" class="flex items-center text-sm hover:text-primary-200 transition-colors">
                    <i class="fas fa-sign-out-alt mr-1"></i> Logout
                </a>
            </div>
        </div>
      </header>

      <!-- Sidebar Navigation -->
      <nav class="fixed top-16 bottom-0 left-0 z-40 bg-primary-800 text-gray-100 w-64 flex-shrink-0 flex flex-col justify-between lg:block hidden shadow-lg overflow-y-auto">
          <div class="p-4">
              <div class="text-xl font-bold mb-8 text-white"> WS <%= sname %></div>
              <ul class="space-y-2">
                  <li>
                      <a href="#dashboard-home" class="flex items-center p-2 rounded-lg text-gray-100 hover:bg-primary-600 hover:text-white transition-colors duration-200 active-nav-link">
                          <i class="fas fa-home w-5 h-5 mr-2"></i>
                          Dashboard
                      </a>
                  </li>
                  <li x-data="{ open: false }">
                      <button @click="open = !open" class="flex items-center w-full p-2 rounded-lg text-gray-100 hover:bg-primary-600 hover:text-white transition-colors">
                          <i class="fas fa-box-open w-5 h-5 mr-2"></i>
                          Products
                          <i class="fas fa-chevron-down w-4 h-4 ml-auto" :class="{'rotate-180': open}"></i>
                      </button>
                      <ul x-show="open" class="pl-4 mt-2 space-y-2">
                         <li>
                            <a href="#products-stock" class="block p-2 rounded-lg text-gray-100 hover:bg-primary-600 hover:text-white transition-colors">
                              Stock
                            </a>
                          </li>
                          <li>
                            <a href="#products-buy" class="block p-2 rounded-lg text-gray-100 hover:bg-primary-600 hover:text-white transition-colors">
                              Buy Product
                            </a>
                          </li>
                      </ul>
                  </li>
                  <li x-data="{ open: false }">
                      <button @click="open = !open" class="flex items-center w-full p-2 rounded-lg text-gray-100 hover:bg-primary-600 hover:text-white transition-colors">
                          <i class="fas fa-handshake w-5 h-5 mr-2"></i>
                          Wholesaling
                          <i class="fas fa-chevron-down w-4 h-4 ml-auto" :class="{'rotate-180': open}"></i>
                      </button>
                      <ul x-show="open" class="pl-4 mt-2 space-y-2">
                          <li><a href="#wholesaling-retailer-orders" class="block p-2 rounded-lg text-gray-100 hover:bg-primary-600 hover:text-white transition-colors">Retailer Orders</a></li>
                          <li><a href="#wholesaling-order-tracking" class="block p-2 rounded-lg text-gray-100 hover:bg-primary-600 hover:text-white transition-colors">Order Tracking</a></li>
                          <li><a href="#wholesaling-payments" class="block p-2 rounded-lg text-gray-100 hover:bg-primary-600 hover:text-white transition-colors">Payments & Invoice</a></li>
                          <li><a href="#wholesaling-demand" class="block p-2 rounded-lg text-gray-100 hover:bg-primary-600 hover:text-white transition-colors">Demand & Feedback</a></li>
                      </ul>
                  </li>
              </ul>
          </div>
                         
          <!-- Bottom block: Profile (Logout removed) -->
          <div class="p-4 border-t border-primary-600 space-y-4">
              <!-- Profile -->
              <div class="flex items-center space-x-3">
                  <img src="https://placehold.co/48?text=U" alt="Profile"
                       class="w-10 h-10 rounded-full border border-white/30" />
                  <div class="flex flex-col leading-tight">
                      <span class="text-sm font-semibold"><%= email %></span>
                  </div>
              </div>
          </div>
      </nav>

      <!-- Mobile Menu Button -->
      <button type="button" 
          class="lg:hidden fixed top-4 right-4 z-20 rounded-lg p-2 bg-primary-500 text-white"
          @click="isOpen = !isOpen"
          aria-controls="mobile-menu"
          :aria-expanded="isOpen">
          <svg x-show="!isOpen" class="w-6 h-6" x-cloak fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
          </svg>
          <svg x-show="isOpen" class="w-6 h-6" x-cloak fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
          </svg>
      </button>

      <!-- Mobile Menu -->
      <div id="mobile-menu" 
          x-show="isOpen" 
          x-cloak
          @click.away="isOpen = false"
          @resize.window="if (window.innerWidth > 1024) isOpen = false"
          class="lg:hidden fixed inset-0 z-10 bg-primary-500/95 backdrop-blur-lg"
          x-transition:enter="transition ease-out duration-100 transform"
          x-transition:enter-start="opacity-0 scale-95"
          x-transition:enter-end="opacity-100 scale-100"
          x-transition:leave="transition ease-in duration-75 transform"
          x-transition:leave-start="opacity-100 scale-100"
          x-transition:leave-end="opacity-0 scale-95">
          <div class="p-4">
              <div class="text-xl font-bold mb-8 text-white">WS Shop Name</div>
              <ul class="space-y-2">
                  <!-- Mobile menu items mirror desktop navigation -->
                  <li>
                      <a href="#dashboard-home" class="block p-2 text-white hover:bg-primary-400 rounded-lg">Dashboard</a>
                  </li>
                  <li>
                      <a href="#products-stock" class="block p-2 text-white hover:bg-primary-400 rounded-lg">Stock</a>
                  </li>
                  <li>
                      <a href="#products-buy" class="block p-2 text-white hover:bg-primary-400 rounded-lg">Buy Product</a>
                  </li>
                  <li>
                      <a href="#wholesaling-retailer-orders" class="block p-2 text-white hover:bg-primary-400 rounded-lg">Retailer Orders</a>
                  </li>
                  <li>
                      <a href="#wholesaling-order-tracking" class="block p-2 text-white hover:bg-primary-400 rounded-lg">Order Tracking</a>
                  </li>
                  <li>
                      <a href="#wholesaling-payments" class="block p-2 text-white hover:bg-primary-400 rounded-lg">Payments & Invoice</a>
                  </li>
                  <li>
                      <a href="#wholesaling-demand" class="block p-2 text-white hover:bg-primary-400 rounded-lg">Demand & Feedback</a>
                  </li>
              </ul>
          </div>
      </div>

      <!-- Main content area -->
      <main id="main-content" class="flex-1 pt-16 bg-primary-50 lg:ml-64 overflow-y-auto">
          <section id="dashboard-home" class="p-6">
              <!-- Header -->
              <div class="flex justify-between items-center mb-8 border-b border-primary-200 pb-4">
                  <h1 class="text-2xl font-bold text-gray-800">Welcome <%= sname %></h1>
                  <div class="flex items-center gap-4">
                      <div class="relative">
                          <input type="search" placeholder="Search..." class="pl-10 pr-4 py-2 rounded-lg border border-primary-200 focus:outline-none focus:border-primary-400 shadow-sm">
                          <i class="fas fa-search w-5 h-5 absolute left-3 top-2.5 text-gray-400"></i>
                      </div>
                      <button class="p-2 hover:bg-primary-100 rounded-lg transition-colors duration-200">
                          <i class="fas fa-bell w-6 h-6 text-gray-600"></i>
                      </button>
                      <button class="p-2 hover:bg-primary-100 rounded-lg transition-colors duration-200">
                          <i class="fas fa-cog w-6 h-6 text-gray-600"></i>
                      </button>
                  </div>
              </div>

              <!-- Performance Cards -->
              <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                  <div class="p-6 bg-white rounded-lg border border-primary-200 shadow-md animate-fade-in hover:scale-105 hover:shadow-xl transition-all duration-300">
                      <div class="flex items-center justify-between mb-2">
                          <h3 class="text-gray-500 text-sm">Total Products</h3>
                          <i class="fas fa-box-open text-2xl text-primary-600 opacity-70"></i>
                      </div>
                      <p class="text-3xl font-bold text-primary-700"><%= totalProducts %></p>
                      <div class="mt-2 text-sm text-primary-600">+12% from last month</div>
                  </div>
                  <div class="p-6 bg-white rounded-lg border border-primary-200 shadow-md animate-fade-in delay-100 hover:scale-105 hover:shadow-xl transition-all duration-300">
                      <div class="flex items-center justify-between mb-2">
                          <h3 class="text-gray-500 text-sm">Purchase Orders</h3>
                          <i class="fas fa-shopping-cart text-2xl text-primary-600 opacity-70"></i>
                      </div>
                      <p class="text-3xl font-bold text-primary-700"><%= purchaseOrdersCount %></p>
                      <div class="mt-2 text-sm text-primary-600">+8% from last month</div>
                  </div>
                  <div class="p-6 bg-white rounded-lg border border-primary-200 shadow-md animate-fade-in delay-200 hover:scale-105 hover:shadow-xl transition-all duration-300">
                      <div class="flex items-center justify-between mb-2">
                          <h3 class="text-gray-500 text-sm">Proforma</h3>
                          <i class="fas fa-file-invoice text-2xl text-primary-600 opacity-70"></i>
                      </div>
                      <p class="text-3xl font-bold text-primary-700">89</p>
                      <div class="mt-2 text-sm text-primary-600">+5% from last month</div>
                  </div>
                  <div class="p-6 bg-white rounded-lg border border-primary-200 shadow-md animate-fade-in delay-300 hover:scale-105 hover:shadow-xl transition-all duration-300">
                      <div class="flex items-center justify-between mb-2">
                          <h3 class="text-gray-500 text-sm">Total Invoices</h3>
                          <i class="fas fa-receipt text-2xl text-primary-600 opacity-70"></i>
                      </div>
                      <p class="text-3xl font-bold text-primary-700"><%= totalInvoices %></p>
                      <div class="mt-2 text-sm text-primary-600">+10% from last month</div>
                  </div>
              </div>
          
              <!-- Your Orders Table -->
              <div class="mb-8 bg-white rounded-lg border border-primary-200 shadow-md overflow-hidden animate-slide-up">
                  <div class="p-4 border-b border-primary-200 bg-primary-100">
                      <h2 class="text-xl font-bold text-gray-800">Your Orders</h2>
                  </div>
                  <div class="overflow-x-auto">
                      <table class="w-full">
                          <thead class="bg-primary-50">
                              <tr>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Order Id</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Tracking Id</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Product Name</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Status</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Actions</th>
                              </tr>
                          </thead>
                          <tbody class="divide-y divide-primary-200">
                          <%
                              try (Connection conn = PostgresConnection.getConnection()){
                                  String yourorders = "SELECT my_order_id, shipment_id, product_name, order_status FROM wholeseller.my_orders WHERE wholeseller_id= ?";
                                  PreparedStatement ps = conn.prepareStatement(yourorders);
                                  ps.setInt(1, loginId);
                                  ResultSet rs = ps.executeQuery();

                                  while (rs.next()) {
                          %>
                              <tr class="hover:bg-primary-50 transition-colors duration-150">
                                  <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">#YO<%= rs.getInt("my_order_id") %></td>
                                  <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">#TRK<%= rs.getString("shipment_id") %></td>
                                  <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700"><%= rs.getString("product_name") %></td>
                                  <td class="px-6 py-4 whitespace-nowrap">
                                      <span class="px-2 py-1 text-xs font-semibold rounded-full
                                          <%= rs.getString("order_status").equals("In Transit") ? "status-in-transit" :
                                              rs.getString("order_status").equals("Pending") ? "status-pending" :
                                              "status-completed" 
                                          %>">
                                          <%= rs.getString("order_status") %>
                                      </span>
                                  </td>
                                  
                                  <td class="px-6 py-4 whitespace-nowrap space-x-2">
                                      <% String statusval = rs.getString("order_status"); %>
                                      <% if ("In Transit".equals(statusval)) { %>
                                          <a href="OrderTracking.jsp?shipment_id=<%= rs.getString("shipment_id") %>" 
                                             class="text-primary-600 hover:text-primary-800 transition-colors duration-200">
                                             Track Order
                                          </a>
                                      <% } else if ("Delivered".equals(statusval)) { %>
                                          <button class="text-blue-600 hover:text-blue-800 transition-colors duration-200">View Invoice</button>
                                      <% } else { %>
                                          <button class="text-blue-600 hover:text-blue-800 transition-colors duration-200">View</button>
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
          </section>

          <section id="products-stock" class="p-6">
              <!-- Header -->
              <div class="flex justify-between items-center mb-8 border-b border-primary-200 pb-4">
                  <h1 class="text-2xl font-bold text-gray-800">Stock Management</h1>
                  <div class="flex gap-4">
                      <a href="Add-new-product.jsp?loginId=<%= session.getAttribute("loginId") %>">
                          <button class="px-4 py-2 bg-primary-500 text-white rounded-lg hover:bg-primary-600 flex items-center gap-2 shadow-md transition-colors duration-200">
                              <i class="fas fa-plus w-5 h-5"></i>
                              Add New Product
                          </button>
                      </a>
                  </div>
              </div>

              <!-- Stock Overview Cards -->
              <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                  <div class="p-6 bg-white rounded-lg border border-primary-200 shadow-md animate-fade-in hover:scale-105 hover:shadow-xl transition-all duration-300">
                      <div class="flex items-center justify-between mb-2">
                          <h3 class="text-gray-500 text-sm">Total Products</h3>
                          <i class="fas fa-boxes text-2xl text-primary-600 opacity-70"></i>
                      </div>
                      <p class="text-3xl font-bold text-primary-700"><%= totalProducts %></p>
                      <div class="mt-2 text-sm text-primary-600">+12% from last month</div>
                  </div>
                  <div class="p-6 bg-white rounded-lg border border-primary-200 shadow-md animate-fade-in delay-100 hover:scale-105 hover:shadow-xl transition-all duration-300">
                      <div class="flex items-center justify-between mb-2">
                          <h3 class="text-gray-500 text-sm">Low Stock Items</h3>
                          <i class="fas fa-exclamation-triangle text-2xl text-yellow-600 opacity-70"></i>
                      </div>
                      <p class="text-3xl font-bold text-yellow-700"><%= lowStockItems %></p>
                      <div class="mt-2 text-sm text-yellow-600">Needs attention</div>
                  </div>
                  <div class="p-6 bg-white rounded-lg border border-primary-200 shadow-md animate-fade-in delay-200 hover:scale-105 hover:shadow-xl transition-all duration-300">
                      <div class="flex items-center justify-between mb-2">
                          <h3 class="text-gray-500 text-sm">Out of Stock</h3>
                          <i class="fas fa-times-circle text-2xl text-red-600 opacity-70"></i>
                      </div>
                      <p class="text-3xl font-bold text-red-700"><%= outOfStockItems %></p>
                      <div class="mt-2 text-sm text-red-600">Action required</div>
                  </div>
              </div>

              <!-- Stock Table -->
              <%
              Map<Integer, String> categoryMap = new LinkedHashMap<>();
              String selectedCategory = request.getParameter("category"); 
              int selectedCategoryId = -1;
              if (selectedCategory != null && !selectedCategory.isEmpty()) {
                  try {
                      selectedCategoryId = Integer.parseInt(selectedCategory);
                  } catch (NumberFormatException e) {
                      selectedCategoryId = -1; // fallback in case of bad input
                  }
              }
              %>
              
              <div class="bg-white rounded-lg border border-primary-200 shadow-md overflow-hidden animate-slide-up">
                  <div class="p-4 border-b border-primary-200 bg-primary-100 flex justify-between items-center">
                      <h2 class="text-xl font-bold text-gray-800">Current Stock</h2>
                      <form method="get" action="">
                          <div class="flex gap-4">
                              <div class="relative">
                                  <input type="search" placeholder="Search products..." class="pl-10 pr-4 py-2 rounded-lg border border-primary-200 focus:outline-none focus:border-primary-400 shadow-sm">
                                  <i class="fas fa-search w-5 h-5 absolute left-3 top-2.5 text-gray-400"></i>
                              </div>

                              <select name="category" onchange="this.form.submit()" class="px-4 py-2 rounded-lg border border-primary-200 focus:outline-none focus:border-primary-400 shadow-sm">
                              <option value="">All Categories</option>
                              <%
                              try (Connection conn = PostgresConnection.getConnection()) {
                                  String categorysql = "SELECT stock_cat_id, category_name FROM wholeseller.stock_cat WHERE wholeseller_id = ?";
                                  PreparedStatement stmt = conn.prepareStatement(categorysql);
                                  stmt.setInt(1, loginId);
                                  ResultSet strs = stmt.executeQuery();

                                  while (strs.next()) {
                                      int catId = strs.getInt("stock_cat_id");
                                      String catName = strs.getString("category_name");
                                      categoryMap.put(catId, catName);
                              %>
                                      <option value="<%= catId %>" <%= (selectedCategoryId == catId) ? "selected" : "" %>><%= catName %></option>
                              <%
                                  }
                              }
                              %>
                          </select>
                          </div>
                      </form>   
                  </div>
                  
                  <div class="overflow-x-auto">
                      <table class="w-full">
                          <thead class="bg-primary-50">
                              <tr>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Product ID</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Product Name</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Category</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Stock Level</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Unit Price</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Status</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Actions</th>
                              </tr>
                          </thead>
                          <tbody class="divide-y divide-primary-200">
                          <%
                              try (Connection conn = PostgresConnection.getConnection()){
                                  String stocksql;
                                  PreparedStatement ps_stock;
                                  if (selectedCategoryId > 0) {
                                      stocksql = "SELECT s.stock_id, s.product_name, s.quantity, s.price, s.status, c.category_name FROM wholeseller.stock s JOIN wholeseller.stock_cat c ON s.stock_cat_id = c.stock_cat_id WHERE s.wholeseller_id = ? AND s.stock_cat_id = ?";
                                      ps_stock = conn.prepareStatement(stocksql);
                                      ps_stock.setInt(1, loginId);
                                      ps_stock.setInt(2, selectedCategoryId);
                                  } else {
                                      stocksql = "SELECT s.stock_id, s.product_name, s.quantity, s.price, s.status, c.category_name FROM wholeseller.stock s JOIN wholeseller.stock_cat c ON s.stock_cat_id = c.stock_cat_id WHERE s.wholeseller_id = ?";
                                      ps_stock = conn.prepareStatement(stocksql);
                                      ps_stock.setInt(1, loginId);
                                  }
                                  ResultSet rs_stock = ps_stock.executeQuery();

                                  while (rs_stock.next()) {
                          %>
                              <tr class="hover:bg-primary-50 transition-colors duration-150">
                                  <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">#PRD<%= rs_stock.getInt("stock_id") %></td>
                                  <td class="px-6 py-4 text-sm text-gray-700"><%= rs_stock.getString("product_name") %></td>
                                  <td class="px-6 py-4 text-sm text-gray-700"><%= rs_stock.getString("category_name") %></td>
                                  <td class="px-6 py-4 text-sm text-gray-700"><%= rs_stock.getInt("quantity") %> </td>
                                  <td class="px-6 py-4 text-sm text-gray-700">$<%= rs_stock.getDouble("price") %> </td>
                                  <td class="px-6 py-4">
                                      <span class="px-2 py-1 text-xs font-semibold rounded-full
                                          <%= rs_stock.getString("status").equals("In Stock") ? "status-in-stock" :
                                              rs_stock.getString("status").equals("Low Stock") ? "status-low-stock" :
                                              "status-out-of-stock" %>">
                                          <%= rs_stock.getString("status") %>
                                      </span>
                                  </td>
                                  <td class="px-6 py-4">
                                      <div class="flex gap-2">
                                          <a href="Add-new-product.jsp?stock_id=<%= rs_stock.getInt("stock_id") %>&loginId=<%= session.getAttribute("loginId") %>"
                                             class="text-primary-600 hover:text-primary-800 transition-colors duration-200">
                                              Reorder
                                          </a>
                                          <form action="/Supply-chain-and-Logistic/AddnewProductServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this product?');">
                                              <input type="hidden" name="Delstockid" value="<%= rs_stock.getInt("stock_id") %>">
                                              <button type="submit" class="text-red-600 hover:text-red-800 transition-colors duration-200">Delete</button>
                                          </form>
                                      </div>
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
                  <div class="p-4 border-t border-primary-200 flex justify-between items-center bg-primary-100">
                      <div class="text-sm text-gray-600">Showing 1 to 3 of 100 entries</div>
                      <div class="flex gap-2">
                          <button class="px-3 py-1 border border-primary-300 rounded-lg hover:bg-primary-200 text-primary-700 transition-colors duration-200">Previous</button>
                          <button class="px-3 py-1 bg-primary-500 text-white rounded-lg shadow-md hover:bg-primary-600 transition-colors duration-200">1</button>
                          <button class="px-3 py-1 border border-primary-300 rounded-lg hover:bg-primary-200 text-primary-700 transition-colors duration-200">2</button>
                          <button class="px-3 py-1 border border-primary-300 rounded-lg hover:bg-primary-200 text-primary-700 transition-colors duration-200">3</button>
                          <button class="px-3 py-1 border border-primary-300 rounded-lg hover:bg-primary-200 text-primary-700 transition-colors duration-200">Next</button>
                      </div>
                  </div>
              </div>
          </section>

          <section id="products-buy" class="p-6">
              <!-- Header -->
              <div class="flex justify-between items-center mb-8 border-b border-primary-200 pb-4">
                  <h1 class="text-2xl font-bold text-gray-800">Buy Products</h1>
                  <a href="buy-product.jsp?loginId=<%= session.getAttribute("loginId") %>&type=wholeseller"> 
                      <div class="flex gap-4">
                          <div class="relative">
                              <input type="search" placeholder="Search products..." class="pl-10 pr-4 py-2 rounded-lg border border-primary-200 focus:outline-none focus:border-primary-400 shadow-sm">
                              <i class="fas fa-search w-5 h-5 absolute left-3 top-2.5 text-gray-400"></i>
                          </div>
                          <select class="px-4 py-2 rounded-lg border border-primary-200 focus:outline-none focus:border-primary-400 shadow-sm">
                              <option>All Categories</option>
                              <option>Electronics</option>
                              <option>Clothing</option>
                              <option>Food</option>
                          </select>
                      </div>
                  </a>
              </div>

              <!-- Product Grid -->
              <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                  <!-- Product Card 1 -->
                  <div class="bg-white rounded-lg border border-primary-200 shadow-md overflow-hidden animate-scale-in hover:scale-105 hover:shadow-xl transition-all duration-300">
                      <img src="https://placehold.co/400x300/008080/FFFFFF?text=Product+A" alt="Product" class="w-full h-48 object-cover">
                      <div class="p-4">
                          <h3 class="text-lg font-semibold mb-2 text-primary-700">Product Name A</h3>
                          <p class="text-gray-600 text-sm mb-4">Category: Electronics</p>
                          <div class="flex justify-between items-center mb-4">
                              <span class="text-lg font-bold text-primary-800">$99.99</span>
                              <span class="text-sm text-gray-500">MOQ: 100 units</span>
                          </div>
                          <button class="w-full py-2 bg-primary-500 text-white rounded-lg hover:bg-primary-600 shadow-md transition-colors duration-200">Add to Cart</button>
                      </div>
                  </div>

                  <!-- Product Card 2 -->
                  <div class="bg-white rounded-lg border border-primary-200 shadow-md overflow-hidden animate-scale-in delay-100 hover:scale-105 hover:shadow-xl transition-all duration-300">
                      <img src="https://placehold.co/400x300/008080/FFFFFF?text=Product+B" alt="Product" class="w-full h-48 object-cover">
                      <div class="p-4">
                          <h3 class="text-lg font-semibold mb-2 text-primary-700">Product Name B</h3>
                          <p class="text-gray-600 text-sm mb-4">Category: Clothing</p>
                          <div class="flex justify-between items-center mb-4">
                              <span class="text-lg font-bold text-primary-800">$49.99</span>
                              <span class="text-sm text-gray-500">MOQ: 50 units</span>
                          </div>
                          <button class="w-full py-2 bg-primary-500 text-white rounded-lg hover:bg-primary-600 shadow-md transition-colors duration-200">Add to Cart</button>
                      </div>
                  </div>

                  <!-- Product Card 3 -->
                  <div class="bg-white rounded-lg border border-primary-200 shadow-md overflow-hidden animate-scale-in delay-200 hover:scale-105 hover:shadow-xl transition-all duration-300">
                      <img src="https://placehold.co/400x300/008080/FFFFFF?text=Product+C" alt="Product" class="w-full h-48 object-cover">
                      <div class="p-4">
                          <h3 class="text-lg font-semibold mb-2 text-primary-700">Product Name C</h3>
                          <p class="text-gray-600 text-sm mb-4">Category: Food</p>
                          <div class="flex justify-between items-center mb-4">
                              <span class="text-lg font-bold text-primary-800">$29.99</span>
                              <span class="text-sm text-gray-500">MOQ: 200 units</span>
                          </div>
                          <button class="w-full py-2 bg-primary-500 text-white rounded-lg hover:bg-primary-600 shadow-md transition-colors duration-200">Add to Cart</button>
                      </div>
                  </div>
              </div>

              <!-- Shopping Cart Preview -->
              <div class="fixed bottom-0 right-0 m-6">
                  <button class="relative p-3 bg-primary-500 text-white rounded-full shadow-lg hover:bg-primary-600 transition-colors duration-200">
                      <i class="fas fa-shopping-cart w-6 h-6"></i>
                      <span class="absolute -top-2 -right-2 bg-red-500 text-white text-xs w-5 h-5 rounded-full flex items-center justify-center">3</span>
                  </button>
              </div>
          </section>


          <section id="wholesaling-retailer-orders" class="p-6">
              <!-- Header -->
              <div class="flex justify-between items-center mb-8 border-b border-primary-200 pb-4">
                  <h1 class="text-2xl font-bold text-gray-800">Retailer Orders</h1>
                  <div class="flex gap-4">
                      <div class="relative">
                          <input type="search" placeholder="Search orders..." class="pl-10 pr-4 py-2 rounded-lg border border-primary-200 focus:outline-none focus:border-primary-400 shadow-sm">
                          <i class="fas fa-search w-5 h-5 absolute left-3 top-2.5 text-gray-400"></i>
                      </div>
                      <select class="px-4 py-2 rounded-lg border border-primary-200 focus:outline-none focus:border-primary-400 shadow-sm">
                          <option>All Status</option>
                          <option>Pending</option>
                          <option>Processing</option>
                          <option>Completed</option>
                      </select>
                  </div>
              </div>

              <!-- Order Statistics -->
              <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                  <div class="p-6 bg-white rounded-lg border border-primary-200 shadow-md animate-fade-in hover:scale-105 hover:shadow-xl transition-all duration-300">
                      <div class="flex items-center justify-between mb-2">
                          <h3 class="text-gray-500 text-sm">Total Orders</h3>
                          <i class="fas fa-clipboard-list text-2xl text-primary-600 opacity-70"></i>
                      </div>
                      <p class="text-3xl font-bold text-primary-700"><%= totalOrders %></p>
                      <div class="mt-2 text-sm text-primary-600">+15% from last month</div>
                  </div>
                  <div class="p-6 bg-white rounded-lg border border-primary-200 shadow-md animate-fade-in delay-100 hover:scale-105 hover:shadow-xl transition-all duration-300">
                      <div class="flex items-center justify-between mb-2">
                          <h3 class="text-gray-500 text-sm">Pending Orders</h3>
                          <i class="fas fa-hourglass-start text-2xl text-yellow-600 opacity-70"></i>
                      </div>
                      <p class="text-3xl font-bold text-yellow-700"><%= pendingOrders %></p>
                      <div class="mt-2 text-sm text-yellow-600">Needs attention</div>
                  </div>
                  <div class="p-6 bg-white rounded-lg border border-primary-200 shadow-md animate-fade-in delay-200 hover:scale-105 hover:shadow-xl transition-all duration-300">
                      <div class="flex items-center justify-between mb-2">
                          <h3 class="text-gray-500 text-sm">Processing</h3>
                          <i class="fas fa-cogs text-2xl text-blue-600 opacity-70"></i>
                      </div>
                      <p class="text-3xl font-bold text-blue-700"><%= processingOrders %></p>
                      <div class="mt-2 text-sm text-blue-600">In progress</div>
                  </div>
                  <div class="p-6 bg-white rounded-lg border border-primary-200 shadow-md animate-fade-in delay-300 hover:scale-105 hover:shadow-xl transition-all duration-300">
                      <div class="flex items-center justify-between mb-2">
                          <h3 class="text-gray-500 text-sm">Completed</h3>
                          <i class="fas fa-check-double text-2xl text-accent-600 opacity-70"></i>
                      </div>
                      <p class="text-3xl font-bold text-accent-700"><%= completedOrders %></p>
                      <div class="mt-2 text-sm text-accent-600">Successfully delivered</div>
                  </div>
              </div>

              <!-- Orders Table -->
              <div class="bg-white rounded-lg border border-primary-200 shadow-md overflow-hidden animate-slide-up">
                  <div class="p-4 border-b border-primary-200 bg-primary-100">
                      <h2 class="text-xl font-bold text-gray-800">Retailer Orders List</h2>
                  </div>
                  <div class="overflow-x-auto">
                      <table class="w-full">
                          <thead class="bg-primary-50">
                              <tr>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Order ID</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Retailer Name</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Order Date</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Total Amount</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Status</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Actions</th>
                              </tr>
                          </thead>

                          <tbody class="divide-y divide-primary-200">
                          <%
                              try (Connection conn = PostgresConnection.getConnection()) {
                                  String sql = "SELECT o.order_request_id, o.price, o.order_date, o.status, c.customer_name  FROM wholeseller.order_request o JOIN wholeseller.customer c ON o.customer_id = c.customer_id  WHERE o.wholeseller_id = ?";

                                  PreparedStatement ps_orders = conn.prepareStatement(sql);
                                  ps_orders.setInt(1, loginId);
                                  ResultSet rs_orders = ps_orders.executeQuery();

                                  while (rs_orders.next()) {
                          %>
                              <tr class="hover:bg-primary-50 transition-colors duration-150">
                                  <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">#ORD<%= rs_orders.getInt("order_request_id") %></td>
                                  <td class="px-6 py-4 text-sm text-gray-700"><%= rs_orders.getString("customer_name") %></td>
                                  <td class="px-6 py-4 text-sm text-gray-700"><%= rs_orders.getString("order_date") %></td>
                                  <td class="px-6 py-4 text-sm text-gray-700">Rs.<%= rs_orders.getInt("price") %></td>
                                  <td class="px-6 py-4">
                                      <span class="px-2 py-1 text-xs font-semibold rounded-full
                                          <%= rs_orders.getString("status").equals("Pending") ? "status-pending" : 
                                              rs_orders.getString("status").equals("Processing") ? "status-processing" : 
                                              "status-completed" 
                                          %>">
                                          <%= rs_orders.getString("status") %>
                                      </span>
                                  </td>
                                  <td class="px-6 py-4">
                                      <div class="flex gap-2">
                                          <a href="RT-request.jsp?orderID=<%= rs_orders.getInt("order_request_id") %>">
                                              <button class="text-primary-600 hover:text-primary-800 transition-colors duration-200">View Details</button>
                                          </a>
                                          <% if (rs_orders.getString("status").equals("Pending")) { %>
                                              <button class="text-accent-600 hover:text-accent-800 transition-colors duration-200">Accept</button>
                                              <button class="text-red-600 hover:text-red-800 transition-colors duration-200">Reject</button>
                                          <% } else if (rs_orders.getString("status").equals("Accepted")) { %>
                                              <button class="text-primary-600 hover:text-primary-800 transition-colors duration-200">Track</button>
                                          <% } %>
                                      </div>
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
                  <div class="p-4 border-t border-primary-200 flex justify-between items-center bg-primary-100">
                      <div class="text-sm text-gray-600">Showing 1 to 3 of 45 entries</div>
                      <div class="flex gap-2">
                          <button class="px-3 py-1 border border-primary-300 rounded-lg hover:bg-primary-200 text-primary-700 transition-colors duration-200">Previous</button>
                          <button class="px-3 py-1 bg-primary-500 text-white rounded-lg shadow-md hover:bg-primary-600 transition-colors duration-200">1</button>
                          <button class="px-3 py-1 border border-primary-300 rounded-lg hover:bg-primary-200 text-primary-700 transition-colors duration-200">2</button>
                          <button class="px-3 py-1 border border-primary-300 rounded-lg hover:bg-primary-200 text-primary-700 transition-colors duration-200">3</button>
                          <button class="px-3 py-1 border border-primary-300 rounded-lg hover:bg-primary-200 text-primary-700 transition-colors duration-200">Next</button>
                      </div>
                  </div>
              </div>
          </section>

          <section id="wholesaling-order-tracking" class="p-6">
              <!-- This section was commented out in your original code. Keeping it commented. -->
          </section>

          <section id="wholesaling-payments" class="p-6">
              <!-- Header -->
              <div class="flex justify-between items-center mb-8 border-b border-primary-200 pb-4">
                  <h1 class="text-2xl font-bold text-gray-800">Payments & Invoices</h1>
                  <div class="flex gap-4">
                      <a href = "payment-details.html">
                          <button class="px-4 py-2 bg-primary-500 text-white rounded-lg hover:bg-primary-600 flex items-center gap-2 shadow-md transition-colors duration-200">
                              <i class="fas fa-info-circle w-5 h-5"></i>
                              Get Details
                          </button>
                      </a>
                  </div>
              </div>

              <!-- Payment Statistics -->
              <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                  <div class="p-6 bg-white rounded-lg border border-primary-200 shadow-md animate-fade-in hover:scale-105 hover:shadow-xl transition-all duration-300">
                      <div class="flex items-center justify-between mb-2">
                          <h3 class="text-gray-500 text-sm">Total Revenue</h3>
                          <i class="fas fa-sack-dollar text-2xl text-primary-600 opacity-70"></i>
                      </div>
                      <p class="text-3xl font-bold text-primary-700"><%= totalRevenue %></p>
                      <div class="mt-2 text-sm text-primary-600">+12% from last month</div>
                  </div>
                  <div class="p-6 bg-white rounded-lg border border-primary-200 shadow-md animate-fade-in delay-100 hover:scale-105 hover:shadow-xl transition-all duration-300">
                      <div class="flex items-center justify-between mb-2">
                          <h3 class="text-gray-500 text-sm">Pending Payments</h3>
                          <i class="fas fa-hourglass-half text-2xl text-yellow-600 opacity-70"></i>
                      </div>
                      <p class="text-3xl font-bold text-yellow-700"><%= pendingPayments %></p>
                      <div class="mt-2 text-sm text-yellow-600"><%= pinvoices %> invoices pending</div>
                  </div>
                  <div class="p-6 bg-white rounded-lg border border-primary-200 shadow-md animate-fade-in delay-200 hover:scale-105 hover:shadow-xl transition-all duration-300">
                      <div class="flex items-center justify-between mb-2">
                          <h3 class="text-gray-500 text-sm">Overdue Payments</h3>
                          <i class="fas fa-exclamation-circle text-2xl text-red-600 opacity-70"></i>
                      </div>
                      <p class="text-3xl font-bold text-red-700"><%= overduePayments %></p>
                      <div class="mt-2 text-sm text-red-600"><%= oinvoices %> invoices overdue</div>
                  </div>
                  <div class="p-6 bg-white rounded-lg border border-primary-200 shadow-md animate-fade-in delay-300 hover:scale-105 hover:shadow-xl transition-all duration-300">
                      <div class="flex items-center justify-between mb-2">
                          <h3 class="text-gray-500 text-sm">Paid Invoices</h3>
                          <i class="fas fa-file-invoice-dollar text-2xl text-accent-600 opacity-70"></i>
                      </div>
                      <p class="text-3xl font-bold text-accent-700"><%= paidInvoices %></p>
                      <div class="mt-2 text-sm text-accent-600">This month</div>
                  </div>
              </div>

              <!-- Invoices Table -->
              <div class="bg-white rounded-lg border border-primary-200 shadow-md overflow-hidden mb-8 animate-slide-up">
                  <div class="p-4 border-b border-primary-200 bg-primary-100">
                      <h2 class="text-xl font-bold text-gray-800">Recent Invoices</h2>
                  </div>
                  <div class="overflow-x-auto">
                      <table class="w-full">
                          <thead class="bg-primary-50">
                              <tr>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Invoice ID</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Retailer Name</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Amount</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Due Date</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Status</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Actions</th>
                              </tr>
                          </thead>
                          <tbody class="divide-y divide-primary-200">
                          <%
                              try (Connection conn = PostgresConnection.getConnection()){
                                  String invoicesql = "SELECT i.invoice_id,  i.amount, i.invoice_date, i.payment_status, c.customer_name FROM wholeseller.invoice i JOIN wholeseller.customer c ON i.customer_id = c.customer_id WHERE i.wholeseller_id = ?";
                                  PreparedStatement ps_invoice = conn.prepareStatement(invoicesql);
                                  ps_invoice.setInt(1, loginId);
                                  ResultSet rs_invoice = ps_invoice.executeQuery();

                                  while (rs_invoice.next()) {
                          %>
                              <tr class="hover:bg-primary-50 transition-colors duration-150">
                                  <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">#INV<%= rs_invoice.getInt("invoice_id") %></td>
                                  <td class="px-6 py-4 text-sm text-gray-700"><%= rs_invoice.getString("customer_name") %></td>
                                  <td class="px-6 py-4 text-sm text-gray-700">Rs.<%= rs_invoice.getDouble("amount") %></td>
                                  <td class="px-6 py-4 text-sm text-gray-700"><%= rs_invoice.getString("invoice_date") %></td>
                                  <td class="px-6 py-4">
                                      <span class="px-2 py-1 text-xs font-semibold rounded-full
                                          <%= rs_invoice.getString("payment_status").equals("Unpaid") ? "status-pending" :
                                              rs_invoice.getString("payment_status").equals("Paid") ? "status-paid" :
                                              "status-overdue" %>">
                                          <%= rs_invoice.getString("payment_status") %>
                                      </span>
                                  </td>
                                  <td class="px-6 py-4">
                                      <div class="flex gap-2">
                                          <button class="text-primary-600 hover:text-primary-800 transition-colors duration-200">View</button>
                                          <% if (rs_invoice.getString("payment_status").equals("Unpaid")) { %>
                                              <a href="payment-gateway/select-payment.jsp?invoiceid=<%= rs_invoice.getInt("invoice_id") %>"> 
                                                  <button class="text-red-600 hover:text-red-800 transition-colors duration-200">Pay</button>
                                              </a>
                                          <% } %>
                                          <% if (rs_invoice.getString("payment_status").equals("Overdue")) { %>
                                              <button class="text-red-600 hover:text-red-800 transition-colors duration-200">Send Reminder</button>
                                          <% } %>
                                      </div>
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
                  <div class="p-4 border-t border-primary-200 flex justify-between items-center bg-primary-100">
                      <div class="text-sm text-gray-600">Showing 1 to 3 of 45 entries</div>
                      <div class="flex gap-2">
                          <button class="px-3 py-1 border border-primary-300 rounded-lg hover:bg-primary-200 text-primary-700 transition-colors duration-200">Previous</button>
                          <button class="px-3 py-1 bg-primary-500 text-white rounded-lg shadow-md hover:bg-primary-600 transition-colors duration-200">1</button>
                          <button class="px-3 py-1 border border-primary-300 rounded-lg hover:bg-primary-200 text-primary-700 transition-colors duration-200">2</button>
                          <button class="px-3 py-1 border border-primary-300 rounded-lg hover:bg-primary-200 text-primary-700 transition-colors duration-200">3</button>
                          <button class="px-3 py-1 border border-primary-300 rounded-lg hover:bg-primary-200 text-primary-700 transition-colors duration-200">Next</button>
                      </div>
                  </div>
              </div>

              <!-- Payment Methods -->
              <div class="bg-white rounded-lg border border-primary-200 shadow-md p-6 animate-slide-up">
                  <h2 class="text-xl font-bold mb-4 text-gray-800">Payment Methods</h2>
                  <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                      <div class="p-4 border border-primary-200 rounded-lg shadow-sm hover:shadow-md transition-shadow duration-200">
                          <div class="flex justify-between items-center mb-4">
                              <h3 class="font-semibold text-gray-700">Bank Transfer</h3>
                              <i class="fas fa-bank w-8 h-8 text-blue-600"></i>
                          </div>
                          <p class="text-sm text-gray-600">Account ending in 1234</p>
                      </div>
                      <div class="p-4 border border-primary-200 rounded-lg shadow-sm hover:shadow-md transition-shadow duration-200">
                          <div class="flex justify-between items-center mb-4">
                              <h3 class="font-semibold text-gray-700">Credit Card</h3>
                              <i class="fas fa-credit-card w-8 h-8 text-blue-600"></i>
                          </div>
                          <p class="text-sm text-gray-600">Card ending in 5678</p>
                      </div>
                      <div class="p-4 border border-primary-200 rounded-lg shadow-sm hover:shadow-md transition-shadow duration-200">
                          <button class="w-full h-full flex items-center justify-center text-primary-600 hover:text-primary-700 transition-colors duration-200">
                              <i class="fas fa-plus-circle w-6 h-6 mr-2"></i>
                              Add Payment Method
                          </button>
                      </div>
                  </div>
              </div>
              <br><br>
              
              <!-- Retailer Payments Table -->
              <div class="bg-white rounded-lg border border-primary-200 shadow-md overflow-hidden mb-8 animate-slide-up">
                  <div class="p-4 border-b border-primary-200 bg-primary-100">
                      <h2 class="text-xl font-bold text-gray-800">Retailer Payments</h2>
                  </div>
                  <div class="overflow-x-auto">
                      <table class="w-full">
                          <thead class="bg-primary-50">
                              <tr>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Order ID</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Retailer Name</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Amount</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Due Date</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Status</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Actions</th>
                              </tr>
                          </thead>
                          <tbody class="divide-y divide-primary-200">
                          <%
                              try (Connection conn = PostgresConnection.getConnection()){
                                  String retailerpaysql = "SELECT rp.pay_slip_id, rp.payment_status, rp.payment_amount, rp.due_date,  c.customer_name FROM wholeseller.retailer_payments rp JOIN wholeseller.order_request reo ON rp.order_request_id = reo.order_request_id JOIN wholeseller.customer c ON reo.customer_id = c.customer_id WHERE rp.wholeseller_id = ?";
                                  PreparedStatement ps_rpay = conn.prepareStatement(retailerpaysql);
                                  ps_rpay.setInt(1, loginId);
                                  ResultSet rs_rpay = ps_rpay.executeQuery();

                                  while (rs_rpay.next()) {
                          %>
                              <tr class="hover:bg-primary-50 transition-colors duration-150">
                                  <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">#PAS<%= rs_rpay.getInt("pay_slip_id") %></td>
                                  <td class="px-6 py-4 text-sm text-gray-700"><%= rs_rpay.getString("customer_name") %></td>
                                  <td class="px-6 py-4 text-sm text-gray-700">RS.<%= rs_rpay.getDouble("payment_amount") %></td>
                                  <td class="px-6 py-4 text-sm text-gray-700"><%= rs_rpay.getString("due_date") %></td>
                                  <td class="px-6 py-4">
                                      <span class="px-2 py-1 text-xs font-semibold rounded-full
                                          <%= rs_rpay.getString("payment_status").equals("Unpaid") ? "status-pending" :
                                              rs_rpay.getString("payment_status").equals("Paid") ? "status-paid" :
                                              "status-overdue" %>">
                                          <%= rs_rpay.getString("payment_status") %>
                                      </span>
                                  </td>
                                  <td class="px-6 py-4">
                                      <div class="flex gap-2">
                                      <% if (rs_rpay.getString("payment_status").equals("Unpaid")) { %>
                                          <a href="Pay-Slip.jsp?payId=<%= rs_rpay.getInt("pay_slip_id") %>">
                                          <button class="text-primary-600 hover:text-primary-800 transition-colors duration-200">View</button>
                                          </a>
                                          <form action= "/Supply-chain-and-Logistic/PaymentSlipServlet" method = "post">
                                          <input type="hidden" name = "PaymentSlipID" value = "<%= rs_rpay.getInt("pay_slip_id") %>" >
                                          <button type="submit" class="text-red-600 hover:text-red-800 transition-colors duration-200">Send</button>
                                          </form>
                                      <% } %>
                                      <% if (rs_rpay.getString("payment_status").equals("Overdue")) { %>
                                          <button class="text-red-600 hover:text-red-800 transition-colors duration-200">Send Reminder</button>
                                      <% } %>
                                      </div>
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
                  <div class="p-4 border-t border-primary-200 flex justify-between items-center bg-primary-100">
                      <div class="text-sm text-gray-600">Showing 1 to 3 of 45 entries</div>
                      <div class="flex gap-2">
                          <button class="px-3 py-1 border border-primary-300 rounded-lg hover:bg-primary-200 text-primary-700 transition-colors duration-200">Previous</button>
                          <button class="px-3 py-1 bg-primary-500 text-white rounded-lg shadow-md hover:bg-primary-600 transition-colors duration-200">1</button>
                          <button class="px-3 py-1 border border-primary-300 rounded-lg hover:bg-primary-200 text-primary-700 transition-colors duration-200">2</button>
                          <button class="px-3 py-1 border border-primary-300 rounded-lg hover:bg-primary-200 text-primary-700 transition-colors duration-200">3</button>
                          <button class="px-3 py-1 border border-primary-300 rounded-lg hover:bg-primary-200 text-primary-700 transition-colors duration-200">Next</button>
                      </div>
                  </div>
              </div>
          </section>
          
          <section id="wholesaling-demand" class="p-6">
              <!-- Header -->
              <div class="flex justify-between items-center mb-8 border-b border-primary-200 pb-4">
                  <h1 class="text-2xl font-bold text-gray-800">Demand & Feedback Analysis</h1>
                  <div class="flex gap-4">
                      <a href="report.html">
                          <button class="px-4 py-2 bg-primary-500 text-white rounded-lg hover:bg-primary-600 shadow-md transition-colors duration-200">
                              Generate Report
                          </button>
                      </a>
                  </div>
              </div>

              <!-- Demand Overview Cards -->
              <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                  <div class="p-6 bg-white rounded-lg border border-primary-200 shadow-md animate-fade-in hover:scale-105 hover:shadow-xl transition-all duration-300">
                      <div class="flex items-center justify-between mb-2">
                          <h3 class="text-gray-500 text-sm">Total Feedback</h3>
                          <i class="fas fa-comments text-2xl text-primary-600 opacity-70"></i>
                      </div>
                      <p class="text-3xl font-bold text-primary-700"><%= totalFeedback %></p>
                      <div class="mt-2 text-sm text-primary-600">+15% from last month</div>
                  </div>
                  <div class="p-6 bg-white rounded-lg border border-primary-200 shadow-md animate-fade-in delay-100 hover:scale-105 hover:shadow-xl transition-all duration-300">
                      <div class="flex items-center justify-between mb-2">
                          <h3 class="text-gray-500 text-sm">Average Rating</h3>
                          <i class="fas fa-star-half-alt text-2xl text-yellow-600 opacity-70"></i>
                      </div>
                      <p class="text-3xl font-bold text-yellow-700"><%= String.format("%.1f", averageRating) %></p>
                      <div class="mt-2 text-sm text-yellow-600">Based on <%= totalFeedback %> reviews</div>
                  </div>
                  <div class="p-6 bg-white rounded-lg border border-primary-200 shadow-md animate-fade-in delay-200 hover:scale-105 hover:shadow-xl transition-all duration-300">
                      <div class="flex items-center justify-between mb-2">
                          <h3 class="text-gray-500 text-sm">Product Requests</h3>
                          <i class="fas fa-hand-holding-box text-2xl text-blue-600 opacity-70"></i>
                      </div>
                      <p class="text-3xl font-bold text-blue-700"><%= totalOrders %></p>
                      <div class="mt-2 text-sm text-blue-600">New requests</div>
                  </div>
                  <div class="p-6 bg-white rounded-lg border border-primary-200 shadow-md animate-fade-in delay-300 hover:scale-105 hover:shadow-xl transition-all duration-300">
                      <div class="flex items-center justify-between mb-2">
                          <h3 class="text-gray-500 text-sm">Improvement Suggestions</h3>
                          <i class="fas fa-lightbulb text-2xl text-purple-600 opacity-70"></i>
                      </div>
                      <p class="text-3xl font-bold text-purple-700"><%= improvementSuggestions %></p>
                      <div class="mt-2 text-sm text-purple-600">Pending review</div>
                  </div>
              </div>

              <!-- Most Demanded Products -->
              <div class="bg-white rounded-lg border border-primary-200 shadow-md p-6 mb-8 animate-slide-up">
                  <h2 class="text-xl font-bold mb-6 text-gray-800">Most Demanded Products</h2>
                  <div class="overflow-x-auto">
                      <table class="w-full">
                          <thead class="bg-primary-50">
                              <tr>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Product Name</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Demand Count</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Current Stock</th>
                                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-600 uppercase">Status</th>
                              </tr>
                          </thead>
                          <tbody class="divide-y divide-primary-200">
                              <%
                              try (Connection conn = PostgresConnection.getConnection()){
                                  String demandsql = "SELECT product_name, current_stock, status, demand_count FROM wholeseller.demand WHERE wholeseller_id = ?";
                                  PreparedStatement ps_demand = conn.prepareStatement(demandsql);
                                  ps_demand.setInt(1, loginId);
                                  ResultSet rs_demand = ps_demand.executeQuery();

                                  while (rs_demand.next()) {
                              %>
                              <tr class="hover:bg-primary-50 transition-colors duration-150">
                                  <td class="px-6 py-4 text-sm text-gray-700"><%= rs_demand.getString("product_name") %></td>
                                  <td class="px-6 py-4 text-sm text-gray-700"><%= rs_demand.getInt("demand_count") %></td>
                                  <td class="px-6 py-4 text-sm text-gray-700"><%= rs_demand.getInt("current_stock") %></td>
                                  <td class="px-6 py-4">
                                      <span class="px-2 py-1 text-xs font-semibold rounded-full
                                          <%= rs_demand.getString("status").equals("High Demand") ? "status-high-demand" :
                                              rs_demand.getString("status").equals("Moderate") ? "status-moderate" :
                                              "status-completed" %>">
                                          <%= rs_demand.getString("status") %>
                                      </span>
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
          
              <!-- Recent Feedback -->
              <div class="bg-white rounded-lg border border-primary-200 shadow-md p-6 mb-8 animate-slide-up">
                  <h2 class="text-xl font-bold mb-6 text-gray-800">Recent Feedback</h2>
                  <div class="space-y-6">
                      <% 
                      try (Connection conn = PostgresConnection.getConnection()){
                          String feedback = "SELECT  f.feedback_text, f.rating, f.feedback_date, c.customer_name FROM wholeseller.feedback f JOIN wholeseller.customer c ON f.customer_id = c.customer_id WHERE f.wholeseller_id = ? ORDER BY f.feedback_date DESC LIMIT 5 ";
                          PreparedStatement ps_feedback = conn.prepareStatement(feedback);
                          ps_feedback.setInt(1, loginId);
                          ResultSet rs_feedback = ps_feedback.executeQuery();

                          while (rs_feedback.next()) {
                      %>
                      <div class="border-b border-primary-200 pb-6">
                          <div class="flex justify-between items-start mb-2">
                              <div>
                                  <h3 class="font-semibold text-gray-800"><%= rs_feedback.getString("customer_name") %></h3>
                                  <div class="flex items-center text-yellow-400">
                                      <% for (int i = 0; i < rs_feedback.getInt("rating"); i++) { %>
                                          <i class="fas fa-star w-5 h-5"></i>
                                      <% } %>
                                  </div>
                              </div>
                              <span class="text-sm text-gray-500"><%= rs_feedback.getString("feedback_date") %></span>
                          </div>
                          <p class="text-gray-600"><%= rs_feedback.getString("feedback_text") %></p>
                      </div>
                      <% 
                          }
                      } catch (Exception e) {
                          request.setAttribute("errorMessage", e.getMessage());
                          request.getRequestDispatcher("/error.jsp").forward(request, response);
                      }
                      %>
                  </div>
              </div>

              <!-- Feedback Form -->
              <div class="bg-white rounded-lg border border-primary-200 shadow-md p-6 animate-slide-up">
                  <h2 class="text-xl font-bold mb-6 text-gray-800">Submit Feedback</h2>
                  <form class="space-y-6" action = "">
                      <div>
                          <label class="block text-sm font-medium text-gray-700 mb-2">Subject</label>
                          <input type="text" class="w-full px-4 py-2 rounded-lg border border-primary-200 focus:outline-none focus:border-primary-400 shadow-sm">
                      </div>
                      <div>
                          <label class="block text-sm font-medium text-gray-700 mb-2">Message</label>
                          <textarea rows="4" class="w-full px-4 py-2 rounded-lg border border-primary-200 focus:outline-none focus:border-primary-400 shadow-sm"></textarea>
                      </div>
                      <button type="submit" class="px-6 py-2 bg-primary-500 text-white rounded-lg hover:bg-primary-600 shadow-md transition-colors duration-200">Submit Feedback</button>
                  </form>
              </div>
          </section>
      </main>
      <!-- Utilities and Components -->
      <script src="https://cdnjs.cloudflare.com/ajax/libs/alpinejs/3.13.3/cdn.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/apexcharts/3.45.1/apexcharts.min.js"></script>
   </body>
</html>
