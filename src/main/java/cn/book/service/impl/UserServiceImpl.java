package cn.book.service.impl;

import cn.book.dao.UserMapper;
import cn.book.pojo.Admin;
import cn.book.pojo.User;
import cn.book.service.UserService;
import org.junit.jupiter.api.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("userService")
public class UserServiceImpl implements UserService {

    @Resource(name = "userMapper")
    private UserMapper userMapper;

    @Override
    public List<User> getUsrList() {
        return userMapper.getUsrList();
    }

    @Override
    public List<User> getUserListByUserNameAndPaging(String userName, Integer indexPage, Integer pageSize) {
            ApplicationContext context = new ClassPathXmlApplicationContext("applicationConfig.xml");
            userMapper = (UserMapper) context.getBean("userMapper");
        return userMapper.getUserListByUserNameAndPaging(userName, indexPage, pageSize);
    }

    @Override
    public User getUserByUserName(String userName) {
        return userMapper.getUserByUserName(userName);
    }

    public User getUserByUserNameAndPwd(String userName,String pwd){
        User user = userMapper.getUserByUserName(userName);
        if (user != null && user.getUserPwd().equals(pwd)) {
            return user;
        }
        return null;
    }
    @Override
    public int addUser(User user) {
        return userMapper.addUser(user);
    }

    @Override
    public int deleteUserByUserId(Integer userId) {
        return userMapper.deleteUserByUserId(userId);
    }

    @Override
    public int updateUserByUserId(User user) {
        return userMapper.updateUserByUserId(user);
    }

    @Override
    public User getUserByUserId(Integer userId) {
        return userMapper.getUserByUserId(userId);
    }

    @Override
    public int userUpByUserId(Integer userId, Double money) {
        return userMapper.userUpByUserId(userId,money);
    }

    @Override
    public int userMoneyMinusByUserId(Integer userId, Double money) {
        return userMapper.userMoneyMinusByUserId(userId,money);
    }

    @Override
    public int openIsMemberByUserId(Integer userId) {
        return userMapper.openIsMemberByUserId(userId);
    }

    @Test
    public void test() {
        List<User> list = getUserListByUserNameAndPaging("", 9, 9);
        for (User item : list) {
           /* System.out.println(item.getType);*/
        }
    }
}
