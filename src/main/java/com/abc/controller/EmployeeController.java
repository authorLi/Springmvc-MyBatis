package com.abc.controller;
/*
    restfulURL的规范：
    ／emps/{id}  GET 查询员工
    ／emps       POST 保存员工
    ／emps/{id}  PUT　修改员工
    ／emps/{id}  DELETE　删除员工
 */

import com.abc.bean.Employee;
import com.abc.bean.Msg;
import com.abc.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import sun.applet.resources.MsgAppletViewer;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;


    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids")String ids){
        if(ids.contains("-")){
            //批量删除
            List<Integer> list = new ArrayList<Integer>();
            String[] strs = ids.split("-");
            for(String s:strs){
                list.add(Integer.parseInt(s));
            }
            employeeService.deleteBatch(list);
            return Msg.success();
        }else{
            //单个删除
            int id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
            return Msg.success();
        }
    }


    //员工更新方法
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee){
        System.out.println(employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }


    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }



    //检查用户名是否可用
    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkUser(@RequestParam(value = "empName") String empName) {

        //先判断用户名是否是合法的表达式
        String regix = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
        if (!empName.matches(regix)) {
            return Msg.fail().add("va_msg", "用户名必须是6-16位数字和字母的组合或者2-5位中文");
        }

        //数据库用户名校验
        boolean b = employeeService.checkUser(empName);
        if (b) {
            return Msg.success();
        }
        return Msg.fail().add("va_msg", "用户名不可用");
    }

    //员工保存
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            Map<String, Object> map = new HashMap<String, Object>();
            List<FieldError> list = result.getFieldErrors();
            for (FieldError fieldError : list) {
                System.out.println("错误的字段名" + fieldError.getField());
                System.out.println("错误的字段信息" + fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFieldMap", map);
        } else {
            employeeService.saveEmp(employee);
        }
        return Msg.success();
    }

    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        //引入PageHelper分页插件
        //在查询之前只需要调用PageHelper.startPage()，第一个参数是页码，第二个参数是一个页面有多少数据
        PageHelper.startPage(pn, 5);
        //startPage()之后紧跟的查询就是分页查询
        List<Employee> list = employeeService.getAll();
        //使用PageInfo包装查询结果只需要将PageInfo交给页面就可以了
        //封装了详细的分页信息，包括有我们查询出来的数据,第二个参数是连续显示的页数
        PageInfo pageInfo = new PageInfo(list, 5);

        return Msg.success().add("pageInfo", pageInfo);
    }


//    @RequestMapping("/emps")
//    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
//
//        //引入PageHelper分页插件
//        //在查询之前只需要调用PageHelper.startPage()，第一个参数是页码，第二个参数是一个页面有多少数据
//        PageHelper.startPage(pn,5);
//        //startPage()之后紧跟的查询就是分页查询
//        List<Employee> list = employeeService.getAll();
//        //使用PageInfo包装查询结果只需要将PageInfo交给页面就可以了
//        //封装了详细的分页信息，包括有我们查询出来的数据,第二个参数是连续显示的页数
//        PageInfo pageInfo = new PageInfo(list,5);
//
//        model.addAttribute("pageInfo",pageInfo);
//
//        return "list";
//    }
}
