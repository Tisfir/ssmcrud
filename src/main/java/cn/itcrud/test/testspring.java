package cn.itcrud.test;

import cn.itcrud.service.EmployeeService;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * @author L.N
 * @creat 2021-02-22-14:07
 */
public class testspring {
    @Test
    public void run2(){
        //加载配置文件
        ApplicationContext ac= new ClassPathXmlApplicationContext("classpath:applicationContext.xml");
        //获取对象
        EmployeeService at= (EmployeeService) ac.getBean("employeeservice");
        //调用方法
        at.findAll();
    }
}
