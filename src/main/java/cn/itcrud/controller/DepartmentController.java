package cn.itcrud.controller;

import cn.itcrud.domain.Department;
import cn.itcrud.domain.Message;
import cn.itcrud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author L.N
 * @creat 2021-02-23-15:20
 */
@Controller
@RequestMapping("/dedepartment")
public class DepartmentController {
    @Autowired
    DepartmentService departmentService;
    @RequestMapping("/dept_findall")
    @ResponseBody //这个注解直接可以返回json字符串的对象,如果他能正常工作，需要导入jackson的包
    public Message getDepts(){
        //查出的所有部门信息
        List<Department> list = departmentService.findAll();
        return Message.success().add("depts",list);
    }

/*    public String findAll(Model model){  //如果存起来，写一个model的对象
        System.out.println("departmentfindAll方法没问题，执行了，springmvc 环境成功");
        //调用service的方法代表成功
        List<Department> list=departmentService.findAll();
        model.addAttribute("list1",list);
        return "list";
    }*/

}
