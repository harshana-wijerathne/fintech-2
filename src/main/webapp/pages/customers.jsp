<%@ page import="site.wijerathne.harshana.fintech.model.Customer" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="./../css/style.css">
    <script type="module" src="../js/customers.js" defer></script>
</head>
<body>
<%--<%--%>
<%--    response.setHeader("Cache-Control","no-cache,no-store,must,revalidate"); //HTTP 1.1--%>
<%--    response.setHeader("Pragma","no-cache"); //HTTP 1.0--%>
<%--    response.setHeader("Expires","0");--%>

<%--    if (session.getAttribute("username") == null) {--%>
<%--        response.sendRedirect("login.jsp");--%>
<%--    }--%>
<%--%>--%>
<%@include file="header.jsp" %>
<div class="main-content">
    <div id="customersPage" class="page">
        <div class="card">
            <div style="display: flex; justify-content: space-between ; align-items: center; margin-bottom: 1rem">
                <div class="card-title">
                    <i data-lucide="users"></i>
                    Customer List
                </div>
                <button class="btn btn-primary" id="addNewCustomerButton" onclick="viewAddNewCustomerModal()">
                    <i data-lucide="user-plus"></i>
                    Add New Customer
                </button>
            </div>

            <div class="search-bar">
                <input type="text" class="search-input" onkeyup="searchUser(event)"
                       placeholder="Search by name or NIC..." id="customerSearch">
                <button class="btn btn-primary">
                    <i data-lucide="search"></i>
                    Search
                </button>
            </div>
            <div class="table-container">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Full Name</th>
                        <th>NIC/Passport</th>
                        <th>Mobile</th>
                        <th>Email</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody id="customersTableBody">
                    <%--                    <c:forEach items="${sessionScope.customers}" var="c">--%>
                    <%--                        <tr>--%>
                    <%--                            <td>${c.fullName}</td>--%>
                    <%--                            <td>${c.nicPassport}</td>--%>
                    <%--                            <td>${c.mobile}</td>--%>
                    <%--                            <td>${c.email}</td>--%>
                    <%--                            <td>--%>
                    <%--                                <button class="btn btn-warning" onclick="editCustomer(${c.id})">--%>
                    <%--                                    <i data-lucide="edit"></i>--%>
                    <%--                                    Edit--%>
                    <%--                                </button>--%>
                    <%--                                <button class="btn btn-danger" onclick="deleteCustomer(${c.id})">--%>
                    <%--                                    <i data-lucide="trash"></i>--%>
                    <%--                                    Delete--%>
                    <%--                                </button>--%>
                    <%--                            </td>--%>
                    <%--                        </tr>--%>
                    <%--                    </c:forEach>--%>

                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div id="AddNewCustomerModal" class="modal">
        <div class="modal-content" style="max-width: 800px">
            <div class="modal-header">
                <div class="card-title">
                    <i data-lucide="user-plus"></i>
                    Add New Customer
                </div>
                <button class="close-btn" onclick="closeModal()"><i data-lucide="square-x"></i></button>
            </div>
            <div id="accountDetailsContent">
                <form class="form-grid" id="customerForm">
                    <div class="form-group">
                        <label class="form-label">Full Name</label>
                        <input type="text" class="form-input" name="fullName" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">NIC/Passport No</label>
                        <input type="text" class="form-input" name="nicPassport" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Date of Birth</label>
                        <input type="date" class="form-input" name="dob" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Address</label>
                        <input type="text" class="form-input" name="address" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Mobile Number</label>
                        <input type="tel" class="form-input" name="mobile" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Email Address</label>
                        <input type="email" class="form-input" name="email" required>
                    </div>
                    <div class="form-group" style="grid-column: span 2;">
                        <button type="submit" class="btn btn-primary">
                            <i data-lucide="user-plus"></i>
                            Add Customer
                        </button>
                    </div>
                    <button type="button" id="dumydatabutton" onclick="dummyButtonHandle()">Demo data</button>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>
