package cn.book.service.impl;

import cn.book.dao.BorrowingMapper;
import cn.book.pojo.Borrowing;
import cn.book.service.BorrowingService;
import org.junit.jupiter.api.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service("borrowingService")
public class BorrowingServiceImpl implements BorrowingService {

    @Resource
    private BorrowingMapper borrowingMapper;

    @Override
    public int addBorrowing(Borrowing borrowing) {
        return borrowingMapper.addBorrowing(borrowing);
    }

    @Override
    public List<Borrowing> getBorrowing(String term,String overtime ,Integer indexPage, Integer pageSize) {
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationConfig.xml");
        borrowingMapper = (BorrowingMapper) context.getBean("borrowingMapper");
        return borrowingMapper.getBorrowing(term,overtime,indexPage,pageSize);
    }

    @Override
    public List<Borrowing> getBorrowingByName(String userName,String bookName, String overtime, Integer indexPage, Integer pageSize) {
        return borrowingMapper.getBorrowingByName(userName,bookName,overtime,indexPage,pageSize);
    }

    @Override
    public int restoreBook(Integer borrowingId) {
        return borrowingMapper.restoreBook(borrowingId);
    }

    @Override
    public int deleteByUserId(Integer userId) {
        return borrowingMapper.deleteByUserId(userId);
    }

    @Override
    public int deleteByBookId(Integer bookId) {
        return borrowingMapper.deleteByBookId(bookId);
    }

    @Test
    public void Test(){
        Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");//可以方便地修改日期格式
        String time = dateFormat.format( now );
        System.out.println(time);

        List<Borrowing> borrowings=new BorrowingServiceImpl().getBorrowing("",time,null,null);
        for (Borrowing item:borrowings) {
            System.out.println(item.getBookId().getBookName()+"===="+item.getUserId().getUserName());
        }
    }
}

