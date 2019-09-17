package cn.book.service;

import cn.book.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserService {
    /**
     * 得到用户集合
     * @return
     */
    List<User> getUsrList();

    /**
     * 根据用户名模糊查询，以及分页条件
     * @param userName
     * @param indexPage
     * @param pageSize
     * @return
     */
    List<User> getUserListByUserNameAndPaging(String userName,Integer indexPage,Integer pageSize);

    /**
     * 根据用户名得到用户对象
     * @param userName
     * @return
     */
    User getUserByUserName(String userName);

    /**
     * 根据用户名密码得到对象
     * @param userName
     * @param pwd
     * @return
     */
    User getUserByUserNameAndPwd(String userName,String pwd);

    /**
     * 新增用户
     * @param user
     * @return
     */
    int addUser(User user);

    /**
     * 根据用户编号删除用户
     * @param userId
     * @return
     */
    int deleteUserByUserId(Integer userId);

    /**
     * 根据用户编号修改用户信息
     * @param user
     * @return
     */
    int updateUserByUserId(User user);
    /**
     * 根据编号得到用户
     * @param userId
     * @return
     */
    User getUserByUserId(Integer userId);

    /**
     * 根据用户编号进行充值
     * @param userId
     * @return
     */
    int userUpByUserId(Integer userId, Double money);

    /**
     * 根据用户编号进行扣费
     * @param userId
     * @return
     */
    int userMoneyMinusByUserId(Integer userId,Double money);

    /**
     * 根据id开通会员
     * @param userId
     * @return
     */
    int openIsMemberByUserId(@Param("userId") Integer userId);
}
