package cn.book.dao;

import cn.book.pojo.Admin;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository("adminMapper")
public interface AdminMapper {
    /**
     * 根据名称获取管理员对象
     * @param name
     * @return
     */
    Admin getAdminByName(@Param("name") String name);

}
