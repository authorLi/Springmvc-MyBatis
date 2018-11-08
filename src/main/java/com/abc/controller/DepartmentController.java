package com.abc.controller;

import com.abc.bean.Department;
import com.abc.bean.Msg;
import com.abc.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    //返回所有部门信息
    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDepts(){

        //查出的所有部门信息
        List<Department> list = departmentService.getDepts();

        return Msg.success().add("depts",list);
    }
}
