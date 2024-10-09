package com.crimsonlogic.bms3.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.crimsonlogic.bms3.dao.WalletDao;
import com.crimsonlogic.bms3.dao.WalletDaoImpl;
import com.crimsonlogic.bms3.model.Wallet;

@WebServlet("/wallet")
public class WalletServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private WalletDao walletDao;

    public void init() {
        walletDao = new WalletDaoImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/index/signin.jsp");
            return;
        }

        switch (action) {
            case "addFunds":
                handleAddFunds(request, response, userId);
                break;
            case "deductFunds":
                handleDeductFunds(request, response, userId);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/users/userHome.jsp");
                break;
        }
    }

    private void handleAddFunds(HttpServletRequest request, HttpServletResponse response, int userId) throws IOException {
        try {
            double amountToAdd = parseAmount(request.getParameter("amount"));

            if (amountToAdd <= 0) {
                response.sendRedirect(request.getContextPath() + "/users/wallet.jsp?error=invalidAmount");
                return;
            }

            boolean success = walletDao.addToWallet(userId, amountToAdd);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/wallet?action=view&success=addFunds");
            } else {
                response.sendRedirect(request.getContextPath() + "/users/wallet.jsp?error=addFundsFailed");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/users/wallet.jsp?error=invalidInput");
        }
    }

    private void handleDeductFunds(HttpServletRequest request, HttpServletResponse response, int userId) throws IOException {
        try {
            double amountToDeduct = parseAmount(request.getParameter("amount"));

            if (amountToDeduct <= 0) {
                response.sendRedirect(request.getContextPath() + "/users/wallet.jsp?error=invalidAmount");
                return;
            }

            boolean success = walletDao.deductFromWallet(userId, amountToDeduct);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/wallet?action=view&success=deductFunds");
            } else {
                response.sendRedirect(request.getContextPath() + "/users/wallet.jsp?error=deductFundsFailed");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/users/wallet.jsp?error=invalidInput");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/index/signin.jsp");
            return;
        }

        if ("view".equals(action)) {
            Wallet wallet = walletDao.getWalletByUserId(userId);
            request.setAttribute("wallet", wallet);
            request.getRequestDispatcher("/users/wallet.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/users/userHome.jsp");
        }
    }

    // Helper method to parse the amount and handle exceptions
    private double parseAmount(String amountStr) throws NumberFormatException {
        if (amountStr == null || amountStr.isEmpty()) {
            throw new NumberFormatException("Invalid or empty amount");
        }
        return Double.parseDouble(amountStr);
    }
}
