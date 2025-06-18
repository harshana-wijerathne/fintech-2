//package site.wijerathne.harshana.fintech.filter;
//
//import site.wijerathne.harshana.fintech.model.User;
//
//import javax.servlet.*;
//import javax.servlet.annotation.WebFilter;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//import java.io.IOException;
//
//@WebFilter("/admin/*")
//public class AuthFilter implements Filter {
//    @Override
//    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
//        HttpServletRequest request = (HttpServletRequest) servletRequest;
//        HttpServletResponse response = (HttpServletResponse) servletResponse;
//        HttpSession session = request.getSession();
//        User user = (User) session.getAttribute("username");
//        if (user == null || !"ADMIN".equals(user.getRole())) {
//            response.sendRedirect("/pages/login.jsp");
//        }else{
//            filterChain.doFilter(servletRequest, servletResponse);
//        }
//
//    }
//}
