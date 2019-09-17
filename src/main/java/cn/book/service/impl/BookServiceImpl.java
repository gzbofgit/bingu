package cn.book.service.impl;

import cn.book.dao.BookMapper;
import cn.book.pojo.Book;
import cn.book.service.BookService;
import org.junit.jupiter.api.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service("bookService")
public class BookServiceImpl implements BookService {
    @Resource(name = "bookMapper")
    private BookMapper bookMapper;

    @Override
    public List<Book> getBookByConditionsAndPaging(Integer typeId, Integer inventory, String bookName,
                                                   Integer indexPage, Integer pageSize) {
       /* ApplicationContext context = new ClassPathXmlApplicationContext("applicationConfig.xml");
        bookMapper = (BookMapper) context.getBean("bookMapper");*/
        return bookMapper.getBookByConditionsAndPaging(typeId,inventory,bookName,indexPage,pageSize);
    }

    @Override
    public Book getBookByBookId(Integer bookId) {
        return bookMapper.getBookByBookId(bookId);
    }

    @Override
    public Book getBookByBookName(String bookName) {
        return bookMapper.getBookByBookName(bookName);
    }

    @Override
    public int addBook(Book book) {
        return bookMapper.addBook(book);
    }

    @Override
    public int updateBookByBookId(Book book) {
        return bookMapper.updateBookByBookId(book);
    }

    @Override
    public int deleteBookByBookId(Integer bookId) {
        return bookMapper.deleteBookByBookId(bookId);
    }

    @Override
    public int deleteBookByTypeId(Integer typeId) {
        return bookMapper.deleteBookByTypeId(typeId);
    }

    @Override
    public int minusInventoryByBookId(Integer bookId) {
        return bookMapper.minusInventoryByBookId(bookId);
    }

    @Override
    public int inventoryInsertByBookId(Integer bookId) {
        return bookMapper.inventoryInsertByBookId(bookId);
    }

    @Test
    public void test(){
       List<Book> bookList= new BookServiceImpl().getBookByConditionsAndPaging(null,0,"",(1-1)*1,1);
        for (Book item:bookList) {
            System.out.println(item.getTypeId().getTypeName()+"=="+item.getBookName());
        }
    }
}
