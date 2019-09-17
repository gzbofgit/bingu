package cn.book.dao;

import cn.book.pojo.Book;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("bookMapper")
public interface BookMapper {

    /**
     * 多条件查询图书列表及分页，条件包括图书名，类别，是否借出
     *
     * @param typeId
     * @param inventory
     * @param bookName
     * @param indexPage
     * @param pageSize
     * @return
     */
    List<Book> getBookByConditionsAndPaging(@Param("typeId") Integer typeId, @Param("inventory") Integer inventory,
                                            @Param("bookName") String bookName, @Param("indexPage") Integer indexPage,
                                            @Param("pageSize") Integer pageSize);

    /**
     * 根据图书编号得到图书
     *
     * @param bookId
     * @return
     */
    Book getBookByBookId(@Param("bookId") Integer bookId);

    /**
     * 根据图书名获取图书
     *
     * @param bookName
     * @return
     */
    Book getBookByBookName(@Param("bookName") String bookName);

    /**
     * 根据图书名得到图书
     *
     * @param bookName
     * @return
     */
    Book getBookBookName(@Param("bookName") String bookName);

    /**
     * 新增一条图书记录
     *
     * @param book
     * @return
     */
    int addBook(Book book);

    /**
     * 根据图书编号修改图书记录
     *
     * @param book
     * @return
     */
    int updateBookByBookId(Book book);

    /**
     * 根据图书编号删除图书记录
     *
     * @param bookId
     * @return
     */
    int deleteBookByBookId(@Param("bookId") Integer bookId);

    /**
     * 根据类别名删除图书
     *
     * @param typeId
     * @return
     */
    int deleteBookByTypeId(@Param("typeId") Integer typeId);

    /**
     * 根据图书编号减少库存量
     *
     * @param bookId
     * @return
     */
    int minusInventoryByBookId(@Param("bookId") Integer bookId);

    /**
     * 根据图书编号减少库存量
     *
     * @param bookId
     * @return
     */
    int inventoryInsertByBookId(@Param("bookId") Integer bookId);
}
