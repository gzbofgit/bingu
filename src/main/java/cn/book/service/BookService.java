package cn.book.service;

import cn.book.pojo.Book;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BookService {
    /**
     * 多条件查询图书列表及分页，条件包括图书名，类别，有无库存
     *
     * @param typeId
     * @param inventory
     * @param bookName
     * @param indexPage
     * @param pageSize
     * @return
     */
    List<Book> getBookByConditionsAndPaging(Integer typeId, Integer inventory, String bookName,
                                            Integer indexPage,Integer pageSize);

    /**
     * 根据图书编号得到图书
     * @param bookId
     * @return
     */
    Book getBookByBookId(Integer bookId);

    /**
     * 根据图书名获取图书
     * @param bookName
     * @return
     */
    Book getBookByBookName(String bookName);

    /**
     * 新增一条图书记录
     * @param book
     * @return
     */
    int addBook(Book book);

    /**
     * 根据图书编号修改图书记录
     * @param book
     * @return
     */
    int updateBookByBookId(Book book);

    /**
     * 根据图书编号删除图书记录
     * @param bookId
     * @return
     */
    int deleteBookByBookId(Integer bookId);

    /**
     * 根据类别名删除图书
     * @param typeId
     * @return
     */
    int deleteBookByTypeId(Integer typeId);

    /**
     * 根据图书编号减少库存量
     *
     * @param bookId
     * @return
     */
    int minusInventoryByBookId(Integer bookId);

    /**
     * 根据图书编号增加库存量
     *
     * @param bookId
     * @return
     */
    int inventoryInsertByBookId( Integer bookId);
}
