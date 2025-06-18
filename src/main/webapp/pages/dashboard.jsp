<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <link rel="stylesheet" href="../css/style.css">
    <script type="module" src="https://unpkg.com/lucide@latest/dist/umd/lucide.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            lucide.createIcons();
        });
    </script>
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
    <div id="dashboardPage" class="page active">
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-number">156</div>
                <div class="stat-label">Total Customers</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">89</div>
                <div class="stat-label">Active Accounts</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">$2.4M</div>
                <div class="stat-label">Total Deposits</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">1,234</div>
                <div class="stat-label">Transactions Today</div>
            </div>
        </div>

        <div class="card">
            <div class="card-title">
                <i data-lucide="trending-up"></i>
                Recent Activity
            </div>
            <div class="table-container">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Date</th>
                        <th>Account Number</th>
                        <th>Transaction Type</th>
                        <th>Amount</th>
                        <th>Balance After Transaction</th>
                    </tr>
                    </thead>
                    <tbody id="transactionHistoryBody">
                    <tr>
                        <td>2025-06-16</td>
                        <td>SAV001234567</td>
                        <td><span style="color: #28a745;">Deposit</span></td>
                        <td>$1,500.00</td>
                        <td>$15,250.00</td>
                    </tr>
                    <tr>
                        <td>2025-06-15</td>
                        <td>SAV001234568</td>
                        <td><span style="color: #dc3545;">Withdrawal</span></td>
                        <td>$300.00</td>
                        <td>$8,750.00</td>
                    </tr>
                    <tr>
                        <td>2025-06-15</td>
                        <td>SAV001234569</td>
                        <td><span style="color: #28a745;">Deposit</span></td>
                        <td>$750.00</td>
                        <td>$12,500.00</td>
                    </tr>
                    <tr>
                        <td>2025-06-14</td>
                        <td>SAV001234567</td>
                        <td><span style="color: #dc3545;">Withdrawal</span></td>
                        <td>$500.00</td>
                        <td>$13,750.00</td>
                    </tr>
                    <tr>
                        <td>2025-06-14</td>
                        <td>SAV001234568</td>
                        <td><span style="color: #28a745;">Deposit</span></td>
                        <td>$2,000.00</td>
                        <td>$9,050.00</td>
                    </tr>
                    <tr>
                        <td>2025-06-13</td>
                        <td>SAV001234569</td>
                        <td><span style="color: #dc3545;">Withdrawal</span></td>
                        <td>$1,250.00</td>
                        <td>$11,750.00</td>
                    </tr>
                    <tr>
                        <td>2025-06-10</td>
                        <td>SAV001234567</td>
                        <td><span style="color: #28a745;">Deposit</span></td>
                        <td>$5,000.00</td>
                        <td>$14,250.00</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>