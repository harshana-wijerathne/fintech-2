<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Management | SecureBank Pro</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">

    <!-- Custom CSS -->
    <style>
        :root {
            --primary: #2a4b7c;
            --secondary: #5a8fcc;
            --accent: #ff6b35;
            --light: #f8f9fa;
            --dark: #212529;
            --success: #28a745;
            --info: #17a2b8;
            --warning: #ffc107;
            --danger: #dc3545;
        }

        body {
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            background-color: #f5f7fa;
            color: var(--dark);
        }

        /* Sidebar styling */
        .sidebar {
            background: linear-gradient(180deg, var(--primary) 0%, #1a365d 100%);
            color: white;
            height: 100vh;
            position: fixed;
            width: 250px;
            transition: all 0.3s;
            z-index: 1000;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
        }

        .sidebar-brand {
            padding: 1.5rem;
            font-size: 1.2rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar-brand i {
            font-size: 1.5rem;
            margin-right: 10px;
        }

        .nav-link {
            color: rgba(255, 255, 255, 0.8);
            padding: 0.75rem 1.5rem;
            margin: 0.25rem 0;
            border-radius: 0;
            transition: all 0.2s;
            display: flex;
            align-items: center;
        }

        .nav-link:hover, .nav-link.active {
            color: white;
            background-color: rgba(255, 255, 255, 0.1);
        }

        .nav-link i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }

        /* Main content area */
        .main-content {
            margin-left: 250px;
            padding: 2rem;
            transition: all 0.3s;
        }

        /* Header */
        .topbar {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            padding: 1rem;
            margin-bottom: 2rem;
            border-radius: 0.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .user-profile {
            display: flex;
            align-items: center;
        }

        .user-profile img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
            object-fit: cover;
        }

        /* Cards */
        .card {
            border: none;
            border-radius: 0.5rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            transition: transform 0.2s, box-shadow 0.2s;
            margin-bottom: 1.5rem;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            background-color: white;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            padding: 1.25rem 1.5rem;
            border-radius: 0.5rem 0.5rem 0 0 !important;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-title {
            margin: 0;
            font-size: 1.25rem;
            font-weight: 600;
            display: flex;
            align-items: center;
        }

        .card-title i {
            margin-right: 10px;
            color: var(--secondary);
        }

        /* Buttons */
        .btn-primary {
            background-color: var(--primary);
            border-color: var(--primary);
        }

        .btn-primary:hover {
            background-color: #1e3a68;
            border-color: #1e3a68;
        }

        .btn-outline-primary {
            color: var(--primary);
            border-color: var(--primary);
        }

        .btn-outline-primary:hover {
            background-color: var(--primary);
            border-color: var(--primary);
        }

        /* Tables */
        .table {
            margin-bottom: 0;
        }

        .table thead th {
            background-color: var(--primary);
            color: white;
            border-bottom: none;
            padding: 1rem;
            font-weight: 500;
        }

        .table tbody tr {
            transition: all 0.2s;
        }

        .table tbody tr:hover {
            background-color: rgba(42, 75, 124, 0.03);
        }

        .table td, .table th {
            vertical-align: middle;
            padding: 1rem;
        }

        /* Forms */
        .form-control, .form-select {
            border-radius: 0.375rem;
            padding: 0.5rem 1rem;
            border: 1px solid #dee2e6;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--secondary);
            box-shadow: 0 0 0 0.25rem rgba(90, 143, 204, 0.25);
        }

        /* Search bar */
        .search-bar {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .search-bar .form-control {
            padding-left: 2.5rem;
            border-radius: 2rem;
        }

        .search-bar i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }

        /* Modal */
        .modal-content {
            border: none;
            border-radius: 0.5rem;
        }

        .modal-header {
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            padding: 1.5rem;
        }

        .modal-footer {
            border-top: 1px solid rgba(0, 0, 0, 0.05);
        }

        /* Responsive adjustments */
        @media (max-width: 992px) {
            .sidebar {
                margin-left: -250px;
            }

            .sidebar.active {
                margin-left: 0;
            }

            .main-content {
                margin-left: 0;
            }

            .topbar .btn {
                padding: 0.375rem 0.75rem;
            }
        }

        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .fade-in {
            animation: fadeIn 0.3s ease-out;
        }

        /* Notification */
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1100;
            animation: fadeIn 0.3s;
        }

        /* Badge */
        .badge {
            font-weight: 500;
            padding: 0.35em 0.65em;
        }

        /* Action buttons */
        .action-btn {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
            margin: 0 0.25rem;
        }
    </style>
</head>
<body>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    }
%>
<!-- Sidebar -->
<div class="sidebar">
    <div class="sidebar-brand">
        <i class="bi bi-building"></i>
        <span>SecureBank Pro</span>
    </div>
    <nav class="nav flex-column">
        <a href="dashboard.jsp" class="nav-link">
            <i class="bi bi-speedometer2"></i>
            Dashboard
        </a>
        <a href="customers.jsp" class="nav-link active">
            <i class="bi bi-people-fill"></i>
            Customers
        </a>
        <a href="accounts.jsp" class="nav-link">
            <i class="bi bi-credit-card"></i>
            Accounts
        </a>
        <a href="transactions.jsp" class="nav-link">
            <i class="bi bi-arrow-left-right"></i>
            Transactions
        </a>
    </nav>
</div>

<!-- Main Content -->
<div class="main-content">
    <!-- Top Bar -->
    <div class="topbar fade-in">
        <button class="btn btn-outline-primary d-lg-none" id="sidebarToggle">
            <i class="bi bi-list"></i>
        </button>
        <div class="user-profile">
            <img src="https://ui-avatars.com/api/?name=Admin&background=2a4b7c&color=fff" alt="Admin">
            <div>
                <div class="fw-bold">Admin</div>
                <small class="text-muted">Administrator</small>
            </div>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger ms-3">
                <i class="bi bi-box-arrow-right"></i>
            </a>
        </div>
    </div>

    <!-- Page Content -->
    <div class="container-fluid">
        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold"><i class="bi bi-people-fill text-primary me-2"></i> Customer Management</h2>
            <button class="btn btn-primary" onclick="viewAddNewCustomerModal()">
                <i class="bi bi-plus-lg me-1"></i> Add New Customer
            </button>
        </div>

        <!-- Customer List Card -->
        <div class="card fade-in">
            <div class="card-header">
                <h3 class="card-title"><i class="bi bi-list-ul"></i> Customer List</h3>
                <div class="search-bar">
                    <i class="bi bi-search"></i>
                    <input type="text" class="form-control" placeholder="Search by name or NIC..."
                           id="customerSearch" onkeyup="searchUser(event)">
                </div>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead>
                        <tr>
                            <th>Full Name</th>
                            <th>NIC/Passport</th>
                            <th>Mobile</th>
                            <th>Email</th>
                            <th class="text-end">Actions</th>
                        </tr>
                        </thead>
                        <tbody id="customersTableBody">
                        <!-- Customers will be loaded here dynamically -->
                        <tr>
                            <td colspan="5" class="text-center py-4">
                                <div class="spinner-border text-primary" role="status">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="card-footer bg-white">
                <nav>
                    <ul class="pagination justify-content-center mb-0">
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1">Previous</a>
                        </li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#">Next</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</div>

<!-- Add New Customer Modal -->
<div class="modal fade" id="AddNewCustomerModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><i class="bi bi-person-plus me-2"></i> Add New Customer</h5>
                <button type="button" class="btn-close" onclick="closeModal()"></button>
            </div>
            <form id="customerForm">
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="fullName" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="fullName" name="fullName" required>
                        </div>
                        <div class="col-md-6">
                            <label for="nicPassport" class="form-label">NIC/Passport No</label>
                            <input type="text" class="form-control" id="nicPassport" name="nicPassport" required>
                        </div>
                        <div class="col-md-6">
                            <label for="dob" class="form-label">Date of Birth</label>
                            <input type="date" class="form-control" id="dob" name="dob" required>
                        </div>
                        <div class="col-md-6">
                            <label for="mobile" class="form-label">Mobile Number</label>
                            <input type="tel" class="form-control" id="mobile" name="mobile" required>
                        </div>
                        <div class="col-12">
                            <label for="address" class="form-label">Address</label>
                            <input type="text" class="form-control" id="address" name="address" required>
                        </div>
                        <div class="col-md-6">
                            <label for="email" class="form-label">Email Address</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="col-md-6">
                            <label for="customerType" class="form-label">Customer Type</label>
                            <select class="form-select" id="customerType" name="customerType">
                                <option value="INDIVIDUAL">Individual</option>
                                <option value="BUSINESS">Business</option>
                                <option value="VIP">VIP</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" onclick="closeModal()">Cancel</button>
                    <button type="button" class="btn btn-outline-info" onclick="dummyButtonHandle()">
                        <i class="bi bi-magic me-1"></i> Fill Demo Data
                    </button>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-save me-1"></i> Save Customer
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Your existing JavaScript with some enhancements -->
<script>
    document.addEventListener('DOMContentLoaded', function () {
        getAllCustomers();

        // Initialize Bootstrap tooltips
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });

        // Sidebar toggle for mobile
        document.getElementById('sidebarToggle').addEventListener('click', function() {
            document.querySelector('.sidebar').classList.toggle('active');
        });

        // Initialize modal
        var addCustomerModal = new bootstrap.Modal(document.getElementById('AddNewCustomerModal'));
        window.viewAddNewCustomerModal = function() {
            addCustomerModal.show();
        };

        window.closeModal = function() {
            addCustomerModal.hide();
        };
    });

    const getAllCustomers = async () => {
        console.log("came")
        try {
            const response = await fetch("/admin/customers");
            const customers = await response.json();
            const tableBody = document.getElementById("customersTableBody");

            if (customers && customers.length > 0) {
                let html = '';
                customers.forEach(customer => {
                    html += `
                        <tr>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="avatar me-3">
                                        <span class="avatar-initial bg-primary rounded-circle">${customer.fullName.charAt(0)}</span>
                                    </div>
                                    <div>
                                        <h6 class="mb-0">${customer.fullName}</h6>
                                        <small class="text-muted">ID: ${customer.id}</small>
                                    </div>
                                </div>
                            </td>
                            <td>${customer.nicPassport}</td>
                            <td>${customer.mobile}</td>
                            <td>${customer.email}</td>
                            <td class="text-end">
                                <div class="btn-group" role="group">
                                    <button class="btn btn-sm btn-outline-primary action-btn" onclick="viewAccountDetails('${customer.id}')" data-bs-toggle="tooltip" title="View">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-warning action-btn" onclick="editCustomer(${customer.id})" data-bs-toggle="tooltip" title="Edit">
                                        <i class="bi bi-pencil"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-danger action-btn" onclick="deleteCustomer(${customer.id})" data-bs-toggle="tooltip" title="Delete">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>`;
                });
                tableBody.innerHTML = html;
            } else {
                tableBody.innerHTML = `<tr><td colspan="5" class="text-center py-4 text-muted">No customers found</td></tr>`;
            }
        } catch (error) {
            console.error("Error fetching customers:", error);
            document.getElementById("customersTableBody").innerHTML =
                `<tr><td colspan="5" class="text-center py-4 text-danger">Error loading customer data</td></tr>`;
        }
    };

    window.deleteCustomer = async (id) => {
        if (confirm('Are you sure you want to delete this customer?')) {
            try {
                const response = await fetch("/admin/customers?id="+id, {method: "delete"});
                if (response.ok) {
                    showNotification('Customer deleted successfully', 'success');
                    getAllCustomers();
                } else {
                    throw new Error('Failed to delete customer');
                }
            } catch(error) {
                showNotification('Failed to delete customer', 'error');
                console.error('Delete error:', error);
            }
        }
    };

    // Enhanced search function with debouncing
    function debounce(func, timeout = 300) {
        let timer;
        return (...args) => {
            clearTimeout(timer);
            timer = setTimeout(() => { func.apply(this, args); }, timeout);
        };
    }

    const searchUser = debounce(async (event) => {
        const searchTerm = event.target.value.trim();
        if (searchTerm.length === 0) {
            getAllCustomers();
            return;
        }

        try {
            const response = await fetch(`/admin/customers?search=${encodeURIComponent(searchTerm)}`);
            const customers = await response.json();
            updateCustomerTable(customers);
        } catch (error) {
            console.error('Search error:', error);
            showNotification('Error searching customers', 'error');
        }
    });

    function updateCustomerTable(customers) {
        const tableBody = document.getElementById('customersTableBody');
        if (!customers || customers.length === 0) {
            tableBody.innerHTML = '<tr><td colspan="5" class="text-center py-4 text-muted">No matching customers found</td></tr>';
            return;
        }

        let html = '';
        customers.forEach(customer => {
            html += `
                <tr>
                    <td>${customer.fullName}</td>
                    <td>${customer.nicPassport}</td>
                    <td>${customer.mobile}</td>
                    <td>${customer.email}</td>
                    <td class="text-end">
                        <div class="btn-group" role="group">
                            <button class="btn btn-sm btn-outline-primary action-btn" onclick="viewAccountDetails('${customer.id}')">
                                <i class="bi bi-eye"></i>
                            </button>
                            <button class="btn btn-sm btn-outline-warning action-btn" onclick="editCustomer(${customer.id})">
                                <i class="bi bi-pencil"></i>
                            </button>
                            <button class="btn btn-sm btn-outline-danger action-btn" onclick="deleteCustomer(${customer.id})">
                                <i class="bi bi-trash"></i>
                            </button>
                        </div>
                    </td>
                </tr>`;
        });
        tableBody.innerHTML = html;
    }

    document.getElementById("customerForm").addEventListener('submit', async function(e) {
        e.preventDefault();
        const formData = new FormData(this);

        try {
            const newCustomer = {
                nicPassport: formData.get('nicPassport'),
                fullName: formData.get('fullName'),
                dob: formData.get('dob'),
                address: formData.get('address'),
                mobile: formData.get('mobile'),
                email: formData.get('email'),
                customerType: formData.get('customerType')
            };

            const response = await fetch('/admin/customers', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(newCustomer)
            });

            if (!response.ok) {
                const error = await response.json();
                throw new Error(error.message || 'Failed to create customer');
            }

            this.reset();
            closeModal();
            showNotification('Customer added successfully!', 'success');
            getAllCustomers();
        } catch (error) {
            showNotification(error.message || 'Error creating customer', 'error');
            console.error('Form error:', error);
        }
    });

    window.dummyButtonHandle = () => {
        const currentDate = new Date();
        const dobDate = new Date(currentDate.getFullYear() - 25, currentDate.getMonth(), currentDate.getDate());
        const dobString = dobDate.toISOString().split('T')[0];

        document.getElementById('fullName').value = "John Doe";
        document.getElementById('nicPassport').value = "199025600123";
        document.getElementById('dob').value = dobString;
        document.getElementById('address').value = "123 Main Street, Colombo";
        document.getElementById('mobile').value = "+94771234567";
        document.getElementById('email').value = "john.doe@example.com";
        document.getElementById('customerType').value = "INDIVIDUAL";
    };

    function showNotification(message, type) {
        const notification = document.createElement('div');
        notification.className = `alert alert-${type} notification fade show`;
        notification.role = 'alert';
        notification.innerHTML = `
                <i class="bi ${type == 'success' ? 'bi-check-circle' : 'bi-exclamation-triangle'} me-2"></i>
                ${message}
            `;

        document.body.appendChild(notification);
        setTimeout(() => {
            notification.classList.remove('show');
            setTimeout(() => notification.remove(), 150);
        }, 3000);
    }

    // Placeholder functions
    window.viewAccountDetails = (id) => {
        alert(`View account details for customer ID: ${id}`);
    };

    window.editCustomer = (id) => {
        alert(`Edit customer with ID: ${id}`);
    };
</script>
</body>
</html>