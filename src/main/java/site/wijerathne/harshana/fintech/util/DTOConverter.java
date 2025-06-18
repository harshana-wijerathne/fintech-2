package site.wijerathne.harshana.fintech.util;

import site.wijerathne.harshana.fintech.dto.CustomerDTO;
import site.wijerathne.harshana.fintech.model.Customer;

public class DTOConverter {
    public CustomerDTO convertToCustomerDTO(Customer customer) {
        return CustomerDTO.builder()
                .customerId(customer.getCustomerId())
                .nicPassport(customer.getNicPassport())
                .fullName(customer.getFullName())
                .dob(customer.getDob())
                .address(customer.getAddress())
                .mobile(customer.getMobile())
                .email(customer.getEmail())
                .createdAt(customer.getCreatedAt())
                .updatedAt(customer.getUpdatedAt())
                .build();
    }

    public Customer convertToCustomerModel(CustomerDTO customerDTO) {
        Customer customer = new Customer();
        customer.setCustomerId(customerDTO.getCustomerId());
        customer.setNicPassport(customerDTO.getNicPassport());
        customer.setFullName(customerDTO.getFullName());
        customer.setDob(customerDTO.getDob());
        customer.setAddress(customerDTO.getAddress());
        customer.setMobile(customerDTO.getMobile());
        customer.setEmail(customerDTO.getEmail());
        customer.setCreatedAt(customerDTO.getCreatedAt());
        customer.setUpdatedAt(customerDTO.getUpdatedAt());
        return customer;
    }
}