package com.scm.ERROR;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class ErrorHandler extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
}
