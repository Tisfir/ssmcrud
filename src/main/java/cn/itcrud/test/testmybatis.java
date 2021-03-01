package cn.itcrud.test;

import cn.itcrud.dao.DepartmentDao;
import cn.itcrud.dao.EmployeeDao;
import cn.itcrud.domain.Department;
import cn.itcrud.domain.Emp_Dept;
import cn.itcrud.domain.Employee;
import cn.itcrud.domain.QueryVo;
import cn.itcrud.service.EmployeeService;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.InputStream;
import java.util.List;

/**
 * @author L.N
 * @creat 2021-02-22-14:10
 */
public class testmybatis {
    @Autowired
    SqlSession sqlSession;
    private InputStream in;
    private EmployeeDao employeeDao;
    private DepartmentDao departmentDao;

    @Before
    public void before() throws Exception {
        //编写程序，加载mybatis的配置文件
        in = Resources.getResourceAsStream("SqlMapConfig.xml");
        //创建SqlSessionFactory对象
        SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(in);
        //使用工厂创建SqlSession对象
        sqlSession = factory.openSession();
        //获取到代理对象
         employeeDao = sqlSession.getMapper(EmployeeDao.class);
    }
    @After
    public void after() throws Exception {
        //关闭资源
        sqlSession.close();
        in.close();
    }

    @Test
    public void run1() throws Exception {
        //查询所有的账户信息
        List<Employee> list = employeeDao.findAll1();
        for (Employee employee : list) {
            System.out.println("---每个用户的信息-------");
            System.out.println(employee);
            System.out.println(employee.getDepartment());
        }

    }

    @Test
    public void run2() throws Exception {
        //获取到代理对象
        DepartmentDao dao = sqlSession.getMapper(DepartmentDao.class);
        //查询所有的账户信息
        List<Department> list = dao.findAll();
        for (Department department : list) {
            System.out.println(department);
        }

    }
    //测试保存操作
    @Test
    public void run3() throws Exception{
        Employee employee=new Employee();
        employee.setEmp_name("凳子子");
        employee.setGender("W");
        employee.setEmail("333@123.com");
        employee.setD_id(2);

        //保存
        employeeDao.saveEmployee(employee);
        //增删改之后，必须要提交事物。否则不会成功
        sqlSession.commit();

    }
    //测试更新操作
    @Test
    public void run4() throws Exception{
        Employee employee=new Employee();
        employee.setEmp_name("小胖子");
        employee.setEmp_id(11);
        employee.setGender("W");
        employee.setEmail("333@123.com");
        employee.setD_id(2);

        employeeDao.updateEmployee(employee);
        //增删改之后，必须要提交事物。否则不会成功
        sqlSession.commit();
        //关闭资源
        sqlSession.close();
        in.close();

    }
    //测试删除操作
    @Test
    public void run5() throws Exception{

        employeeDao.deleteEmployee(52);
        //增删改之后，必须要提交事物。否则不会成功
        sqlSession.commit();

    }
    //测试根据ID查询操作
    @Test
    public void run6() throws Exception{

        Employee employee=employeeDao.findById(6);  //封装打印一下
        System.out.println(employee);

    }
    //测试根据I根据名字的模糊查询操作
    @Test
    public void run7() throws Exception{
        List<Employee> employee=employeeDao.findByName("%李%"); //封装打印一下
        for (Employee employee1:employee){
            System.out.println(employee1);
        }

    }
    //测试查询总记录条数
    @Test
    public void run8() throws Exception{
        int count=employeeDao.findTotal();
        System.out.println(count);

    }

    //测试根据IQueryVo查询操作
    @Test
    public void run9() throws Exception{
        //把employee弄好之后，employee赋给vo,查找用vo查找
        QueryVo vo=new QueryVo();
        Employee employee=new Employee();
        employee.setEmp_name("%李%");
        vo.setEmployee(employee);
        List<Employee> user=employeeDao.findEmployeeByVo(vo); //封装打印一下
        for (Employee u:user){
            System.out.println(u);
        }

    }

    //测试employee与dept共同的查询操作
    @Test
    public void run10() throws Exception{
        List<Emp_Dept> emp_depts=employeeDao.findAllOfIt(); //封装打印一下
        for (Emp_Dept u:emp_depts){
            System.out.println(u);
        }

    }


    //测试根据ID查询操作
    @Test
    public void run13() throws Exception{
        departmentDao = sqlSession.getMapper(DepartmentDao.class);
        Department department=departmentDao.findById(2);
        System.out.println(department);

    }
    //测试新一款的employee与dept共同的查询操作，使用注解方式的查询
    @Test
    public void run11() throws Exception{
        List<Employee> emp_depts=employeeDao.findAllOfIt_2(); //封装打印一下
        for (Employee u:emp_depts){
            System.out.println("每个用户");
            System.out.println(u);
            System.out.println(u.getDepartment());
        }

    }
    @Test
    public void run12(){
        employeeDao=sqlSession.getMapper(EmployeeDao.class);
        Employee employee=employeeDao.findById(15);
        System.out.println(employee);
        System.out.println(employee.getDepartment());
    }

}
