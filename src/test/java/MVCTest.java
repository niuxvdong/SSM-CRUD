import com.github.pagehelper.PageInfo;
import com.itnxd.bean.Employee;
import org.aspectj.lang.annotation.Before;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * 使用spring测试模块基于junit5的测试，测试CRUD正确性！
 *
 * MockMvc只支持spring4.x版本，5.x需要降到4.x版本！降低版本仍然报错！
 * 直接弃用，直接在页面测试即可！
 *
 * @author ITNXD
 * @create 2021-04-10 21:14
 */
@WebAppConfiguration
@SpringJUnitConfig(locations = "classpath:applicationContext.xml")
public class MVCTest {

    // 传入springmvc的ioc，是自带的
    // @Autowired 只能处理ioc容器内的，ioc自己的无法自动装配
    // 需要使用一个注解处理：@WebAppConfiguration，然后再@Autowierd
    @Autowired
    WebApplicationContext context;
    // spring-test中的虚拟mvc测试对象，需要初始化后使用！
    MockMvc mockMvc;

    /**
     * MockMvc初始化！
     */
    @BeforeEach
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    /**
     * 测试分页的方法！
     */
    @Test
    public void testPage() throws Exception {
        // 模拟我们发送请求！并拿到返回值！
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").
                param("p", "1")).andReturn();
        // 请求成功后，请求域会有pageInfo信息！
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");

        System.out.println("当前页码：" + pageInfo.getPageNum());
        System.out.println("总页码：" + pageInfo.getPages());
        System.out.println("总记录数：" + pageInfo.getTotal());
        System.out.println("需要连续显示的页码：");
        int[] ints = pageInfo.getNavigatepageNums();
        for (int i : ints) {
            System.out.println(" " + i);
        }
        // 获取员工信息
        List<Employee> employees = pageInfo.getList();
        for (Employee employee : employees) {
            System.out.println(employee);
        }
    }
}
