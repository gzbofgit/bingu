package cn.book.dao;

import cn.book.pojo.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("userMapper")
public interface UserMapper {
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
    List<User> getUserListByUserNameAndPaging(@Param("userName") String userName, @Param("indexPage") Integer indexPage,
                                              @Param("pageSize") Integer pageSize);

    /**
     * 根据用户名得到用户对象
     * @param userName
     * @return
     */
    User getUserByUserName(@Param("userName") String userName);

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
    int deleteUserByUserId(@Param("userId") Integer userId);

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
    User getUserByUserId(@Param("userId") Integer userId);

    /**
     * 根据用户编号进行充值
     * @param userId
     * @return
     */
    int userUpByUserId(@Param("userId") Integer userId, @Param("money") Double money);

    /**
     * 根据用户编号进行扣费
     * @param userId
     * @return
     */
    int userMoneyMinusByUserId(@Param("userId") Integer userId, @Param("money") Double money);

    /**
     * 根据id开通会员
     * @param userId
     * @return
     */
    int openIsMemberByUserId(@Param("userId") Integer userId);

}
