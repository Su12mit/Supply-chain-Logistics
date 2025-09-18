package com.scm.Transport;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;

@MultipartConfig
public class LoginId extends HttpServlet {

	public static void setLoginId(HttpSession session, int loginId) {
        session.setAttribute("login_id", loginId);
    }

    public static int getLoginId(HttpSession session) {
        Object loginId = session.getAttribute("login_id");
        return (loginId != null) ? (int) loginId : -1; // Return -1 if no ID is found
    }

   
}