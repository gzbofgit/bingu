package cn.book.service;

import cn.book.pojo.Borrowing;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BorrowingService {
    /**
     * 新增借阅记录
     * @param borrowing
     * @return
     */
    int addBorrowing(Borrowing borrowing);
    /**
     * 根据条件获取借阅记录并分页
     * @param term
     * @param indexPage
     * @param pageSize
     * @return
     */
    List<Borrowing> getBorrowing(String term,String overtime, Integer indexPage,Integer pageSize);


    /**
     * 根据条件获取借阅记录并分页
     * @param userName
     * @param overtime
     * @param indexPage
     * @param pageSize
     * @param bookName
     * @return
     */
    List<Borrowing> getBorrowingByName(String userName,String bookName,String overtime,Integer indexPage,Integer pageSize);
    /**
     * 归还书籍
     * @param borrowingId
     * @return
     */
    int restoreBook(Integer borrowingId);

    /**
     * 根据用户编号删除借阅记录
     * @param userId
     * @return
     */
    int deleteByUserId(Integer userId);

    /**
     * 根据图书编号删除借阅记录
     * @param bookId
     * @return
     */
    int deleteByBookId(Integer bookId);


}
