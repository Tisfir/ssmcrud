package cn.itcrud.service;

import cn.itcrud.domain.Emp_Dept;
import cn.itcrud.domain.Employee;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author L.N
 * @creat 2021-02-22-13:54
 */
public interface EmployeeService {
//    public List<Employee> findAll();
    public List<Employee> findAll();
    List<Emp_Dept> findAllOfIt();
    List<Employee> findAllOfIt_2();
    //保存用户
    public Employee saveEmployee(Employee employee);
    public Employee findById(Integer emp_id);

    public Employee updateEmp(Employee employee);
    public void deleteEmployee(Integer emp_id);

    void deleteAllByID(@Param("list_id") List<Integer> list_id);
    public void deleteAll(@Param("detailIds")String detailIds) throws Exception;

    boolean checkUser(String email);
//    public Employee updateEmp_zhuangtai(Employee employee);


}
