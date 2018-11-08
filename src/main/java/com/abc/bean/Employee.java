package com.abc.bean;

import org.hibernate.validator.constraints.Email;

import javax.validation.constraints.Pattern;

public class Employee {

    private Integer empId;

    @Pattern(regexp = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})"
            , message = "用户名必须是6-16位数字和字母的组合或者2-5位中文")
    private String empName;


    private String gende;

    //    @Email
    @Pattern(regexp = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
            , message = "邮箱格式不正确")
    private String email;


    private Integer dId;

    public Employee() {
    }

    public Employee(Integer empId, String empName, String gende, String email, Integer dId) {
        this.empId = empId;
        this.empName = empName;
        this.gende = gende;
        this.email = email;
        this.dId = dId;
    }

    //希望查询员工时，部门也是查询好的
    private Department departmentt;


    public Department getDepartment() {
        return departmentt;
    }


    public void setDepartment(Department Department) {
        this.departmentt = Department;
    }


    public Integer getEmpId() {
        return empId;
    }


    public void setEmpId(Integer empId) {
        this.empId = empId;
    }


    public String getEmpName() {
        return empName;
    }


    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }


    public String getGende() {
        return gende;
    }


    public void setGende(String gende) {
        this.gende = gende == null ? null : gende.trim();
    }


    public String getEmail() {
        return email;
    }


    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }


    public Integer getdId() {
        return dId;
    }


    public void setdId(Integer dId) {
        this.dId = dId;
    }
}