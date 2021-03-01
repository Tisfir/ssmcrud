package cn.itcrud.dao;

import cn.itcrud.domain.Department;
import cn.itcrud.domain.Employee;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author L.N
 * @creat 2021-02-22-16:18
 */
@Repository
public interface DepartmentDao {

    //查询所有账户信息
    @Select("select * from tnl_dept")
    public List<Department> findAll();
    @Select("select * from tnl_dept where dept_id=#{dept_id}")
    public Department findById(Integer dept_id);
}
