package com.itnxd.controller;

import com.itnxd.bean.Department;
import com.itnxd.bean.Msg;
import com.itnxd.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 处理和部门有关的请求！
 *
 * @author ITNXD
 * @create 2021-04-11 15:44
 */
@Controller
public class DepartmentController {

    @Autowired
    DepartmentService departmentService;

    /**
     * 查询所有Dept信息！
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/depts", method = RequestMethod.GET)
    public Msg getDepts(){
        List<Department> list = departmentService.getDepts();
        return Msg.success().add("depts", list);
    }


}
