package cn.book.dao;

import cn.book.pojo.Borrowing;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("borrowingMapper")
public interface BorrowingMapper {
    /**
     * 新增借阅记录
     * @param borrowing
     * @return
     */
    int addBorrowing(Borrowing borrowing);


    /**
     * 根据条件获取借阅记录并分页
     * @param term
     * @param overtime
     * @param indexPage
     * @param pageSize
     * @return
     */
    List<Borrowing> getBorrowing(@Param("term") String term,@Param("overtime") String overtime,
                                 @Param("indexPage") Integer indexPage,@Param("pageSize") Integer pageSize);


    /**
     * 根据用户名得到订单
     * @param bookName
     * @param userName
     * @param overtime
     * @param indexPage
     * @param pageSize
     * @return
     */
    List<Borrowing> getBorrowingByName(@Param("userName") String userName,@Param("bookName") String bookName,@Param("overtime") String overtime,
                                           @Param("indexPage") Integer indexPage,@Param("pageSize") Integer pageSize);

    /**
     * 归还书籍
     * @param borrowingId
     * @return
     */
    int restoreBook(@Param("borrowingId") Integer borrowingId);

    /**
     * 根据用户编号删除借阅记录
     * @param userId
     * @return
     */
    int deleteByUserId(@Param("userId") Integer userId);

    /**
     * 根据图书编号删除借阅记录
     * @param bookId
     * @return
     */
    int deleteByBookId(@Param("bookId") Integer bookId);
}
