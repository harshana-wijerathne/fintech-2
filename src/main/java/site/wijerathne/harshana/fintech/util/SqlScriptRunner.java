package site.wijerathne.harshana.fintech.util;

import java.io.FileNotFoundException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.Statement;
import java.util.Scanner;

public class SqlScriptRunner {
    public static void runScript(Connection connection, String resourcePath1 ,String resourcePath2) {
        try (InputStream is1 = SqlScriptRunner.class.getClassLoader().getResourceAsStream(resourcePath1);
             InputStream is2 = SqlScriptRunner.class.getClassLoader().getResourceAsStream(resourcePath2)) {
            if (is1 == null) {
                throw new FileNotFoundException("SQL file not found: " + resourcePath1);
            }
            Scanner scanner1 = new Scanner(is1).useDelimiter(";");
            Scanner scanner2 = new Scanner(is2).useDelimiter(";");
            Statement stmt1 = connection.createStatement();
            Statement stmt2 = connection.createStatement();
            while (scanner1.hasNext()) {
                String sql = scanner1.next().trim();
                if (!sql.isEmpty()) {
                    stmt1.execute(sql);
                }
            }
            while (scanner2.hasNext()) {
                String sql = scanner2.next().trim();
                if (!sql.isEmpty()) {
                    stmt2.execute(sql);
                }
            }
            stmt1.close();
            stmt2.close();
            scanner1.close();
            scanner2.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

