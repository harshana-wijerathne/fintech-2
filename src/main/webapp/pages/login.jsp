<%--
  Created by IntelliJ IDEA.
  User: harshana
  Date: 6/17/25
  Time: 12:06 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>login</title>
    <link rel="stylesheet" href="../css/login.css">
    <script type="module" src="https://unpkg.com/lucide@latest/dist/umd/lucide.js" defer></script>
</head>
<body>
<div class="app-container">
<div id="loginPage" class="page active">
    <div class="login-container">
        <div class="login-card">
            <div class="login-title">
                <i data-lucide="building-2"></i>
                SecureBank Pro
            </div>
            <form action="${pageContext.request.contextPath}/login" method="post" id="loginForm">
                <div class="form-group">
                    <label class="form-label">Username</label>
                    <input type="text" name="username" class="form-input" id="username" placeholder="Enter your username" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-input" id="password" placeholder="Enter your password" required>
                </div>
                <button type="submit" class="login-btn">
                    <i data-lucide="log-in"></i>
                    Login to Dashboard
                </button>
            </form>
            <p style="margin-top: 1rem; color: #666; font-size: 0.9rem;">
                Demo: admin / password
            </p>
        </div>
    </div>
</div>
</div>

</body>
</html>
