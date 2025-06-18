//package site.wijerathne.harshana.fintech.dao;
//
//
//import ch.qos.logback.classic.spi.EventArgUtil;
//import org.junit.jupiter.api.*;
//import org.junit.jupiter.params.ParameterizedTest;
//import org.junit.jupiter.params.provider.ValueSource;
//import site.wijerathne.harshana.fintech.model.Customer;
//
//import java.io.BufferedReader;
//import java.io.InputStreamReader;
//import java.nio.file.Files;
//import java.nio.file.Path;
//import java.sql.*;
//import java.sql.Date;
//import java.util.*;
//
//import static org.junit.jupiter.api.Assertions.*;
//
//
//public class CustomerDAOTest {
//
//    Connection connection;
//
//    @BeforeEach
//    void setUp() throws ClassNotFoundException, SQLException {
//        Class.forName("org.h2.Driver");
//        connection = DriverManager.getConnection(
//                "jdbc:h2:mem:test;MODE=MYSQL;DATABASE_TO_LOWER=TRUE;DEFAULT_NULL_ORDERING=HIGH",
//                "","");
//
//        executeScripts();
//
//        PreparedStatement ps = connection.prepareStatement("""
//            INSERT INTO customers (customer_id, nic_passport, full_name, dob, address, mobile_no, email, created_at, updated_at)
//            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
//        """);
//
//        ps.setString(1, "123e4567-e89b-12d3-a456-426614174000");
//        ps.setString(2, "NIC123456");
//        ps.setString(3, "Test User");
//        ps.setDate(4, Date.valueOf("1990-01-01"));
//        ps.setString(5, "123 Main Street");
//        ps.setString(6, "0771234567");
//        ps.setString(7, "test@example.com");
//        Timestamp now = new Timestamp(System.currentTimeMillis());
//        ps.setTimestamp(8, now);
//        ps.setTimestamp(9, now);
//
//        ps.executeUpdate();
//
//    }
//
//    private void executeScripts() {
//        try (BufferedReader schemeBr = new BufferedReader(new InputStreamReader
//                (Objects.requireNonNull(getClass().getResourceAsStream("/schema.sql"))))) {
//            StringBuilder schemaScript = new StringBuilder();
//            schemeBr.lines().forEach(schemaScript::append);
//            try (var stm = connection.createStatement()) {
//                stm.execute(schemaScript.toString());
//            }
//
//            Path path = Path.of(Objects.requireNonNull(getClass().getResource("/data.sql")).toURI());
//            String dataScript = Files.readString(path);
//            try (var stm = connection.createStatement()) {
//                stm.execute(dataScript);
//            }
//        } catch (Exception e) {
//            throw new RuntimeException(e);
//        }
//    }
//    @AfterEach
//    void tearDown() throws SQLException {
//        connection.close();
//    }
//
//
//    @Test
//    void getAllCustomers() {
//        // 2. Exercise (SUT = System Under Test)
//        List<Customer> customerList = CustomerDAO.getAllCustomers(1,8,connection);
//
//        // 3. Verify (State)
//        assertFalse(customerList.isEmpty());
//        assertEquals(8, customerList.size());
//        customerList.forEach(System.out::println);
//    }
//
//    @Test
//    void testSaveCustomer() throws SQLException {
//        Customer customer = new Customer();
//        customer.setCustomerId(UUID.randomUUID().toString());
//        customer.setNicPassport("19980309V");
//        customer.setFullName("Harshana Wijerathne");
//        customer.setDob(new Date(100000));
//        customer.setAddress("Colombo");
//        customer.setMobile("0771234567");
//        customer.setEmail("test@example.com");
//
//
//        // Save customer
//        CustomerDAO repo = new CustomerDAO();
//        Customer savedCustomer = repo.saveCustomer(customer,connection);
//
//        // Assertions
//        assertNotNull(savedCustomer.getCustomerId());
//        assertEquals("Harshana Wijerathne", savedCustomer.getFullName());
//        assertNotNull(savedCustomer.getCreatedAt());
//
//        // Also query the database directly
//        try (PreparedStatement pstmt = connection.prepareStatement(
//                "SELECT * FROM customers WHERE customer_id = ?")) {
//            pstmt.setString(1, savedCustomer.getCustomerId());
//            ResultSet rs = pstmt.executeQuery();
//            assertTrue(rs.next());
//            assertEquals("Harshana Wijerathne", rs.getString("full_name"));
//            assertEquals("0771234567", rs.getString("mobile_no"));
//        }
//    }
//
//    @Test
//    void deleteCustomers() throws SQLException {
//        List<String> uuids = List.of(UUID.randomUUID().toString(), UUID.randomUUID().toString(), UUID.randomUUID().toString());
//        int i = 0;
//        for (String uuid : uuids) {
//            try (PreparedStatement stmt = connection.prepareStatement(
//                    "INSERT INTO customers (customer_id, full_name, nic_passport, dob, address, mobile_no, email, created_at, updated_at) " +
//                            "VALUES (?, ?, ?, ?, ?, ?, ?, NOW(), NOW())")) {
//                stmt.setString(1, uuid);
//                stmt.setString(2, "Dummy");
//                stmt.setString(3, "19901234V"+i++);
//                stmt.setDate(4, Date.valueOf("1990-01-01"));
//                stmt.setString(5, "Test Address");
//                stmt.setString(6, "0712345678");
//                stmt.setString(7, "dummy@example.com");
//                stmt.executeUpdate();
//            }
//        }
//
//        for (String uuid : uuids) {
//            boolean deleted = CustomerDAO.deleteCustomer(uuid, connection);
//            assertTrue(deleted);
//
//            try (PreparedStatement stmt = connection.prepareStatement("SELECT * FROM customers WHERE customer_id = ?")) {
//                stmt.setString(1, uuid);
//                ResultSet rs = stmt.executeQuery();
//                assertFalse(rs.next());
//            }
//        }
//    }
//
//    @Test
//    void updateCustomerTest() throws SQLException {
//        // Step 1: Insert a dummy customer
//        String uuid = UUID.randomUUID().toString();
//        try (PreparedStatement stmt = connection.prepareStatement(
//                "INSERT INTO customers (customer_id, full_name, nic_passport, dob, address, mobile_no, email, created_at, updated_at) " +
//                        "VALUES (?, ?, ?, ?, ?, ?, ?, NOW(), NOW())")) {
//            stmt.setString(1, uuid);
//            stmt.setString(2, "Original Name");
//            stmt.setString(3, "999999999V");
//            stmt.setDate(4, Date.valueOf("1995-05-05"));
//            stmt.setString(5, "Original Address");
//            stmt.setString(6, "0700000000");
//            stmt.setString(7, "original@example.com");
//            stmt.executeUpdate();
//        }
//
//        // Step 2: Update the customer
//        Customer updatedCustomer = new Customer();
//        updatedCustomer.setCustomerId(uuid);
//        updatedCustomer.setNicPassport("19980309V");
//        updatedCustomer.setFullName("Updated Name");
//        updatedCustomer.setDob(new Date(100000));
//        updatedCustomer.setAddress("Updated Address");
//        updatedCustomer.setMobile("0711111111");
//        updatedCustomer.setEmail("updated@example.com");
//
//        // Assume your DAO method is like: updateCustomer(Customer customer, Connection conn)
//        Customer success = CustomerDAO.updateCustomer(updatedCustomer, connection);
//        assertTrue(success!=null);
//
//        // Step 3: Verify changes
//        try (PreparedStatement stmt = connection.prepareStatement("SELECT * FROM customers WHERE customer_id = ?")) {
//            stmt.setString(1, uuid);
//            ResultSet rs = stmt.executeQuery();
//            assertTrue(rs.next());
//            assertEquals("Updated Name", rs.getString("full_name"));
//            assertEquals("Updated Address", rs.getString("address"));
//            assertEquals("0711111111", rs.getString("mobile_no"));
//            assertEquals("updated@example.com", rs.getString("email"));
//        }
//    }
//
//    @Test
//    public void testGetCustomerById_Found() {
//        Customer customer = CustomerDAO.getCustomerById("123e4567-e89b-12d3-a456-426614174000", connection);
//        assertNotNull(customer);
//        assertEquals("Test User", customer.getFullName());
//        assertEquals("NIC123456", customer.getNicPassport());
//    }
//
//    @Test
//    public void testGetCustomerById_NotFound() {
//        Customer customer = CustomerDAO.getCustomerById("non-existing-id", connection);
//        assertNull(customer);
//    }
//
//    @Test
//    public void testFindCustomersByNameOrNIC_ByName() throws SQLException {
//        List<Customer> customers = CustomerDAO.findCustomersByNameOrNIC("Test", connection);
//        assertFalse(customers.isEmpty());
//        assertEquals("Test User", customers.get(0).getFullName());
//    }
//
//    @Test
//    public void testFindCustomersByNameOrNIC_ByNIC() throws SQLException {
//        List<Customer> customers = CustomerDAO.findCustomersByNameOrNIC("NIC123456", connection);
//        assertFalse(customers.isEmpty());
//        assertEquals("NIC123456", customers.get(0).getNicPassport());
//    }
//
//    @Test
//    public void testFindCustomersByNameOrNIC_EmptyResult() throws SQLException {
//        List<Customer> customers = CustomerDAO.findCustomersByNameOrNIC("NotFound", connection);
//        assertTrue(customers.isEmpty());
//    }
//
//    @Test
//    public void testFindCustomersByNameOrNIC_ThrowsOnEmptyInput() {
//        assertThrows(IllegalArgumentException.class, () ->
//                CustomerDAO.findCustomersByNameOrNIC("   ", connection)
//        );
//    }
//
//    @Test
//    public void testUpdateCustomer_Success() throws SQLException {
//        Customer customer = CustomerDAO.getCustomerById("123e4567-e89b-12d3-a456-426614174000", connection);
//        customer.setFullName("Updated Name");
//        customer.setEmail("newemail@example.com");
//
//        Customer updated = CustomerDAO.updateCustomer(customer, connection);
//
//        assertEquals("Updated Name", updated.getFullName());
//        assertEquals("newemail@example.com", updated.getEmail());
//
//        Customer fromDB = CustomerDAO.getCustomerById("123e4567-e89b-12d3-a456-426614174000", connection);
//        assertEquals("Updated Name", fromDB.getFullName());
//        assertEquals("newemail@example.com", fromDB.getEmail());
//    }
//
//    @Test
//    public void testUpdateCustomer_NoRowsAffected() {
//        Customer fakeCustomer = new Customer();
//        fakeCustomer.setCustomerId("non-existent-id");
//        fakeCustomer.setFullName("Doesn't Matter");
//        fakeCustomer.setNicPassport("XXX");
//        fakeCustomer.setDob(Date.valueOf("2000-01-01"));
//        fakeCustomer.setAddress("Nowhere");
//        fakeCustomer.setMobile("000");
//        fakeCustomer.setEmail("none@example.com");
//
//        assertThrows(SQLException.class, () -> CustomerDAO.updateCustomer(fakeCustomer, connection));
//    }
//}
//
//
//
//
//
//
//
//
//
//
