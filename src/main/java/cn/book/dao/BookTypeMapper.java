package cn.book.dao;

import cn.book.pojo.BookType;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("bookTypeMapper")
public interface BookTypeMapper {
    /**
     * 得到图书类别集合
     * @return
     */
    List<BookType> getBookTypeList(@Param("typeName") String typeName,@Param("indexPage") Integer indexPage,
                                   @Param("pageSize") Integer pageSize);

    /**
     * 根据类别名/类别编号得到类别对象
     * @param typeName
     * @return
     */
    BookType getBootTypeByTypeName(@Param("typeName") String typeName);

    /**
     * 根据类别名/类别编号得到类别对象
     * @param typeId
     * @return
     */
    BookType getBootTypeByTypeId(@Param("typeId") Integer typeId);

    /**
     * 新增类别
     * @param bookType
     * @return
     */
    int addBookType(BookType bookType);

    /**
     * 删除类别
     * @param typeId
     * @return
     */
    int deleteBookTypeByTypeId(@Param("typeId") Integer typeId);

    /**
     * 修改类别
     * @param bookType
     * @return
     */
    int updateBookTypeByTypeId(BookType bookType);


}
