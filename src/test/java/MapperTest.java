import com.itnxd.bean.Department;
import com.itnxd.bean.Employee;
import com.itnxd.dao.DepartmentMapper;
import com.itnxd.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;

import java.util.UUID;

/**
 * @author ITNXD
 * @create 2021-04-10 19:52
 */
// 推荐Spring的项目就可以使用Spring的单元测试，可以自动注入我们需要的组件
// Spring5对于junit5的复合注解
// https://www.itnxd.cn/posts/34962.html#1%E3%80%81Spring%E6%95%B4%E5%90%88Junit4

@SpringJUnitConfig(locations = "classpath:applicationContext.xml")
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    /**
     * 测试DepartmentMapper！
     */
    @Test
    public void test(){
        // 之前方式
       /* ApplicationContext ioc = new ClassPathXmlApplicationContext
                ("applicationContext.xml");
        DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);*/

        // 使用spring测试，直接Autowired
//        System.out.println(departmentMapper);

        // 插入
//        departmentMapper.insertSelective(new Department(null, "开发部"));
//        departmentMapper.insertSelective(new Department(null, "测试部"));

        // 生成员工数据
//        employeeMapper.insertSelective(new Employee(null, "tom", "F", "tom@gmail.com", 2, null));

        // 批量插入生成测试数据
        // 去配置支持批量的SqlSessionFactory
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for(int i = 0; i < 10000; i ++){
            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
            String gender;
            if(i % 2 == 0) gender = "F";
            else gender = "M";
            mapper.insertSelective(new Employee(null, uid, gender, uid + "@gmail.com", 2, null));
        }
        System.out.println("批量插入完成！");

    }
}
