// Initialize Lucide icons - wait for script to load
document.addEventListener('DOMContentLoaded', function () {
    // Check if lucide is available, if not wait a bit
    function initIcons() {
        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        } else {
            setTimeout(initIcons, 100);
        }
    }

    initIcons();
});

// Sample data
let customers = [
    {
        id: 1,
        fullName: "John Smith",
        nicPassport: "199512345678",
        dob: "1995-03-15",
        address: "123 Main St, Colombo",
        mobile: "+94 77 123 4567",
        email: "john.smith@email.com"
    },
    {
        id: 2,
        fullName: "Sarah Johnson",
        nicPassport: "198712345678",
        dob: "1987-07-22",
        address: "456 Oak Ave, Kandy",
        mobile: "+94 71 987 6543",
        email: "sarah.johnson@email.com"
    },
    {
        id: 3,
        fullName: "Mike Davis",
        nicPassport: "199012345678",
        dob: "1990-11-08",
        address: "789 Pine Rd, Galle",
        mobile: "+94 76 555 1234",
        email: "mike.davis@email.com"
    }
];

let accounts = [
    {
        accountNumber: "SAV001234567",
        customerId: 1,
        customerName: "John Smith",
        openingDate: "2024-01-15",
        balance: 15250.00
    },
    {
        accountNumber: "SAV001234568",
        customerId: 2,
        customerName: "Sarah Johnson",
        openingDate: "2024-02-20",
        balance: 8750.00
    },
    {
        accountNumber: "SAV001234569",
        customerId: 3,
        customerName: "Mike Davis",
        openingDate: "2024-03-10",
        balance: 12500.00
    }
];

let transactions = [
    {date: "2025-06-16", accountNumber: "SAV001234567", type: "Deposit", amount: 1500.00, balanceAfter: 15250.00},
    {date: "2025-06-15", accountNumber: "SAV001234568", type: "Withdrawal", amount: 300.00, balanceAfter: 8750.00},
    {date: "2025-06-15", accountNumber: "SAV001234569", type: "Deposit", amount: 750.00, balanceAfter: 12500.00},
    {date: "2025-06-14", accountNumber: "SAV001234567", type: "Withdrawal", amount: 500.00, balanceAfter: 13750.00},
    {date: "2025-06-14", accountNumber: "SAV001234568", type: "Deposit", amount: 2000.00, balanceAfter: 9050.00},
    {date: "2025-06-13", accountNumber: "SAV001234569", type: "Withdrawal", amount: 1250.00, balanceAfter: 11750.00},
    {date: "2025-06-10", accountNumber: "SAV001234567", type: "Deposit", amount: 5000.00, balanceAfter: 14250.00}
];

// Navigation
document.addEventListener('DOMContentLoaded', function () {
    const navItems = document.querySelectorAll('.nav-item');
    const pages = document.querySelectorAll('.page');

    navItems.forEach(item => {
        item.addEventListener('click', function () {
            const targetPage = this.getAttribute('data-page') + 'Page';

            // Remove active class from all nav items and pages
            navItems.forEach(nav => nav.classList.remove('active'));
            pages.forEach(page => page.classList.remove('active'));

            // Add active class to clicked nav item and corresponding page
            this.classList.add('active');
            document.getElementById(targetPage).classList.add('active');
        });
    });

    // Set today's date as default for date inputs
    const today = new Date().toISOString().split('T')[0];
    document.querySelectorAll('input[type="date"]').forEach(input => {
        if (!input.value) {
            input.value = today;
        }
    });
});

// Login functionality
document.getElementById('loginForm').addEventListener('submit', function (e) {
    e.preventDefault();
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;

    if (username === 'admin' && password === 'password') {
        document.getElementById('loginPage').classList.add('hidden');
        document.getElementById('mainApp').classList.remove('hidden');
        showNotification('Login successful!', 'success');
    } else {
        showNotification('Invalid credentials!', 'error');
    }
});

// Logout functionality
function logout() {
    alert("pressed logout")
    const responsePromise = fetch("http://localhost:8080/logout", {method: "get"});
}

// Customer management
document.getElementById('customerForm').addEventListener('submit', function (e) {
    e.preventDefault();
    const formData = new FormData(this);
    const newCustomer = {
        id: customers.length + 1,
        fullName: formData.get('fullName'),
        nicPassport: formData.get('nicPassport'),
        dob: formData.get('dob'),
        address: formData.get('address'),
        mobile: formData.get('mobile'),
        email: formData.get('email')
    };

    customers.push(newCustomer);
    updateCustomerTable();
    this.reset();
    showNotification('Customer added successfully!', 'success');
});

function updateCustomerTable() {
    const tbody = document.getElementById('customersTableBody');
    tbody.innerHTML = '';

    customers.forEach(customer => {
        const row = `
                    <tr>
                        <td>${customer.fullName}</td>
                        <td>${customer.nicPassport}</td>
                        <td>${customer.mobile}</td>
                        <td>${customer.email}</td>
                        <td>
                            <button class="btn btn-warning" onclick="editCustomer(${customer.id})">
                                <i data-lucide="edit"></i>
                                Edit
                            </button>
                            <button class="btn btn-danger" onclick="deleteCustomer(${customer.id})">
                                <i data-lucide="trash"></i>
                                Delete
                            </button>
                        </td>
                    </tr>
                `;
        tbody.innerHTML += row;
    });
    lucide.createIcons();
}

function editCustomer(id) {
    showNotification('Edit functionality would open a modal here', 'info');
}

function deleteCustomer(id) {
    if (confirm('Are you sure you want to delete this customer?')) {
        customers = customers.filter(customer => customer.id !== id);
        updateCustomerTable();
        showNotification('Customer deleted successfully!', 'success');
    }
}

// Account management
document.getElementById('accountForm').addEventListener('submit', function (e) {
    e.preventDefault();
    const formData = new FormData(this);
    const customerId = parseInt(formData.get('customerId'));
    const customer = customers.find(c => c.id === customerId);

    if (!customer) {
        showNotification('Customer not found!', 'error');
        return;
    }

    const newAccount = {
        accountNumber: 'SAV' + (Math.floor(Math.random() * 1000000000)).toString().padStart(9, '0'),
        customerId: customerId,
        customerName: customer.fullName,
        openingDate: formData.get('openingDate'),
        balance: parseFloat(formData.get('initialDeposit'))
    };

    accounts.push(newAccount);
    this.reset();
    showNotification('Account opened successfully! Account Number: ' + newAccount.accountNumber, 'success');
});

function viewAccountDetails(accountNumber) {
    const account = accounts.find(acc => acc.accountNumber === accountNumber);
    const accountTransactions = transactions.filter(t => t.accountNumber === accountNumber);

    const content = `
                <div style="margin-bottom: 2rem;">
                    <h4>Account Information</h4>
                    <p><strong>Account Number:</strong> ${account.accountNumber}</p>
                    <p><strong>Customer Name:</strong> ${account.customerName}</p>
                    <p><strong>Opening Date:</strong> ${account.openingDate}</p>
                    <p><strong>Current Balance:</strong> ${account.balance.toFixed(2)}</p>
                </div>
                
                <div>
                    <h4>Recent Transactions</h4>
                    <div class="table-container">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Type</th>
                                    <th>Amount</th>
                                    <th>Balance After</th>
                                </tr>
                            </thead>
                            <tbody>
                                ${accountTransactions.slice(0, 5).map(t => `
                                    <tr>
                                        <td>${t.date}</td>
                                        <td><span style="color: ${t.type === 'Deposit' ? '#28a745' : '#dc3545'};">${t.type}</span></td>
                                        <td>${t.amount.toFixed(2)}</td>
                                        <td>${t.balanceAfter.toFixed(2)}</td>
                                    </tr>
                                `).join('')}
                            </tbody>
                        </table>
                    </div>
                </div>
            `;

    document.getElementById('accountDetailsContent').innerHTML = content;
    document.getElementById('accountModal').classList.add('active');
}

function closeModal() {
    document.getElementById('accountModal').classList.remove('active');
}

// Transaction management
document.getElementById('depositForm').addEventListener('submit', function (e) {
    e.preventDefault();
    const formData = new FormData(this);
    const accountNumber = formData.get('accountNumber');
    const amount = parseFloat(formData.get('amount'));
    const date = formData.get('date');

    const account = accounts.find(acc => acc.accountNumber === accountNumber);
    if (!account) {
        showNotification('Account not found!', 'error');
        return;
    }

    account.balance += amount;

    const newTransaction = {
        date: date,
        accountNumber: accountNumber,
        type: 'Deposit',
        amount: amount,
        balanceAfter: account.balance
    };

    transactions.unshift(newTransaction);
    updateTransactionHistory();
    this.reset();
    showNotification(`Deposit of ${amount.toFixed(2)} successful!`, 'success');
});

document.getElementById('withdrawForm').addEventListener('submit', function (e) {
    e.preventDefault();
    const formData = new FormData(this);
    const accountNumber = formData.get('accountNumber');
    const amount = parseFloat(formData.get('amount'));
    const date = formData.get('date');

    const account = accounts.find(acc => acc.accountNumber === accountNumber);
    if (!account) {
        showNotification('Account not found!', 'error');
        return;
    }

    if (account.balance < amount) {
        showNotification('Insufficient balance!', 'error');
        return;
    }

    account.balance -= amount;

    const newTransaction = {
        date: date,
        accountNumber: accountNumber,
        type: 'Withdrawal',
        amount: amount,
        balanceAfter: account.balance
    };

    transactions.unshift(newTransaction);
    updateTransactionHistory();
    this.reset();
    showNotification(`Withdrawal of ${amount.toFixed(2)} successful!`, 'success');
});

function updateTransactionHistory() {
    const tbody = document.getElementById('transactionHistoryBody');
    tbody.innerHTML = '';

    transactions.forEach(transaction => {
        const row = `
                    <tr>
                        <td>${transaction.date}</td>
                        <td>${transaction.accountNumber}</td>
                        <td><span style="color: ${transaction.type === 'Deposit' ? '#28a745' : '#dc3545'};">${transaction.type}</span></td>
                        <td>${transaction.amount.toFixed(2)}</td>
                        <td>${transaction.balanceAfter.toFixed(2)}</td>
                    </tr>
                `;
        tbody.innerHTML += row;
    });
}

function filterTransactions() {
    const accountNumber = document.getElementById('historyAccount').value;
    const fromDate = document.getElementById('fromDate').value;
    const toDate = document.getElementById('toDate').value;

    let filteredTransactions = transactions;

    if (accountNumber) {
        filteredTransactions = filteredTransactions.filter(t => t.accountNumber === accountNumber);
    }

    if (fromDate) {
        filteredTransactions = filteredTransactions.filter(t => t.date >= fromDate);
    }

    if (toDate) {
        filteredTransactions = filteredTransactions.filter(t => t.date <= toDate);
    }

    const tbody = document.getElementById('transactionHistoryBody');
    tbody.innerHTML = '';

    filteredTransactions.forEach(transaction => {
        const row = `
                    <tr>
                        <td>${transaction.date}</td>
                        <td>${transaction.accountNumber}</td>
                        <td><span style="color: ${transaction.type === 'Deposit' ? '#28a745' : '#dc3545'};">${transaction.type}</span></td>
                        <td>${transaction.amount.toFixed(2)}</td>
                        <td>${transaction.balanceAfter.toFixed(2)}</td>
                    </tr>
                `;
        tbody.innerHTML += row;
    });

    showNotification(`Showing ${filteredTransactions.length} transactions`, 'info');
}

// Search functionality
document.getElementById('customerSearch').addEventListener('input', function () {
    const searchTerm = this.value.toLowerCase();
    const rows = document.querySelectorAll('#customersTableBody tr');

    rows.forEach(row => {
        const text = row.textContent.toLowerCase();
        if (text.includes(searchTerm)) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
});

// Notification system
function showNotification(message, type) {
    const notification = document.createElement('div');
    notification.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 1rem 2rem;
                border-radius: 8px;
                color: white;
                font-weight: 600;
                z-index: 10000;
                animation: slideIn 0.3s ease;
                max-width: 400px;
            `;

    switch (type) {
        case 'success':
            notification.style.background = 'linear-gradient(135deg, #28a745 0%, #20c997 100%)';
            break;
        case 'error':
            notification.style.background = 'linear-gradient(135deg, #dc3545 0%, #e83e8c 100%)';
            break;
        case 'info':
            notification.style.background = 'linear-gradient(135deg, #17a2b8 0%, #6f42c1 100%)';
            break;
        default:
            notification.style.background = 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)';
    }

    notification.textContent = message;
    document.body.appendChild(notification);

    setTimeout(() => {
        notification.style.animation = 'slideOut 0.3s ease';
        setTimeout(() => {
            document.body.removeChild(notification);
        }, 300);
    }, 3000);
}

// Add CSS for notification animations
const style = document.createElement('style');
style.textContent = `
    @keyframes slideIn {
    from { transform: translateX(100%); opacity: 0; }
    to { transform: translateX(0); opacity: 1; }
}

    @keyframes slideOut {
    from { transform: translateX(0); opacity: 1; }
    to { transform: translateX(100%); opacity: 0; }
}
    `;
document.head.appendChild(style);

// Initialize icons after page load
window.addEventListener('load', function () {
    if (typeof lucide !== 'undefined') {
        lucide.createIcons();
    }
});
