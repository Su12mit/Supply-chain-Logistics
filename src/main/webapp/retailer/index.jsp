<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setDateHeader("Expires", 0); // Proxies.
%>

<%@ page import="java.sql.*"%>
<%@ page import="com.scm.db.PostgresConnection"%>
<%@ page import="com.scm.Transport.LoginId" %>
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

    try (Connection conn = PostgresConnection.getConnection()){
    	
    	
        PreparedStatement ps = null;
        
        ResultSet rs = null;
		 PreparedStatement ps1 = null;
        
        ResultSet rs1 = null;
        
        ps = conn.prepareStatement("SELECT email FROM retailer.login WHERE login_id = ?");
    	ps.setInt(1, loginId);
    	rs = ps.executeQuery();
    	if (rs.next()) {
    	    email = rs.getString("email");
    	    request.setAttribute("email", email);
    	}
    	rs.close();
        ps.close();

        // 1. Total Products
        ps = conn.prepareStatement("SELECT COUNT(*) FROM retailer.stock WHERE retailer_id = ?");
        ps.setInt(1, loginId);
        rs = ps.executeQuery();
        if (rs.next()) {
            totalProducts = rs.getInt(1);
            request.setAttribute("totalProducts", totalProducts);
        }
        rs.close();
        ps.close();
        
        // 2. Purchase Orders Count
        ps = conn.prepareStatement("SELECT COUNT(*) FROM retailer.my_orders WHERE retailer_id = ?");
        ps.setInt(1, loginId);
        rs = ps.executeQuery();
        if (rs.next()) {
            purchaseOrdersCount = rs.getInt(1);
            request.setAttribute("purchaseOrdersCount", purchaseOrdersCount);
        }
        rs.close();
        ps.close();
        
        // 3. Proforma Count
        
     // 4. Total Invoices Count
        ps = conn.prepareStatement("SELECT COUNT(*) FROM retailer.invoice WHERE retailer_id = ?");
        ps.setInt(1, loginId);
        rs = ps.executeQuery();
        if (rs.next()) {
            totalInvoices = rs.getInt(1);
            request.setAttribute("totalInvoices", totalInvoices);
        }
        rs.close();
        ps.close();
        
        // 5. Low Stock Items (assuming quantity < 10 and > 0)
        ps = conn.prepareStatement("SELECT COUNT(*) FROM retailer.stock WHERE retailer_id = ? AND quantity < 30 AND quantity > 0");
        ps.setInt(1, loginId);
        rs = ps.executeQuery();
        if (rs.next()) {
            lowStockItems = rs.getInt(1);
            request.setAttribute("lowStockItems", lowStockItems);
        }
        rs.close();
        ps.close();
        
     // 6. Out of Stock Items (quantity = 0)
        ps = conn.prepareStatement("SELECT COUNT(*) FROM retailer.stock WHERE retailer_id = ? AND quantity = 0");
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
            "SUM(CASE WHEN order_status = 'pending' THEN 1 ELSE 0 END) AS pending, " +
            "SUM(CASE WHEN order_status = 'processing' THEN 1 ELSE 0 END) AS processing, " +
            "SUM(CASE WHEN order_status = 'completed' THEN 1 ELSE 0 END) AS completed " +
            "FROM retailer.my_orders WHERE retailer_id = ?"
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
        ps = conn.prepareStatement("SELECT COALESCE(SUM(amount), 0) FROM retailer.invoice WHERE retailer_id = ? AND payment_status = 'paid'");
        ps.setInt(1, loginId);
        rs = ps.executeQuery();
        if (rs.next()) {
            totalRevenue = rs.getDouble(1);
            request.setAttribute("totalRevenue", totalRevenue);
        }
        rs.close();
        ps.close();
        
     // 9. Pending Payments: Total unpaid amount in pending invoices
        ps = conn.prepareStatement("SELECT COALESCE(SUM(amount), 0) FROM retailer.invoice WHERE retailer_id = ? AND payment_status = 'Unpaid'");
        ps.setInt(1, loginId);
        rs = ps.executeQuery();
        ps1 = conn.prepareStatement("SELECT COUNT(*) FROM retailer.invoice WHERE retailer_id = ? AND payment_status = 'Unpaid'");
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
        ps = conn.prepareStatement("SELECT COALESCE(SUM(amount), 0) FROM retailer.invoice WHERE retailer_id = ? AND invoice_date < CURRENT_DATE AND payment_status <> 'paid'");
        ps.setInt(1, loginId);
        rs = ps.executeQuery();
        ps1 = conn.prepareStatement("SELECT COUNT(*) FROM retailer.invoice WHERE retailer_id = ? AND payment_status = 'Overdue'");
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
        ps = conn.prepareStatement("SELECT COUNT(*) FROM retailer.invoice WHERE retailer_id = ? AND payment_status = 'paid'");
        ps.setInt(1, loginId);
        rs = ps.executeQuery();
        
        if (rs.next()) {
            paidInvoices = rs.getInt(1);
            request.setAttribute("paidInvoices", paidInvoices);
        }
        rs.close();
        ps.close();
        
        
    } catch (Exception e) {
        request.setAttribute("errorMessage", e.getMessage());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
%>
<!DOCTYPE html>
<html lang="en" class="scroll-smooth">

   <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <meta name="description" content="{{project.meta.ogDescription}}">
      <meta name="theme-color" content="#ffffff">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="robots" content="{{project.meta.robotsMeta}}">
      
      <title>{{project.seoTitle}}</title>
      <!-- SEO Description -->
      <meta name="description" content="{{project.seoDescription}}">

      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100..900;1,100..900&family=Source+Code+Pro:ital,wght@0,200..900;1,200..900&display=swap" rel="stylesheet">

       <link href="{{fontLink}}" rel="stylesheet">
       <link href="{{secondaryFontLink}}" rel="stylesheet">
      
      <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:ital,wght@0,100..800;1,100..800&display=swap" rel="stylesheet">

      <!-- Performance optimization: Preload critical resources -->
      <link rel="preload" href="https://cdn.tailwindcss.com" as="script">
      
      <!-- Header Scripts -->
      <script id="header-scripts">
        // This script tag will be replaced with actual scripts.head content
        if (window.scripts && window.scripts.head) {
          document.getElementById('header-scripts').outerHTML = window.scripts.head;
        }
      </script>

      <!-- Preconnect -->
      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

      <!-- Font stylesheet -->

      <script type="application/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.8/handlebars.min.js"></script>

      <!-- Core CSS -->
      <script src="https://cdn.tailwindcss.com">
        

      </script>
      <script>
      document.addEventListener('DOMContentLoaded', function() {
        tailwind.config = {
          theme: {
            extend: {
              colors: {
                primary: {
                  DEFAULT: '{{settings.colors.primary}}',
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
                  DEFAULT: '{{settings.colors.secondary}}',
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
                  DEFAULT: '{{settings.colors.accent}}',
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
                sans: ['{{settings.fonts.primary}}', 'Roboto', 'system-ui', '-apple-system', 'BlinkMacSystemFont', 'Segoe UI', 'Roboto', 'Helvetica Neue', 'Arial', 'sans-serif'],
                heading: ['{{settings.fonts.secondary}}', 'system-ui', 'sans-serif'],
                body: ['{{settings.fonts.secondary}}', 'system-ui', 'sans-serif'],
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

      <!-- Utilities and Components -->
      <script defer src="https://cdnjs.cloudflare.com/ajax/libs/alpinejs/3.13.3/cdn.min.js"></script>
      <script defer src="https://cdnjs.cloudflare.com/ajax/libs/apexcharts/3.45.1/apexcharts.min.js"></script>
      
      <!-- Optimized Font Loading -->
      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      
      <!-- Icons -->
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" 
            integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />

      <!-- Dynamic Meta Tags -->
      <meta name="description" content="{{project.meta.ogDescription}}">
      <meta name="keywords" content="{{project.meta.keywords}}">
      <meta name="robots" content="{{project.meta.robotsMeta}}">
      <meta name="google-site-verification" content="{{project.meta.googleVerification}}">
      <meta name="baidu-verification" content="{{project.meta.baiduVerification}}">
      <meta name="yandex-verification" content="{{project.meta.yandexVerification}}">
      <meta name="bing-verification" content="{{project.meta.bingVerification}}">
      <meta property="og:title" content="{{project.meta.ogTitle}}">
      <meta property="og:description" content="{{project.meta.ogDescription}}">
      <meta property="og:image" content="{{project.meta.ogImage}}">
      <meta property="og:type" content="website">
      <meta property="og:locale" content="en_US">
      <meta property="og:site_name" content="{{project.name}}">
      <meta name="twitter:card" content="summary_large_image">
      <meta name="twitter:title" content="{{project.meta.ogTitle}}">
      <meta name="twitter:description" content="{{project.meta.ogDescription}}">
      <meta name="twitter:image" content="{{project.meta.ogImage}}">

      
      <link rel="icon" type="image/x-icon" href="{{settings.favicon}}">
      
      <style>
        h1, h2, h3, h4, h5, h6 {
          font-family: {{settings.fonts.primary}}, system-ui, sans-serif;
        }
        body {
          font-family: {{settings.fonts.secondary}}, system-ui, sans-serif;
        }
      </style>
      
      <!--      ////////////////////////////////////////////////////// -->
      <%
      //Variable declaration
      
      	int orderID;
		String pname;
		int qty;
		int price;
		String order_date;
		String status;
		String cname;
		String cemail;
		String cphone;
		String caddress;
		String wcontact;
		String waddress;
		String sname;
      %>
     
      
            <%
      try (Connection conn = PostgresConnection.getConnection()) {
    	 
  	String snamesql = "SELECT shop_name FROM retailer.retailer WHERE retailer_id="+loginId;
    	Statement stmtsname = conn.createStatement();
   	ResultSet rs_sname = stmtsname.executeQuery(snamesql);
   	if (rs_sname.next()) {
           sname = rs_sname.getString("shop_name");
          request.setAttribute("sname", sname);
      }
} catch (Exception e) {
    request.setAttribute("errorMessage", e.getMessage());
    request.getRequestDispatcher("/error.jsp").forward(request, response);
}
      %>
      	
       
   </head>
   <body class="antialiased text-gray-900 min-h-screen flex flex-col">
      <!-- Skip to main content link for accessibility -->
      <a href="#main-content" 
         class="sr-only focus:not-sr-only focus:absolute focus:top-0 focus:left-0 focus:z-50 focus:p-4 focus:bg-white focus:text-black">
         Skip to main content
      </a>

      <!-- Header -->
      <header class="relative z-50 bg-white dark:bg-gray-900">
        <!-- Header content goes here -->
      </header>

      <!-- Main content area -->
      <main id="main-content" class="flex-1 relative h-full">
        <!-- Content will be injected here -->
      </main>

      <!-- {bodyScripts} -->

   </body>
</html><element id="9f7dbc6f-2125-43b7-a419-5f5efc83a4f9" data-section-id="9f7dbc6f-2125-43b7-a419-5f5efc83a4f9">


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>
    <style>
        [x-cloak] { display: none !important; }
        .active-nav-link { @apply bg-green-200 text-green-800; }
        html { scroll-behavior: smooth; }
    </style>
</head>
<body class="bg-[#E5E7EB]">
    <div class="flex" id="root" >
        <div x-data="{ isOpen: false }">
           <nav class="fixed h-screen bg-green-700 text-white w-64 flex flex-col justify-between lg:block hidden">

                <div class="p-4">
                    <div class="text-xl font-bold mb-8 text-white-800"> RT  ${loginId}</div>
                    <ul class="space-y-2">
                        <li>
                            <a href="#dashboard-home"class="flex items-center p-2 rounded-lg text-white hover:bg-emerald-600 hover:text-white transition-colors duration-200 active-nav-link">

                                <svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M3 4a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1V4z"/>
                                    <path d="M3 10a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1v-2z"/>
                                    <path d="M3 16a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1v-2z"/>
                                </svg>
                                Dashboard
                            </a>
                        </li>
                        <li x-data="{ open: false }">
                            <button @click="open = !open" class="flex items-center w-full p-2 rounded-lg text-gray-100 hover:bg-emerald-600 hover:text-white transition-colors">

                                <svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M4 3a2 2 0 100 4h12a2 2 0 100-4H4z"/>
                                    <path d="M3 8h14v9a2 2 0 01-2 2H5a2 2 0 01-2-2V8z"/>
                                </svg>
                                Products
                                <svg class="w-4 h-4 ml-auto" :class="{'rotate-180': open}" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                                </svg>
                            </button>
                            <ul x-show="open" class="pl-4 mt-2 space-y-2">
                               <li>
  <a href="#products-stock" class="block p-2 rounded-lg text-gray-100 hover:bg-emerald-600 hover:text-white transition-colors">
    Stock
  </a>
</li>
<li>
  <a href="#products-buy" class="block p-2 rounded-lg text-gray-100 hover:bg-emerald-600 hover:text-white transition-colors">
    Buy Product
  </a>
</li>

                            </ul>
                        </li>
                        <li x-data="{ open: false }">
                            <button @click="open = !open" class="flex items-center w-full p-2 rounded-lg text-gray-100 hover:bg-emerald-600 hover:text-white transition-colors">
                                <svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M9 6a3 3 0 11-6 0 3 3 0 016 0zM17 6a3 3 0 11-6 0 3 3 0 016 0zM12.93 17c.046-.327.07-.66.07-1a6.97 6.97 0 00-1.5-4.33A5 5 0 0119 16v1h-6.07zM6 11a5 5 0 015 5v1H1v-1a5 5 0 015-5z"/>
                                </svg>
                                Retailing
                                <svg class="w-4 h-4 ml-auto" :class="{'rotate-180': open}" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                                </svg>
                            </button>
                            <ul x-show="open" class="pl-4 mt-2 space-y-2">
                               
                                <li><a href="#wholesaling-payments" class="block p-2 rounded-lg text-gray-100 hover:bg-emerald-600 hover:text-white transition-colors">Payments & Invoice</a></li>
                                <li><a href="#wholesaling-demand" class="block p-2 rounded-lg text-gray-100 hover:bg-emerald-600 hover:text-white transition-colors">Demand & Feedback</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
                
<!-- Bottom block: Logo + Profile + Logout -->
<div class="p-4 border-t border-green-600 space-y-4">
    <!-- Shop logo -->

    <!-- Profile + Logout -->
    <div class="flex items-center space-x-3">
        <img src="https://placehold.co/48?text=U" alt="Profile"
             class="w-10 h-10 rounded-full border border-white/30" />
        <div class="flex flex-col leading-tight">
            <span class="text-sm font-semibold"><%= email %></span>
            <a href="logout.jsp"
   class="mt-1 flex items-center gap-1 text-xs text-gray-200 hover:text-red-400 transition-colors">
    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
              d="M17 16l4-4m0 0l-4-4m4 4H9m4 4v1m0-10V5"/>
    </svg>
    Logout
</a>
        </div>
    </div>
</div>
            </nav>

            <!-- Mobile Menu Button -->
            <button type="button" 
                class="lg:hidden fixed top-4 right-4 z-20 rounded-lg p-2 bg-green-500 text-white"
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
                class="lg:hidden fixed inset-0 z-10 bg-green-500/95 backdrop-blur-lg"
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
                            <a href="#dashboard" class="block p-2 text-white hover:bg-green-400 rounded-lg">Dashboard</a>
                        </li>
                        <li>
                            <a href="#stock" class="block p-2 text-white hover:bg-green-400 rounded-lg">Stock</a>
                        </li>
                        <li>
                            <a href="#buy" class="block p-2 text-white hover:bg-green-400 rounded-lg">Buy Product</a>
                        </li>
                        
                        
                        <li>
                            <a href="#payments" class="block p-2 text-white hover:bg-green-400 rounded-lg">Payments & Invoice</a>
                        </li>
                        <li>
                            <a href="#feedback" class="block p-2 text-white hover:bg-green-400 rounded-lg">Demand & Feedback</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- <main class="flex-1 ml-64 lg:ml-64 bg-[#e5ede1] min-h-screen overflow-y-auto"> -->
        <main class="flex-1 ml-64 bg-gray-50 min-h-screen overflow-y-auto p-6">
        
            <MountPoint>

</element><element id="79295d15-fd7a-41b4-b14e-41b080bfd80a" data-section-id="79295d15-fd7a-41b4-b14e-41b080bfd80a">


<section id="dashboard-home" class="p-6">
    <!-- Header -->
    <div class="flex justify-between items-center mb-8 border-b border-green-200 pb-4">
        <h1 class="text-2xl font-bold text-gray-800">Welcome  ${sname}</h1>
        <div class="flex items-center gap-4">
            <div class="relative">
                <input type="search" placeholder="Search..." class="pl-10 pr-4 py-2 rounded-lg border border-green-200 focus:outline-none focus:border-green-400">
                <svg class="w-5 h-5 absolute left-3 top-2.5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                </svg>
            </div>
            
<%
List<String[]> alerts = new ArrayList<>();
try (Connection conn = PostgresConnection.getConnection()) {
    String stocknotificationsql = "SELECT alert_date, alert_message FROM retailer.stock_alerts WHERE retailer_id=" + loginId;
    Statement stmtstocknoti = conn.createStatement();
    ResultSet rs_stocknotify = stmtstocknoti.executeQuery(stocknotificationsql);

    while (rs_stocknotify.next()) {
        String date = rs_stocknotify.getString("alert_date");
        String msg = rs_stocknotify.getString("alert_message");
        alerts.add(new String[]{date, msg});
    }
    request.setAttribute("alerts", alerts);
} catch (Exception e) {
    request.setAttribute("errorMessage", e.getMessage());
    request.getRequestDispatcher("/error.jsp").forward(request, response);
}
%>
         <!-- Notification Button -->
<!-- Notification Button -->
<button id="notificationBtn" class="p-2 hover:bg-green-100 rounded-lg relative z-50">
    <svg class="w-6 h-6 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
              d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"/>
    </svg>
    <span id="notificationCount"
          class="absolute -top-1 -right-1 bg-red-500 text-white text-xs font-semibold px-1.5 py-0.5 rounded-full hidden">
        0
    </span>
</button>


<!-- Overlay with blur -->
<div id="notificationOverlay" class="hidden fixed inset-0 bg-black bg-opacity-30 backdrop-blur-sm z-40 transition-opacity duration-300"></div>
<!-- Notification Panel -->
<div id="notificationPanel"
     class="hidden fixed top-0 left-1/2 transform -translate-x-1/2 -translate-y-full w-[36rem] bg-white shadow-lg rounded-lg border border-gray-300 z-50 transition-all duration-500 ease-in-out opacity-0">
    <div class="p-4 border-b font-semibold text-green-700 flex justify-between items-center">
    <span>Notifications</span>
    <button id="clearAllBtn" class="text-sm text-red-600 hover:underline">Clear All</button>
</div>

   <ul id="notificationList" class="max-h-80 overflow-y-auto">

        <%
        List<String[]> alertsList = (List<String[]>) request.getAttribute("alerts");
        if (alertsList != null && !alertsList.isEmpty()) {
            for (String[] alert : alertsList) {
        %>
                <li class="group p-2">
    <div class="relative bg-white rounded-lg shadow-md p-4 hover:bg-green-50 transition">
        <div>
            <p class="text-sm text-gray-800"><%= alert[1] %></p>
            <p class="text-xs text-gray-400"><%= alert[0] %></p>
        </div>
        <button class="absolute top-2 right-2 text-gray-400 hover:text-red-500 opacity-0 group-hover:opacity-100 transition"
                onclick="this.closest('li').remove()" title="Dismiss">
            &times;
        </button>
    </div>
</li>

        <%
            }
        } else {
        %>
            <li class="p-4 text-gray-500">No new notifications.</li>
        <%
        }
        %>
    </ul>
</div>

<script>
const panel = document.getElementById("notificationPanel");
const overlay = document.getElementById("notificationOverlay");
const btn = document.getElementById("notificationBtn");
const countSpan = document.getElementById("notificationCount");
const list = document.getElementById("notificationList") || document.querySelector("ul");

btn.addEventListener("click", () => {
    const isHidden = panel.classList.contains("hidden");

    if (isHidden) {
        overlay.classList.remove("hidden");
        panel.classList.remove("hidden");

        // Trigger slide-down
        requestAnimationFrame(() => {
            panel.classList.remove("-translate-y-full", "opacity-0");
            panel.classList.add("translate-y-1/2", "opacity-100");
        });

        updateNotificationCount(); // optional here
    } else {
        closePanel();
    }
});

function closePanel() {
    panel.classList.remove("translate-y-1/2", "opacity-100");
    panel.classList.add("-translate-y-full", "opacity-0");

    setTimeout(() => {
        panel.classList.add("hidden");
        overlay.classList.add("hidden");
    }, 500);
}

// Count updater
function updateNotificationCount() {
    const items = list.querySelectorAll("li:not(.empty)");
    const count = items.length;

    if (count > 0) {
        countSpan.textContent = count;
        countSpan.classList.remove("hidden");
    } else {
        countSpan.classList.add("hidden");
    }
}

// Mark as read (from fetch or static)
function markAsRead(button) {
    const li = button.closest("li");
    li.remove();
    updateNotificationCount();
}

// Clear all
const clearAllBtn = document.getElementById("clearAllBtn");
if (clearAllBtn) {
    clearAllBtn.addEventListener("click", () => {
        list.innerHTML = '<li class="empty p-4 text-gray-500">No new notifications.</li>';
        updateNotificationCount();
    });
}

// If using AJAX
function fetchNotifications() {
    fetch('/RetailerNotificationsServlet')
        .then(response => response.json())
        .then(notifications => {
            list.innerHTML = '';

            if (notifications.length === 0) {
                list.innerHTML = '<li class="empty p-4 text-gray-500">No new notifications.</li>';
                updateNotificationCount();
                return;
            }

            notifications.forEach(n => {
                const li = document.createElement("li");
                li.className = "group p-2";
                li.innerHTML = `
                    <div class="relative bg-white rounded-lg shadow-md p-4 hover:bg-green-50 transition">
                        <div>
                            <p class="text-sm text-gray-800">${n.message}</p>
                            <p class="text-xs text-gray-400">${n.timestamp}</p>
                        </div>
                        <button class="absolute top-2 right-2 text-gray-400 hover:text-red-500 opacity-0 group-hover:opacity-100 transition"
                                onclick="this.closest('li').remove(); updateNotificationCount();" title="Dismiss">
                            &times;
                        </button>
                    </div>
                `;
                list.appendChild(li);
            });

            updateNotificationCount();
        });
}

// Dismiss outside panel
document.addEventListener("click", (e) => {
    if (!panel.contains(e.target) && !btn.contains(e.target)) {
        closePanel();
    }
});

// Initial update if content is rendered server-side
window.addEventListener("DOMContentLoaded", updateNotificationCount);
</script>

            <button class="p-2 hover:bg-green-100 rounded-lg">
                <svg class="w-6 h-6 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"/>
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                </svg>
            </button>
        </div>
    </div>

    <!-- Performance Cards -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <div class="p-6 bg-white rounded-lg border border-green-200">
            <h3 class="text-gray-500 text-sm mb-2">Total Products</h3>
            <p class="text-2xl font-bold">${totalProducts}</p>
        </div>
        <div class="p-6 bg-white rounded-lg border border-green-200">
            <h3 class="text-gray-500 text-sm mb-2">Purchase Orders</h3>
            <p class="text-2xl font-bold">${purchaseOrdersCount}</p>
        </div>
        <div class="p-6 bg-white rounded-lg border border-green-200">
            <h3 class="text-gray-500 text-sm mb-2">Proforma</h3>
            <p class="text-2xl font-bold">89</p>
        </div>
        <div class="p-6 bg-white rounded-lg border border-green-200">
            <h3 class="text-gray-500 text-sm mb-2">Invoice</h3>
            <p class="text-2xl font-bold">${totalInvoices}</p>
        </div>
    </div>

   
    <!-- Transactions Table -->
   <!--  <div class="mb-8 bg-white rounded-lg border border-green-200 overflow-hidden">
        <div class="p-4 border-b border-green-200">
            <h2 class="text-xl font-bold">Transactions</h2>
        </div>
        <div class="overflow-x-auto">
            <table class="w-full">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Purchase Order Id</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Retailer Name</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Retailer Id</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Status</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Purchase Type</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-green-200">
                    <tr>
                        <td class="px-6 py-4 whitespace-nowrap">#PO001</td>
                        <td class="px-6 py-4 whitespace-nowrap">John's Store</td>
                        <td class="px-6 py-4 whitespace-nowrap">RT789</td>
                        <td class="px-6 py-4 whitespace-nowrap"><span class="px-2 py-1 bg-green-100 text-green-800 rounded">Proceed</span></td>
                        <td class="px-6 py-4 whitespace-nowrap">Credit</td>
                    </tr>
                    <tr>
                        <td class="px-6 py-4 whitespace-nowrap">#PO002</td>
                        <td class="px-6 py-4 whitespace-nowrap">Mary's Mart</td>
                        <td class="px-6 py-4 whitespace-nowrap">RT012</td>
                        <td class="px-6 py-4 whitespace-nowrap"><span class="px-2 py-1 bg-red-100 text-red-800 rounded">Cancelled</span></td>
                        <td class="px-6 py-4 whitespace-nowrap">Cash</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
 -->
   
    <!-- Your Orders Table -->
    <div class="mb-8 bg-white rounded-lg border border-green-200 overflow-hidden">
        <div class="p-4 border-b border-green-200">
            <h2 class="text-xl font-bold">Your Orders</h2>
        </div>
        <div class="overflow-x-auto">
            <table class="w-full">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Order Id</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Tracking Id</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Product Name</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Status</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions</th>
                    </tr>
                </thead>
               <tbody class="divide-y divide-green-200">

<%
    try (Connection conn = PostgresConnection.getConnection()){
    	String yourorders = "SELECT my_order_id, shipment_id, product_name, order_status FROM retailer.my_orders WHERE retailer_id= ? AND order_status IN('Pending','Accepted','In Transit')";
         PreparedStatement ps = conn.prepareStatement(yourorders);
    		ps.setInt(1, loginId);
         ResultSet rs = ps.executeQuery();

        while (rs.next()) {
%>
    <tr>
        <td class="px-6 py-4 whitespace-nowrap">#YO<%= rs.getInt("my_order_id") %></td>
       <td class="px-6 py-4 whitespace-nowrap">
    <%
        String shipmentId = rs.getString("shipment_id");
        if (shipmentId == null || shipmentId.trim().isEmpty()) {
    %>
        -
    <%
        } else {
    %>
        #TRK<%= shipmentId %>
    <%
        }
    %>
</td>
        <td class="px-6 py-4 whitespace-nowrap"><%= rs.getString("product_name") %></td>
        <td class="px-6 py-4 whitespace-nowrap">
            <span class="px-2 py-1 
                <%= rs.getString("order_status").equals("In Transit") ? "bg-blue-100 text-blue-800" :
                     rs.getString("order_status").equals("Pending") ? "bg-yellow-100 text-yellow-800" :
                     "bg-green-100 text-green-800" 
                %> rounded">
                <%= rs.getString("order_status") %>
            </span>
        </td>
        
<td class="px-6 py-4 whitespace-nowrap space-x-2">
    <% String statusval = rs.getString("order_status"); %>

    <% if ("In Transit".equals(statusval)) { %>
         <a href="OrderTracking.jsp?delivery_id=<%= rs.getString("shipment_id") %>" 
   class="text-green-600 hover:text-green-800">
   Track
</a>

       
    <% } else if ("Delivered".equals(statusval)) { %>
        <button class="text-red-600 hover:text-red-800">View Invoice</button>
    <% } else if("Accepted".equals(statusval)) { %>
       <a href="orderview.jsp?OrderId=<%= rs.getInt("my_order_id") %>">
  <button class="text-blue-600 hover:text-blue-800">View</button>
</a>

        <button class="text-green-600 hover:text-green-800">Pay</button>
    <% } else{ %>
    	<a href="orderview.jsp?OrderId=<%= rs.getInt("my_order_id") %>">
    	<button class="text-blue-600 hover:text-blue-800">View</button></a>
    	<button class="text-red-600 hover:text-red-800">Cancel</button>
    <%} %>
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

    <element id="cb349741-45e3-41c8-8f26-332d94434c83" data-section-id="cb349741-45e3-41c8-8f26-332d94434c83">


<section id="products-stock" class="p-6">
    <!-- Header -->
    <div class="flex justify-between items-center mb-8 border-b border-green-200 pb-4">
        <h1 class="text-2xl font-bold text-gray-800">Stock Management</h1>
        <div class="flex gap-4">
         <a href="Add-new-product.jsp?loginId=<%= session.getAttribute("loginId") %>">  <button class="px-4 py-2 bg-green-500 text-white rounded-lg hover:bg-green-600 flex items-center gap-2">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                </svg>
                Add New Product
            </button></a>
        </div>
    </div>

    <!-- Stock Overview Cards -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <div class="p-6 bg-white rounded-lg border border-green-200">
            <h3 class="text-gray-500 text-sm mb-2">Total Products</h3>
            <p class="text-2xl font-bold">${totalProducts}</p>
            <div class="mt-2 text-sm text-green-600">+12% from last month</div>
        </div>
        <div class="p-6 bg-white rounded-lg border border-green-200">
            <h3 class="text-gray-500 text-sm mb-2">Low Stock Items</h3>
            <p class="text-2xl font-bold">${lowStockItems}</p>
            <div class="mt-2 text-sm text-red-600">Needs attention</div>
        </div>
        <div class="p-6 bg-white rounded-lg border border-green-200">
            <h3 class="text-gray-500 text-sm mb-2">Out of Stock</h3>
            <p class="text-2xl font-bold">${outOfStockItems}</p>
            <div class="mt-2 text-sm text-gray-600">Action required</div>
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
    
    <div class="bg-white rounded-lg border border-green-200 overflow-hidden">
        <div class="p-4 border-b border-green-200 flex justify-between items-center">
            <h2 class="text-xl font-bold">Current Stock</h2>
            <form method="get" action="">
            <div class="flex gap-4">
                <div class="relative">
                    <input type="search" placeholder="Search products..." class="pl-10 pr-4 py-2 rounded-lg border border-green-200 focus:outline-none focus:border-green-400">
                    <svg class="w-5 h-5 absolute left-3 top-2.5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                    </svg>
                </div>

                <select name="category" onchange="this.form.submit()" class="px-4 py-2 rounded-lg border border-green-200 focus:outline-none focus:border-green-400">
                <option value="">All Categories</option>
                <%
                try (Connection conn = PostgresConnection.getConnection()) {
                    String categorysql = "SELECT stock_cat_id, category_name FROM retailer.stock_cat WHERE retailer_id = ?";
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
        </div>
     </form>   

        

        
        <div class="overflow-x-auto">
            <table class="w-full">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Product ID</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Product Name</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Category</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Stock Level</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Unit Price</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Status</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-green-200">

<%


    try (Connection conn = PostgresConnection.getConnection()){
    	
    	 String stocksql;
    	 PreparedStatement ps;
    	 if (selectedCategoryId > 0) {
    		    stocksql = "SELECT s.stock_id, s.product_name, s.quantity, s.price, s.status, c.category_name FROM retailer.stock s JOIN retailer.stock_cat c ON s.stock_cat_id = c.stock_cat_id WHERE s.retailer_id = ? AND s.stock_cat_id = ?";
    		    ps = conn.prepareStatement(stocksql);
    		    ps.setInt(1, loginId);
    		    ps.setInt(2, selectedCategoryId);
    		
    	 } else {
    		    
    	stocksql = "SELECT s.stock_id, s.product_name, s.quantity, s.price, s.status, c.category_name FROM retailer.stock s JOIN retailer.stock_cat c ON s.stock_cat_id = c.stock_cat_id WHERE s.retailer_id = ?";
         ps = conn.prepareStatement(stocksql);
         ps.setInt(1, loginId);
    	 }
         ResultSet rs_stock = ps.executeQuery();

        while (rs_stock.next()) {
%>
    <tr>
        <td class="px-6 py-4 whitespace-nowrap">#PRD<%= rs_stock.getInt("stock_id") %></td>
        <td class="px-6 py-4"><%= rs_stock.getString("product_name") %></td>
        <td class="px-6 py-4"><%= rs_stock.getString("category_name") %></td>
        <td class="px-6 py-4"><%= rs_stock.getInt("quantity") %> </td>
        <td class="px-6 py-4">Rs.<%= rs_stock.getDouble("price") %> </td>
        <td class="px-6 py-4">
            <span class="px-2 py-1 
                <%= rs_stock.getString("status").equals("In Stock") ? "bg-green-100 text-green-800" :
                     rs_stock.getString("status").equals("Low Stock") ? "bg-yellow-100 text-yellow-800" :
                     "bg-red-100 text-red-800" %> rounded">
                <%= rs_stock.getString("status") %>
            </span>
        </td>
        <td class="px-6 py-4">
    <div class="flex gap-2">
        <a href="Add-new-product.jsp?stock_id=<%= rs_stock.getInt("stock_id") %>&loginId=<%= session.getAttribute("loginId") %>"
           class="text-blue-600 hover:text-blue-800">
            Reorder
        </a>
        <form action="/Supply-chain-and-Logistic/AddnewProductServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this product?');">
         <input type="hidden" name="Delstockid" value="<%= rs_stock.getInt("stock_id") %>">
       <button class="text-red-600 hover:text-red-800">Delete</button>
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
        <div class="p-4 border-t border-green-200 flex justify-between items-center">
            <div class="text-sm text-gray-500">Showing 1 to 3 of 100 entries</div>
            <div class="flex gap-2">
                <button class="px-3 py-1 border border-green-200 rounded-lg hover:bg-green-50">Previous</button>
                <button class="px-3 py-1 bg-green-500 text-white rounded-lg">1</button>
                <button class="px-3 py-1 border border-green-200 rounded-lg hover:bg-green-50">2</button>
                <button class="px-3 py-1 border border-green-200 rounded-lg hover:bg-green-50">3</button>
                <button class="px-3 py-1 border border-green-200 rounded-lg hover:bg-green-50">Next</button>
            </div>
        </div>
    </div>
</section>
</element><element id="eaacc218-0410-4c4a-932c-e34c3fce1629" data-section-id="eaacc218-0410-4c4a-932c-e34c3fce1629">

<section id="products-buy" class="p-6">
    <!-- Header -->
    <div class="flex justify-between items-center mb-8 border-b border-green-200 pb-4">
        <h1 class="text-2xl font-bold text-gray-800">Buy Products</h1>
       <a href="buy-product.html"> <div class="flex gap-4">
            <div class="relative">
                <input type="search" placeholder="Search products..." class="pl-10 pr-4 py-2 rounded-lg border border-green-200 focus:outline-none focus:border-green-400">
                <svg class="w-5 h-5 absolute left-3 top-2.5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                </svg>
            </div>
            <select class="px-4 py-2 rounded-lg border border-green-200 focus:outline-none focus:border-green-400">
                <option>All Categories</option>
                <option>Electronics</option>
                <option>Clothing</option>
                <option>Food</option>
            </select>
        </div></a>
    </div>

    <!-- Product Grid -->
    <a href="buy-product.jsp?loginId=<%= session.getAttribute("loginId") %>&type=wholeseller"><div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
        <!-- Product Card 1 -->
        <div class="bg-white rounded-lg border border-green-200 overflow-hidden">
            <img src="https://placehold.co/400x300" alt="Product" class="w-full h-48 object-cover">
            <div class="p-4">
                <h3 class="text-lg font-semibold mb-2">Product Name A</h3>
                <p class="text-gray-600 text-sm mb-4">Category: Electronics</p>
                <div class="flex justify-between items-center mb-4">
                    <span class="text-lg font-bold">$99.99</span>
                    <span class="text-sm text-gray-500">MOQ: 100 units</span>
                </div>
                <button class="w-full py-2 bg-green-500 text-white rounded-lg hover:bg-green-600">Add to Cart</button>
            </div>
        </div>

        <!-- Product Card 2 -->
        <div class="bg-white rounded-lg border border-green-200 overflow-hidden">
            <img src="https://placehold.co/400x300" alt="Product" class="w-full h-48 object-cover">
            <div class="p-4">
                <h3 class="text-lg font-semibold mb-2">Product Name B</h3>
                <p class="text-gray-600 text-sm mb-4">Category: Clothing</p>
                <div class="flex justify-between items-center mb-4">
                    <span class="text-lg font-bold">$49.99</span>
                    <span class="text-sm text-gray-500">MOQ: 50 units</span>
                </div>
                <button class="w-full py-2 bg-green-500 text-white rounded-lg hover:bg-green-600">Add to Cart</button>
            </div>
        </div>

        <!-- Product Card 3 -->
        <div class="bg-white rounded-lg border border-green-200 overflow-hidden">
            <img src="https://placehold.co/400x300" alt="Product" class="w-full h-48 object-cover">
            <div class="p-4">
                <h3 class="text-lg font-semibold mb-2">Product Name C</h3>
                <p class="text-gray-600 text-sm mb-4">Category: Food</p>
                <div class="flex justify-between items-center mb-4">
                    <span class="text-lg font-bold">$29.99</span>
                    <span class="text-sm text-gray-500">MOQ: 200 units</span>
                </div>
                <button class="w-full py-2 bg-green-500 text-white rounded-lg hover:bg-green-600">Add to Cart</button>
            </div>
        </div>
    </div>

    <!-- Shopping Cart Preview -->
    <div class="fixed bottom-0 right-0 m-6">
        <button class="relative p-3 bg-green-500 text-white rounded-full shadow-lg hover:bg-green-600">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"/>
            </svg>
            <span class="absolute -top-2 -right-2 bg-red-500 text-white text-xs w-5 h-5 rounded-full flex items-center justify-center">3</span>
        </button>
    </div></a>


<section id="wholesaling-retailer-orders" class="p-6">
    <!-- Header -->
    <div class="flex justify-between items-center mb-8 border-b border-green-200 pb-4">
        <h1 class="text-2xl font-bold text-gray-800">Orders</h1>
        <div class="flex gap-4">
           
           
        </div>
    </div>

    <!-- Order Statistics -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
        <div class="p-6 bg-white rounded-lg border border-green-200">
            <h3 class="text-gray-500 text-sm mb-2">Total Orders</h3>
            <p class="text-2xl font-bold">${totalOrders}</p>
            <div class="mt-2 text-sm text-green-600">+15% from last month</div>
        </div>
        <div class="p-6 bg-white rounded-lg border border-green-200">
            <h3 class="text-gray-500 text-sm mb-2">Pending Orders</h3>
            <p class="text-2xl font-bold">${pendingOrders}</p>
            <div class="mt-2 text-sm text-yellow-600">Needs attention</div>
        </div>
        <div class="p-6 bg-white rounded-lg border border-green-200">
            <h3 class="text-gray-500 text-sm mb-2">Processing</h3>
            <p class="text-2xl font-bold">${processingOrders}</p>
            <div class="mt-2 text-sm text-blue-600">In progress</div>
        </div>
        <div class="p-6 bg-white rounded-lg border border-green-200">
            <h3 class="text-gray-500 text-sm mb-2">Completed</h3>
            <p class="text-2xl font-bold">${completedOrders}</p>
            <div class="mt-2 text-sm text-green-600">Successfully delivered</div>
        </div>
    </div>

  <%--  <!-- Orders Table -->
    <div class="bg-white rounded-lg border border-green-200 overflow-hidden">
        <div class="p-4 border-b border-green-200">
            <h2 class="text-xl font-bold">Retailer Orders List</h2>
        </div>
        <div class="overflow-x-auto">
            <table class="w-full">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Order ID</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Retailer Name</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Order Date</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Total Amount</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Status</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions</th>
                    </tr>
                </thead>

<tbody class="divide-y divide-green-200">
<%
	try (Connection conn = PostgresConnection.getConnection()) {
    
	String sql = "SELECT o.order_request_id, o.price, o.order_date, o.status, c.customer_name  FROM wholeseller.order_request o JOIN wholeseller.customer c ON o.customer_id = c.customer_id  WHERE o.wholeseller_id = ?";

	PreparedStatement ps = conn.prepareStatement(sql);
	ps.setInt(1, loginId);
	ResultSet rs = ps.executeQuery();

	while (rs.next()) {
%>

    <tr>
        <td class="px-6 py-4 whitespace-nowrap">#ORD<%= rs.getInt("order_request_id") %></td>
        <td class="px-6 py-4"><%= rs.getString("customer_name") %></td>
        <td class="px-6 py-4"><%= rs.getString("order_date") %></td>
        <td class="px-6 py-4">Rs.<%= rs.getInt("price") %></td>
        <td class="px-6 py-4">
            <span class="px-2 py-1 
                <%= rs.getString("status").equals("Pending") ? "bg-yellow-100 text-yellow-800" : 
                     rs.getString("status").equals("Processing") ? "bg-blue-100 text-blue-800" : 
                     "bg-green-100 text-green-800" 
                %> rounded">
                <%= rs.getString("status") %>
            </span>
        </td>
        <td class="px-6 py-4">
            <div class="flex gap-2">
                <a href="RT-request.jsp?orderID=<%= rs.getInt("order_request_id") %>"><button class="text-blue-600 hover:text-blue-800">View Details</button></a>
                <% if (rs.getString("status").equals("Pending")) { %>
                    <button class="text-green-600 hover:text-green-800">Accept</button>
                    <button class="text-red-600 hover:text-red-800">Reject</button>
                <% } else if (rs.getString("status").equals("Accepted")) { %>
                    <button class="text-red-600 hover:text-green-800">Track</button>
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
        <div class="p-4 border-t border-green-200 flex justify-between items-center">
            <div class="text-sm text-gray-500">Showing 1 to 3 of 45 entries</div>
            <div class="flex gap-2">
                <button class="px-3 py-1 border border-green-200 rounded-lg hover:bg-green-50">Previous</button>
                <button class="px-3 py-1 bg-green-500 text-white rounded-lg">1</button>
                <button class="px-3 py-1 border border-green-200 rounded-lg hover:bg-green-50">2</button>
                <button class="px-3 py-1 border border-green-200 rounded-lg hover:bg-green-50">3</button>
                <button class="px-3 py-1 border border-green-200 rounded-lg hover:bg-green-50">Next</button>
            </div>
        </div>
    </div>  --%>
    
</section></element><element id="94aa0906-c989-48fa-89b1-6c9072484167" data-section-id="94aa0906-c989-48fa-89b1-6c9072484167">

<section id="wholesaling-order-tracking" class="p-6">
<%--    <!-- Header -->
    <div class="flex justify-between items-center mb-8 border-b border-green-200 pb-4">
        <h1 class="text-2xl font-bold text-gray-800">Order Tracking</h1>
    </div>

    <!-- Search Order -->
    <div class="max-w-3xl mx-auto mb-8">
        <div class="bg-white rounded-lg border border-green-200 p-6">
            <h2 class="text-lg font-semibold mb-4">Track Your Order</h2>
            <div class="flex gap-4">
                <input type="text" placeholder="Enter Order ID" class="flex-1 px-4 py-2 rounded-lg border border-green-200 focus:outline-none focus:border-green-400">
                <button class="px-6 py-2 bg-green-500 text-white rounded-lg hover:bg-green-600">Track Order</button>
            </div>
        </div>
    </div>

    <!-- Tracking Result -->
    <div class="max-w-4xl mx-auto bg-white rounded-lg border border-green-200 p-6">
        <div class="flex justify-between items-center mb-8">
            <div>
                <h3 class="text-lg font-semibold">#ORD123456</h3>
                <p class="text-sm text-gray-500">Expected Delivery: Jan 25, 2024</p>
            </div>
            <span class="px-3 py-1 bg-green-100 text-green-800 rounded-full text-sm">In Transit</span>
        </div>

        <!-- Tracking Timeline -->
        <div class="relative">
            <div class="absolute left-0 top-0 bottom-0 w-0.5 bg-gray-200 ml-6"></div>
            
            <!-- Order Placed -->
            <div class="relative flex items-center mb-8">
                <div class="w-12 h-12 bg-green-500 rounded-full flex items-center justify-center text-white">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                    </svg>
                </div>
                <div class="ml-4">
                    <h4 class="font-semibold">Order Placed</h4>
                    <p class="text-sm text-gray-500">Jan 20, 2024 - 10:30 AM</p>
                </div>
            </div>

            <!-- Order Confirmed -->
            <div class="relative flex items-center mb-8">
                <div class="w-12 h-12 bg-green-500 rounded-full flex items-center justify-center text-white">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                </div>
                <div class="ml-4">
                    <h4 class="font-semibold">Order Confirmed</h4>
                    <p class="text-sm text-gray-500">Jan 20, 2024 - 2:45 PM</p>
                </div>
            </div>

            <!-- Order Shipped -->
            <div class="relative flex items-center mb-8">
                <div class="w-12 h-12 bg-green-500 rounded-full flex items-center justify-center text-white">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 8h14M5 8a2 2 0 110-4h14a2 2 0 110 4M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4"/>
                    </svg>
                </div>
                <div class="ml-4">
                    <h4 class="font-semibold">Order Shipped</h4>
                    <p class="text-sm text-gray-500">Jan 21, 2024 - 9:15 AM</p>
                </div>
            </div>

            <!-- In Transit -->
            <div class="relative flex items-center mb-8">
                <div class="w-12 h-12 bg-blue-500 rounded-full flex items-center justify-center text-white">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"/>
                    </svg>
                </div>
                <div class="ml-4">
                    <h4 class="font-semibold">In Transit</h4>
                    <p class="text-sm text-gray-500">Current Status</p>
                </div>
            </div>

            <!-- Out for Delivery -->
            <div class="relative flex items-center mb-8">
                <div class="w-12 h-12 bg-gray-300 rounded-full flex items-center justify-center text-white">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/>
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/>
                    </svg>
                </div>
                <div class="ml-4">
                    <h4 class="font-semibold text-gray-500">Out for Delivery</h4>
                    <p class="text-sm text-gray-500">Pending</p>
                </div>
            </div>

            <!-- Delivered -->
            <div class="relative flex items-center">
                <div class="w-12 h-12 bg-gray-300 rounded-full flex items-center justify-center text-white">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                    </svg>
                </div>
                <div class="ml-4">
                    <h4 class="font-semibold text-gray-500">Delivered</h4>
                    <p class="text-sm text-gray-500">Pending</p>
                </div>
            </div>
        </div>
    </div>   --%>
</section></element><element id="9bee65cf-7ba5-4c10-9d41-760c2f0bfb62" data-section-id="9bee65cf-7ba5-4c10-9d41-760c2f0bfb62">

<section id="wholesaling-payments" class="p-6">
    <!-- Header -->
    <div class="flex justify-between items-center mb-8 border-b border-green-200 pb-4">
        <h1 class="text-2xl font-bold text-gray-800">Payments & Invoices</h1>
        <div class="flex gap-4">
        <a href = "payment_details.html">
            <button class="px-4 py-2 bg-green-500 text-white rounded-lg hover:bg-green-600 flex items-center gap-2">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                </svg>
                Get Details
            </button>
            </a>
        </div>
    </div>

    <!-- Payment Statistics -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
        <div class="p-6 bg-white rounded-lg border border-green-200">
            <h3 class="text-gray-500 text-sm mb-2">Total Revenue</h3>
            <p class="text-2xl font-bold">${totalRevenue}</p>
            <div class="mt-2 text-sm text-green-600">+12% from last month</div>
        </div>
        <div class="p-6 bg-white rounded-lg border border-green-200">
            <h3 class="text-gray-500 text-sm mb-2">Pending Payments</h3>
            <p class="text-2xl font-bold">${pendingPayments}</p>
            <div class="mt-2 text-sm text-yellow-600">${pinvoices} invoices pending</div>
        </div>
        <div class="p-6 bg-white rounded-lg border border-green-200">
            <h3 class="text-gray-500 text-sm mb-2">Overdue Payments</h3>
            <p class="text-2xl font-bold">${overduePayments}</p>
            <div class="mt-2 text-sm text-red-600">${oinvoices} invoices overdue</div>
        </div>
        <div class="p-6 bg-white rounded-lg border border-green-200">
            <h3 class="text-gray-500 text-sm mb-2">Paid Invoices</h3>
            <p class="text-2xl font-bold">${paidInvoices}</p>
            <div class="mt-2 text-sm text-green-600">This month</div>
        </div>
    </div>

    <!-- Invoices Table -->
    <div class="bg-white rounded-lg border border-green-200 overflow-hidden mb-8">
        <div class="p-4 border-b border-green-200">
            <h2 class="text-xl font-bold">Recent Invoices</h2>
        </div>
        <div class="overflow-x-auto">
            <table class="w-full">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Invoice ID</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Order ID</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Amount</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Invoice Date</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Order Status</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-green-200">

<%
    try (Connection conn = PostgresConnection.getConnection()){
    	String invoicesql = "SELECT i.transport_invoiceid,  i.order_id, i.amount, i.invoice_date, mor.order_status FROM retailer.invoice i JOIN retailer.my_orders mor ON i.order_id = mor.my_order_id WHERE i.retailer_id = ? AND mor.order_status = 'Delivered'";
         PreparedStatement ps = conn.prepareStatement(invoicesql);
         ps.setInt(1, loginId);
         ResultSet rs_invoice = ps.executeQuery();

        while (rs_invoice.next()) {
%>
    <tr>
        <td class="px-6 py-4 whitespace-nowrap">#INV<%= rs_invoice.getInt("transport_invoiceid") %></td>
        <td class="px-6 py-4"><%= rs_invoice.getInt("order_id") %></td>
        <td class="px-6 py-4">RS.<%= rs_invoice.getDouble("amount") %></td>
        <td class="px-6 py-4"><%= rs_invoice.getString("invoice_date") %></td>
        <td class="px-6 py-4 bg-yellow-100 text-yellow-800"><%= rs_invoice.getString("order_status") %></td>
        <td class="px-6 py-4">
           <div class="flex gap-2">
            <a href="invoice.jsp?invoiceid=<%= rs_invoice.getInt("transport_invoiceid") %>">
                <button class="text-blue-600 hover:text-blue-800">View Invoice</button>
            </a>
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
        <div class="p-4 border-t border-green-200 flex justify-between items-center">
            <div class="text-sm text-gray-500">Showing 1 to 3 of 45 entries</div>
            <div class="flex gap-2">
                <button class="px-3 py-1 border border-green-200 rounded-lg hover:bg-green-50">Previous</button>
                <button class="px-3 py-1 bg-green-500 text-white rounded-lg">1</button>
                <button class="px-3 py-1 border border-green-200 rounded-lg hover:bg-green-50">2</button>
                <button class="px-3 py-1 border border-green-200 rounded-lg hover:bg-green-50">3</button>
                <button class="px-3 py-1 border border-green-200 rounded-lg hover:bg-green-50">Next</button>
            </div>
        </div>
    </div>

    <!-- Payment Methods -->
    <div class="bg-white rounded-lg border border-green-200 p-6">
        <h2 class="text-xl font-bold mb-4">Payment Methods</h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div class="p-4 border border-green-200 rounded-lg">
                <div class="flex justify-between items-center mb-4">
                    <h3 class="font-semibold">Bank Transfer</h3>
                    <svg class="w-8 h-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"/>
                    </svg>
                </div>
                <p class="text-sm text-gray-600">Account ending in 1234</p>
            </div>
            <div class="p-4 border border-green-200 rounded-lg">
                <div class="flex justify-between items-center mb-4">
                    <h3 class="font-semibold">Credit Card</h3>
                    <svg class="w-8 h-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"/>
                    </svg>
                </div>
                <p class="text-sm text-gray-600">Card ending in 5678</p>
            </div>
            <div class="p-4 border border-green-200 rounded-lg">
                <button class="w-full h-full flex items-center justify-center text-green-600 hover:text-green-700">
                    <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                    </svg>
                    Add Payment Method
                </button>
            </div>
        </div>
    </div>
    <br><br>
     <!-- Payment Table -->
    <div class="bg-white rounded-lg border border-green-200 overflow-hidden mb-8">
        <div class="p-4 border-b border-green-200">
            <h2 class="text-xl font-bold">Wholesaler Payments</h2>
        </div>
        <div class="overflow-x-auto">
            <table class="w-full">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Order ID</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Wholesaler Name</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Amount</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Due Date</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Status</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-green-200">

<%
    try (Connection conn = PostgresConnection.getConnection()){
    	String paysql = "SELECT order_id,  wholesaler_name, amount, due_date, payment_status FROM retailer.invoice  WHERE retailer_id = ? AND  payment_status IN('Unpaid', 'Overdue') ";
         PreparedStatement payps = conn.prepareStatement(paysql);
         payps.setInt(1, loginId);
         ResultSet payrs = payps.executeQuery();

        while (payrs.next()) {
%>
    <tr>
        <td class="px-6 py-4 whitespace-nowrap">#ORD<%= payrs.getInt("order_id") %></td>
        <td class="px-6 py-4"><%= payrs.getString("wholesaler_name") %></td>
        <td class="px-6 py-4">RS.<%= payrs.getDouble("amount") %></td>
        <td class="px-6 py-4"><%= payrs.getString("due_date") %></td>
       
        <td class="px-6 py-4">
            <span class="px-2 py-1 
                <%= payrs.getString("payment_status").equals("Unpaid") ? "bg-yellow-100 text-yellow-800" :
                	payrs.getString("payment_status").equals("Paid") ? "bg-green-100 text-green-800" :
                     "bg-red-100 text-red-800" %> rounded">
                <%= payrs.getString("payment_status") %>
            </span>
        </td>
        <td class="px-6 py-4">
            <div class="flex gap-2">
            <a href="Pay-Slip.jsp?payId=<%= payrs.getInt("order_id") %>">
                <button class="text-blue-600 hover:text-blue-800">View</button>
                </a>
                <% if (payrs.getString("payment_status").equals("Unpaid")) { %>
               <a href="payment-gateway/select-payment.jsp?Orderid=<%= payrs.getInt("order_id") %>"> <button class="text-red-600 hover:text-red-800">Pay</button></a>
                 <% } %>
                <% if (payrs.getString("payment_status").equals("Overdue")) { %>
                    <button class="text-red-600 hover:text-red-800">Send Reminder</button>
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
        <div class="p-4 border-t border-green-200 flex justify-between items-center">
            <div class="text-sm text-gray-500">Showing 1 to 3 of 45 entries</div>
            <div class="flex gap-2">
                <button class="px-3 py-1 border border-green-200 rounded-lg hover:bg-green-50">Previous</button>
                <button class="px-3 py-1 bg-green-500 text-white rounded-lg">1</button>
                <button class="px-3 py-1 border border-green-200 rounded-lg hover:bg-green-50">2</button>
                <button class="px-3 py-1 border border-green-200 rounded-lg hover:bg-green-50">3</button>
                <button class="px-3 py-1 border border-green-200 rounded-lg hover:bg-green-50">Next</button>
            </div>
        </div>
    </div>
    
</section></element><element id="596888f1-b649-4a98-a99f-c5fa410d6032" data-section-id="596888f1-b649-4a98-a99f-c5fa410d6032">

<section id="wholesaling-demand" class="p-6">
    <!-- Header -->
    <div class="flex justify-between items-center mb-8 border-b border-green-200 pb-4">
        <h1 class="text-2xl font-bold text-gray-800">Demand & Feedback Analysis</h1>
        <div class="flex gap-4">
        <a href="report.html">
            <button class="px-4 py-2 bg-green-500 text-white rounded-lg hover:bg-green-600">
                Generate Report
            </button>
            </a>
        </div>
    </div>

    <!-- Demand Overview Cards -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
        <div class="p-6 bg-white rounded-lg border border-green-200">
            <h3 class="text-gray-500 text-sm mb-2">Total Feedback</h3>
            <p class="text-2xl font-bold">${totalFeedback}</p>
            <div class="mt-2 text-sm text-green-600">+15% from last month</div>
        </div>
        <div class="p-6 bg-white rounded-lg border border-green-200">
            <h3 class="text-gray-500 text-sm mb-2">Average Rating</h3>
            <p class="text-2xl font-bold">${averageRating}</p>
            <div class="mt-2 text-sm text-yellow-600">Based on ${totalFeedback} reviews</div>
        </div>
        <div class="p-6 bg-white rounded-lg border border-green-200">
            <h3 class="text-gray-500 text-sm mb-2">Product Requests</h3>
            <p class="text-2xl font-bold">${totalOrders}</p>
            <div class="mt-2 text-sm text-blue-600">New requests</div>
        </div>
        <div class="p-6 bg-white rounded-lg border border-green-200">
            <h3 class="text-gray-500 text-sm mb-2">Improvement Suggestions</h3>
            <p class="text-2xl font-bold">${improvementSuggestions}</p>
            <div class="mt-2 text-sm text-purple-600">Pending review</div>
        </div>
    </div>

    <!-- Most Demanded Products -->
    <div class="bg-white rounded-lg border border-green-200 p-6 mb-8">
        <h2 class="text-xl font-bold mb-6">Most Demanded Products</h2>
        <div class="overflow-x-auto">
            <table class="w-full">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Product Name</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Demand Count</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Current Stock</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Status</th>
                        
                    </tr>
                </thead>
                <tbody class="divide-y divide-green-200">
                    <%
    try (Connection conn = PostgresConnection.getConnection()){
    	String demandsql = "SELECT product_name, current_stock, status, demand_count FROM retailer.demand WHERE retailer_id = ?";
         PreparedStatement ps = conn.prepareStatement(demandsql);
         ps.setInt(1, loginId);
         ResultSet rs_demand = ps.executeQuery();

        while (rs_demand.next()) {
%>
    <tr>
        <td class="px-6 py-4"><%= rs_demand.getString("product_name") %></td>
        <td class="px-6 py-4"><%= rs_demand.getInt("demand_count") %></td>
        <td class="px-6 py-4"><%= rs_demand.getInt("current_stock") %></td>
        <td class="px-6 py-4">
            <span class="px-2 py-1 
                <%= rs_demand.getString("status").equals("High Demand") ? "bg-red-100 text-red-800" :
                	rs_demand.getString("status").equals("Moderate") ? "bg-yellow-100 text-yellow-800" :
                     "bg-green-100 text-green-800" %> rounded">
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

   
   
   
   <%-- <!-- Recent Feedback -->
    <div class="bg-white rounded-lg border border-green-200 p-6 mb-8">
    <h2 class="text-xl font-bold mb-6">Recent Feedback</h2>
    <div class="space-y-6">
        <% 
        try (Connection conn = PostgresConnection.getConnection()){
        	String feedback = "SELECT  f.feedback_text, f.rating, f.feedback_date, c.customer_name FROM wholeseller.feedback f JOIN wholeseller.customer c ON f.customer_id = c.customer_id WHERE f.wholeseller_id = ? ORDER BY f.feedback_date DESC LIMIT 5 ";
             PreparedStatement ps = conn.prepareStatement(feedback);
             ps.setInt(1, loginId);
             ResultSet rs_feedback = ps.executeQuery();

            while (rs_feedback.next()) {
        %>
        <div class="border-b border-green-200 pb-6">
            <div class="flex justify-between items-start mb-2">
                <div>
                    <h3 class="font-semibold"><%= rs_feedback.getString("customer_name") %></h3>
                    <div class="flex items-center text-yellow-400">
                        <% for (int i = 0; i < rs_feedback.getInt("rating"); i++) { %>
                            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                            </svg>
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

 --%>
    <!-- Feedback Form -->
    
<%
    Map<Integer, String> orderproductMap = new LinkedHashMap<>();
    String selectedorder = request.getParameter("ProductName"); 
    int selectedorderID = -1;
    if (selectedorder != null && !selectedorder.isEmpty()) {
        try {
            selectedorderID = Integer.parseInt(selectedorder);
        } catch (NumberFormatException e) {
            selectedorderID = -1; // fallback in case of bad input
        }
    }
%>


<div class="bg-white rounded-lg border border-green-200 p-6">
    <h2 class="text-xl font-bold mb-6">Submit Feedback</h2>
    <form class="space-y-6" action="/Supply-chain-and-Logistic/FeedbackServlet" method="post">
        <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">Select Product</label>
            <select class="w-full px-4 py-2 rounded-lg border border-green-200 focus:outline-none focus:ring-2 focus:ring-green-400 focus:border-green-400" name="ProductName">
                <option value="">-- Select Product --</option>
                <%
                    try (Connection conn = PostgresConnection.getConnection()) {
                        String orderselectsql = "SELECT my_order_id , product_name FROM retailer.my_orders WHERE retailer_id = ? AND order_status = 'Delivered'";
                        PreparedStatement orderstmt = conn.prepareStatement(orderselectsql);
                        orderstmt.setInt(1, loginId); // Make sure loginId is in request/session
                        ResultSet orderstrs = orderstmt.executeQuery();

                        while (orderstrs.next()) {
                            int orderId = orderstrs.getInt("my_order_id");
                            
                            String productName = orderstrs.getString("product_name");
                            String label = "#ORD" + orderId + " - " + productName;
                %>
                    <option value="<%= orderId %>" <%= (selectedorderID == orderId) ? "selected" : "" %>><%= label %></option>
                <%
                        }
                    }
                %>
            </select>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">Subject</label>
            <input type="text" class="w-full px-4 py-2 rounded-lg border border-green-200 focus:outline-none focus:border-green-400" name="Subjectstr">
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">Message</label>
            <textarea rows="4" class="w-full px-4 py-2 rounded-lg border border-green-200 focus:outline-none focus:border-green-400" name="textareamsg"></textarea>
        </div>
        
        <div class="mt-4">
  <label class="block text-sm font-medium text-gray-700 mb-2">Rating <span class="text-red-600">*</span></label>
  <div class="flex space-x-2 cursor-pointer select-none" id="starRating" aria-label="Star rating" role="radiogroup">
    <span data-value="1" class="star text-6xl" role="radio" aria-checked="false" tabindex="0">&#9733;</span>
    <span data-value="2" class="star text-6xl" role="radio" aria-checked="false" tabindex="-1">&#9733;</span>
    <span data-value="3" class="star text-6xl" role="radio" aria-checked="false" tabindex="-1">&#9733;</span>
    <span data-value="4" class="star text-6xl" role="radio" aria-checked="false" tabindex="-1">&#9733;</span>
    <span data-value="5" class="star text-6xl" role="radio" aria-checked="false" tabindex="-1">&#9733;</span>
  </div>
  <input type="hidden" name="rating" id="ratingInput" value="" required>
  <p id="ratingError" class="text-red-600 mt-1 hidden">Please select a rating.</p>
</div>

<style>
  .star {
    color: #d1d5db; /* gray-300 */
    user-select: none;
    transition: color 0.3s ease;
  }
  .star.filled {
    color: #22c55e; /* green-500 */
  }
</style>

<script>
  const stars = document.querySelectorAll('#starRating .star');
  const ratingInput = document.getElementById('ratingInput');
  const ratingError = document.getElementById('ratingError');

  stars.forEach((star, idx) => {
    star.addEventListener('click', () => selectRating(idx));
    star.addEventListener('keydown', (e) => {
      if (e.key === 'Enter' || e.key === ' ') {
        e.preventDefault();
        selectRating(idx);
      }
    });
  });

  function selectRating(index) {
    ratingInput.value = index + 1;
    ratingError.classList.add('hidden');
    animateStars(index);
  }

  function animateStars(targetIndex) {
    stars.forEach(star => star.classList.remove('filled'));
    
    let current = -1;
    const interval = setInterval(() => {
      if (current === targetIndex) {
        clearInterval(interval);
        updateAria(targetIndex);
        return;
      }
      current++;
      stars[current].classList.add('filled');
      updateAria(current);
    }, 200);
  }

  function updateAria(selectedIndex) {
    stars.forEach((star, idx) => {
      star.setAttribute('aria-checked', idx === selectedIndex ? 'true' : 'false');
      star.tabIndex = idx === selectedIndex ? 0 : -1;
    });
  }

  document.querySelector('form').addEventListener('submit', (e) => {
    if (!ratingInput.value) {
      e.preventDefault();
      ratingError.classList.remove('hidden');
      ratingInput.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }
  });
</script>
        

        <button type="submit" class="px-6 py-2 bg-green-500 text-white rounded-lg hover:bg-green-600">Submit Feedback</button>
    </form>
</div>
</section></element>
            <div id="page_complete">
            <script>
                console.log('Page complete');
            </script>
            </body>
            </html>
          