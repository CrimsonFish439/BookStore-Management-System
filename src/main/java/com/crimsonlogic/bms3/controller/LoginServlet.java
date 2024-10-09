package com.crimsonlogic.bms3.controller;

import java.io.IOException;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.crimsonlogic.bms3.dao.UserDao;
import com.crimsonlogic.bms3.dao.UserDaoImpl;
import com.crimsonlogic.bms3.model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDao userDao;

    public void init() {
        userDao = new UserDaoImpl();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Optional<User> user = userDao.getUserByEmailAndPassword(email, password);
        if (user.isPresent()) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user.get());  // Store the full User object in the session
            session.setAttribute("userId", user.get().getUserId());  // Store the user ID in the session separately

            // Check if the user is an admin
            if (user.get().isAdmin()) {
                response.sendRedirect("admin/adminHome.jsp");
            } else {
                response.sendRedirect("users/userHome.jsp");
            }
        } else {
            // Redirect back to signin page with an error message
            response.sendRedirect("index/signin.jsp?loginError=true");
        }
    }
}
