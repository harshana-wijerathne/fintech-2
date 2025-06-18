<%--
  Created by IntelliJ IDEA.
  User: harshana
  Date: 6/17/25
  Time: 1:26 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="./../css/style.css">
</head>
<body>
<%--<%--%>
<%--    response.setHeader("Cache-Control","no-cache,no-store,must,revalidate"); //HTTP 1.1--%>
<%--    response.setHeader("Pragma","no-cache"); //HTTP 1.0--%>
<%--    response.setHeader("Expires","0");--%>

<%--    if(session.getAttribute("username")==null){--%>
<%--        response.sendRedirect("login.jsp");--%>
<%--    }--%>
<%--%>--%>

<%@include file="header.jsp"%>
<div class="main-content">
    <div id="accountsPage" class="page">
        <div class="card">
            <div class="card-title">
                <i data-lucide="plus-circle"></i>
                Open New Savings Account
            </div>
            <form class="form-grid" id="accountForm">
                <div class="form-group">
                    <label class="form-label">Select Customer</label>
                    <select class="form-input" name="customerId" required>
                        <option value="">Choose a customer...</option>
                        <option value="1">John Smith - 199512345678</option>
                        <option value="2">Sarah Johnson - 198712345678</option>
                        <option value="3">Mike Davis - 199012345678</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">Opening Date</label>
                    <input type="date" class="form-input" name="openingDate" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Initial Deposit</label>
                    <input type="number" class="form-input" name="initialDeposit" min="100" step="0.01" required>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-success">
                        <i data-lucide="plus-circle"></i>
                        Open Account
                    </button>
                </div>
            </form>
        </div>

        <div class="card">
            <div class="card-title">
                <i data-lucide="credit-card"></i>
                Account Details
            </div>
            <div class="table-container">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Account Number</th>
                        <th>Customer Name</th>
                        <th>Opening Date</th>
                        <th>Current Balance</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>SAV001234567</td>
                        <td>John Smith</td>
                        <td>2024-01-15</td>
                        <td>$15,250.00</td>
                        <td>
                            <button class="btn btn-primary" onclick="viewAccountDetails('SAV001234567')">
                                <i data-lucide="eye"></i>
                                View
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>SAV001234568</td>
                        <td>Sarah Johnson</td>
                        <td>2024-02-20</td>
                        <td>$8,750.00</td>
                        <td>
                            <button class="btn btn-primary" onclick="viewAccountDetails('SAV001234568')">
                                <i data-lucide="eye"></i>
                                View
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>SAV001234569</td>
                        <td>Mike Davis</td>
                        <td>2024-03-10</td>
                        <td>$12,500.00</td>
                        <td>
                            <button class="btn btn-primary" onclick="viewAccountDetails('SAV001234569')">
                                <i data-lucide="eye"></i>
                                View
                            </button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
