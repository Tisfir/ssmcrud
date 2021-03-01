package cn.itcrud.service.impl;

import cn.itcrud.dao.DepartmentDao;
import cn.itcrud.domain.Department;
import cn.itcrud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author L.N
 * @creat 2021-02-22-16:20
 */
@Service("departmentService")
public class DepartmentServiceImpl implements DepartmentService {
    @Autowired
    private DepartmentDao departmentDao;
    public List<Department> findAll(){
        System.out.println("department业务层执行中");
        return departmentDao.findAll();
    }



}
