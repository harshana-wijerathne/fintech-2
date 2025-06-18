document.addEventListener('DOMContentLoaded', function () {
    getAllCustomers();
});

const getAllCustomers = async () => {
    try {
        const response = await fetch("/admin/customers");

        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }

        const customers = await response.json(); // Parse the JSON response
        const tableBody = document.getElementById("customersTableBody");

        if (customers && customers.length > 0) {
            let innerHtml = "";

            // Use for...of loop for arrays instead of for...in
            for (const customer of customers) {
                innerHtml += `<tr>
                                <td>${customer.fullName}</td>
                                <td>${customer.nicPassport}</td>
                                <td>${customer.mobile}</td>
                                <td>${customer.email}</td>
                                <td style="display: flex; justify-content: space-evenly">
                                    <button class="btn btn-warning" onclick="editCustomer(${customer.id})">
                                        <i data-lucide="edit"></i>
                                        Edit
                                    </button>
                                    <button class="btn btn-danger" onclick="deleteCustomer(${customer.id})">
                                        <i data-lucide="trash"></i>
                                        Delete
                                    </button>
                                    <button class="btn btn-primary" onclick="viewAccountDetails('SAV001234569')">
                                        <i data-lucide="eye"></i>
                                        View
                                    </button>
                                </td>
                            </tr>`;
            }

            tableBody.innerHTML = innerHtml;

            // Refresh Lucide icons after DOM update
            if (window.lucide) {
                lucide.createIcons();
            }
        } else {
            tableBody.innerHTML = `<tr><td colspan="5">No customers found</td></tr>`;
        }
    } catch (error) {
        console.error("Error fetching customers:", error);
        document.getElementById("customersTableBody").innerHTML =
            `<tr><td colspan="5">Error loading customer data</td></tr>`;
    }
};

window.deleteCustomer = async (id)=>{
    alert("delete")
    try{
        const response = await fetch("/admin/customers?id="+id,{method:"delete"});
        if(response.ok){
            getAllCustomers();
        }else{
            alert("failed to delete1")
        }
    }catch(error){
        alert("failed to delete2")
    }
}

// Function to update the table with search results
function updateCustomerTable(customers) {
    const tableBody = document.getElementById('customersTableBody');

    if (!customers || customers.length === 0) {
        tableBody.innerHTML = '<tr><td colspan="5">No customers found</td></tr>';
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
        </tr>`;
    });

    tableBody.innerHTML = html;

    // Refresh Lucide icons
    if (window.lucide) {
        lucide.createIcons();
    }

}

// Debounce function to limit API calls while typing
function debounce(func, timeout = 300) {
    let timer;
    return (...args) => {
        clearTimeout(timer);
        timer = setTimeout(() => { func.apply(this, args); }, timeout);
    };
}

// Search function with debouncing
window.searchUser = debounce(async (event) => {
    const searchTerm = event.target.value.trim();

    if (searchTerm.length === 0) {
        getAllCustomers();
        // document.getElementById('customersTableBody').innerHTML = '';
        // return;
    }

    try {
        const response = await fetch(`/admin/customers?search=${encodeURIComponent(searchTerm)}`);

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }

        const customers = await response.json();
        console.log(customers);
        displayResults(customers);
    } catch (error) {
        console.error('Error fetching search results:', error);
        // You might want to show an error message to the user
    }
});

// Function to display results in the table
function displayResults(customers) {
    const tableBody = document.getElementById('customersTableBody');
    tableBody.innerHTML = ''; // Clear previous results

    if (customers.length === 0) {
        tableBody.innerHTML = '<tr><td colspan="5" class="text-center">No customers found</td></tr>';
        return;
    }

    customers.forEach(customer => {
        const row = document.createElement('tr');
        row.innerHTML = `
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
                <button class="btn btn-primary" onclick="viewAccountDetails('SAV001234569')">
                      <i data-lucide="eye"></i>
                       View
                 </button>
            </td>
        `;
        tableBody.appendChild(row);
    });

    // Refresh Lucide icons if needed
    if (window.lucide) {
        window.lucide.createIcons();
    }
}

document.getElementById("customerForm").addEventListener('submit', async function(e) {
    e.preventDefault();
    // Get form data
    const formData = new FormData(this);
    const dobValue = formData.get('dob');

    try {
        // Create customer object
        const newCustomer = {
            nicPassport: formData.get('nicPassport'),
            fullName: formData.get('fullName'),
            dob: dobValue,
            address: formData.get('address'),
            mobile: formData.get('mobile'),
            email: formData.get('email')
        };


        const response = await fetch('/admin/customers', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(newCustomer)
        });

        if (!response.ok) {
            const error = await response.json();
            throw new Error(error.message || 'Failed to create customer');
        }

        const savedCustomer = await response.json();

        updateCustomerTable();
        this.reset();
        alert("saved");
        showNotification('Customer added successfully!', 'success');

    } catch (error) {
        console.error('Error:', error);
        showNotification(error.message || 'Error creating customer', 'error');
    }
});

window.dummyButtonHandle = () =>{
    alert("clicked")
    const currentDate = new Date();
    const dobDate = new Date(currentDate.getFullYear() - 25, currentDate.getMonth(), currentDate.getDate());
    const dobString = dobDate.toISOString().split('T')[0]; // Format as YYYY-MM-DD

    // Fill form fields with dummy data
    document.querySelector('input[name="fullName"]').value = "John Doe";
    document.querySelector('input[name="nicPassport"]').value = "199025600123";
    document.querySelector('input[name="dob"]').value = dobString;
    document.querySelector('input[name="address"]').value = "123 Main Street, Colombo";
    document.querySelector('input[name="mobile"]').value = "+94771234567";
    document.querySelector('input[name="email"]').value = "john.doe@example.com";
}

export function showNotification(message, type) {
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

    switch(type) {
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

window.viewAddNewCustomerModal = () => {
    document.getElementById('AddNewCustomerModal').classList.add('active');
}

window.closeModal = ()=> {
    document.getElementById('AddNewCustomerModal').classList.remove('active');
    getAllCustomers();
}

