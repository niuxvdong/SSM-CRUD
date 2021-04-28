package com.itnxd.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.itnxd.bean.Employee;
import com.itnxd.bean.Msg;
import com.itnxd.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工增删改查请求！
 *
 * @author ITNXD
 * @create 2021-04-10 20:55
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 查询员工数据，分页查询！
     *
     * @return
     */
    //@RequestMapping(value = "/emps", method = RequestMethod.GET)
    public String getEmps(@RequestParam(value = "p", defaultValue = "1")
                                      Integer p, Model model){
        // 引入pageHelper插件实现分页！
        // 只处理紧跟的查询！
        // 参数：页码 每页个数
        PageHelper.startPage(p, 7);
        List<Employee> emps = employeeService.getAll();

        // 使用pageInfo包装查询结果！
        // 参数：包装类 连续显示页数
        PageInfo<Employee> pageInfo = new PageInfo<>(emps, 5);
        // 传到list页面！
        model.addAttribute("pageInfo", pageInfo);
        return "list";
    }

    /**
     * 导入Jackson包处理Json数据！
     *
     * 查询员工数据，分页查询！
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emps", method = RequestMethod.GET)
    public Msg getEmpsWithJson(@RequestParam(value = "p", defaultValue = "1") Integer p){
        PageHelper.startPage(p, 7, "emp_id");
        List<Employee> emps = employeeService.getAll();

        PageInfo<Employee> pageInfo = new PageInfo<>(emps, 5);
        return Msg.success().add("pageInfo", pageInfo);
    }

    /**
     * 员工保存！
     * ResponseBody还可以 自动封装JavaBean！
     *
     *  添加JSR303后端校验！
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            // 校验失败，前端显示错误信息
            Map<String, Object> map = new HashMap<>();
            for (FieldError fieldError : result.getFieldErrors()) {
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        }else{
            employeeService.saveEmp(employee);
            return Msg.success();
        }

    }

    /**
     * 检验用户名是否可用！
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkEmpName")
    public Msg checkEmpName(@RequestParam("empName") String empName){

        // 先判断用户名是否是合法的表达式！（由于前端代码可以认为修改，并不安全！）
        String regx = "(^[a-zA-Z0-9_-]{5,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
        if(!empName.matches(regx)){
            return Msg.fail().add("inValid_empName", "用户名必须是2-5位中文或者5-16位英文和数字的组合！");
        }
        // 在判断是否重复！
        boolean isValid = employeeService.checkEmpName(empName);
        if(isValid){
            return Msg.success();
        }else {
            return Msg.fail().add("inValid_empName", "用户名重复！不可用！");
        }
    }

    /**
     * 获取编辑时要查询的员工信息！
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }

    /**
     * 更新员工信息！
     *
     * 可以通过_method带put参数
     *
     * 也可以通过ajax直接发送put请求，但是信息无法封装到employee对象！
     *
     * 问题:
     * 请求体中有数据;
     * 但是Employee对象封装不上;
     * update tbl_emp where emp_id = 1014;
     *
     * 原因:
     * Tomcat:
     * 1、将请求体中的数据，封装一个map。
     * 2、request.getParameter( "empName")就会从这个map中取值。
     * 3、SpringMVC封装POJO对象的时候。
     *
     * 会把POJO中每个属性的值，request.getParameter( "email" );
     *
     * AJAX发送PUT请求引发的血案;
     *      PUT请求，请求体中的数据，request.getParameter( "empName ")拿不到
     *      Tomcat一看是PUT不会封装请求体中的数据为map，只有POST形式的请求才封装请求体为map
     *
 *     我们要能支持直接发送PUT之类的请求还要封装请求体中的数据
     *     配置上HttpPutFormContentFilter;
     *     spring5.x需要配置 FormContentFilter
     * 他的作用，将请求体中的数据解析包装成一个map。
     * request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数搓员工
     * 更新方法
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    public Msg updateEmp(Employee employee){
        System.out.println("--------------------------------------" + employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 删除员工！
     * 单个批量删除二合一！
     * 单个 ：1
     * 批量：1-2-3-5
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids") String ids){
        // 批量删除
        if(ids.contains("-")){
            List<Integer> del_ids = new ArrayList<>();
            String[] str_id = ids.split("-");
            for (String id : str_id) {
                del_ids.add(Integer.parseInt(id));
            }
            employeeService.deleteBatch(del_ids);
        }else{ // 单个删除
            employeeService.deleteEmpById(Integer.parseInt(ids));
        }
        return Msg.success();
    }
}
