async function logout() {
    await fetch("http://localhost:8080/logout")
}

document.addEventListener('DOMContentLoaded', function () {
    const navItems = document.querySelectorAll('.nav-item');
    const page = document.querySelector('.page');
    navItems.forEach(item => {
        const targetItem = item.getAttribute("data-page")
        const targetPage = page.getAttribute("id");
        if(targetPage.includes(targetItem)){
            item.classList.add("active");
        }
    });

    // Set today's date as default for date inputs
    const today = new Date().toISOString().split('T')[0];
    document.querySelectorAll('input[type="date"]').forEach(input => {
        if (!input.value) {
            input.value = today;
        }
    });
});