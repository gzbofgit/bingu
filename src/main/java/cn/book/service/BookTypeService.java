package cn.book.service;

import cn.book.pojo.BookType;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BookTypeService {
    /**
     * 得到图书类别集合
     *
     * @return
     */
    List<BookType> getBookTypeList(String typeName, Integer indexPage,Integer pageSize);

    /**
     * 根据类别名/类别编号得到类别对象
     * @param typeName
     * @return
     */
    BookType getBootTypeByTypeName(String typeName);

    /**
     * 根据类别名/类别编号得到类别对象
     * @param typeId
     * @return
     */
    BookType getBootTypeByTypeId(Integer typeId);

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
    int deleteBookTypeByTypeId(Integer typeId);

    /**
     * 修改类别
     * @param bookType
     * @return
     */
    int updateBookTypeByTypeId(BookType bookType);

}
