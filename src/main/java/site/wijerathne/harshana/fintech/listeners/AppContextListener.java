package site.wijerathne.harshana.fintech.listeners;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import site.wijerathne.harshana.fintech.controller.CustomerController;
import site.wijerathne.harshana.fintech.util.SqlScriptRunner;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;


@WebListener
public class AppContextListener implements ServletContextListener {
    private static final Logger logger = Logger.getLogger(CustomerController.class.getName());
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try(InputStream inputStream = getClass().getClassLoader().getResourceAsStream("h2.properties")){
            Properties PROPS = new Properties();
            PROPS.load(inputStream);
            HikariConfig config = new HikariConfig();
            config.setDriverClassName(PROPS.getProperty("app.datasource.driver"));
            config.setUsername(PROPS.getProperty("app.datasource.user"));
            config.setPassword(PROPS.getProperty("app.datasource.password"));
            config.setJdbcUrl(PROPS.getProperty("app.datasource.url"));

            config.setMaximumPoolSize(10);
            config.setMinimumIdle(5);
            config.setIdleTimeout(600000);
            config.setConnectionTimeout(30000);
            config.setMaxLifetime(1800000);
            config.setLeakDetectionThreshold(30000);
            config.setConnectionTestQuery("SELECT 1");
            HikariDataSource dataSource = new HikariDataSource(config);

            sce.getServletContext().setAttribute("DATA_SOURCE", dataSource);

            Connection connection = dataSource.getConnection();
            SqlScriptRunner.runScript(connection,"h21.sql","h22.sql");

        }catch (IOException e){
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


    }
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        ServletContextListener.super.contextDestroyed(sce);
    }


}
