package com.abc.test;

import com.abc.bean.Department;
import com.abc.bean.Employee;
import com.abc.dao.DepartmentMapper;
import com.abc.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
//此注解指定SpringMVC的位置
@ContextConfiguration(locations = {"classpath:application-context.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    //批量的SqlSession
    @Autowired
    SqlSession sqlSession;



    @Test
    public void test(){
//        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("application-context.xml");
//        DepartmentMapper departmentMapper = applicationContext.getBean(DepartmentMapper.class);

//        System.out.println(departmentMapper);

        //1.插入几个部门
//        departmentMapper.insertSelective(new Department(null,"开发部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));

        //2.生成员工数据
//        employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@qq.com",1));
        //3.批量插入多个员工,使用可以执行批量操作的SqlSession
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for(int i = 0;i < 1000;i++){
            String uid = UUID.randomUUID().toString().substring(0,5) + i;
            mapper.insertSelective(new Employee(null,uid,"M",uid + "@qq.com",1));
        }
        System.out.println("批量完成");
    }

}
