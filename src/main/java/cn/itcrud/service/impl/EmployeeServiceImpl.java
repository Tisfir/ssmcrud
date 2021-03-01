package cn.itcrud.service.impl;

import cn.itcrud.dao.EmployeeDao;
import cn.itcrud.domain.Emp_Dept;
import cn.itcrud.domain.Employee;
import cn.itcrud.service.EmployeeService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author L.N
 * @creat 2021-02-22-14:00
 */
@Service("employeeservice")
public class EmployeeServiceImpl implements EmployeeService {
    @Autowired
    private EmployeeDao employeeDao;
    public List<Employee> findAll(){
        System.out.println("业务层查询中……");
        return employeeDao.findAll();
    }
   public List<Emp_Dept> findAllOfIt(){
       System.out.println("业务层查询中……");
       return employeeDao.findAllOfIt();
   }
    public List<Employee> findAllOfIt_2(){
        System.out.println("emp_dept业务层查询");
        return employeeDao.findAllOfIt_2();
    }

    @Override
    public Employee saveEmployee(Employee employee) {
        System.out.println("saveEmployee业务层执行……");
        employeeDao.saveEmployee(employee);
        return employee;
    }
    public Employee findById(Integer emp_id){
        System.out.println("根据ID查询员工信息，业务层执行中");
        Employee employee=employeeDao.findById(emp_id);
        return employee;
    }
    public Employee updateEmp(Employee employee){
        System.out.println("根据员工，更新员工信息，执行中——————————");
        employeeDao.updateEmp(employee);
        return employee;
    }
    public void deleteEmployee(Integer emp_id){
        System.out.println("删除员工业务层执行中——————");
        employeeDao.deleteEmployee(emp_id);
    }

    public void deleteAllByID(@Param("list_id") List<Integer> list_id){
        System.out.println("批量删除执行中");
        employeeDao.deleteAllByID(list_id);
    }

    public void deleteAll(@Param("detailIds")String detailIds) throws Exception{
        System.out.println("删除多选");
        employeeDao.deleteAll(detailIds);
    }
    public boolean checkUser(String email){
        //检验用户名是否可用
        System.out.println("查询邮箱是否可用");
        long count=employeeDao.checkUser(email);
       return count==0;
    }


  /*  public Employee updateEmp_zhuangtai(Employee employee){
        employeeDao.updateEmp_zhuangtai(employee);
        return employee;
    }*/









   /* public List<Employee> findAll() {

        System.out.println("执行中，查询");
        return employeeDao.findAll();
    }*/
}
