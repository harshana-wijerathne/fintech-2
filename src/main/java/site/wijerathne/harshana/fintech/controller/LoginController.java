package site.wijerathne.harshana.fintech.controller;

import com.zaxxer.hikari.HikariDataSource;
import site.wijerathne.harshana.fintech.dto.LoginRequestDTO;
import site.wijerathne.harshana.fintech.model.User;
import site.wijerathne.harshana.fintech.service.LoginServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    private final LoginServiceImpl loginService = new LoginServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        HikariDataSource dataSource = (HikariDataSource) getServletContext().getAttribute("DATA_SOURCE");
        try(Connection connection = dataSource.getConnection()){
            LoginRequestDTO loginDTO = new LoginRequestDTO(username, password);
            User authenticatedUser = loginService.authenticate(loginDTO, req,connection);
//            if (authenticatedUser != null) {
//                HttpSession session = req.getSession();
//                session.setAttribute("username", authenticatedUser);
//                resp.sendRedirect("/");
//            } else {
//                resp.sendRedirect("pages/login.jsp?error=invalid");
//            }
        }catch (Exception e){
            e.printStackTrace();
            throw new ServletException(e);
        }



    }
}
