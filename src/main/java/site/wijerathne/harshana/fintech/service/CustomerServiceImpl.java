package site.wijerathne.harshana.fintech.service;

import site.wijerathne.harshana.fintech.dao.AuditLogDAO;
import site.wijerathne.harshana.fintech.dao.CustomerDAO;
import site.wijerathne.harshana.fintech.dto.AuditLogDTO;
import site.wijerathne.harshana.fintech.dto.CustomerDTO;
import site.wijerathne.harshana.fintech.model.Customer;
import site.wijerathne.harshana.fintech.util.DTOConverter;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;


public class CustomerServiceImpl implements CustomerService {
    private static final Logger logger = Logger.getLogger(CustomerServiceImpl.class.getName());
    private final CustomerDAO customerDAO;
    private final AuditLogDAO auditLogDAO;
    private final DTOConverter dtoConverter;

    public CustomerServiceImpl() {
        this.customerDAO = new CustomerDAO();
        this.auditLogDAO = new AuditLogDAO();
        this.dtoConverter = new DTOConverter();
    }

    public List<CustomerDTO> getAllCustomers(int page, int pageSize,Connection connection) {
        try {
            return CustomerDAO.getAllCustomers(page, pageSize,connection)
                    .stream()
                    .map(dtoConverter::convertToCustomerDTO)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error fetching all customers", e);
            throw new RuntimeException("Error fetching customers", e);
        }
    }

    public CustomerDTO getCustomerById(String customerId,Connection connection) {
        try {
            Customer customer = CustomerDAO.getCustomerById(customerId,connection);
            return customer != null ? dtoConverter.convertToCustomerDTO(customer) : null;
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error fetching customer by ID: " + customerId, e);
            throw new RuntimeException("Error fetching customer", e);
        }
    }

    public List<CustomerDTO> searchCustomers(String searchTerm,Connection connection) {
        try {
            return CustomerDAO.findCustomersByNameOrNIC(searchTerm,connection)
                    .stream()
                    .map(dtoConverter::convertToCustomerDTO)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error searching customers with term: " + searchTerm, e);
            throw new RuntimeException("Error searching customers", e);
        }
    }

    public CustomerDTO createCustomer(CustomerDTO customerDTO, String actorUserId, String ipAddress,Connection connection) {
        try {
            Customer customer = dtoConverter.convertToCustomerModel(customerDTO);
            Customer createdCustomer = CustomerDAO.saveCustomer(customer,connection);

            // Log audit
            AuditLogDTO auditLog = AuditLogDTO.builder()
                    .actorUserId(actorUserId)
                    .actionType("CREATE")
                    .entityType("CUSTOMER")
                    .entityId(createdCustomer.getCustomerId())
                    .description("Created new customer: " + createdCustomer.getFullName() + "|" + createdCustomer.getNicPassport())
                    .ipAddress(ipAddress)
                    .build();
            auditLogDAO.saveAuditLog(auditLog,connection);

            return dtoConverter.convertToCustomerDTO(createdCustomer);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error creating customer", e);
            throw new RuntimeException("Error creating customer", e);
        }
    }

    public void deleteCustomer(String customerId, String actorUserId, String ipAddress,Connection connection) {
        try {

            Customer customer = customerDAO.getCustomerById(customerId,connection);
            if (customer == null) {
                throw new IllegalArgumentException("Customer not found with ID: " + customerId);
            }


            boolean deleted = CustomerDAO.deleteCustomer(customerId,connection);
            if (!deleted) {
                throw new RuntimeException("Failed to delete customer with ID: " + customerId);
            }

            AuditLogDTO auditLog = AuditLogDTO.builder()
                    .actorUserId(actorUserId)
                    .actionType("DELETE")
                    .entityType("CUSTOMER")
                    .entityId(customerId)
                    .description("Deleted customer: " + customer.getFullName())
                    .ipAddress(ipAddress)
                    .build();
            auditLogDAO.saveAuditLog(auditLog,connection);

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error deleting customer with ID: " + customerId, e);
            throw new RuntimeException("Error deleting customer", e);
        }
    }

    public CustomerDTO updateCustomer(String customerId, CustomerDTO customerDTO, String actorUserId, String ipAddress,Connection connection) {
        try {
            connection.setAutoCommit(false);

            Customer existingCustomer = CustomerDAO.getCustomerById(customerId,connection);
            if (existingCustomer == null) {
                throw new IllegalArgumentException("Customer not found with ID: " + customerId);
            }

            Customer customerToUpdate = dtoConverter.convertToCustomerModel(customerDTO);
            customerToUpdate.setCustomerId(customerId);

            Customer updatedCustomer = customerDAO.updateCustomer(customerToUpdate, connection);

            AuditLogDTO auditLog = AuditLogDTO.builder()
                    .actorUserId(actorUserId)
                    .actionType("UPDATE")
                    .entityType("CUSTOMER")
                    .entityId(customerId)
                    .description("Updated customer: " + updatedCustomer.getFullName())
                    .ipAddress(ipAddress)
                    .build();
            auditLogDAO.saveAuditLog(auditLog,connection);

            connection.commit();
            return dtoConverter.convertToCustomerDTO(updatedCustomer);

        } catch (Exception e) {
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException ex) {
                    logger.log(Level.SEVERE, "Transaction rollback failed", ex);
                }
            }
            logger.log(Level.SEVERE, "Error updating customer with ID: " + customerId, e);
            throw new RuntimeException("Error updating customer", e);
        } finally {
            if (connection != null) {
                try {
                    connection.setAutoCommit(true);
                    connection.close();
                } catch (SQLException e) {
                    logger.log(Level.WARNING, "Error closing connection", e);
                }
            }
        }
    }
}
