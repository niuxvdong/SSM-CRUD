package com.itnxd.service;

import com.itnxd.bean.Department;
import com.itnxd.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author ITNXD
 * @create 2021-04-11 15:46
 */
@Service
public class DepartmentService {

    @Autowired
    DepartmentMapper departmentMapper;

    /**
     * 获取所有Dept信息！
     *
     * @return
     */
    public List<Department> getDepts() {
        return departmentMapper.selectByExample(null);
    }
}
