package cn.book.service.impl;

import cn.book.dao.BookTypeMapper;
import cn.book.pojo.BookType;
import cn.book.service.BookTypeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("bookTypeService")
public class BookTypeServiceImpl implements BookTypeService {
    @Resource
    private BookTypeMapper bookTypeMapper;
    @Override
    public List<BookType> getBookTypeList(String typeName, Integer indexPage, Integer pageSize) {
        return bookTypeMapper.getBookTypeList(typeName,indexPage,pageSize);
    }

    @Override
    public BookType getBootTypeByTypeName(String typeName) {
        return bookTypeMapper.getBootTypeByTypeName(typeName);
    }

    @Override
    public BookType getBootTypeByTypeId(Integer typeId) {
        return bookTypeMapper.getBootTypeByTypeId(typeId);
    }

    @Override
    public int addBookType(BookType bookType) {
        return bookTypeMapper.addBookType(bookType);
    }

    @Override
    public int deleteBookTypeByTypeId(Integer typeId) {
        return bookTypeMapper.deleteBookTypeByTypeId(typeId);
    }

    @Override
    public int updateBookTypeByTypeId(BookType bookType) {
        return bookTypeMapper.updateBookTypeByTypeId(bookType);
    }
}
