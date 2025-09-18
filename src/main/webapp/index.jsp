<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
   <head>
      <meta charset="UTF-8">
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta name="theme-color" content="#ffffff">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- Removed duplicate and empty meta tags -->
<meta name="robots" content="index, follow">

<link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;0,800;1,300;1,400;1,500;1,600;1,700;1,800&display=swap" rel="stylesheet">

<title>SupplyChain Pro - Comprehensive Supply Chain & Logistics Management System</title>

<!-- Header Scripts -->
<script id="header-scripts">
  // This script tag will be replaced with actual scripts.head content
  if (window.scripts && window.scripts.head) {
    document.getElementById('header-scripts').outerHTML = window.scripts.head;
  }
</script>

      <script type="application/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.8/handlebars.min.js"></script>

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
                  DEFAULT: '#1E3A8A',
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
                  DEFAULT: '#10B981',
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
                sans: ['Roboto, sans-serif', 'Inter', 'system-ui', '-apple-system', 'BlinkMacSystemFont', 'Segoe UI', 'Helvetica Neue', 'Arial', 'sans-serif'],
                heading: ['Open Sans, sans-serif', 'Inter', 'system-ui', 'sans-serif'],
                body: ['Open Sans, sans-serif', 'Inter', 'system-ui', 'sans-serif'],
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
            integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />
   </head>
   <body class="antialiased text-gray-800 min-h-screen flex flex-col">
      
<div id="root">
  <header id="header" class="bg-white dark:bg-neutral-900 shadow-md">
    <nav class="container mx-auto px-4 py-4">
      <div class="flex justify-between items-center">
        <!-- Logo -->
        <div class="flex items-center">
          <a href="#" class="text-2xl font-bold text-primary dark:text-white">
            <span class="text-[#1E3A8A] dark:text-[#10B981]">Logi</span><span class="text-[#10B981]">Chain</span>
          </a>
        </div>
        
        <!-- Desktop Navigation -->
        <div class="hidden md:flex space-x-6">
          <a href="#" class="text-gray-700 hover:text-[#1E3A8A] dark:text-gray-300 dark:hover:text-[#10B981] transition-colors">Home</a>
          <a href="#features" class="text-gray-700 hover:text-[#1E3A8A] dark:text-gray-300 dark:hover:text-[#10B981] transition-colors">Features</a>
          <a href="#userRoles" class="text-gray-700 hover:text-[#1E3A8A] dark:text-gray-300 dark:hover:text-[#10B981] transition-colors">User Roles</a>
          <a href="#systemBenefits" class="text-gray-700 hover:text-[#1E3A8A] dark:text-gray-300 dark:hover:text-[#10B981] transition-colors">Benefits</a>
          
          <a href="#faq" class="text-gray-700 hover:text-[#1E3A8A] dark:text-gray-300 dark:hover:text-[#10B981] transition-colors">FAQ</a>
          <a href="#contact" class="text-gray-700 hover:text-[#1E3A8A] dark:text-gray-300 dark:hover:text-[#10B981] transition-colors">Contact</a>
        </div>
        
        <!-- Auth Buttons & Theme Toggle -->
        <div class="hidden md:flex items-center space-x-4">
          <button id="theme-toggle" aria-label="Toggle Theme" class="p-2 rounded-full bg-gray-100 dark:bg-neutral-800 text-gray-700 dark:text-gray-300">
            <!-- Sun icon for dark mode -->
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 hidden dark:block" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z" />
            </svg>
            <!-- Moon icon for light mode -->
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 block dark:hidden" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z" />
            </svg>
          </button>
          <a href="All_login.jsp" class="px-4 py-2 text-gray-700 hover:text-[#1E3A8A] dark:text-gray-300 dark:hover:text-[#10B981] border border-gray-300 dark:border-gray-700 rounded-md transition-colors">Login</a>
          <a href="transport/CMT_signup.html" class="px-4 py-2 bg-[#1E3A8A] hover:bg-[#152a65] text-white dark:bg-[#10B981] dark:hover:bg-[#0e9d6d] rounded-md transition-colors">Sign Up</a>
        </div>
        
        
      </div>
      
    
    </nav>
  </header>
</div>

<script>

  
  // Theme toggle functionality
  function setupThemeToggle(buttonId) {
    const toggleButton = document.getElementById(buttonId);
    const sunIcon = toggleButton.querySelector("svg:first-of-type");
    const moonIcon = toggleButton.querySelector("svg:last-of-type");

    // Check saved theme or system preference
    let storedTheme = localStorage.getItem('theme');
    let prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
    
    if (storedTheme === 'dark' || (!storedTheme && prefersDark)) {
        document.documentElement.classList.add('dark');
        sunIcon.classList.remove("hidden");
        moonIcon.classList.add("hidden");
    } else {
        document.documentElement.classList.remove('dark');
        sunIcon.classList.add("hidden");
        moonIcon.classList.remove("hidden");
    }

    // Toggle theme on button click
    toggleButton.addEventListener('click', () => {
        const isDark = document.documentElement.classList.toggle('dark');
        localStorage.setItem('theme', isDark ? 'dark' : 'light');

        // Toggle icons
        sunIcon.classList.toggle("hidden", !isDark);
        moonIcon.classList.toggle("hidden", isDark);
    });
}

// Initialize the theme toggle button
setupThemeToggle('theme-toggle');

</script>

</element><element id="ed0fb92e-d18c-4c60-b338-64216b9c11d4" data-section-id="ed0fb92e-d18c-4c60-b338-64216b9c11d4">


<div id="root">
  <section id="hero" class="bg-gradient-to-br from-blue-50 to-blue-100 dark:from-neutral-900 dark:to-neutral-800 py-16 md:py-24">
    <div class="container mx-auto px-4">
      <div class="flex flex-col md:flex-row items-center">
        <div class="md:w-1/2 mb-10 md:mb-0">
          <h1 class="text-4xl md:text-5xl lg:text-6xl font-bold text-blue-900 dark:text-white mb-4 leading-tight">
            Streamline Your <span class="text-emerald-600">Supply Chain</span> Operations
          </h1>
          <p class="text-lg md:text-xl text-gray-700 dark:text-gray-300 mb-8">
            A powerful, integrated platform connecting every stakeholder in your logistics ecosystem - from suppliers to retailers and everyone in between.
          </p>
          <div class="flex flex-wrap gap-4">
            <a href="#signup" class="px-6 py-3 bg-blue-800 hover:bg-blue-900 text-white rounded-lg transition-colors duration-300 shadow-lg hover:shadow-xl font-medium text-center">
              Get Started
            </a>
            <a href="#features" class="px-6 py-3 bg-white dark:bg-neutral-800 border border-blue-300 dark:border-neutral-700 hover:border-blue-400 dark:hover:border-neutral-600 text-blue-800 dark:text-emerald-500 rounded-lg transition-colors duration-300 shadow-md hover:shadow-lg font-medium text-center">
              Explore Features
            </a>
          </div>
        </div>
        
        <div class="md:w-1/2 relative">
          <div class="bg-white dark:bg-neutral-800 rounded-xl shadow-2xl overflow-hidden p-4 md:p-6 transform md:rotate-1 hover:rotate-0 transition-transform duration-500">
            <div class="relative">
              <!-- Supply Chain Dashboard Illustration -->
              <div class="aspect-w-16 aspect-h-9 bg-gradient-to-r from-blue-100 to-blue-50 dark:from-neutral-800 dark:to-neutral-700 rounded-lg overflow-hidden">
                <div class="absolute inset-0 flex items-center justify-center">
                  <div class="w-full h-full p-4">
                    <!-- Interactive Supply Chain Visualization -->
                    <div class="relative h-full flex items-center justify-between px-4">
                      <!-- Supply Chain Flow Illustration -->
                      <div class="flex flex-col items-center space-y-2">
                        <div class="w-16 h-16 bg-emerald-100 dark:bg-emerald-900/30 rounded-full flex items-center justify-center">
                          <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-emerald-600" viewBox="0 0 20 20" fill="currentColor">
                            <path d="M8 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM15 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0z" />
                            <path d="M3 4a1 1 0 00-1 1v10a1 1 0 001 1h1.05a2.5 2.5 0 014.9 0H10a1 1 0 001-1v-5h2.5l2.143-4.35A1 1 0 0014.7 5H5a1 1 0 00-1 1v1H3a1 1 0 00-1 1v3a1 1 0 001 1h1v4a1 1 0 00.806.98l1.98-3.042A2 2 0 015 13V8h1V6a1 1 0 011-1h5.5l-.424.851A2 2 0 0111.5 7H8a1 1 0 00-1 1v4a1 1 0 001 1h3.054a2.5 2.5 0 014.896 0H17a1 1 0 001-1v-5a1 1 0 00-1-1h-1V8a1 1 0 00-1-1h-1.5v2H12v-1a1 1 0 00-1-1H9v3h2a1 1 0 001-1v-1h1v3H9a1 1 0 00-1 1v2h5.05a2.5 2.5 0 014.9 0H19a1 1 0 001-1V5a1 1 0 00-1-1h-1a1 1 0 00-1 1v3h-1V4a1 1 0 00-1-1H3z" />
                          </svg>
                        </div>
                        <span class="text-sm font-medium text-gray-700 dark:text-gray-300">Supplier</span>
                      </div>
                      
                      <div class="h-0.5 w-full bg-blue-200 dark:bg-blue-900/30 absolute top-1/2 -translate-y-1/2 z-0"></div>
                      
                      <div class="flex flex-col items-center space-y-2 z-10">
                        <div class="w-16 h-16 bg-blue-100 dark:bg-blue-900/30 rounded-full flex items-center justify-center">
                          <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-blue-600" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M2 5a2 2 0 012-2h12a2 2 0 012 2v10a2 2 0 01-2 2H4a2 2 0 01-2-2V5zm2 1a1 1 0 011-1h1a1 1 0 011 1v1a1 1 0 01-1 1H5a1 1 0 01-1-1V6zm0 3a1 1 0 011-1h1a1 1 0 011 1v1a1 1 0 01-1 1H5a1 1 0 01-1-1V9zm0 3a1 1 0 011-1h1a1 1 0 011 1v1a1 1 0 01-1 1H5a1 1 0 01-1-1v-1zm5-6a1 1 0 011-1h1a1 1 0 011 1v1a1 1 0 01-1 1h-1a1 1 0 01-1-1V6zm0 3a1 1 0 011-1h1a1 1 0 011 1v1a1 1 0 01-1 1h-1a1 1 0 01-1-1V9zm0 3a1 1 0 011-1h1a1 1 0 011 1v1a1 1 0 01-1 1h-1a1 1 0 01-1-1v-1zm5-6a1 1 0 011-1h1a1 1 0 011 1v1a1 1 0 01-1 1h-1a1 1 0 01-1-1V6zm0 3a1 1 0 011-1h1a1 1 0 011 1v1a1 1 0 01-1 1h-1a1 1 0 01-1-1V9zm0 3a1 1 0 011-1h1a1 1 0 011 1v1a1 1 0 01-1 1h-1a1 1 0 01-1-1v-1z" clip-rule="evenodd" />
                          </svg>
                        </div>
                        <span class="text-sm font-medium text-gray-700 dark:text-gray-300">Warehouse</span>
                      </div>
                      
                      <div class="flex flex-col items-center space-y-2">
                        <div class="w-16 h-16 bg-indigo-100 dark:bg-indigo-900/30 rounded-full flex items-center justify-center">
                          <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-indigo-600" viewBox="0 0 20 20" fill="currentColor">
                            <path d="M8 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM15 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0z" />
                            <path d="M3 4a1 1 0 00-1 1v10a1 1 0 001 1h1.05a2.5 2.5 0 014.9 0H10a1 1 0 001-1V5a1 1 0 00-1-1H3zM14 7a1 1 0 00-1 1v6.05A2.5 2.5 0 0115.95 16H17a1 1 0 001-1v-5a1 1 0 00-.293-.707l-2-2A1 1 0 0015 7h-1z" />
                          </svg>
                        </div>
                        <span class="text-sm font-medium text-gray-700 dark:text-gray-300">Retailer</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              
              <!-- Dashboard Controls Overlay -->
              <div class="absolute bottom-2 left-2 right-2 bg-white/90 dark:bg-neutral-900/90 backdrop-blur-sm p-2 rounded-lg shadow-md">
                <div class="flex items-center justify-between text-xs md:text-sm">
                  <div class="flex items-center space-x-2">
                    <div class="w-2 h-2 rounded-full bg-green-500"></div>
                    <span class="text-gray-800 dark:text-gray-200">System Online</span>
                  </div>
                  <div class="flex items-center space-x-1">
                    <span class="text-gray-500 dark:text-gray-400">Real-time tracking</span>
                    <div class="relative inline-block w-8 align-middle select-none">
                      <div class="block w-8 h-4 rounded-full bg-green-500"></div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            
            <div class="mt-4 grid grid-cols-3 gap-2">
              <div class="p-2 bg-gray-50 dark:bg-neutral-700 rounded-lg">
                <div class="text-xs text-gray-500 dark:text-gray-400">Active Orders</div>
                <div class="text-lg font-semibold text-gray-900 dark:text-white">214</div>
              </div>
              <div class="p-2 bg-gray-50 dark:bg-neutral-700 rounded-lg">
                <div class="text-xs text-gray-500 dark:text-gray-400">Avg. Time</div>
                <div class="text-lg font-semibold text-gray-900 dark:text-white">3.5d</div>
              </div>
              <div class="p-2 bg-gray-50 dark:bg-neutral-700 rounded-lg">
                <div class="text-xs text-gray-500 dark:text-gray-400">Efficiency</div>
                <div class="text-lg font-semibold text-gray-900 dark:text-white">97%</div>
              </div>
            </div>
          </div>
          
          <!-- Decorative elements -->
          <div class="absolute -top-6 -right-6 w-12 h-12 bg-yellow-400 dark:bg-yellow-600 rounded-full opacity-70 dark:opacity-50 blur-sm"></div>
          <div class="absolute -bottom-4 -left-4 w-16 h-16 bg-emerald-400 dark:bg-emerald-600 rounded-full opacity-70 dark:opacity-50 blur-sm"></div>
        </div>
      </div>
      
      <!-- Trust Badges -->
      <div class="mt-16 md:mt-24">
        <p class="text-center text-gray-600 dark:text-gray-400 mb-6 uppercase tracking-wider text-sm font-medium">Trusted by industry leaders</p>
        <div class="flex flex-wrap justify-center gap-8 md:gap-12">
          <div class="w-24 h-12 bg-white dark:bg-neutral-800 rounded-md flex items-center justify-center">
            <div class="text-gray-400 dark:text-gray-500 font-bold">COMPANY</div>
          </div>
          <div class="w-24 h-12 bg-white dark:bg-neutral-800 rounded-md flex items-center justify-center">
            <div class="text-gray-400 dark:text-gray-500 font-bold">BRAND</div>
          </div>
          <div class="w-24 h-12 bg-white dark:bg-neutral-800 rounded-md flex items-center justify-center">
            <div class="text-gray-400 dark:text-gray-500 font-bold">CORP</div>
          </div>
          <div class="w-24 h-12 bg-white dark:bg-neutral-800 rounded-md flex items-center justify-center">
            <div class="text-gray-400 dark:text-gray-500 font-bold">LOGISTICS</div>
          </div>
          <div class="w-24 h-12 bg-white dark:bg-neutral-800 rounded-md flex items-center justify-center">
            <div class="text-gray-400 dark:text-gray-500 font-bold">GLOBAL</div>
          </div>
        </div>
      </div>
    </div>
  </section>
</div>

</element><element id="64428b7b-0f2e-41b5-876c-ea2b9b600df2" data-section-id="64428b7b-0f2e-41b5-876c-ea2b9b600df2">


<div id="root">
  <section id="features" class="py-16 md:py-24 bg-white dark:bg-neutral-900">
    <div class="container mx-auto px-4">
      <div class="text-center mb-16">
        <h2 class="text-3xl md:text-4xl font-bold text-gray-900 dark:text-white mb-4">
          Powerful Supply Chain Management Features
        </h2>
        <p class="text-lg text-gray-600 dark:text-gray-400 max-w-3xl mx-auto">
          Our comprehensive platform integrates every aspect of your supply chain operations, providing real-time visibility and control from end to end.
        </p>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 mb-16">
        <!-- Feature 1 -->
        <div class="bg-blue-50 dark:bg-neutral-800 rounded-xl p-6 shadow-md hover:shadow-lg transition-shadow duration-300">
          <div class="w-14 h-14 bg-blue-100 dark:bg-blue-900/30 rounded-lg flex items-center justify-center mb-5">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-blue-600 dark:text-blue-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01" />
            </svg>
          </div>
          <h3 class="text-xl font-semibold text-gray-900 dark:text-white mb-3">Real-Time Inventory Management</h3>
          <p class="text-gray-600 dark:text-gray-400 mb-4">
            Track inventory levels across multiple locations in real-time. Set automated reorder points and receive alerts when stock is running low.
          </p>
          <ul class="space-y-2">
            <li class="flex items-center text-gray-600 dark:text-gray-400">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-green-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
              </svg>
              Automated stock monitoring
            </li>
            <li class="flex items-center text-gray-600 dark:text-gray-400">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-green-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
              </svg>
              Barcode & RFID integration
            </li>
            <li class="flex items-center text-gray-600 dark:text-gray-400">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-green-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
              </svg>
              Multi-location management
            </li>
          </ul>
        </div>

        <!-- Feature 2 -->
        <div class="bg-indigo-50 dark:bg-neutral-800 rounded-xl p-6 shadow-md hover:shadow-lg transition-shadow duration-300">
          <div class="w-14 h-14 bg-indigo-100 dark:bg-indigo-900/30 rounded-lg flex items-center justify-center mb-5">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-indigo-600 dark:text-indigo-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 12l3-3 3 3 4-4M8 21l4-4 4 4M3 4h18M4 4h16v12a1 1 0 01-1 1H5a1 1 0 01-1-1V4z" />
            </svg>
          </div>
          <h3 class="text-xl font-semibold text-gray-900 dark:text-white mb-3">Advanced Analytics & Forecasting</h3>
          <p class="text-gray-600 dark:text-gray-400 mb-4">
            Make data-driven decisions with powerful analytics. Forecast demand, identify trends, and optimize your supply chain.
          </p>
          <ul class="space-y-2">
            <li class="flex items-center text-gray-600 dark:text-gray-400">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-green-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
              </svg>
              Predictive demand forecasting
            </li>
            <li class="flex items-center text-gray-600 dark:text-gray-400">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-green-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
              </svg>
              Customizable dashboards
            </li>
            <li class="flex items-center text-gray-600 dark:text-gray-400">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-green-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
              </svg>
              Performance KPI monitoring
            </li>
          </ul>
        </div>

        <!-- Feature 3 -->
        <div class="bg-emerald-50 dark:bg-neutral-800 rounded-xl p-6 shadow-md hover:shadow-lg transition-shadow duration-300">
          <div class="w-14 h-14 bg-emerald-100 dark:bg-emerald-900/30 rounded-lg flex items-center justify-center mb-5">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-emerald-600 dark:text-emerald-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
            </svg>
          </div>
          <h3 class="text-xl font-semibold text-gray-900 dark:text-white mb-3">Secure Role-Based Access</h3>
          <p class="text-gray-600 dark:text-gray-400 mb-4">
            Control access to sensitive information with customizable permissions for each user role in your supply chain.
          </p>
          <ul class="space-y-2">
            <li class="flex items-center text-gray-600 dark:text-gray-400">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-green-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
              </svg>
              Role-based permissions
            </li>
            <li class="flex items-center text-gray-600 dark:text-gray-400">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-green-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
              </svg>
              Data encryption
            </li>
            <li class="flex items-center text-gray-600 dark:text-gray-400">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-green-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
              </svg>
              Audit logging
            </li>
          </ul>
        </div>

        <!-- Feature 4 -->
        <div class="bg-amber-50 dark:bg-neutral-800 rounded-xl p-6 shadow-md hover:shadow-lg transition-shadow duration-300">
          <div class="w-14 h-14 bg-amber-100 dark:bg-amber-900/30 rounded-lg flex items-center justify-center mb-5">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-amber-600 dark:text-amber-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
          </div>
          <h3 class="text-xl font-semibold text-gray-900 dark:text-white mb-3">Real-Time Tracking & Notifications</h3>
          <p class="text-gray-600 dark:text-gray-400 mb-4">
            Monitor shipments in real-time and receive instant notifications about delays, exceptions, or status changes.
          </p>
          <ul class="space-y-2">
            <li class="flex items-center text-gray-600 dark:text-gray-400">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-green-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
              </svg>
              GPS integration
            </li>
            <li class="flex items-center text-gray-600 dark:text-gray-400">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-green-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
              </svg>
              Custom alert thresholds
            </li>
            <li class="flex items-center text-gray-600 dark:text-gray-400">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-green-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
              </svg>
              Mobile notifications
            </li>
          </ul>
        </div>

        <!-- Feature 5 -->
        <div class="bg-purple-50 dark:bg-neutral-800 rounded-xl p-6 shadow-md hover:shadow-lg transition-shadow duration-300">
          <div class="w-14 h-14 bg-purple-100 dark:bg-purple-900/30 rounded-lg flex items-center justify-center mb-5">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-purple-600 dark:text-purple-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
            </svg>
          </div>
          <h3 class="text-xl font-semibold text-gray-900 dark:text-white mb-3">Automated Documentation</h3>
          <p class="text-gray-600 dark:text-gray-400 mb-4">
            Generate shipping documents, invoices, and customs forms automatically to streamline your paperwork process.
          </p>
          <ul class="space-y-2">
            <li class="flex items-center text-gray-600 dark:text-gray-400">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-green-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
              </svg>
              Digital document generation
            </li>
            <li class="flex items-center text-gray-600 dark:text-gray-400">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-green-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
              </svg>
              E-signature capability
            </li>
            <li class="flex items-center text-gray-600 dark:text-gray-400">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-green-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
              </svg>
              Compliance management
            </li>
          </ul>
        </div>

        <!-- Feature 6 -->
        <div class="bg-rose-50 dark:bg-neutral-800 rounded-xl p-6 shadow-md hover:shadow-lg transition-shadow duration-300">
          <div class="w-14 h-14 bg-rose-100 dark:bg-rose-900/30 rounded-lg flex items-center justify-center mb-5">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-rose-600 dark:text-rose-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z" />
            </svg>
          </div>
          <h3 class="text-xl font-semibold text-gray-900 dark:text-white mb-3">Integrated Financial Management</h3>
          <p class="text-gray-600 dark:text-gray-400 mb-4">
            Handle invoicing, payments, and financial reporting all within a single platform for streamlined operations.
          </p>
          <ul class="space-y-2">
            <li class="flex items-center text-gray-600 dark:text-gray-400">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-green-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
              </svg>
              Automated invoicing
            </li>
            <li class="flex items-center text-gray-600 dark:text-gray-400">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-green-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
              </svg>
              Payment processing
            </li>
            <li class="flex items-center text-gray-600 dark:text-gray-400">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-green-500 mr-2" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
              </svg>
              Financial reporting
            </li>
          </ul>
        </div>
      </div>

      <!-- Feature Highlight -->
      <div class="bg-gradient-to-r from-blue-600 to-indigo-700 dark:from-blue-900 dark:to-indigo-900 rounded-2xl overflow-hidden shadow-xl">
        <div class="flex flex-col md:flex-row">
          <div class="md:w-1/2 p-8 md:p-12">
            <div class="text-white dark:text-white mb-6">
              <h3 class="text-2xl md:text-3xl font-bold mb-4">End-to-End Supply Chain Visibility</h3>
              <p class="text-blue-100 dark:text-blue-200 mb-6">
                Our platform connects all participants in your supply chain, providing unprecedented visibility from manufacturing to final delivery.
              </p>
              <ul class="space-y-3">
                <li class="flex items-start">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-blue-300 mr-2 mt-0.5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                  </svg>
                  <span>Connect suppliers, manufacturers, warehouses, transporters, wholesalers, and retailers</span>
                </li>
                <li class="flex items-start">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-blue-300 mr-2 mt-0.5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                  </svg>
                  <span>Identify bottlenecks and resolve issues before they impact your business</span>
                </li>
                <li class="flex items-start">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-blue-300 mr-2 mt-0.5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                  </svg>
                  <span>Gain insights to optimize your entire supply chain operation</span>
                </li>
              </ul>
              <div class="mt-8">
                <a href="#userRoles" class="inline-block px-6 py-3 bg-white text-blue-700 font-medium rounded-lg hover:bg-blue-50 transition-colors duration-300">
                  Explore User Roles
                </a>
              </div>
            </div>
          </div>
          <div class="md:w-1/2 bg-blue-800 dark:bg-blue-950 p-8 md:p-12 flex items-center justify-center">
            <div class="relative w-full max-w-md">
              <div class="relative rounded-xl overflow-hidden shadow-2xl bg-white dark:bg-neutral-800 p-4">
                <div class="flex space-x-3 absolute top-2 left-2">
                  <div class="w-3 h-3 bg-red-500 rounded-full"></div>
                  <div class="w-3 h-3 bg-yellow-500 rounded-full"></div>
                  <div class="w-3 h-3 bg-green-500 rounded-full"></div>
                </div>
                <div class="mt-6">
                  <div class="mb-4 flex justify-between items-center">
                    <div class="text-sm font-medium text-gray-900 dark:text-white">Supply Chain Overview</div>
                    <div class="text-xs text-gray-500 dark:text-gray-400">Real-time</div>
                  </div>
                  <div class="w-full bg-gray-100 dark:bg-neutral-700 h-2 rounded-full mb-6">
                    <div class="bg-blue-600 dark:bg-blue-500 h-2 rounded-full" style="width: 85%"></div>
                  </div>
                  <div class="grid grid-cols-2 gap-4 mb-4">
                    <div class="bg-gray-50 dark:bg-neutral-700 p-3 rounded-lg">
                      <div class="text-xs text-gray-500 dark:text-gray-400">In Transit</div>
                      <div class="text-lg font-bold text-gray-900 dark:text-white">42</div>
                    </div>
                    <div class="bg-gray-50 dark:bg-neutral-700 p-3 rounded-lg">
                      <div class="text-xs text-gray-500 dark:text-gray-400">Delivered</div>
                      <div class="text-lg font-bold text-gray-900 dark:text-white">128</div>
                    </div>
                    <div class="bg-gray-50 dark:bg-neutral-700 p-3 rounded-lg">
                      <div class="text-xs text-gray-500 dark:text-gray-400">Pending</div>
                      <div class="text-lg font-bold text-gray-900 dark:text-white">16</div>
                    </div>
                    <div class="bg-gray-50 dark:bg-neutral-700 p-3 rounded-lg">
                      <div class="text-xs text-gray-500 dark:text-gray-400">Issues</div>
                      <div class="text-lg font-bold text-red-600 dark:text-red-400">3</div>
                    </div>
                  </div>
                  <div class="flex justify-between items-center text-sm">
                    <div class="text-gray-500 dark:text-gray-400">Status: Operational</div>
                    <div class="text-green-600 dark:text-green-400 flex items-center">
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                      </svg>
                      All Systems Go
                    </div>
                  </div>
                </div>
              </div>
              <!-- Decorative dots -->
              <div class="absolute -bottom-4 -right-4 w-24 h-24 bg-blue-400 dark:bg-blue-600 rounded-full opacity-20"></div>
              <div class="absolute -top-4 -left-4 w-16 h-16 bg-indigo-400 dark:bg-indigo-600 rounded-full opacity-20"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</div>

</element><element id="f0965331-8fc0-4516-860a-316037638c88" data-section-id="f0965331-8fc0-4516-860a-316037638c88">

<div id="root">
  <section id="userRoles" class="py-16 md:py-24 bg-gray-50 dark:bg-neutral-800">
    <div class="container mx-auto px-4">
      <div class="text-center mb-16">
        <h2 class="text-3xl md:text-4xl font-bold text-gray-900 dark:text-white mb-4">
          Tailored Solutions for Every Role
        </h2>
        <p class="text-lg text-gray-600 dark:text-gray-400 max-w-3xl mx-auto">
          Our platform provides specialized functionality for each stakeholder in your supply chain, ensuring everyone has the tools they need.
        </p>
      </div>

      <!-- Role Selection Tabs -->
      <div class="flex flex-wrap justify-center mb-12">
        <div class="flex flex-wrap justify-center w-full mb-10 space-x-2 space-y-2 sm:space-y-0">
          <button class="role-tab px-4 py-2 rounded-lg bg-blue-600 text-white" data-role="supplier">Supplier</button>
          <button class="role-tab px-4 py-2 rounded-lg bg-white text-gray-700 hover:bg-gray-100 dark:bg-neutral-700 dark:text-gray-200 dark:hover:bg-neutral-600" data-role="manufacturer">Manufacturer</button>
          <button class="role-tab px-4 py-2 rounded-lg bg-white text-gray-700 hover:bg-gray-100 dark:bg-neutral-700 dark:text-gray-200 dark:hover:bg-neutral-600" data-role="warehouse">Warehouse Manager</button>
          <button class="role-tab px-4 py-2 rounded-lg bg-white text-gray-700 hover:bg-gray-100 dark:bg-neutral-700 dark:text-gray-200 dark:hover:bg-neutral-600" data-role="transporter">Transporter</button>
          <button class="role-tab px-4 py-2 rounded-lg bg-white text-gray-700 hover:bg-gray-100 dark:bg-neutral-700 dark:text-gray-200 dark:hover:bg-neutral-600" data-role="wholesaler">Wholesaler</button>
          <button class="role-tab px-4 py-2 rounded-lg bg-white text-gray-700 hover:bg-gray-100 dark:bg-neutral-700 dark:text-gray-200 dark:hover:bg-neutral-600" data-role="retailer">Retailer</button>
          <button class="role-tab px-4 py-2 rounded-lg bg-white text-gray-700 hover:bg-gray-100 dark:bg-neutral-700 dark:text-gray-200 dark:hover:bg-neutral-600" data-role="accountant">Accountant</button>
        </div>
      </div>

      <!-- Role Content Panels -->
      <div class="role-content" id="supplier-content">
        <div class="flex flex-col lg:flex-row bg-white dark:bg-neutral-900 rounded-2xl shadow-lg overflow-hidden">
          <div class="lg:w-1/2 p-8 md:p-12">
            <div class="flex items-center mb-6">
              <div class="w-12 h-12 bg-blue-100 dark:bg-blue-900/50 rounded-lg flex items-center justify-center mr-4">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-blue-600 dark:text-blue-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 8h14M5 8a2 2 0 110-4h14a2 2 0 110 4M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4" />
                </svg>
              </div>
              <h3 class="text-2xl font-bold text-gray-900 dark:text-white">Supplier Portal</h3>
            </div>
            <p class="text-gray-600 dark:text-gray-400 mb-6">
              Streamline your inventory management, forecast demand, and build stronger relationships with your business partners through our dedicated supplier portal.
            </p>
            <ul class="space-y-4 mb-8">
              <li class="flex items-start">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-500 mr-3 mt-0.5" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
                <div>
                  <h4 class="font-medium text-gray-900 dark:text-white">Real-time Order Management</h4>
                  <p class="text-gray-600 dark:text-gray-400">Receive and process orders instantly with automated notifications and status tracking.</p>
                </div>
              </li>
              <li class="flex items-start">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-500 mr-3 mt-0.5" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
                <div>
                  <h4 class="font-medium text-gray-900 dark:text-white">Demand Forecasting</h4>
                  <p class="text-gray-600 dark:text-gray-400">Access predictive analytics to anticipate future orders and optimize your production schedule.</p>
                </div>
              </li>
              <li class="flex items-start">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-500 mr-3 mt-0.5" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
                <div>
                  <h4 class="font-medium text-gray-900 dark:text-white">Digital Documentation</h4>
                  <p class="text-gray-600 dark:text-gray-400">Generate and manage invoices, packing slips, and compliance documents automatically.</p>
                </div>
              </li>
            </ul>
            <div class="flex flex-wrap gap-4">
              <a href="#signup" class="px-6 py-3 bg-blue-600 hover:bg-blue-700 text-white font-medium rounded-lg transition-colors duration-300 flex items-center justify-center">
                Sign Up as Supplier
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 ml-2" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L12.586 11H5a1 1 0 110-2h7.586l-2.293-2.293a1 1 0 010-1.414z" clip-rule="evenodd" />
                </svg>
              </a>
              <a href="#pricing" class="px-6 py-3 bg-white hover:bg-gray-100 dark:bg-neutral-800 dark:hover:bg-neutral-700 text-blue-600 dark:text-blue-400 font-medium rounded-lg border border-blue-200 dark:border-neutral-700 transition-colors duration-300 flex items-center justify-center">
                View Pricing
              </a>
            </div>
          </div>
          <div class="lg:w-1/2 bg-gradient-to-br from-blue-50 to-indigo-50 dark:from-blue-900/20 dark:to-indigo-900/20 p-8 md:p-12 flex items-center justify-center">
            <div class="max-w-md">
              <div class="bg-white dark:bg-neutral-800 rounded-xl shadow-lg overflow-hidden">
                <div class="p-4 border-b border-gray-200 dark:border-neutral-700 flex justify-between items-center">
                  <div class="font-medium text-gray-900 dark:text-white">Supplier Dashboard</div>
                  <div class="flex space-x-2">
                    <div class="w-3 h-3 bg-red-500 rounded-full"></div>
                    <div class="w-3 h-3 bg-yellow-500 rounded-full"></div>
                    <div class="w-3 h-3 bg-green-500 rounded-full"></div>
                  </div>
                </div>
                <div class="p-6">
                  <div class="grid grid-cols-2 gap-4 mb-6">
                    <div class="bg-blue-50 dark:bg-blue-900/30 p-3 rounded-lg">
                      <div class="text-sm text-blue-700 dark:text-blue-400 font-medium">Active Orders</div>
                      <div class="text-2xl font-bold text-blue-900 dark:text-blue-200">24</div>
                    </div>
                    <div class="bg-green-50 dark:bg-green-900/30 p-3 rounded-lg">
                      <div class="text-sm text-green-700 dark:text-green-400 font-medium">On-time Delivery</div>
                      <div class="text-2xl font-bold text-green-900 dark:text-green-200">98%</div>
                    </div>
                  </div>
                  
                  <div class="mb-6">
                    <div class="flex justify-between mb-1">
                      <span class="text-sm font-medium text-gray-700 dark:text-gray-300">Inventory Status</span>
                      <span class="text-sm font-medium text-gray-700 dark:text-gray-300">76%</span>
                    </div>
                    <div class="w-full bg-gray-200 dark:bg-neutral-700 rounded-full h-2.5">
                      <div class="bg-blue-600 h-2.5 rounded-full" style="width: 76%"></div>
                    </div>
                  </div>
                  
                  <div class="bg-gray-50 dark:bg-neutral-700 rounded-lg p-4 mb-6">
                    <div class="text-sm font-medium text-gray-700 dark:text-gray-300 mb-3">Recent Orders</div>
                    <div class="space-y-3">
                      <div class="flex justify-between items-center">
                        <div class="flex items-center">
                          <div class="w-2 h-2 bg-green-500 rounded-full mr-2"></div>
                          <span class="text-sm text-gray-600 dark:text-gray-400">Order #38294</span>
                        </div>
                        <span class="text-sm text-gray-500 dark:text-gray-500">2 hours ago</span>
                      </div>
                      <div class="flex justify-between items-center">
                        <div class="flex items-center">
                          <div class="w-2 h-2 bg-yellow-500 rounded-full mr-2"></div>
                          <span class="text-sm text-gray-600 dark:text-gray-400">Order #38293</span>
                        </div>
                        <span class="text-sm text-gray-500 dark:text-gray-500">5 hours ago</span>
                      </div>
                      <div class="flex justify-between items-center">
                        <div class="flex items-center">
                          <div class="w-2 h-2 bg-blue-500 rounded-full mr-2"></div>
                          <span class="text-sm text-gray-600 dark:text-gray-400">Order #38290</span>
                        </div>
                        <span class="text-sm text-gray-500 dark:text-gray-500">Yesterday</span>
                      </div>
                    </div>
                  </div>
                  
                  <div class="flex justify-between items-center">
                    <button class="text-sm text-blue-600 dark:text-blue-400 hover:text-blue-700 dark:hover:text-blue-300">View All Orders</button>
                    <button class="text-sm px-3 py-1 bg-blue-600 hover:bg-blue-700 text-white rounded-md">Refresh</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="role-content hidden" id="manufacturer-content">
        <!-- Manufacturer content similar to supplier but with different details -->
        <div class="flex flex-col lg:flex-row bg-white dark:bg-neutral-900 rounded-2xl shadow-lg overflow-hidden">
          <div class="lg:w-1/2 p-8 md:p-12">
            <div class="flex items-center mb-6">
              <div class="w-12 h-12 bg-indigo-100 dark:bg-indigo-900/50 rounded-lg flex items-center justify-center mr-4">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-indigo-600 dark:text-indigo-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
                </svg>
              </div>
              <h3 class="text-2xl font-bold text-gray-900 dark:text-white">Manufacturer Portal</h3>
            </div>
            <p class="text-gray-600 dark:text-gray-400 mb-6">
              Optimize your production processes, manage raw materials, and coordinate with suppliers and distributors through our integrated manufacturing platform.
            </p>
            <ul class="space-y-4 mb-8">
              <li class="flex items-start">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-500 mr-3 mt-0.5" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
                <div>
                  <h4 class="font-medium text-gray-900 dark:text-white">Production Planning</h4>
                  <p class="text-gray-600 dark:text-gray-400">Schedule and optimize production runs based on real-time order data and inventory levels.</p>
                </div>
              </li>
              <li class="flex items-start">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-500 mr-3 mt-0.5" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
                <div>
                  <h4 class="font-medium text-gray-900 dark:text-white">Quality Control</h4>
                  <p class="text-gray-600 dark:text-gray-400">Track and manage quality metrics throughout the production process to ensure consistent output.</p>
                </div>
              </li>
              <li class="flex items-start">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-500 mr-3 mt-0.5" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
                <div>
                  <h4 class="font-medium text-gray-900 dark:text-white">Equipment Monitoring</h4>
                  <p class="text-gray-600 dark:text-gray-400">Monitor machine performance and schedule preventive maintenance to minimize downtime.</p>
                </div>
              </li>
            </ul>
            <div class="flex flex-wrap gap-4">
              <a href="#signup" class="px-6 py-3 bg-indigo-600 hover:bg-indigo-700 text-white font-medium rounded-lg transition-colors duration-300 flex items-center justify-center">
                Sign Up as Manufacturer
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 ml-2" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L12.586 11H5a1 1 0 110-2h7.586l-2.293-2.293a1 1 0 010-1.414z" clip-rule="evenodd" />
                </svg>
              </a>
              <a href="#pricing" class="px-6 py-3 bg-white hover:bg-gray-100 dark:bg-neutral-800 dark:hover:bg-neutral-700 text-indigo-600 dark:text-indigo-400 font-medium rounded-lg border border-indigo-200 dark:border-neutral-700 transition-colors duration-300 flex items-center justify-center">
                View Pricing
              </a>
            </div>
          </div>
          <div class="lg:w-1/2 bg-gradient-to-br from-indigo-50 to-purple-50 dark:from-indigo-900/20 dark:to-purple-900/20 p-8 md:p-12 flex items-center justify-center">
            <div class="max-w-md">
              <div class="bg-white dark:bg-neutral-800 rounded-xl shadow-lg overflow-hidden">
                <div class="p-4 border-b border-gray-200 dark:border-neutral-700 flex justify-between items-center">
                  <div class="font-medium text-gray-900 dark:text-white">Manufacturing Console</div>
                  <div class="flex space-x-2">
                    <div class="w-3 h-3 bg-red-500 rounded-full"></div>
                    <div class="w-3 h-3 bg-yellow-500 rounded-full"></div>
                    <div class="w-3 h-3 bg-green-500 rounded-full"></div>
                  </div>
                </div>
                <div class="p-6">
                  <div class="grid grid-cols-2 gap-4 mb-6">
                    <div class="bg-indigo-50 dark:bg-indigo-900/30 p-3 rounded-lg">
                      <div class="text-sm text-indigo-700 dark:text-indigo-400 font-medium">Production</div>
                      <div class="text-2xl font-bold text-indigo-900 dark:text-indigo-200">87%</div>
                    </div>
                    <div class="bg-green-50 dark:bg-green-900/30 p-3 rounded-lg">
                      <div class="text-sm text-green-700 dark:text-green-400 font-medium">Quality Rate</div>
                      <div class="text-2xl font-bold text-green-900 dark:text-green-200">99.2%</div>
                    </div>
                  </div>
                  
                  <div class="mb-6">
                    <div class="flex justify-between mb-1">
                      <span class="text-sm font-medium text-gray-700 dark:text-gray-300">Raw Materials</span>
                      <span class="text-sm font-medium text-gray-700 dark:text-gray-300">82%</span>
                    </div>
                    <div class="w-full bg-gray-200 dark:bg-neutral-700 rounded-full h-2.5">
                      <div class="bg-indigo-600 h-2.5 rounded-full" style="width: 82%"></div>
                    </div>
                  </div>
                  
                  <div class="bg-gray-50 dark:bg-neutral-700 rounded-lg p-4 mb-6">
                    <div class="text-sm font-medium text-gray-700 dark:text-gray-300 mb-3">Production Lines</div>
                    <div class="space-y-3">
                      <div class="flex justify-between items-center">
                        <div class="flex items-center">
                          <div class="w-2 h-2 bg-green-500 rounded-full mr-2"></div>
                          <span class="text-sm text-gray-600 dark:text-gray-400">Line A</span>
                        </div>
                        <span class="text-sm text-green-500 dark:text-green-400">Active</span>
                      </div>
                      <div class="flex justify-between items-center">
                        <div class="flex items-center">
                          <div class="w-2 h-2 bg-green-500 rounded-full mr-2"></div>
                          <span class="text-sm text-gray-600 dark:text-gray-400">Line B</span>
                        </div>
                        <span class="text-sm text-green-500 dark:text-green-400">Active</span>
                      </div>
                      <div class="flex justify-between items-center">
                        <div class="flex items-center">
                          <div class="w-2 h-2 bg-yellow-500 rounded-full mr-2"></div>
                          <span class="text-sm text-gray-600 dark:text-gray-400">Line C</span>
                        </div>
                        <span class="text-sm text-yellow-500 dark:text-yellow-400">Maintenance</span>
                      </div>
                    </div>
                  </div>
                  
                  <div class="flex justify-between items-center">
                    <button class="text-sm text-indigo-600 dark:text-indigo-400 hover:text-indigo-700 dark:hover:text-indigo-300">Equipment Status</button>
                    <button class="text-sm px-3 py-1 bg-indigo-600 hover:bg-indigo-700 text-white rounded-md">Production Report</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="role-content hidden" id="warehouse-content">
        <!-- Warehouse Manager content -->
        <div class="flex flex-col lg:flex-row bg-white dark:bg-neutral-900 rounded-2xl shadow-lg overflow-hidden">
          <div class="lg:w-1/2 p-8 md:p-12">
            <div class="flex items-center mb-6">
              <div class="w-12 h-12 bg-green-100 dark:bg-green-900/50 rounded-lg flex items-center justify-center mr-4">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-600 dark:text-green-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 14v3m4-3v3m4-3v3M3 21h18M3 10h18M3 7l9-4 9 4M4 10h16v11H4V10z" />
                </svg>
              </div>
              <h3 class="text-2xl font-bold text-gray-900 dark:text-white">Warehouse Management</h3>
            </div>
            <p class="text-gray-600 dark:text-gray-400 mb-6">
              Efficiently manage your warehouse operations with powerful inventory control, order picking, and space utilization tools.
            </p>
            <ul class="space-y-4 mb-8">
              <li class="flex items-start">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-500 mr-3 mt-0.5" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
                <div>
                  <h4 class="font-medium text-gray-900 dark:text-white">Inventory Management</h4>
                  <p class="text-gray-600 dark:text-gray-400">Track stock levels, locations, and movements with barcode/RFID integration.</p>
                </div>
              </li>
              <li class="flex items-start">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-500 mr-3 mt-0.5" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
                <div>
                  <h4 class="font-medium text-gray-900 dark:text-white">Picking & Packing</h4>
                  <p class="text-gray-600 dark:text-gray-400">Optimize picking routes and packing processes to improve efficiency and accuracy.</p>
                </div>
              </li>
              <li class="flex items-start">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-500 mr-3 mt-0.5" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
                <div>
                  <h4 class="font-medium text-gray-900 dark:text-white">Space Utilization</h4>
                  <p class="text-gray-600 dark:text-gray-400">Maximize warehouse space with 3D visualization and optimization tools.</p>
                </div>
              </li>
            </ul>
            <div class="flex flex-wrap gap-4">
              <a href="#signup" class="px-6 py-3 bg-green-600 hover:bg-green-700 text-white font-medium rounded-lg transition-colors duration-300 flex items-center justify-center">
                Sign Up as Warehouse Manager
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 ml-2" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L12.586 11H5a1 1 0 110-2h7.586l-2.293-2.293a1 1 0 010-1.414z" clip-rule="evenodd" />
                </svg>
              </a>
              <a href="#pricing" class="px-6 py-3 bg-white hover:bg-gray-100 dark:bg-neutral-800 dark:hover:bg-neutral-700 text-green-600 dark:text-green-400 font-medium rounded-lg border border-green-200 dark:border-neutral-700 transition-colors duration-300 flex items-center justify-center">
                View Pricing
              </a>
            </div>
          </div>
          <div class="lg:w-1/2 bg-gradient-to-br from-green-50 to-emerald-50 dark:from-green-900/20 dark:to-emerald-900/20 p-8 md:p-12 flex items-center justify-center">
            <div class="max-w-md">
              <div class="bg-white dark:bg-neutral-800 rounded-xl shadow-lg overflow-hidden">
                <div class="p-4 border-b border-gray-200 dark:border-neutral-700 flex justify-between items-center">
                  <div class="font-medium text-gray-900 dark:text-white">Warehouse Dashboard</div>
                  <div class="flex space-x-2">
                    <div class="w-3 h-3 bg-red-500 rounded-full"></div>
                    <div class="w-3 h-3 bg-yellow-500 rounded-full"></div>
                    <div class="w-3 h-3 bg-green-500 rounded-full"></div>
                  </div>
                </div>
                <div class="p-6">
                  <div class="grid grid-cols-2 gap-4 mb-6">
                    <div class="bg-green-50 dark:bg-green-900/30 p-3 rounded-lg">
                      <div class="text-sm text-green-700 dark:text-green-400 font-medium">Capacity</div>
                      <div class="text-2xl font-bold text-green-900 dark:text-green-200">73%</div>
                    </div>
                    <div class="bg-amber-50 dark:bg-amber-900/30 p-3 rounded-lg">
                      <div class="text-sm text-amber-700 dark:text-amber-400 font-medium">Pick Rate</div>
                      <div class="text-2xl font-bold text-amber-900 dark:text-amber-200">98.5%</div>
                    </div>
                  </div>
                  
                  <div class="mb-6">
                    <div class="flex justify-between mb-1">
                      <span class="text-sm font-medium text-gray-700 dark:text-gray-300">Orders Processing</span>
                      <span class="text-sm font-medium text-gray-700 dark:text-gray-300">62%</span>
                    </div>
                    <div class="w-full bg-gray-200 dark:bg-neutral-700 rounded-full h-2.5">
                      <div class="bg-green-600 h-2.5 rounded-full" style="width: 62%"></div>
                    </div>
                  </div>
                  
                  <div class="bg-gray-50 dark:bg-neutral-700 rounded-lg p-4 mb-6">
                    <div class="text-sm font-medium text-gray-700 dark:text-gray-300 mb-3">Warehouse Zones</div>
                    <div class="space-y-3">
                      <div class="flex justify-between items-center">
                        <div class="flex items-center">
                          <div class="w-2 h-2 bg-red-500 rounded-full mr-2"></div>
                          <span class="text-sm text-gray-600 dark:text-gray-400">Zone A</span>
                        </div>
                        <span class="text-sm text-red-500 dark:text-red-400">92% Full</span>
                      </div>
                      <div class="flex justify-between items-center">
                        <div class="flex items-center">
                          <div class="w-2 h-2 bg-yellow-500 rounded-full mr-2"></div>
                          <span class="text-sm text-gray-600 dark:text-gray-400">Zone B</span>
                        </div>
                        <span class="text-sm text-yellow-500 dark:text-yellow-400">76% Full</span>
                      </div>
                      <div class="flex justify-between items-center">
                        <div class="flex items-center">
                          <div class="w-2 h-2 bg-green-500 rounded-full mr-2"></div>
                          <span class="text-sm text-gray-600 dark:text-gray-400">Zone C</span>
                        </div>
                        <span class="text-sm text-green-500 dark:text-green-400">42% Full</span>
                      </div>
                    </div>
                  </div>
                  
                  <div class="flex justify-between items-center">
                    <button class="text-sm text-green-600 dark:text-green-400 hover:text-green-700 dark:hover:text-green-300">Inventory Report</button>
                    <button class="text-sm px-3 py-1 bg-green-600 hover:bg-green-700 text-white rounded-md">Process Orders</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="role-content hidden" id="transporter-content">
        <!-- Transporter content -->
        <div class="flex flex-col lg:flex-row bg-white dark:bg-neutral-900 rounded-2xl shadow-lg overflow-hidden">
          <div class="lg:w-1/2 p-8 md:p-12">
            <div class="flex items-center mb-6">
              <div class="w-12 h-12 bg-amber-100 dark:bg-amber-900/50 rounded-lg flex items-center justify-center mr-4">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-amber-600 dark:text-amber-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path d="M9 17a2 2 0 11-4 0 2 2 0 014 0zM19 17a2 2 0 11-4 0 2 2 0 014 0z" />
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16V6a1 1 0 00-1-1H4a1 1 0 00-1 1v10a1 1 0 001 1h1m8-1a1 1 0 01-1 1H9m4-1V8a1 1 0 011-1h2.586a1 1 0 01.707.293l3.414 3.414a1 1 0 01.293.707V16a1 1 0 01-1 1h-1m-6-1a1 1 0 001 1h1M5 17a2 2 0 104 0m-4 0a2 2 0 114 0m6 0a2 2 0 104 0m-4 0a2 2 0 114 0" />
                </svg>
              </div>
              <h3 class="text-2xl font-bold text-gray-900 dark:text-white">Transporter Portal</h3>
            </div>
            <p class="text-gray-600 dark:text-gray-400 mb-6">
              Optimize your transportation operations with route planning, real-time tracking, and automated documentation.
            </p>
            <ul class="space-y-4 mb-8">
              <li class="flex items-start">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-500 mr-3 mt-0.5" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
                <div>
                  <h4 class="font-medium text-gray-900 dark:text-white">Route Optimization</h4>
                  <p class="text-gray-600 dark:text-gray-400">Plan the most efficient delivery routes with real-time traffic and weather data.</p>
                </div>
              </li>
              <li class="flex items-start">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-500 mr-3 mt-0.5" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
                <div>
                  <h4 class="font-medium text-gray-900 dark:text-white">Live Tracking</h4>
                  <p class="text-gray-600 dark:text-gray-400">Provide real-time delivery updates to customers and stakeholders.</p>
                </div>
              </li>
              <li class="flex items-start">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-500 mr-3 mt-0.5" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
                <div>
                  <h4 class="font-medium text-gray-900 dark:text-white">Electronic Proof of Delivery</h4>
                  <p class="text-gray-600 dark:text-gray-400">Capture signatures, photos, and notes digitally for immediate processing.</p>
                </div>
              </li>
            </ul>
            <div class="flex flex-wrap gap-4">
              <a href="#signup" class="px-6 py-3 bg-amber-600 hover:bg-amber-700 text-white font-medium rounded-lg transition-colors duration-300 flex items-center justify-center">
                Sign Up as Transporter
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 ml-2" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L12.586 11H5a1 1 0 110-2h7.586l-2.293-2.293a1 1 0 010-1.414z" clip-rule="evenodd" />
                </svg>
              </a>
              <a href="#pricing" class="px-6 py-3 bg-white hover:bg-gray-100 dark:bg-neutral-800 dark:hover:bg-neutral-700 text-amber-600 dark:text-amber-400 font-medium rounded-lg border border-amber-200 dark:border-neutral-700 transition-colors duration-300 flex items-center justify-center">
                View Pricing
              </a>
            </div>
          </div>
          <div class="lg:w-1/2 bg-gradient-to-br from-amber-50 to-orange-50 dark:from-amber-900/20 dark:to-orange-900/20 p-8 md:p-12 flex items-center justify-center">
            <div class="max-w-md">
              <div class="bg-white dark:bg-neutral-800 rounded-xl shadow-lg overflow-hidden">
                <div class="p-4 border-b border-gray-200 dark:border-neutral-700 flex justify-between items-center">
                  <div class="font-medium text-gray-900 dark:text-white">Transport Management</div>
                  <div class="flex space-x-2">
                    <div class="w-3 h-3 bg-red-500 rounded-full"></div>
                    <div class="w-3 h-3 bg-yellow-500 rounded-full"></div>
                    <div class="w-3 h-3 bg-green-500 rounded-full"></div>
                  </div>
                </div>
                <div class="p-6">
                  <div class="grid grid-cols-2 gap-4 mb-6">
                    <div class="bg-amber-50 dark:bg-amber-900/30 p-3 rounded-lg">
                      <div class="text-sm text-amber-700 dark:text-amber-400 font-medium">Fleet Status</div>
                      <div class="text-2xl font-bold text-amber-900 dark:text-amber-200">86%</div>
                    </div>
                    <div class="bg-green-50 dark:bg-green-900/30 p-3 rounded-lg">
                      <div class="text-sm text-green-700 dark:text-green-400 font-medium">On-time Rate</div>
                      <div class="text-2xl font-bold text-green-900 dark:text-green-200">94%</div>
                    </div>
                  </div>
                  
                  <div class="mb-6">
                    <div class="flex justify-between mb-1">
                      <span class="text-sm font-medium text-gray-700 dark:text-gray-300">Today's Deliveries</span>
                      <span class="text-sm font-medium text-gray-700 dark:text-gray-300">15/24</span>
                    </div>
                    <div class="w-full bg-gray-200 dark:bg-neutral-700 rounded-full h-2.5">
                      <div class="bg-amber-600 h-2.5 rounded-full" style="width: 62%"></div>
                    </div>
                  </div>
                  
                  <div class="bg-gray-50 dark:bg-neutral-700 rounded-lg p-4 mb-6 relative">
                    <div class="text-sm font-medium text-gray-700 dark:text-gray-300 mb-3">Active Vehicles</div>
                    <div class="space-y-3">
                      <div class="flex justify-between items-center">
                        <div class="flex items-center">
                          <div class="w-2 h-2 bg-green-500 rounded-full mr-2"></div>
                          <span class="text-sm text-gray-600 dark:text-gray-400">Truck #TX-42</span>
                        </div>
                        <span class="text-sm text-green-500 dark:text-green-400">En Route</span>
                      </div>
                      <div class="flex justify-between items-center">
                        <div class="flex items-center">
                          <div class="w-2 h-2 bg-blue-500 rounded-full mr-2"></div>
                          <span class="text-sm text-gray-600 dark:text-gray-400">Van #VN-18</span>
                        </div>
                        <span class="text-sm text-blue-500 dark:text-blue-400">Loading</span>
                      </div>
                      <div class="flex justify-between items-center">
                        <div class="flex items-center">
                          <div class="w-2 h-2 bg-yellow-500 rounded-full mr-2"></div>
                          <span class="text-sm text-gray-600 dark:text-gray-400">Truck #TX-37</span>
                        </div>
                        <span class="text-sm text-yellow-500 dark:text-yellow-400">Maintenance</span>
                      </div>
                    </div>
                    
                    <!-- Map overlay -->
                    <div class="absolute top-0 right-0 mt-4 mr-4">
                      <div class="w-6 h-6 bg-amber-100 dark:bg-amber-800 rounded-md flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-amber-600 dark:text-amber-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 20l-5.447-2.724A1 1 0 013 16.382V5.618a1 1 0 011.447-.894L9 7m0 13l6-3m-6 3V7m6 10l4.553 2.276A1 1 0 0021 18.382V7.618a1 1 0 00-.553-.894L15 4m0 13V4m0 0L9 7" />
                        </svg>
                      </div>
                    </div>
                  </div>
                  
                  <div class="flex justify-between items-center">
                    <button class="text-sm text-amber-600 dark:text-amber-400 hover:text-amber-700 dark:hover:text-amber-300">Fleet Overview</button>
                    <button class="text-sm px-3 py-1 bg-amber-600 hover:bg-amber-700 text-white rounded-md">Route Planner</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="role-content hidden" id="wholesaler-content">
        <!-- Wholesaler content -->
        <div class="flex flex-col lg:flex-row bg-white dark:bg-neutral-900 rounded-2xl shadow-lg overflow-hidden">
          <div class="lg:w-1/2 p-8 md:p-12">
            <div class="flex items-center mb-6">
              <div class="w-12 h-12 bg-purple-100 dark:bg-purple-900/50 rounded-lg flex items-center justify-center mr-4">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-purple-600 dark:text-purple-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                </svg>
              </div>
              <h3 class="text-2xl font-bold text-gray-900 dark:text-white">Wholesaler Platform</h3>
            </div>
            <p class="text-gray-600 dark:text-gray-400 mb-6">
              Manage bulk orders, pricing strategies, and distribution networks with a powerful wholesaler management system.
            </p>
            <ul class="space-y-4 mb-8">
              <li class="flex items-start">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-500 mr-3 mt-0.5" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
                <div>
                  <h4 class="font-medium text-gray-900 dark:text-white">Bulk Order Management</h4>
                  <p class="text-gray-600 dark:text-gray-400">Process and manage large volume orders with customizable pricing tiers.</p>
                </div>
              </li>
              <li class="flex items-start">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-500 mr-3 mt-0.5" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
                <div>
                  <h4 class="font-medium text-gray-900 dark:text-white">Customer Relationship Management</h4>
                  <p class="text-gray-600 dark:text-gray-400">Track customer preferences, order history, and communication in one place.</p>
                </div>
              </li>
              <li class="flex items-start">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-500 mr-3 mt-0.5" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
                <div>
                  <h4 class="font-medium text-gray-900 dark:text-white">Dynamic Pricing Tools</h4>
                  <p class="text-gray-600 dark:text-gray-400">Set tiered pricing strategies based on volume, customer type, and market conditions.</p>
                </div>
              </li>
            </ul>
            <div class="flex flex-wrap gap-4">
              <a href="#signup" class="px-6 py-3 bg-purple-600 hover:bg-purple-700 text-white font-medium rounded-lg transition-colors duration-300 flex items-center justify-center">
                Sign Up as Wholesaler
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 ml-2" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L12.586 11H5a1 1 0 110-2h7.586l-2.293-2.293a1 1 0 010-1.414z" clip-rule="evenodd" />
                </svg>
              </a>
              <a href="#pricing" class="px-6 py-3 bg-white hover:bg-gray-100 dark:bg-neutral-800 dark:hover:bg-neutral-700 text-purple-600 dark:text-purple-400 font-medium rounded-lg border border-purple-200 dark:border-neutral-700 transition-colors duration-300 flex items-center justify-center">
                View Pricing
              </a>
            </div>
          </div>
          <div class="lg:w-1/2 bg-gradient-to-br from-purple-50 to-indigo-50 dark:from-purple-900/20 dark:to-indigo-900/20 p-8 md:p-12 flex items-center justify-center">
            <div class="max-w-md">
              <div class="bg-white dark:bg-neutral-800 rounded-xl shadow-lg overflow-hidden">
                <div class="p-4 border-b border-gray-200 dark:border-neutral-700 flex justify-between items-center">
                  <div class="font-medium text-gray-900 dark:text-white">Wholesale Operations</div>
                  <div class="flex space-x-2">
                    <div class="w-3 h-3 bg-red-500 rounded-full"></div>
                    <div class="w-3 h-3 bg-yellow-500 rounded-full"></div>
                    <div class="w-3 h-3 bg-green-500 rounded-full"></div>
                  </div>
                </div>
                <div class="p-6">
                  <div class="grid grid-cols-2 gap-4 mb-6">
                    <div class="bg-purple-50 dark:bg-purple-900/30 p-3 rounded-lg">
                      <div class="text-sm text-purple-700 dark:text-purple-400 font-medium">Sales Volume</div>
                      <div class="text-2xl font-bold text-purple-900 dark:text-purple-200">$832K</div>
                    </div>
                    <div class="bg-blue-50 dark:bg-blue-900/30 p-3 rounded-lg">
                      <div class="text-sm text-blue-700 dark:text-blue-400 font-medium">Active Clients</div>
                      <div class="text-2xl font-bold text-blue-900 dark:text-blue-200">174</div>
                    </div>
                  </div>
                  
                  <div class="mb-6">
                    <div class="flex justify-between mb-1">
                      <span class="text-sm font-medium text-gray-700 dark:text-gray-300">Monthly Target</span>
                      <span class="text-sm font-medium text-gray-700 dark:text-gray-300">83%</span>
                    </div>
                    <div class="w-full bg-gray-200 dark:bg-neutral-700 rounded-full h-2.5">
                      <div class="bg-purple-600 h-2.5 rounded-full" style="width: 83%"></div>
                    </div>
                  </div>
                  
                  <div class="bg-gray-50 dark:bg-neutral-700 rounded-lg p-4 mb-6">
                    <div class="text-sm font-medium text-gray-700 dark:text-gray-300 mb-3">Top Products</div>
                    <div class="space-y-3">
                      <div class="flex justify-between items-center">
                        <div class="flex items-center">
                          <div class="w-2 h-2 bg-purple-500 rounded-full mr-2"></div>
                          <span class="text-sm text-gray-600 dark:text-gray-400">Product A</span>
                        </div>
                        <span class="text-sm text-gray-600 dark:text-gray-400">3,542 units</span>
                      </div>
                      <div class="flex justify-between items-center">
                        <div class="flex items-center">
                          <div class="w-2 h-2 bg-indigo-500 rounded-full mr-2"></div>
                          <span class="text-sm text-gray-600 dark:text-gray-400">Product B</span>
                        </div>
                        <span class="text-sm text-gray-600 dark:text-gray-400">2,854 units</span>
                      </div>
                      <div class="flex justify-between items-center">
                        <div class="flex items-center">
                          <div class="w-2 h-2 bg-blue-500 rounded-full mr-2"></div>
                          <span class="text-sm text-gray-600 dark:text-gray-400">Product C</span>
                        </div>
                        <span class="text-sm text-gray-600 dark:text-gray-400">1,927 units</span>
                      </div>
                    </div>
                  </div>
                  
                  <div class="flex justify-between items-center">
                    <button class="text-sm text-purple-600 dark:text-purple-400 hover:text-purple-700 dark:hover:text-purple-300">Sales Report</button>
                    <button class="text-sm px-3 py-1 bg-purple-600 hover:bg-purple-700 text-white rounded-md">Manage Orders</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="role-content hidden" id="retailer-content">
        <!-- Retailer content -->
        <div class="flex flex-col lg:flex-row bg-white dark:bg-neutral-900 rounded-2xl shadow-lg overflow-hidden">
          <div class="lg:w-1/2 p-8 md:p-12">
            <div class="flex items-center mb-6">
              <div class="w-12 h-12 bg-teal-100 dark:bg-teal-900/50 rounded-lg flex items-center justify-center mr-4">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-teal-600 dark:text-teal-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
                </svg>
              </div>
              <h3 class="text-2xl font-bold text-gray-900 dark:text-white">Retailer Portal</h3>
            </div>
            <p class="text-gray-600 dark:text-gray-400 mb-6">
              Streamline inventory management, order processing, and customer service with our dedicated retail solution.
            </p>
            <ul class="space-y-4 mb-8">
              <li class="flex items-start">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-500 mr-3 mt-0.5" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
                <div>
                  <h4 class="font-medium text-gray-900 dark:text-white">Inventory & POS Integration</h4>
                  <p class="text-gray-600 dark:text-gray-400">Seamless integration between your point-of-sale system and inventory management.</p>
                </div>
              </li>
              <li class="flex items-start">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-500 mr-3 mt-0.5" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
                <div>
                  <h4 class="font-medium text-gray-900 dark:text-white">Order Management</h4>
                  <p class="text-gray-600 dark:text-gray-400">Automate ordering process with smart reordering based on inventory levels and trends.</p>
                </div>
              </li>
              <li class="flex items-start">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-500 mr-3 mt-0.5" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
                <div>
                  <h4 class="font-medium text-gray-900 dark:text-white">Customer Insights</h4>
                  <p class="text-gray-600 dark:text-gray-400">Access customer purchase history and preferences to improve service and targeting.</p>
                </div>
              </li>
            </ul>
            <div class="flex flex-wrap gap-4">
              <a href="#signup" class="px-6 py-3 bg-teal-600 hover:bg-teal-700 text-white font-medium rounded-lg transition-colors duration-300 flex items-center justify-center">
                Sign Up as Retailer
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 ml-2" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L12.586 11H5a1 1 0 110-2h7.586l-2.293-2.293a1 1 0 010-1.414z" clip-rule="evenodd" />
                </svg>
              </a>
              <a href="#pricing" class="px-6 py-3 bg-white hover:bg-gray-100 dark:bg-neutral-800 dark:hover:bg-neutral-700 text-teal-600 dark:text-teal-400 font-medium rounded-lg border border-teal-200 dark:border-neutral-700 transition-colors duration-300 flex items-center justify-center">
                View Pricing
              </a>
            </div>
          </div>
          <div class="lg:w-1/2 bg-gradient-to-br from-teal-50 to-cyan-50 dark:from-teal-900/20 dark:to-cyan-900/20 p-8 md:p-12 flex items-center justify-center">
            <div class="max-w-md">
              <div class="bg-white dark:bg-neutral-800 rounded-xl shadow-lg overflow-hidden">
                <div class="p-4 border-b border-gray-200 dark:border-neutral-700 flex justify-between items-center">
                  <div class="font-medium text-gray-900 dark:text-white">Retail Management</div>
                  <div class="flex space-x-2">
                    <div class="w-3 h-3 bg-red-500 rounded-full"></div>
                    <div class="w-3 h-3 bg-yellow-500 rounded-full"></div>
                    <div class="w-3 h-3 bg-green-500 rounded-full"></div>
                  </div>
                </div>
                <div class="p-6">
                  <div class="grid grid-cols-2 gap-4 mb-6">
                    <div class="bg-teal-50 dark:bg-teal-900/30 p-3 rounded-lg">
                      <div class="text-sm text-teal-700 dark:text-teal-400 font-medium">Daily Sales</div>
                      <div class="text-2xl font-bold text-teal-900 dark:text-teal-200">$4,285</div>
                    </div>
                    <div class="bg-cyan-50 dark:bg-cyan-900/30 p-3 rounded-lg">
                      <div class="text-sm text-cyan-700 dark:text-cyan-400 font-medium">Transactions</div>
                      <div class="text-2xl font-bold text-cyan-900 dark:text-cyan-200">143</div>
                    </div>
                  </div>
                  
                  <div class="mb-6">
                    <div class="flex justify-between mb-1">
                      <span class="text-sm font-medium text-gray-700 dark:text-gray-300">Inventory Health</span>
                      <span class="text-sm font-medium text-gray-700 dark:text-gray-300">78%</span>
                    </div>
                    <div class="w-full bg-gray-200 dark:bg-neutral-700 rounded-full h-2.5">
                      <div class="bg-teal-600 h-2.5 rounded-full" style="width: 78%"></div>
                    </div>
                  </div>
                  
                  <div class="bg-gray-50 dark:bg-neutral-700 rounded-lg p-4 mb-6">
                    <div class="text-sm font-medium text-gray-700 dark:text-gray-300 mb-3">Low Stock Alerts</div>
                    <div class="space-y-3">
                      <div class="flex justify-between items-center">
                        <div class="flex items-center">
                          <div class="w-2 h-2 bg-red-500 rounded-full mr-2"></div>
                          <span class="text-sm text-gray-600 dark:text-gray-400">Product X</span>
                        </div>
                        <span class="text-sm text-red-500 dark:text-red-400">3 units left</span>
                      </div>
                      <div class="flex justify-between items-center">
                        <div class="flex items-center">
                          <div class="w-2 h-2 bg-yellow-500 rounded-full mr-2"></div>
                          <span class="text-sm text-gray-600 dark:text-gray-400">Product Y</span>
                        </div>
                        <span class="text-sm text-yellow-500 dark:text-yellow-400">8 units left</span>
                      </div>
                      <div class="flex justify-between items-center">
                        <div class="flex items-center">
                          <div class="w-2 h-2 bg-yellow-500 rounded-full mr-2"></div>
                          <span class="text-sm text-gray-600 dark:text-gray-400">Product Z</span>
                        </div>
                        <span class="text-sm text-yellow-500 dark:text-yellow-400">12 units left</span>
                      </div>
                    </div>
                  </div>
                  
                  <div class="flex justify-between items-center">
                    <button class="text-sm text-teal-600 dark:text-teal-400 hover:text-teal-700 dark:hover:text-teal-300">Sales Report</button>
                    <button class="text-sm px-3 py-1 bg-teal-600 hover:bg-teal-700 text-white rounded-md">Order Now</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="role-content hidden" id="accountant-content">
        <!-- Accountant content -->
        <div class="flex flex-col lg:flex-row bg-white dark:bg-neutral-900 rounded-2xl shadow-lg overflow-hidden">
          <div class="lg:w-1/2 p-8 md:p-12">
            <div class="flex items-center mb-6">
              <div class="w-12 h-12 bg-red-100 dark:bg-red-900/50 rounded-lg flex items-center justify-center mr-4">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-red-600 dark:text-red-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 7h6m0 10v-3m-3 3h.01M9 17h.01M9 14h.01M12 14h.01M15 11h.01M12 11h.01M9 11h.01M7 21h10a2 2 0 002-2V5a2 2 0 00-2-2H7a2 2 0 00-2 2v14a2 2 0 002 2z" />
                </svg>
              </div>
              <h3 class="text-2xl font-bold text-gray-900 dark:text-white">Financial Management</h3>
            </div>
            <p class="text-gray-600 dark:text-gray-400 mb-6">
              Comprehensive financial tools for tracking revenue, expenses, invoicing, and reporting across your entire supply chain.
            </p>
            <ul class="space-y-4 mb-8">
              <li class="flex items-start">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-500 mr-3 mt-0.5" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
                <div>
                  <h4 class="font-medium text-gray-900 dark:text-white">Integrated Invoicing</h4>
                  <p class="text-gray-600 dark:text-gray-400">Automatically generate and track invoices across your supply chain operations.</p>
                </div>
              </li>
              <li class="flex items-start">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-500 mr-3 mt-0.5" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
                <div>
                  <h4 class="font-medium text-gray-900 dark:text-white">Financial Reporting</h4>
                  <p class="text-gray-600 dark:text-gray-400">Generate comprehensive financial reports with detailed analytics and insights.</p>
                </div>
              </li>
              <li class="flex items-start">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-green-500 mr-3 mt-0.5" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
                <div>
                  <h4 class="font-medium text-gray-900 dark:text-white">Tax Management</h4>
                  <p class="text-gray-600 dark:text-gray-400">Streamline tax calculations, compliance, and documentation across multiple jurisdictions.</p>
                </div>
              </li>
            </ul>
            <div class="flex flex-wrap gap-4">
              <a href="#signup" class="px-6 py-3 bg-red-600 hover:bg-red-700 text-white font-medium rounded-lg transition-colors duration-300 flex items-center justify-center">
                Sign Up as Accountant
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 ml-2" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L12.586 11H5a1 1 0 110-2h7.586l-2.293-2.293a1 1 0 010-1.414z" clip-rule="evenodd" />
                </svg>
              </a>
              <a href="#pricing" class="px-6 py-3 bg-white hover:bg-gray-100 dark:bg-neutral-800 dark:hover:bg-neutral-700 text-red-600 dark:text-red-400 font-medium rounded-lg border border-red-200 dark:border-neutral-700 transition-colors duration-300 flex items-center justify-center">
                View Pricing
              </a>
            </div>
          </div>
          <div class="lg:w-1/2 bg-gradient-to-br from-red-50 to-rose-50 dark:from-red-900/20 dark:to-rose-900/20 p-8 md:p-12 flex items-center justify-center">
            <div class="max-w-md">
              <div class="bg-white dark:bg-neutral-800 rounded-xl shadow-lg overflow-hidden">
                <div class="p-4 border-b border-gray-200 dark:border-neutral-700 flex justify-between items-center">
                  <div class="font-medium text-gray-900 dark:text-white">Financial Dashboard</div>
                  <div class="flex space-x-2">
                    <div class="w-3 h-3 bg-red-500 rounded-full"></div>
                    <div class="w-3 h-3 bg-yellow-500 rounded-full"></div>
                    <div class="w-3 h-3 bg-green-500 rounded-full"></div>
                  </div>
                </div>
                <div class="p-6">
                  <div class="grid grid-cols-2 gap-4 mb-6">
                    <div class="bg-red-50 dark:bg-red-900/30 p-3 rounded-lg">
                      <div class="text-sm text-red-700 dark:text-red-400 font-medium">Revenue</div>
                      <div class="text-2xl font-bold text-red-900 dark:text-red-200">$256.8K</div>
                    </div>
                    <div class="bg-blue-50 dark:bg-blue-900/30 p-3 rounded-lg">
                      <div class="text-sm text-blue-700 dark:text-blue-400 font-medium">Expenses</div>
                      <div class="text-2xl font-bold text-blue-900 dark:text-blue-200">$162.3K</div>
                    </div>
                  </div>
                  
                  <div class="mb-6">
                    <div class="flex justify-between mb-1">
                      <span class="text-sm font-medium text-gray-700 dark:text-gray-300">Profit Margin</span>
                      <span class="text-sm font-medium text-gray-700 dark:text-gray-300">36.8%</span>
                    </div>
                    <div class="w-full bg-gray-200 dark:bg-neutral-700 rounded-full h-2.5">
                      <div class="bg-green-600 h-2.5 rounded-full" style="width: 36.8%"></div>
                    </div>
                  </div>
                  
                  <div class="bg-gray-50 dark:bg-neutral-700 rounded-lg p-4 mb-6">
                    <div class="text-sm font-medium text-gray-700 dark:text-gray-300 mb-3">Financial Status</div>
                    <div class="space-y-3">
                      <div class="flex justify-between items-center">
                        <div class="flex items-center">
                          <div class="w-2 h-2 bg-yellow-500 rounded-full mr-2"></div>
                          <span class="text-sm text-gray-600 dark:text-gray-400">Pending Invoices</span>
                        </div>
                        <span class="text-sm text-gray-600 dark:text-gray-400">$28,562</span>
                      </div>
                      <div class="flex justify-between items-center">
                        <div class="flex items-center">
                          <div class="w-2 h-2 bg-red-500 rounded-full mr-2"></div>
                          <span class="text-sm text-gray-600 dark:text-gray-400">Overdue Payments</span>
                        </div>
                        <span class="text-sm text-gray-600 dark:text-gray-400">$12,845</span>
                      </div>
                      <div class="flex justify-between items-center">
                        <div class="flex items-center">
                          <div class="w-2 h-2 bg-green-500 rounded-full mr-2"></div>
                          <span class="text-sm text-gray-600 dark:text-gray-400">Paid This Month</span>
                        </div>
                        <span class="text-sm text-gray-600 dark:text-gray-400">$86,320</span>
                      </div>
                    </div>
                  </div>
                  
                  <div class="flex justify-between items-center">
                    <button class="text-sm text-red-600 dark:text-red-400 hover:text-red-700 dark:hover:text-red-300">Financial Report</button>
                    <button class="text-sm px-3 py-1 bg-red-600 hover:bg-red-700 text-white rounded-md">Invoice Management</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</div>

<script>
  // Role tabs functionality
  document.addEventListener('DOMContentLoaded', function() {
    const roleTabs = document.querySelectorAll('.role-tab');
    const roleContents = document.querySelectorAll('.role-content');
    
    function activateTab(tabName) {
      // Hide all content sections first
      roleContents.forEach(content => {
        content.classList.add('hidden');
      });
      
      // Show the selected content
      document.getElementById(`${tabName}-content`).classList.remove('hidden');
      
      // Update tab styling
      roleTabs.forEach(tab => {
        if (tab.getAttribute('data-role') === tabName) {
          tab.classList.remove('bg-white', 'dark:bg-neutral-700', 'text-gray-700', 'dark:text-gray-200');
          tab.classList.add('bg-blue-600', 'text-white');
        } else {
          tab.classList.remove('bg-blue-600', 'text-white');
          tab.classList.add('bg-white', 'dark:bg-neutral-700', 'text-gray-700', 'dark:text-gray-200');
        }
      });
    }
    
    // Add click events to tabs
    roleTabs.forEach(tab => {
      tab.addEventListener('click', function() {
        activateTab(this.getAttribute('data-role'));
      });
    });
    
    // Activate the first tab by default
    //activateTab('supplier');
  });
</script>

</element><element id="921ca83b-38b0-472c-beaa-8cffd86e5131" data-section-id="921ca83b-38b0-472c-beaa-8cffd86e5131">

<div id="root">
  <section id="systemBenefits" class="py-16 md:py-24 bg-gradient-to-b from-gray-50 to-white dark:from-neutral-900 dark:to-neutral-800">
    <div class="container mx-auto px-4">
      <div class="text-center mb-16">
        <h2 class="text-3xl md:text-4xl font-bold text-gray-900 dark:text-white mb-4">
          Transform Your Supply Chain
        </h2>
        <p class="text-lg text-gray-600 dark:text-gray-400 max-w-3xl mx-auto">
          Our integrated platform delivers tangible benefits across your entire logistics ecosystem, driving efficiency, transparency, and growth.
        </p>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        <!-- Benefit 1 -->
        <div class="bg-white dark:bg-neutral-800 rounded-xl shadow-md hover:shadow-lg transition-shadow duration-300 overflow-hidden group">
          <div class="p-6">
            <div class="w-12 h-12 rounded-lg bg-blue-100 dark:bg-blue-900/40 flex items-center justify-center mb-5 group-hover:bg-blue-600 group-hover:text-white transition-colors duration-300">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-blue-600 dark:text-blue-400 group-hover:text-white transition-colors duration-300" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
              </svg>
            </div>
            <h3 class="text-xl font-bold text-gray-900 dark:text-white mb-3">Increased Operational Efficiency</h3>
            <p class="text-gray-600 dark:text-gray-400 mb-6">
              Streamline workflows, automate manual processes, and eliminate bottlenecks to achieve significant time and cost savings.
            </p>
            <div class="flex items-center justify-between">
              <div>
                <span class="text-sm font-medium text-blue-600 dark:text-blue-400">Up to</span>
                <span class="text-2xl font-bold text-blue-700 dark:text-blue-300 ml-1">35%</span>
                <span class="text-sm font-medium text-blue-600 dark:text-blue-400 ml-1">reduction in operational costs</span>
              </div>
            </div>
          </div>
          <div class="w-full h-1 bg-gradient-to-r from-blue-400 to-blue-600"></div>
        </div>

        <!-- Benefit 2 -->
        <div class="bg-white dark:bg-neutral-800 rounded-xl shadow-md hover:shadow-lg transition-shadow duration-300 overflow-hidden group">
          <div class="p-6">
            <div class="w-12 h-12 rounded-lg bg-emerald-100 dark:bg-emerald-900/40 flex items-center justify-center mb-5 group-hover:bg-emerald-600 group-hover:text-white transition-colors duration-300">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-emerald-600 dark:text-emerald-400 group-hover:text-white transition-colors duration-300" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
              </svg>
            </div>
            <h3 class="text-xl font-bold text-gray-900 dark:text-white mb-3">Enhanced Visibility & Control</h3>
            <p class="text-gray-600 dark:text-gray-400 mb-6">
              Gain complete transparency across your supply chain with real-time tracking, monitoring, and reporting capabilities.
            </p>
            <div class="flex items-center justify-between">
              <div>
                <span class="text-sm font-medium text-emerald-600 dark:text-emerald-400">Up to</span>
                <span class="text-2xl font-bold text-emerald-700 dark:text-emerald-300 ml-1">95%</span>
                <span class="text-sm font-medium text-emerald-600 dark:text-emerald-400 ml-1">increase in supply chain visibility</span>
              </div>
            </div>
          </div>
          <div class="w-full h-1 bg-gradient-to-r from-emerald-400 to-emerald-600"></div>
        </div>

        <!-- Benefit 3 -->
        <div class="bg-white dark:bg-neutral-800 rounded-xl shadow-md hover:shadow-lg transition-shadow duration-300 overflow-hidden group">
          <div class="p-6">
            <div class="w-12 h-12 rounded-lg bg-purple-100 dark:bg-purple-900/40 flex items-center justify-center mb-5 group-hover:bg-purple-600 group-hover:text-white transition-colors duration-300">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-purple-600 dark:text-purple-400 group-hover:text-white transition-colors duration-300" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 12l3-3 3 3 4-4M8 21l4-4 4 4M3 4h18M4 4h16v12a1 1 0 01-1 1H5a1 1 0 01-1-1V4z" />
              </svg>
            </div>
            <h3 class="text-xl font-bold text-gray-900 dark:text-white mb-3">Data-Driven Decision Making</h3>
            <p class="text-gray-600 dark:text-gray-400 mb-6">
              Leverage powerful analytics and reporting tools to identify trends, forecast demand, and make informed business decisions.
            </p>
            <div class="flex items-center justify-between">
              <div>
                <span class="text-sm font-medium text-purple-600 dark:text-purple-400">Up to</span>
                <span class="text-2xl font-bold text-purple-700 dark:text-purple-300 ml-1">40%</span>
                <span class="text-sm font-medium text-purple-600 dark:text-purple-400 ml-1">improvement in forecasting accuracy</span>
              </div>
            </div>
          </div>
          <div class="w-full h-1 bg-gradient-to-r from-purple-400 to-purple-600"></div>
        </div>

        <!-- Benefit 4 -->
        <div class="bg-white dark:bg-neutral-800 rounded-xl shadow-md hover:shadow-lg transition-shadow duration-300 overflow-hidden group">
          <div class="p-6">
            <div class="w-12 h-12 rounded-lg bg-amber-100 dark:bg-amber-900/40 flex items-center justify-center mb-5 group-hover:bg-amber-600 group-hover:text-white transition-colors duration-300">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-amber-600 dark:text-amber-400 group-hover:text-white transition-colors duration-300" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
            </div>
            <h3 class="text-xl font-bold text-gray-900 dark:text-white mb-3">Reduced Lead Times</h3>
            <p class="text-gray-600 dark:text-gray-400 mb-6">
              Optimize planning, logistics, and coordination to significantly decrease order-to-delivery cycles across your supply chain.
            </p>
            <div class="flex items-center justify-between">
              <div>
                <span class="text-sm font-medium text-amber-600 dark:text-amber-400">Up to</span>
                <span class="text-2xl font-bold text-amber-700 dark:text-amber-300 ml-1">28%</span>
                <span class="text-sm font-medium text-amber-600 dark:text-amber-400 ml-1">reduction in lead time</span>
              </div>
            </div>
          </div>
          <div class="w-full h-1 bg-gradient-to-r from-amber-400 to-amber-600"></div>
        </div>

        <!-- Benefit 5 -->
        <div class="bg-white dark:bg-neutral-800 rounded-xl shadow-md hover:shadow-lg transition-shadow duration-300 overflow-hidden group">
          <div class="p-6">
            <div class="w-12 h-12 rounded-lg bg-red-100 dark:bg-red-900/40 flex items-center justify-center mb-5 group-hover:bg-red-600 group-hover:text-white transition-colors duration-300">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-red-600 dark:text-red-400 group-hover:text-white transition-colors duration-300" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
              </svg>
            </div>
            <h3 class="text-xl font-bold text-gray-900 dark:text-white mb-3">Error-Free Documentation</h3>
            <p class="text-gray-600 dark:text-gray-400 mb-6">
              Eliminate paperwork errors and streamline document processing with automated generation, validation, and exchange.
            </p>
            <div class="flex items-center justify-between">
              <div>
                <span class="text-sm font-medium text-red-600 dark:text-red-400">Up to</span>
                <span class="text-2xl font-bold text-red-700 dark:text-red-300 ml-1">93%</span>
                <span class="text-sm font-medium text-red-600 dark:text-red-400 ml-1">reduction in documentation errors</span>
              </div>
            </div>
          </div>
          <div class="w-full h-1 bg-gradient-to-r from-red-400 to-red-600"></div>
        </div>

        <!-- Benefit 6 -->
        <div class="bg-white dark:bg-neutral-800 rounded-xl shadow-md hover:shadow-lg transition-shadow duration-300 overflow-hidden group">
          <div class="p-6">
            <div class="w-12 h-12 rounded-lg bg-indigo-100 dark:bg-indigo-900/40 flex items-center justify-center mb-5 group-hover:bg-indigo-600 group-hover:text-white transition-colors duration-300">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-indigo-600 dark:text-indigo-400 group-hover:text-white transition-colors duration-300" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
              </svg>
            </div>
            <h3 class="text-xl font-bold text-gray-900 dark:text-white mb-3">Improved Collaboration</h3>
            <p class="text-gray-600 dark:text-gray-400 mb-6">
              Foster seamless communication and cooperation between all stakeholders in your supply chain network.
            </p>
            <div class="flex items-center justify-between">
              <div>
                <span class="text-sm font-medium text-indigo-600 dark:text-indigo-400">Up to</span>
                <span class="text-2xl font-bold text-indigo-700 dark:text-indigo-300 ml-1">58%</span>
                <span class="text-sm font-medium text-indigo-600 dark:text-indigo-400 ml-1">increase in stakeholder coordination</span>
              </div>
            </div>
          </div>
          <div class="w-full h-1 bg-gradient-to-r from-indigo-400 to-indigo-600"></div>
        </div>
      </div>

      <div class="mt-16 lg:mt-24">
        <div class="bg-white dark:bg-neutral-800 rounded-2xl shadow-xl overflow-hidden">
          <div class="lg:flex">
            <div class="lg:w-1/2 p-8 lg:p-12">
              <h3 class="text-2xl font-bold text-gray-900 dark:text-white mb-4">
                Real Business Impact
              </h3>
              <p class="text-gray-600 dark:text-gray-400 mb-6">
                Our platform delivers measurable results across your entire supply chain operations.
              </p>
              <div class="space-y-6">
                <div class="flex">
                  <div class="flex-shrink-0">
                    <div class="flex items-center justify-center h-12 w-12 rounded-md bg-blue-600 text-white">
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                      </svg>
                    </div>
                  </div>
                  <div class="ml-4">
                    <h4 class="text-lg font-medium text-gray-900 dark:text-white">
                      Cost Reduction
                    </h4>
                    <p class="mt-1 text-gray-600 dark:text-gray-400">
                      Streamlined processes, optimized routing, and improved inventory management lead to significant cost savings.
                    </p>
                  </div>
                </div>
                <div class="flex">
                  <div class="flex-shrink-0">
                    <div class="flex items-center justify-center h-12 w-12 rounded-md bg-emerald-600 text-white">
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                      </svg>
                    </div>
                  </div>
                  <div class="ml-4">
                    <h4 class="text-lg font-medium text-gray-900 dark:text-white">
                      Quality Improvement
                    </h4>
                    <p class="mt-1 text-gray-600 dark:text-gray-400">
                      Enhanced tracking, traceability, and QA processes result in fewer defects and higher customer satisfaction.
                    </p>
                  </div>
                </div>
                <div class="flex">
                  <div class="flex-shrink-0">
                    <div class="flex items-center justify-center h-12 w-12 rounded-md bg-amber-600 text-white">
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6" />
                      </svg>
                    </div>
                  </div>
                  <div class="ml-4">
                    <h4 class="text-lg font-medium text-gray-900 dark:text-white">
                      Revenue Growth
                    </h4>
                    <p class="mt-1 text-gray-600 dark:text-gray-400">
                      Faster delivery times, improved service levels, and better inventory management drive increased sales.
                    </p>
                  </div>
                </div>
              </div>
            </div>
            <div class="lg:w-1/2 bg-gradient-to-br from-blue-50 to-indigo-50 dark:from-blue-900/20 dark:to-indigo-900/20 p-8 lg:p-12 flex items-center justify-center">
              <div class="w-full max-w-md">
                <div class="bg-white dark:bg-neutral-900 rounded-xl shadow-lg p-6">
                  <div class="text-center mb-6">
                    <h4 class="text-xl font-bold text-gray-900 dark:text-white">Return on Investment</h4>
                    <p class="text-gray-600 dark:text-gray-400">Average customer results after 12 months</p>
                  </div>
                  
                  <div class="relative mb-10 pt-4">
                    <div class="absolute inset-0 flex items-center justify-center">
                      <div class="text-center">
                        <div class="text-5xl font-bold text-blue-600 dark:text-blue-400">312%</div>
                        <div class="text-sm font-medium text-gray-600 dark:text-gray-400 mt-1">ROI</div>
                      </div>
                    </div>
                    <div class="h-40 w-40 mx-auto rounded-full border-8 border-blue-600 dark:border-blue-500 border-dashed animate-spin-slow"></div>
                  </div>
                  
                  <div class="grid grid-cols-2 gap-4">
                    <div class="bg-gray-50 dark:bg-neutral-800 p-4 rounded-lg text-center">
                      <div class="text-2xl font-bold text-emerald-600 dark:text-emerald-400">5.2</div>
                      <div class="text-xs text-gray-600 dark:text-gray-400">Months to break-even</div>
                    </div>
                    <div class="bg-gray-50 dark:bg-neutral-800 p-4 rounded-lg text-center">
                      <div class="text-2xl font-bold text-amber-600 dark:text-amber-400">27%</div>
                      <div class="text-xs text-gray-600 dark:text-gray-400">Increase in efficiency</div>
                    </div>
                  </div>
                </div>
                
                <div class="mt-8 flex justify-center">
                  <a href="#pricing" class="px-6 py-3 bg-blue-600 hover:bg-blue-700 text-white font-medium rounded-lg transition-colors duration-300 shadow-md hover:shadow-lg flex items-center">
                    <span>Calculate Your ROI</span>
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 ml-2" viewBox="0 0 20 20" fill="currentColor">
                      <path fill-rule="evenodd" d="M10.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L12.586 11H5a1 1 0 110-2h7.586l-2.293-2.293a1 1 0 010-1.414z" clip-rule="evenodd" />
                    </svg>
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</div>

<style>
  .animate-spin-slow {
    animation: spin 15s linear infinite;
  }
  
  @keyframes spin {
    from {
      transform: rotate(0deg);
    }
    to {
      transform: rotate(360deg);
    }
  }
</style>
</element><element id="fc619fab-64bc-475c-90ea-22227509140e" data-section-id="fc619fab-64bc-475c-90ea-22227509140e">

<script>
  document.addEventListener('DOMContentLoaded', function() {
    // Pricing toggle functionality
    const monthlyBtn = document.getElementById('monthly-pricing-btn');
    const annualBtn = document.getElementById('annual-pricing-btn');
    const basicPrice = document.getElementById('basic-price');
    const proPrice = document.getElementById('pro-price');
    const enterprisePrice = document.getElementById('enterprise-price');
    
    // Initial prices (monthly)
    const prices = {
      monthly: {
        basic: '$249',
        pro: '$499',
        enterprise: '$999'
      },
      annual: {
        basic: '$199',
        pro: '$399',
        enterprise: '$799'
      }
    };
    
    monthlyBtn.addEventListener('click', function() {
      // Update UI
      monthlyBtn.classList.add('bg-blue-600', 'text-white');
      monthlyBtn.classList.remove('text-gray-700', 'dark:text-gray-300');
      
      annualBtn.classList.remove('bg-blue-600', 'text-white');
      annualBtn.classList.add('text-gray-700', 'dark:text-gray-300');
      
      // Update prices
      basicPrice.textContent = prices.monthly.basic;
      proPrice.textContent = prices.monthly.pro;
      enterprisePrice.textContent = prices.monthly.enterprise;
    });
    
    annualBtn.addEventListener('click', function() {
      // Update UI
      annualBtn.classList.add('bg-blue-600', 'text-white');
      annualBtn.classList.remove('text-gray-700', 'dark:text-gray-300');
      
      monthlyBtn.classList.remove('bg-blue-600', 'text-white');
      monthlyBtn.classList.add('text-gray-700', 'dark:text-gray-300');
      
      // Update prices
      basicPrice.textContent = prices.annual.basic;
      proPrice.textContent = prices.annual.pro;
      enterprisePrice.textContent = prices.annual.enterprise;
    });
  });
  
  // FAQ toggle functionality
  function toggleFaq(id) {
    const content = document.getElementById(`faq-content-${id}`);
    const arrow = document.getElementById(`faq-arrow-${id}`);
    
    content.classList.toggle('hidden');
    arrow.classList.toggle('rotate-180');
  }
</script>
</element><element id="87656d21-a809-424d-a4d4-df063d1788e5" data-section-id="87656d21-a809-424d-a4d4-df063d1788e5">

</element><element id="c2180cdb-fe40-4974-8e81-c97a0bcf7d42" data-section-id="c2180cdb-fe40-4974-8e81-c97a0bcf7d42">


</element><element id="c2f78d8e-8df9-4fb2-b4e6-444d08c5ac3d" data-section-id="c2f78d8e-8df9-4fb2-b4e6-444d08c5ac3d">


<div id="root">
  <section id="faq" class="py-16 bg-gray-50 dark:bg-neutral-900 transition-colors duration-300">
    <div class="container mx-auto px-4">
      <div class="text-center mb-12">
        <h2 class="text-3xl md:text-4xl font-bold text-gray-800 dark:text-white mb-4">Frequently Asked Questions</h2>
        <p class="text-lg text-gray-600 dark:text-gray-300 max-w-3xl mx-auto">Find answers to common questions about our supply chain and logistics system.</p>
      </div>
      
      <div class="max-w-4xl mx-auto">
        <!-- FAQ Item 1 -->
        <div class="mb-6">
          <div class="bg-white dark:bg-neutral-800 rounded-lg shadow-md overflow-hidden">
            <button class="flex items-center justify-between w-full p-5 text-left focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50" 
                    onclick="toggleFaq(this)" 
                    aria-expanded="false">
              <span class="text-lg font-semibold text-gray-800 dark:text-white">What user roles are supported in the system?</span>
              <svg class="w-6 h-6 text-blue-600 dark:text-blue-400 transform transition-transform duration-300" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
              </svg>
            </button>
            <div class="max-h-0 overflow-hidden transition-all duration-300 ease-in-out">
              <div class="p-5 border-t border-gray-200 dark:border-neutral-700">
                <p class="text-gray-600 dark:text-gray-300">Our system supports multiple user roles including:</p>
                <ul class="list-disc list-inside mt-2 space-y-1 text-gray-600 dark:text-gray-300">
                  <li>Supplier</li>
                  <li>Manufacturer</li>
                  <li>Warehouse Manager</li>
                  <li>Transporter</li>
                  <li>Wholesaler</li>
                  <li>Retailer</li>
                  <li>Accountant</li>
                </ul>
                <p class="mt-2 text-gray-600 dark:text-gray-300">Each role has specific permissions and dashboard views tailored to their responsibilities in the supply chain.</p>
              </div>
            </div>
          </div>
        </div>
        
        <!-- FAQ Item 2 -->
        <div class="mb-6">
          <div class="bg-white dark:bg-neutral-800 rounded-lg shadow-md overflow-hidden">
            <button class="flex items-center justify-between w-full p-5 text-left focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50" 
                    onclick="toggleFaq(this)" 
                    aria-expanded="false">
              <span class="text-lg font-semibold text-gray-800 dark:text-white">What are the licensing options available?</span>
              <svg class="w-6 h-6 text-blue-600 dark:text-blue-400 transform transition-transform duration-300" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
              </svg>
            </button>
            <div class="max-h-0 overflow-hidden transition-all duration-300 ease-in-out">
              <div class="p-5 border-t border-gray-200 dark:border-neutral-700">
                <p class="text-gray-600 dark:text-gray-300">We offer three main licensing tiers:</p>
                <ul class="mt-2 space-y-3 text-gray-600 dark:text-gray-300">
                  <li class="flex items-start">
                    <span class="font-medium mr-2">Basic:</span>
                    <span>For small businesses with limited supply chain operations. Includes core features with up to 5 user accounts.</span>
                  </li>
                  <li class="flex items-start">
                    <span class="font-medium mr-2">Professional:</span>
                    <span>For medium-sized businesses with more complex requirements. Includes advanced analytics and up to 20 user accounts.</span>
                  </li>
                  <li class="flex items-start">
                    <span class="font-medium mr-2">Enterprise:</span>
                    <span>For large organizations with extensive supply chain networks. Includes custom integrations, unlimited users, and dedicated support.</span>
                  </li>
                </ul>
                <p class="mt-3 text-gray-600 dark:text-gray-300">All plans include a 14-day free trial. Contact our sales team for custom pricing options.</p>
              </div>
            </div>
          </div>
        </div>
        
        <!-- FAQ Item 3 -->
        <div class="mb-6">
          <div class="bg-white dark:bg-neutral-800 rounded-lg shadow-md overflow-hidden">
            <button class="flex items-center justify-between w-full p-5 text-left focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50" 
                    onclick="toggleFaq(this)" 
                    aria-expanded="false">
              <span class="text-lg font-semibold text-gray-800 dark:text-white">How does the system handle inventory management?</span>
              <svg class="w-6 h-6 text-blue-600 dark:text-blue-400 transform transition-transform duration-300" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
              </svg>
            </button>
            <div class="max-h-0 overflow-hidden transition-all duration-300 ease-in-out">
              <div class="p-5 border-t border-gray-200 dark:border-neutral-700">
                <p class="text-gray-600 dark:text-gray-300">Our inventory management system offers comprehensive features:</p>
                <ul class="list-disc list-inside mt-2 space-y-1 text-gray-600 dark:text-gray-300">
                  <li>Real-time inventory tracking across multiple locations</li>
                  <li>Automated reorder points and safety stock calculations</li>
                  <li>Batch tracking and expiration date management</li>
                  <li>Barcode and QR code scanning support</li>
                  <li>Inventory forecasting based on historical data</li>
                  <li>Stock transfer management between warehouses</li>
                </ul>
                <p class="mt-2 text-gray-600 dark:text-gray-300">The system provides visibility to all relevant stakeholders based on their role, ensuring everyone has access to the information they need.</p>
              </div>
            </div>
          </div>
        </div>
        
        <!-- FAQ Item 4 -->
        <div class="mb-6">
          <div class="bg-white dark:bg-neutral-800 rounded-lg shadow-md overflow-hidden">
            <button class="flex items-center justify-between w-full p-5 text-left focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50" 
                    onclick="toggleFaq(this)" 
                    aria-expanded="false">
              <span class="text-lg font-semibold text-gray-800 dark:text-white">Can the system integrate with other software we use?</span>
              <svg class="w-6 h-6 text-blue-600 dark:text-blue-400 transform transition-transform duration-300" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
              </svg>
            </button>
            <div class="max-h-0 overflow-hidden transition-all duration-300 ease-in-out">
              <div class="p-5 border-t border-gray-200 dark:border-neutral-700">
                <p class="text-gray-600 dark:text-gray-300">Yes, our system is designed with integration capabilities in mind. We offer:</p>
                <ul class="list-disc list-inside mt-2 space-y-1 text-gray-600 dark:text-gray-300">
                  <li>API access for custom integrations</li>
                  <li>Pre-built connectors for popular ERP systems</li>
                  <li>Integration with accounting software (QuickBooks, Xero, etc.)</li>
                  <li>EDI capabilities for supplier and customer connections</li>
                  <li>Integration with e-commerce platforms</li>
                  <li>Warehouse management system (WMS) integration</li>
                  <li>Transportation management system (TMS) integration</li>
                </ul>
                <p class="mt-2 text-gray-600 dark:text-gray-300">The Professional and Enterprise plans include more extensive integration options. Our team can also develop custom integrations for your specific needs.</p>
              </div>
            </div>
          </div>
        </div>
        
        <!-- FAQ Item 5 -->
        <div class="mb-6">
          <div class="bg-white dark:bg-neutral-800 rounded-lg shadow-md overflow-hidden">
            <button class="flex items-center justify-between w-full p-5 text-left focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50" 
                    onclick="toggleFaq(this)" 
                    aria-expanded="false">
              <span class="text-lg font-semibold text-gray-800 dark:text-white">How secure is the platform?</span>
              <svg class="w-6 h-6 text-blue-600 dark:text-blue-400 transform transition-transform duration-300" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
              </svg>
            </button>
            <div class="max-h-0 overflow-hidden transition-all duration-300 ease-in-out">
              <div class="p-5 border-t border-gray-200 dark:border-neutral-700">
                <p class="text-gray-600 dark:text-gray-300">Security is a top priority. Our platform includes:</p>
                <ul class="list-disc list-inside mt-2 space-y-1 text-gray-600 dark:text-gray-300">
                  <li>End-to-end encryption for all data</li>
                  <li>Role-based access control with fine-grained permissions</li>
                  <li>Two-factor authentication</li>
                  <li>Regular security audits and penetration testing</li>
                  <li>GDPR and CCPA compliance</li>
                  <li>Data backups and disaster recovery planning</li>
                  <li>SOC 2 Type II certification</li>
                </ul>
                <p class="mt-2 text-gray-600 dark:text-gray-300">We maintain strict data protection protocols and continuously monitor for potential security threats. Our security team is available 24/7 to address any concerns.</p>
              </div>
            </div>
          </div>
        </div>
        
        <!-- FAQ Item 6 -->
        <div class="mb-6">
          <div class="bg-white dark:bg-neutral-800 rounded-lg shadow-md overflow-hidden">
            <button class="flex items-center justify-between w-full p-5 text-left focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50" 
                    onclick="toggleFaq(this)" 
                    aria-expanded="false">
              <span class="text-lg font-semibold text-gray-800 dark:text-white">What kind of support do you offer?</span>
              <svg class="w-6 h-6 text-blue-600 dark:text-blue-400 transform transition-transform duration-300" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
              </svg>
            </button>
            <div class="max-h-0 overflow-hidden transition-all duration-300 ease-in-out">
              <div class="p-5 border-t border-gray-200 dark:border-neutral-700">
                <p class="text-gray-600 dark:text-gray-300">Our support options vary by license tier:</p>
                <ul class="mt-2 space-y-3 text-gray-600 dark:text-gray-300">
                  <li class="flex items-start">
                    <span class="font-medium mr-2">Basic:</span>
                    <span>Email support with 24-48 hour response time, access to knowledge base and community forums.</span>
                  </li>
                  <li class="flex items-start">
                    <span class="font-medium mr-2">Professional:</span>
                    <span>Priority email support with 12-24 hour response time, live chat during business hours, and phone support.</span>
                  </li>
                  <li class="flex items-start">
                    <span class="font-medium mr-2">Enterprise:</span>
                    <span>24/7 dedicated support team, personalized onboarding, dedicated account manager, and custom training sessions.</span>
                  </li>
                </ul>
                <p class="mt-3 text-gray-600 dark:text-gray-300">All customers receive access to our comprehensive documentation, video tutorials, and regular webinars.</p>
              </div>
            </div>
          </div>
        </div>
        
        <!-- FAQ Item 7 -->
        <div class="mb-6">
          <div class="bg-white dark:bg-neutral-800 rounded-lg shadow-md overflow-hidden">
            <button class="flex items-center justify-between w-full p-5 text-left focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50" 
                    onclick="toggleFaq(this)" 
                    aria-expanded="false">
              <span class="text-lg font-semibold text-gray-800 dark:text-white">Is there a mobile app available?</span>
              <svg class="w-6 h-6 text-blue-600 dark:text-blue-400 transform transition-transform duration-300" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
              </svg>
            </button>
            <div class="max-h-0 overflow-hidden transition-all duration-300 ease-in-out">
              <div class="p-5 border-t border-gray-200 dark:border-neutral-700">
                <p class="text-gray-600 dark:text-gray-300">Yes, we offer mobile apps for both iOS and Android devices. The mobile app includes:</p>
                <ul class="list-disc list-inside mt-2 space-y-1 text-gray-600 dark:text-gray-300">
                  <li>Real-time notifications and alerts</li>
                  <li>Barcode scanning for inventory management</li>
                  <li>On-the-go approval workflows</li>
                  <li>GPS tracking for shipments</li>
                  <li>Dashboard views tailored to each user role</li>
                  <li>Offline mode for continued access without internet</li>
                </ul>
                <p class="mt-2 text-gray-600 dark:text-gray-300">The mobile app is included with all license tiers and provides a seamless extension of the web application.</p>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <!-- Still Have Questions -->
      <div class="mt-12 text-center">
        <h3 class="text-xl font-bold text-gray-800 dark:text-white mb-4">Still Have Questions?</h3>
        <p class="text-gray-600 dark:text-gray-300 mb-8 max-w-2xl mx-auto">Our team is ready to help you find the right solution for your supply chain needs.</p>
        <div class="flex flex-col sm:flex-row justify-center gap-4">
          <a href="#contact" class="px-8 py-3 bg-blue-600 hover:bg-blue-700 text-white font-bold rounded-lg transition-colors duration-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50">
            Contact Us
          </a>
          <a href="#support" class="px-8 py-3 bg-gray-200 dark:bg-neutral-700 hover:bg-gray-300 dark:hover:bg-neutral-600 text-gray-800 dark:text-white font-bold rounded-lg transition-colors duration-300 focus:outline-none focus:ring-2 focus:ring-gray-400 focus:ring-opacity-50">
            View Documentation
          </a>
        </div>
      </div>
    </div>
  </section>
  
  <script>
    function toggleFaq(element) {
      // Toggle aria-expanded attribute
      const expanded = element.getAttribute('aria-expanded') === 'true';
      element.setAttribute('aria-expanded', !expanded);
      
      // Toggle the arrow icon rotation
      const icon = element.querySelector('svg');
      if (expanded) {
        icon.classList.remove('rotate-180');
      } else {
        icon.classList.add('rotate-180');
      }
      
      // Toggle the content visibility
      const content = element.nextElementSibling;
      if (expanded) {
        content.style.maxHeight = '0px';
      } else {
        content.style.maxHeight = content.scrollHeight + 'px';
      }
    }
  </script>
</div>

</element><element id="f32241fa-97e3-40e5-8c2f-97e816df76f8" data-section-id="f32241fa-97e3-40e5-8c2f-97e816df76f8">


<div id="root">
  <section id="contact" class="py-16 bg-white dark:bg-neutral-900 transition-colors duration-300">
    <div class="container mx-auto px-4">
      <div class="text-center mb-12">
        <h2 class="text-3xl md:text-4xl font-bold text-gray-800 dark:text-white mb-4">Contact Us</h2>
        <p class="text-lg text-gray-600 dark:text-gray-300 max-w-3xl mx-auto">Have questions about our supply chain management system? Our team is here to help.</p>
      </div>
      
      <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 max-w-6xl mx-auto">
        <!-- Contact Form -->
        <div class="bg-gray-50 dark:bg-neutral-800 rounded-xl shadow-lg p-8">
          <h3 class="text-2xl font-bold text-gray-800 dark:text-white mb-6">Send us a message</h3>
          
          <form>
            <div class="mb-6">
              <label for="fullName" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Full Name</label>
              <input type="text" id="fullName" name="fullName" placeholder="Enter your full name" class="w-full px-4 py-3 rounded-lg bg-white dark:bg-neutral-700 border border-gray-300 dark:border-neutral-600 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent" required>
            </div>
            
            <div class="mb-6">
              <label for="email" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Email Address</label>
              <input type="email" id="email" name="email" placeholder="Enter your email address" class="w-full px-4 py-3 rounded-lg bg-white dark:bg-neutral-700 border border-gray-300 dark:border-neutral-600 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent" required>
            </div>
            
            <div class="mb-6">
              <label for="companyName" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Company Name</label>
              <input type="text" id="companyName" name="companyName" placeholder="Enter your company name" class="w-full px-4 py-3 rounded-lg bg-white dark:bg-neutral-700 border border-gray-300 dark:border-neutral-600 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
            </div>
            
            <div class="mb-6">
              <label for="role" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Your Role</label>
              <select id="role" name="role" class="w-full px-4 py-3 rounded-lg bg-white dark:bg-neutral-700 border border-gray-300 dark:border-neutral-600 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                <option value="" selected disabled>Select your role</option>
                <option value="supplier">Supplier</option>
                <option value="manufacturer">Manufacturer</option>
                <option value="warehouseManager">Warehouse Manager</option>
                <option value="transporter">Transporter</option>
                <option value="wholesaler">Wholesaler</option>
                <option value="retailer">Retailer</option>
                <option value="accountant">Accountant</option>
                <option value="other">Other</option>
              </select>
            </div>
            
            <div class="mb-6">
              <label for="message" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Message</label>
              <textarea id="message" name="message" rows="5" placeholder="How can we help you?" class="w-full px-4 py-3 rounded-lg bg-white dark:bg-neutral-700 border border-gray-300 dark:border-neutral-600 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent" required></textarea>
            </div>
            
            <div class="mb-6">
              <label class="flex items-center">
                <input type="checkbox" class="w-5 h-5 rounded text-blue-600 focus:ring-blue-500 border-gray-300 dark:border-neutral-600">
                <span class="ml-2 text-sm text-gray-700 dark:text-gray-300">I agree to receive communications about products, services, and events.</span>
              </label>
            </div>
            
            <button type="submit" class="w-full py-3 px-4 bg-blue-600 hover:bg-blue-700 text-white font-bold rounded-lg transition-colors duration-300 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50">
              Send Message
            </button>
          </form>
        </div>
        
        <!-- Contact Information -->
        <div class="flex flex-col justify-between">
          <div>
            <h3 class="text-2xl font-bold text-gray-800 dark:text-white mb-6">Get in touch</h3>
            
            <div class="space-y-8">
              <!-- Email -->
              <div class="flex items-start">
                <div class="flex-shrink-0">
                  <div class="w-12 h-12 bg-blue-100 dark:bg-blue-900 rounded-lg flex items-center justify-center">
                    <svg class="w-6 h-6 text-blue-600 dark:text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>
                    </svg>
                  </div>
                </div>
                <div class="ml-4">
                  <h4 class="text-lg font-semibold text-gray-800 dark:text-white">Email</h4>
                  <p class="text-gray-600 dark:text-gray-300 mt-1">info@supplychain-system.com</p>
                  <p class="text-gray-600 dark:text-gray-300">support@supplychain-system.com</p>
                </div>
              </div>
              
              <!-- Phone -->
              <div class="flex items-start">
                <div class="flex-shrink-0">
                  <div class="w-12 h-12 bg-green-100 dark:bg-green-900 rounded-lg flex items-center justify-center">
                    <svg class="w-6 h-6 text-green-600 dark:text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"></path>
                    </svg>
                  </div>
                </div>
                <div class="ml-4">
                  <h4 class="text-lg font-semibold text-gray-800 dark:text-white">Phone</h4>
                  <p class="text-gray-600 dark:text-gray-300 mt-1">+91 1234 5678 90 (Sales)</p>
                  <p class="text-gray-600 dark:text-gray-300">+91 1234 5678 90 (Support)</p>
                </div>
              </div>
              
              <!-- Location -->
              <div class="flex items-start">
                <div class="flex-shrink-0">
                  <div class="w-12 h-12 bg-purple-100 dark:bg-purple-900 rounded-lg flex items-center justify-center">
                    <svg class="w-6 h-6 text-purple-600 dark:text-purple-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"></path>
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"></path>
                    </svg>
                  </div>
                </div>
                <div class="ml-4">
                  <h4 class="text-lg font-semibold text-gray-800 dark:text-white">Office Locations</h4>
                  <p class="text-gray-600 dark:text-gray-300 mt-1">123 Supply Chain Avenue</p>
                  <p class="text-gray-600 dark:text-gray-300">Hinjewadi, Pune</p>
                </div>
              </div>
              
              <!-- Hours -->
              <div class="flex items-start">
                <div class="flex-shrink-0">
                  <div class="w-12 h-12 bg-yellow-100 dark:bg-yellow-900 rounded-lg flex items-center justify-center">
                    <svg class="w-6 h-6 text-yellow-600 dark:text-yellow-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                  </div>
                </div>
                <div class="ml-4">
                  <h4 class="text-lg font-semibold text-gray-800 dark:text-white">Business Hours</h4>
                  <p class="text-gray-600 dark:text-gray-300 mt-1">Monday - Friday: 9:00 AM - 6:00 PM EST</p>
                  <p class="text-gray-600 dark:text-gray-300">Support available 24/7 for Enterprise customers</p>
                </div>
              </div>
            </div>
          </div>
          
          <!-- Social Media -->
          <div class="mt-12">
            <h4 class="text-lg font-semibold text-gray-800 dark:text-white mb-4">Connect with us</h4>
            <div class="flex space-x-4">
              <a href="#" class="w-10 h-10 bg-blue-600 hover:bg-blue-700 rounded-full flex items-center justify-center text-white transition-colors duration-300">
                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                  <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
                </svg>
              </a>
              <a href="#" class="w-10 h-10 bg-blue-400 hover:bg-blue-500 rounded-full flex items-center justify-center text-white transition-colors duration-300">
                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                  <path d="M23.953 4.57a10 10 0 01-2.825.775 4.958 4.958 0 002.163-2.723 10.054 10.054 0 01-3.127 1.184 4.92 4.92 0 00-8.384 4.482C7.69 8.095 4.067 6.13 1.64 3.162a4.822 4.822 0 00-.666 2.475c0 1.71.87 3.213 2.188 4.096a4.904 4.904 0 01-2.228-.616v.06a4.923 4.923 0 003.946 4.827 4.996 4.996 0 01-2.212.085 4.936 4.936 0 004.604 3.417 9.867 9.867 0 01-6.102 2.105c-.39 0-.779-.023-1.17-.067a13.995 13.995 0 007.557 2.209c9.053 0 13.998-7.496 13.998-13.985 0-.21 0-.42-.015-.63A9.935 9.935 0 0024 4.59z"/>
                </svg>
              </a>
              <a href="#" class="w-10 h-10 bg-blue-800 hover:bg-blue-900 rounded-full flex items-center justify-center text-white transition-colors duration-300">
                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                  <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433a2.062 2.062 0 01-2.063-2.065 2.064 2.064 0 112.063 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>
                </svg>
              </a>
              <a href="#" class="w-10 h-10 bg-red-600 hover:bg-red-700 rounded-full flex items-center justify-center text-white transition-colors duration-300">
                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                  <path d="M23.498 6.186a3.016 3.016 0 00-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 00.502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 002.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 002.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z"/>
                </svg>
              </a>
            </div>
          </div>
        </div>
      </div>
      
    </div>
  </section>
</div>

</element><element id="7c01ac0d-a238-4bc7-92a3-7e72ec233ceb" data-section-id="7c01ac0d-a238-4bc7-92a3-7e72ec233ceb">


<div id="root">
  <footer id="footer" class="bg-gray-800 dark:bg-neutral-900 text-white pt-12 pb-8 transition-colors duration-300">
    <div class="container mx-auto px-4">
      <!-- Footer Top Section -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-8 mb-12">
        <!-- Company Info -->
        <div class="lg:col-span-2">
          <h2 class="text-2xl font-bold text-white mb-4">SupplyChain+</h2>
          <p class="text-gray-300 mb-6 max-w-md">Comprehensive supply chain and logistics management platform connecting suppliers, manufacturers, transporters, wholesalers, retailers, and accountants in one unified system.</p>
          <div class="flex space-x-4">
            <a href="#" class="text-gray-300 hover:text-white transition-colors duration-200">
              <span class="sr-only">Facebook</span>
              <svg class="h-6 w-6" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                <path fill-rule="evenodd" d="M22 12c0-5.523-4.477-10-10-10S2 6.477 2 12c0 4.991 3.657 9.128 8.438 9.878v-6.987h-2.54V12h2.54V9.797c0-2.506 1.492-3.89 3.777-3.89 1.094 0 2.238.195 2.238.195v2.46h-1.26c-1.243 0-1.63.771-1.63 1.562V12h2.773l-.443 2.89h-2.33v6.988C18.343 21.128 22 16.991 22 12z" clip-rule="evenodd" />
              </svg>
            </a>
            <a href="#" class="text-gray-300 hover:text-white transition-colors duration-200">
              <span class="sr-only">Twitter</span>
              <svg class="h-6 w-6" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                <path d="M8.29 20.251c7.547 0 11.675-6.253 11.675-11.675 0-.178 0-.355-.012-.53A8.348 8.348 0 0022 5.92a8.19 8.19 0 01-2.357.646 4.118 4.118 0 001.804-2.27 8.224 8.224 0 01-2.605.996 4.107 4.107 0 00-6.993 3.743 11.65 11.65 0 01-8.457-4.287 4.106 4.106 0 001.27 5.477A4.072 4.072 0 012.8 9.713v.052a4.105 4.105 0 003.292 4.022 4.095 4.095 0 01-1.853.07 4.108 4.108 0 003.834 2.85A8.233 8.233 0 012 18.407a11.616 11.616 0 006.29 1.84" />
              </svg>
            </a>
            <a href="#" class="text-gray-300 hover:text-white transition-colors duration-200">
              <span class="sr-only">LinkedIn</span>
              <svg class="h-6 w-6" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                <path fill-rule="evenodd" d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z" clip-rule="evenodd" />
              </svg>
            </a>
            <a href="#" class="text-gray-300 hover:text-white transition-colors duration-200">
              <span class="sr-only">YouTube</span>
              <svg class="h-6 w-6" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                <path fill-rule="evenodd" d="M19.812 5.418c.861.23 1.538.907 1.768 1.768C21.998 8.746 22 12 22 12s0 3.255-.418 4.814a2.504 2.504 0 0 1-1.768 1.768c-1.56.419-7.814.419-7.814.419s-6.255 0-7.814-.419a2.505 2.505 0 0 1-1.768-1.768C2 15.255 2 12 2 12s0-3.255.417-4.814a2.507 2.507 0 0 1 1.768-1.768C5.744 5 11.998 5 11.998 5s6.255 0 7.814.418ZM15.194 12 10 15V9l5.194 3Z" clip-rule="evenodd" />
              </svg>
            </a>
          </div>
        </div>
        
        <!-- Quick Links -->
        <div>
          <h3 class="text-lg font-semibold text-white mb-4">Quick Links</h3>
          <ul class="space-y-2">
            <li><a href="#" class="text-gray-300 hover:text-white transition-colors duration-200">Home</a></li>
            <li><a href="#" class="text-gray-300 hover:text-white transition-colors duration-200">About Us</a></li>
            <li><a href="#features" class="text-gray-300 hover:text-white transition-colors duration-200">Features</a></li>
            
            <li><a href="#testimonials" class="text-gray-300 hover:text-white transition-colors duration-200">Testimonials</a></li>
            <li><a href="#contact" class="text-gray-300 hover:text-white transition-colors duration-200">Contact Us</a></li>
          </ul>
        </div>
        
        <!-- Solutions -->
        <div>
          <h3 class="text-lg font-semibold text-white mb-4">Solutions</h3>
          <ul class="space-y-2">
            <li><a href="#" class="text-gray-300 hover:text-white transition-colors duration-200">Supplier Management</a></li>
            <li><a href="#" class="text-gray-300 hover:text-white transition-colors duration-200">Manufacturing</a></li>
            <li><a href="#" class="text-gray-300 hover:text-white transition-colors duration-200">Warehouse Management</a></li>
            <li><a href="#" class="text-gray-300 hover:text-white transition-colors duration-200">Transportation</a></li>
            <li><a href="#" class="text-gray-300 hover:text-white transition-colors duration-200">Retail Integration</a></li>
            <li><a href="#" class="text-gray-300 hover:text-white transition-colors duration-200">Accounting</a></li>
          </ul>
        </div>
        
        <!-- Support -->
        <div>
          <h3 class="text-lg font-semibold text-white mb-4">Support</h3>
          <ul class="space-y-2">
            <li><a href="#" class="text-gray-300 hover:text-white transition-colors duration-200">Help Center</a></li>
            <li><a href="#" class="text-gray-300 hover:text-white transition-colors duration-200">Documentation</a></li>
            <li><a href="#" class="text-gray-300 hover:text-white transition-colors duration-200">API Reference</a></li>
            <li><a href="#" class="text-gray-300 hover:text-white transition-colors duration-200">System Status</a></li>
            <li><a href="#" class="text-gray-300 hover:text-white transition-colors duration-200">Security</a></li>
            <li><a href="#faq" class="text-gray-300 hover:text-white transition-colors duration-200">FAQ</a></li>
          </ul>
        </div>
      </div>
      
      <!-- Divider -->
      <div class="border-t border-gray-700 dark:border-neutral-700 mb-8"></div>
      
      <!-- Footer Bottom Section -->
      <div class="md:flex md:items-center md:justify-between">
        <div class="text-sm text-gray-400">
          <p>&copy; 2023 SupplyChain+. All rights reserved.</p>
        </div>
        
        <div class="mt-4 md:mt-0">
          <ul class="flex flex-wrap space-x-5 text-sm text-gray-400">
            <li><a href="#" class="hover:text-white transition-colors duration-200">Terms of Service</a></li>
            <li><a href="#" class="hover:text-white transition-colors duration-200">Privacy Policy</a></li>
            <li><a href="#" class="hover:text-white transition-colors duration-200">Cookie Policy</a></li>
            <li><a href="#" class="hover:text-white transition-colors duration-200">Accessibility</a></li>
          </ul>
        </div>
      </div>
      
      <!-- App Store Links -->
      <div class="mt-8 flex flex-col sm:flex-row items-center justify-center space-y-4 sm:space-y-0 sm:space-x-4">
        <a href="#" class="bg-black hover:bg-gray-900 text-white flex items-center px-4 py-2 rounded-lg transition-colors duration-200">
          <svg class="h-6 w-6 mr-2" fill="currentColor" viewBox="0 0 24 24">
            <path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.81-.91.65.03 2.47.26 3.64 1.98-.09.06-2.17 1.28-2.15 3.81.03 3.02 2.65 4.03 2.68 4.04-.03.07-.42 1.44-1.38 2.83M13 3.5c.73-.83 1.94-1.46 2.94-1.5.13 1.17-.34 2.35-1.04 3.19-.69.85-1.83 1.51-2.95 1.42-.15-1.15.41-2.35 1.05-3.11z"/>
          </svg>
          <div>
            <div class="text-xs">Download on the</div>
            <div class="text-base font-semibold">App Store</div>
          </div>
        </a>
        
        <a href="#" class="bg-black hover:bg-gray-900 text-white flex items-center px-4 py-2 rounded-lg transition-colors duration-200">
          <svg class="h-6 w-6 mr-2" fill="currentColor" viewBox="0 0 24 24">
            <path d="M3 20.69a2.9 2.9 0 0 0 2.24 1.36c.82-.01 1.57-.4 2.16-1.01l8.59-8.59-3.83-3.83-8.59 8.59c-.53.53-.91 1.22-.95 1.95a3.02 3.02 0 0 0 .38 1.53zm16.76-13.01l-1.32-1.32c-.88-.86-2.29-.89-3.25.02l-1.52 1.52 3.83 3.83 1.52-1.52c.89-.89.89-1.74.74-2.53z"/>
            <path d="M5.26 12.53a2.9 2.9 0 0 1 2.24 1.36c.82-.01 1.57-.4 2.16-1.01l8.59-8.59-3.83-3.83-8.59 8.59c-.53.53-.91 1.22-.95 1.95a3.02 3.02 0 0 0 .38 1.53z"/>
          </svg>
          <div>
            <div class="text-xs">GET IT ON</div>
            <div class="text-base font-semibold">Google Play</div>
          </div>
        </a>
      </div>
      
    
    </div>
  </footer>
</div>

</element></div>
      </main>

      <!-- {bodyScripts} -->
   </body>
</html>