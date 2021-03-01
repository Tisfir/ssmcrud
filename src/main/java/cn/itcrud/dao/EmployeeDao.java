package cn.itcrud.dao;

import cn.itcrud.domain.Emp_Dept;
import cn.itcrud.domain.Employee;
import cn.itcrud.domain.QueryVo;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.mapping.FetchType;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author L.N
 * @creat 2021-02-22-13:58
 */
@Repository
public interface EmployeeDao {

    //一、查询所有账户信息
    @Select("select * from tbl_emp")
    public List<Employee> findAll();

    //二、插入数据
    @Insert("insert into tbl_emp (emp_name,gender,email,d_id) values (#{emp_name}," +
            "#{gender},#{email},#{d_id})")
    public void saveEmployee(Employee employee);

    //三、更新数据
    @Update("update tbl_emp set emp_name=#{emp_name},gender=#{gender},email=#{email}," +
            "d_id=#{d_id} where emp_id=#{emp_id}")
    public void updateEmployee(Employee employee);

    //四、删除数据
    @Delete("delete from tbl_emp where emp_id=#{emp_id}")
    public void deleteEmployee(Integer emp_id);



    //六、模糊查询根据名字
    @Select("select * from tbl_emp where emp_name like #{emp_name}")
    public List<Employee> findByName(String emp_name);

    //七、获取总用户数
    @Select("select count(emp_id) from tbl_emp")
    public int findTotal();

    //八、根据QueryVo中的条件查询vo,将查询对象封装到Query类中
    @Select("select * from tbl_emp where emp_name like #{employee.emp_name}")
    public List<Employee> findEmployeeByVo(QueryVo vo);

    //九、一对一查询方式，根据每个人对应一个部门,有个人信息及部门信息  ,此时需要建立新的类，
// 用来继承关系等等
    @Select("select emp.*,dept.dept_name  from tbl_emp emp," +
            "tnl_dept dept where emp.d_id=dept.dept_id")
    List<Emp_Dept> findAllOfIt();

    //十、新的注解方式，用于解决domain中属性值名与数据库名称不一样的问题。
// colume是数据库中的名字，pro哪个是domain类中定义的
//再用的时候，不用再重新写一次@results的内容，只需要重新用一下这个ID
//例如@Results（value={“employeeMap”}）
    @Select("select * from tbl_emp")
    @Results(id="employeeMap",value = {
            @Result(id=true,column="emp_id",property = "emp_id" ),
            @Result(column="emp_name",property = "emp_name" ),
            @Result(column="d_id",property = "d_id" ),
            @Result(column="gender",property = "gender" ),
            @Result(column="email",property = "email" ),
    })
    List<Employee> findAll1();

    //十二、一对一查询方式，根据每个人对应一个部门,有个人信息及部门信息  ,
// 此时需要建立新的类，用来继承关系等等。除了之前那种建立新的类关系Emp_Dept类，另外可以注解的方式进行
    @Select("select * from tbl_emp")
    @Results(id="emp_deptMap",value = {
            @Result(id=true,column="emp_id",property = "emp_id" ),
            @Result(column="emp_name",property = "emp_name" ),
            @Result(column="d_id",property = "d_id" ),
            @Result(column="gender",property = "gender" ),
            @Result(column="email",property = "email" ),
            @Result(property = "department",column = "d_id",one = @One( select="cn.itcrud.dao.DepartmentDao.findById",
                    fetchType=FetchType.EAGER))
    })
    List<Employee> findAllOfIt_2();


    //五、根据ID查询信息
    @Select("select * from tbl_emp where emp_id=#{emp_id}")
    public Employee findById(Integer emp_id);
    //根据ID有选择的更新
    @Update("update tbl_emp set gender=#{gender},email=#{email}," +
            "d_id=#{d_id} where emp_id=#{emp_id}")
    public void updateEmp(Employee employee);


//    @Update("update web_1rmb_snatch_detail set status = 2 where id in (${detailIds})")

//    public void setStatus(@Param("detailIds")String detailIds) throws Exception;
@Delete({"<script>",
        "delete from tbl_emp WHERE emp_id=0 IN",
        "<foreach collection='list_id' item='emp_id' index='index' open='(' separator=',' close=')'>",
        "#{emp_id}",
        "</foreach>",
        "</script>"})
    void deleteAllByID(@Param("list_id") List<Integer> list_id);

    @Delete("delete from tbl_emp where emp_id in (${detailIds})")
    public void deleteAll(@Param("detailIds")String detailIds) throws Exception;

    @Select("select count(*) from tbl_emp where email=#{email}")
    int checkUser(String email);

/*//设计type为0的不显示，type为1的显示数据，做到表面删除，数据库并不删除
    @Update("update tbl_emp set type=0 where emp_id=#{emp_id}")
    public void updateEmp_zhuangtai(Employee employee);*/


}
