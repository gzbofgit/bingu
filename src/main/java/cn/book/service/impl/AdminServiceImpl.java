package cn.book.service.impl;

import cn.book.dao.AdminMapper;
import cn.book.pojo.Admin;
import cn.book.service.AdminService;
import org.junit.jupiter.api.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("adminService")
public class AdminServiceImpl implements AdminService {

    @Resource(name = "adminMapper")
    private AdminMapper adminMapper;

    @Override
    public Admin getAdminByName(String name, String pwd) {
        Admin admin = adminMapper.getAdminByName(name);
        if (admin != null && admin.getPwd().equals(pwd)) {
            return admin;
        }
        return null;
        /*ApplicationContext context=new ClassPathXmlApplicationContext("applicationConfig.xml");
        adminMapper=(AdminMapper)context.getBean("adminMapper");
        return adminMapper.getAdminByName(name);*/
    }

    @Override
    public Admin getAdminByName(String name) {

        return adminMapper.getAdminByName(name);
    }

    @Test
    public void test() {

        Admin admin = new AdminServiceImpl().getAdminByName("君莫", "123456");
        if (admin != null) {
            System.out.println(admin.getName());
        } else {
            System.out.println("密码错误！hhh");
        }
    }
}
