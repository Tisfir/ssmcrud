package cn.itcrud.controller;

import cn.itcrud.domain.Department;
import cn.itcrud.domain.Employee;
import cn.itcrud.domain.Message;
import cn.itcrud.service.DepartmentService;
import cn.itcrud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author L.N
 * @creat 2021-02-22-14:01
 */
@Controller
@RequestMapping("/employee")
public class EmployeeController {
    @Autowired
    private EmployeeService employeeService;
    @Autowired
    private DepartmentService departmentService;

/*
* URI:
* /emp/{id} GET查询员工
* emp       POST保存员工
* /emp/{id}  PUT修改员工
* /emp/{id} DELECT 删除员工
* */
//因为页面需要分页数据，所以直接返回分页对象。
    @RequestMapping("/emps")
    @ResponseBody //这个注解直接可以返回json字符串的对象,如果他能正常工作，需要导入jackson的包
    public Message GetEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1") Integer pn){
        System.out.println("findAll方法没问题，执行了，springmvc 环境成功");
        //这不是一个分页查询分页查询要加入插件等等
        //引入pagehelper插件
        //在查询之前只需要调用,传入页码，以及每页的数据，每页5条数据
        PageHelper.startPage(pn,5);
        //start后面紧跟的这个查询就是一个分页查询
        List<Employee> list = employeeService.findAllOfIt_2();
        //使用pageinfo包装查询后的结果，只需要将pageinfo交给页面就行
        //包装了详细的分页信息，包括我们查询出来的数据
        PageInfo page=new PageInfo(list,5);// 每次连续显示的页数
        return Message.success().add("pageinfo",page);
    }

//==============================================员工保存方法===========================================
    @RequestMapping(value = "saveEmployee",method = RequestMethod.POST)
    @ResponseBody
    public Message saveEmp(@Valid Employee employee, BindingResult result){
        if (result.hasErrors()){
            //校验失败之后，应该返回失败，在模态框中显示校验失败的错误，
            Map<String,Object> map=new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for(FieldError fieldError:fieldErrors){
                System.out.println("错误字段名："+fieldError.getField());
                System.out.println("错误信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Message.failed().add("errorField",map);
        }else {
            employeeService.saveEmployee(employee);
            return Message.success();
        }

    }
    /*public Message saveEmp(Employee employee){
        employeeService.saveEmployee(employee);
        return Message.success();
    }*///不加校验之前的方法书写

//================================查询员工信息的方法==============================================
    @RequestMapping(value = "/find/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Message getEmp( @PathVariable("id") Integer emp_id){ //pathVariable是指从路径中取出ID的中的值
        Employee employee = employeeService.findById(emp_id);
        return Message.success().add("emp",employee);
    }

/*
*
*  *解决方案：
 * 我们要能支持直接发送PUT之类的请求，还要封装请求体中的数据
 *      在web.xml中配置上HttpPutFormContentFilter过滤器
 *      他的作用是将请求体中的数据解析包装成map
 *      request被重新包装，request.getParameter()被重写，就会从自己封装的map中取出数据
* */
    //================================更新员工信息的方法==============================================
    @RequestMapping(value = "/update/{emp_id}",method = RequestMethod.PUT)
    @ResponseBody
    public Message Update_Emp(Employee employee, HttpServletRequest httpServletRequest){ //pathVariable是指从路径中取出ID的中的值
        System.out.println(httpServletRequest.getParameter("gender"));
        System.out.println(employee);
        employeeService.updateEmp(employee);
       return Message.success();
    }


    //=================================根据ID删除员工的方法【单个】==============================================
    @ResponseBody
    @RequestMapping(value = "/del_emp/{emp_id}",method = RequestMethod.DELETE)
    public Message delete_empById(@PathVariable("emp_id") Integer emp_id){
        employeeService.deleteEmployee(emp_id);
        return Message.success();
    }

    //批量删除的方法
    @ResponseBody
    @RequestMapping(value = "/delete_emp/{ids}",method = RequestMethod.DELETE)
    public Message delete_emp(@PathVariable("ids") String ids) throws Exception {
        if (ids.contains("-")){
            String[] str_ids = ids.split("-");
//            Integer id1;//分割出来的ID数组
            for (String id:str_ids){
//                id1=Integer.parseInt(id);
//                employeeService.deleteAllByID(del_ids);
                employeeService.deleteAll(id );

            }
            System.out.println("111");

//            employeeService.deleteAllByID(del_ids);
        }else {
           Integer id=Integer.parseInt(ids);
            employeeService.deleteEmployee(id);
        }

        return Message.success();
    }


    //校验邮箱是否可用的方法,如果返回的是true,代表当前邮箱可用，否侧不可用
    @ResponseBody
    @RequestMapping("/checkemail")
    public Message checkEmail(@RequestParam("email") String email){
        //先判断邮箱是否是合法的表达式；
        String rex="^\\w+@[a-zA-Z0-9]{2,10}(?:\\.[a-z]{2,4}){1,3}$";
        if(!email.matches(rex)){
            return Message.failed().add("va_msg","邮箱格式不正确，应如：1580322@163.com");
        }
        //数据库名重复校验
        boolean b=employeeService.checkUser(email);
        if (b){
            return Message.success();
        }else {
            return Message.failed().add("va_msg","邮箱已被注册，请更换");
        }
    }


/*    @RequestMapping(value = "/update_zhuangtai/{emp_id}",method = RequestMethod.PUT)
    @ResponseBody
    public Message Update_Empzhuangtai(Employee employee, HttpServletRequest httpServletRequest){ //pathVariable是指从路径中取出ID的中的值
        employeeService.updateEmp(employee);
        return Message.success();
    }*/

    //普通的浏览器调用方式，与list页面的内容相拥。我们即将换一种。用ajax及json字符串的方式返回。同时换了一个新的index
    // @RequestMapping("/findAll")
    public String findAll(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model) {  //如果存起来，写一个model的对象
        System.out.println("findAll方法没问题，执行了，springmvc 环境成功");
        //这不是一个分页查询分页查询要加入插件等等
        //引入pagehelper插件
        //在查询之前只需要调用,传入页码，以及每页的数据，每页5条数据
        PageHelper.startPage(pn,5);
        //start后面紧跟的这个查询就是一个分页查询
        List<Employee> list = employeeService.findAllOfIt_2();
        //使用pageinfo包装查询后的结果，只需要将pageinfo交给页面就行
        //包装了详细的分页信息，包括我们查询出来的数据
        PageInfo page=new PageInfo(list,5);// 每次连续显示的页数


        List<Department> departments=departmentService.findAll();
        model.addAttribute("department",departments);


        model.addAttribute("pageinfo",page);
        return "list";
        //先进行单元测试数据，如果没有问题，在进行页面的展示
    }

}

