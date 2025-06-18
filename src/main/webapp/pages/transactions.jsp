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
    <div id="transactionsPage" class="page">
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem;">
            <!-- Deposit Money -->
            <div class="card">
                <div class="card-title">
                    <i data-lucide="plus"></i>
                    Deposit Money
                </div>
                <form id="depositForm">
                    <div class="form-group">
                        <label class="form-label">Account Number</label>
                        <select class="form-input" name="accountNumber" required>
                            <option value="">Select account...</option>
                            <option value="SAV001234567">SAV001234567 - John Smith</option>
                            <option value="SAV001234568">SAV001234568 - Sarah Johnson</option>
                            <option value="SAV001234569">SAV001234569 - Mike Davis</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Amount</label>
                        <input type="number" class="form-input" name="amount" min="1" step="0.01" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Date</label>
                        <input type="date" class="form-input" name="date" required>
                    </div>
                    <button type="submit" class="btn btn-success">
                        <i data-lucide="plus"></i>
                        Deposit
                    </button>
                </form>
            </div>

            <!-- Withdraw Money -->
            <div class="card">
                <div class="card-title">
                    <i data-lucide="minus"></i>
                    Withdraw Money
                </div>
                <form id="withdrawForm">
                    <div class="form-group">
                        <label class="form-label">Account Number</label>
                        <select class="form-input" name="accountNumber" required>
                            <option value="">Select account...</option>
                            <option value="SAV001234567">SAV001234567 - John Smith</option>
                            <option value="SAV001234568">SAV001234568 - Sarah Johnson</option>
                            <option value="SAV001234569">SAV001234569 - Mike Davis</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Amount</label>
                        <input type="number" class="form-input" name="amount" min="1" step="0.01" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Date</label>
                        <input type="date" class="form-input" name="date" required>
                    </div>
                    <button type="submit" class="btn btn-danger">
                        <i data-lucide="minus"></i>
                        Withdraw
                    </button>
                </form>
            </div>
        </div>

        <!-- Transaction History -->
        <div class="card">
            <div class="card-title">
                <i data-lucide="history"></i>
                Transaction History
            </div>
            <div style="display: grid; grid-template-columns: 1fr 1fr 1fr auto; gap: 1rem; margin-bottom: 2rem; align-items: end;">
                <div class="form-group">
                    <label class="form-label">Account Number</label>
                    <select class="form-input" id="historyAccount">
                        <option value="">All accounts</option>
                        <option value="SAV001234567">SAV001234567 - John Smith</option>
                        <option value="SAV001234568">SAV001234568 - Sarah Johnson</option>
                        <option value="SAV001234569">SAV001234569 - Mike Davis</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">From Date</label>
                    <input type="date" class="form-input" id="fromDate">
                </div>
                <div class="form-group">
                    <label class="form-label">To Date</label>
                    <input type="date" class="form-input" id="toDate">
                </div>
                <button class="btn btn-primary" onclick="filterTransactions()">
                    <i data-lucide="filter"></i>
                    Filter
                </button>
            </div>

            <div class="table-container">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Date</th>
                        <th>Account Number</th>
                        <th>Transaction Type</th>
                        <th>Amount</th>
                        <th>Balance After</th>
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
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
