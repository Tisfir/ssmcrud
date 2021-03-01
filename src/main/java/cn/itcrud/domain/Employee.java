package cn.itcrud.domain;

import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.Pattern;
import java.io.Serializable;

/**
 * @author L.N
 * @creat 2021-02-22-13:57
 */
public class Employee implements Serializable {

    //后端校验，JSR303校验，导入校验包，用的@pattern注解
    private Integer emp_id;
@Pattern(regexp = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)",
        message = "用户名必须是6-16位数字，字母或者_-，也可以是2-5位中文组成")
    private String emp_name;

    private String gender;
@Pattern(regexp = "^\\w+@[a-zA-Z0-9]{2,10}(?:\\.[a-z]{2,4}){1,3}$",
        message = "邮箱格式不正确，应如：1580322@163.com")
    private String email;

    private Integer d_id;
    private Department department;  //一个成员对应一个部门（在mybatis中变相一对一的关系），一个部门对应多个用户。

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public Integer getEmp_id() {
        return emp_id;
    }

    public void setEmp_id(Integer emp_id) {
        this.emp_id = emp_id;
    }

    public String getEmp_name() {
        return emp_name;
    }

    public void setEmp_name(String emp_name) {
        this.emp_name = emp_name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getD_id() {
        return d_id;
    }

    public void setD_id(Integer d_id) {
        this.d_id = d_id;
    }
    public void setDept(Integer emp_id,String emp_name,String gender,String email,Integer d_id){
        this.d_id=d_id;
        this.email=email;
        this.emp_id=emp_id;
        this.emp_name=emp_name;
        this.gender=gender;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "emp_id=" + emp_id +
                ", emp_name='" + emp_name + '\'' +
                ", gender='" + gender + '\'' +
                ", email='" + email + '\'' +
                ", d_id=" + d_id +
                '}';
    }
}
