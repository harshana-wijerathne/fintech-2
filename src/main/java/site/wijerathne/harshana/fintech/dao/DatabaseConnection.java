//package site.wijerathne.harshana.fintech.dao;
//
//import com.zaxxer.hikari.HikariConfig;
//import com.zaxxer.hikari.HikariDataSource;
//
//import java.io.IOException;
//import java.io.InputStream;
//import java.sql.Connection;
//import java.sql.SQLException;
//import java.util.Properties;
//
//public class DatabaseConnection {
//    private static final HikariDataSource dataSource;
//
//    static {
//        try (InputStream inputStream = DatabaseConnection.class.getClassLoader()
//                .getResourceAsStream("db.properties")) {
//            if (inputStream == null) {
//                throw new RuntimeException("Unable to find db.properties file");
//            }
//
//            Properties prop = new Properties();
//            prop.load(inputStream);
//
//            HikariConfig config = new HikariConfig();
//            config.setDriverClassName(prop.getProperty("app.datasource.driver"));
//            config.setJdbcUrl(prop.getProperty("app.datasource.url"));
//            config.setUsername(prop.getProperty("app.datasource.username"));
//            config.setPassword(prop.getProperty("app.datasource.password"));
//
//            config.setMaximumPoolSize(10);
//            config.setMinimumIdle(5);
//            config.setIdleTimeout(600000);
//            config.setConnectionTimeout(30000);
//            config.setMaxLifetime(1800000);
//            config.setLeakDetectionThreshold(30000);
//            config.setConnectionTestQuery("SELECT 1");
//
//            dataSource = new HikariDataSource(config);
//        } catch (IOException e) {
//            throw new RuntimeException("Failed to initialize database connection pool", e);
//        }
//    }
//
//    public static Connection getConnection() throws SQLException {
//        return dataSource.getConnection();
//    }
//
//    public static void closePool() {
//        if (dataSource != null && !dataSource.isClosed()) {
//            dataSource.close();
//        }
//    }
//}