package site.wijerathne.harshana.fintech.service;

import site.wijerathne.harshana.fintech.dto.CustomerDTO;

import java.sql.Connection;
import java.util.List;

public interface CustomerService {

    List<CustomerDTO> getAllCustomers(int page, int pageSize, Connection connection);

    CustomerDTO getCustomerById(String customerId, Connection connection);

    List<CustomerDTO> searchCustomers(String searchTerm, Connection connection);

    CustomerDTO createCustomer(CustomerDTO customerDTO, String actorUserId, String ipAddress, Connection connection);

    void deleteCustomer(String customerId, String actorUserId, String ipAddress, Connection connection);

    CustomerDTO updateCustomer(String customerId, CustomerDTO customerDTO, String actorUserId, String ipAddress, Connection connection);
}
