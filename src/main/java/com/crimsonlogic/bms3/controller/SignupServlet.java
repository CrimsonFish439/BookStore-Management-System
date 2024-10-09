package com.crimsonlogic.bms3.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.crimsonlogic.bms3.dao.UserDao;
import com.crimsonlogic.bms3.dao.UserDaoImpl;
import com.crimsonlogic.bms3.model.User;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 5508518383396166604L;
    private UserDao userDao;

    public void init() {
        userDao = new UserDaoImpl();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String firstName = request.getParameter("firstname");
        String lastName = request.getParameter("lastname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        long phone = Long.parseLong(request.getParameter("phone"));

        // Server-side validations
        if (firstName.isEmpty() || lastName.isEmpty() || email.isEmpty() || password.isEmpty() || confirmPassword.isEmpty()) {
            response.sendRedirect("index/signup.jsp?signupError=emptyFields");
            return;
        }

        if (!password.equals(confirmPassword)) {
            response.sendRedirect("index/signup.jsp?signupError=passwordMismatch");
            return;
        }

        if (!isValidPassword(password)) {
            response.sendRedirect("index/signup.jsp?signupError=invalidPassword");
            return;
        }

        // Check if email or phone already exists
        if (userDao.isEmailExists(email)) {
            response.sendRedirect("index/signup.jsp?signupError=emailExists");
            return;
        }

        if (userDao.isPhoneExists(phone)) {
            response.sendRedirect("index/signup.jsp?signupError=phoneExists");
            return;
        }

        // Create a new user object
        User newUser = new User();
        newUser.setUserFirstName(firstName);
        newUser.setUserLastName(lastName);
        newUser.setUserEmail(email);
        newUser.setUserPassword(password);
        newUser.setUserPhoneNo(phone);

        boolean isUserAdded = userDao.addUser(newUser);
        if (isUserAdded) {
            // Redirect to the signin page after successful signup
            response.sendRedirect("index/signin.jsp?signupSuccess=true");
        } else {
            // Redirect back to signup page with an error
            response.sendRedirect("index/signup.jsp?signupError=unknown");
        }
    }

    private boolean isValidPassword(String password) {
        String passwordPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
        return password.matches(passwordPattern);
    }
}
