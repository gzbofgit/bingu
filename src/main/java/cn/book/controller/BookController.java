package cn.book.controller;

import cn.book.pojo.Book;
import cn.book.pojo.BookType;
import cn.book.pojo.User;
import cn.book.service.BookService;
import cn.book.service.BookTypeService;
import cn.book.service.BorrowingService;
import cn.book.service.UserService;
import com.alibaba.fastjson.JSONArray;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.math.RandomUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/book")
public class BookController {
    @Resource
    private BookTypeService bookTypeService;
    @Resource
    private BookService bookService;
    @Resource
    private BorrowingService borrowingService;

    /**
     * 跳转图书管理界面
     *
     * @param session
     * @return
     */
    @RequestMapping("/bookManager.html")
    public String bookManager(HttpSession session, HttpServletRequest request) {
        List<BookType> bookTypes = bookTypeService.getBookTypeList("", null, null);

        List<Book> books = bookService.getBookByConditionsAndPaging(null, null, "", 0, 9);
        //总行数
        int countRow = bookService.getBookByConditionsAndPaging(null, null, "", null, null).size();
        //总页数
        int countPage = countRow % 9 == 0 ? countRow / 9 : (countRow / 9) + 1;
        //当前页码
        session.setAttribute("indexPage", 1);
        //总页数
        session.setAttribute("countPage", countPage);
        //用户名
        session.setAttribute("bookName", "");
        //类别
        session.setAttribute("typeId", 0);
        //是否借出
        session.setAttribute("inventory", null);
        //图书集合
        session.setAttribute("books", books);
        //类别集合
        session.setAttribute("bookTypes", bookTypes);
        //保存一个图书管理标识,用于变色
        request.setAttribute("bookManager", "bookManager");
        //删除无图书信息标识符
        session.removeAttribute("bookNull");
        return "bookManager";
    }

    /**
     * 筛选图书，查找.分页等。
     *
     * @return
     */
    @RequestMapping("/filtrateBook.html")
    public String filtrateBook(String typeId, String inventory, String bookName, String indexPage, HttpSession session) {
        Integer typeId_ = "0".equals(typeId) || typeId == null || "".equals(typeId) ? null : Integer.parseInt(typeId);
        Integer inventory_ = "0".equals(inventory) || inventory == null || "".equals(inventory) ? null : 1;
        System.out.println(typeId + "==" + inventory + ":session：" + inventory_ + "图书名：" + bookName + "页码：" + indexPage);
        List<Book> books = bookService.getBookByConditionsAndPaging(typeId_, inventory_, bookName, (Integer.parseInt(indexPage) - 1) * 9, 9);
        //总行数
        int countRow = bookService.getBookByConditionsAndPaging(typeId_, inventory_, bookName, null, null).size();
        //总页数
        int countPage = countRow % 9 == 0 ? countRow / 9 : (countRow / 9) + 1;
        //当前页码
        session.setAttribute("indexPage", indexPage);
        //总页数
        session.setAttribute("countPage", countPage);
        //用户名
        session.setAttribute("bookName", bookName);
        //类别
        session.setAttribute("typeId", typeId_);
        //是否借出
        session.setAttribute("inventory", inventory_);
        //图书集合
        session.setAttribute("books", books);
        if (books.size() <= 0) {
            session.setAttribute("bookNull", "bookNull");
        } else {
            session.removeAttribute("bookNull");
        }
        return "bookManager";
    }

    /**
     * 查看图书详细信息
     *
     * @return
     */
    @RequestMapping(value = "/view", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public Object view(String bookId) {
        Book book = bookService.getBookByBookId(Integer.parseInt(bookId));
        return JSONArray.toJSONString(book);
    }

    /**
     * 跳转图书新增/修改页面
     *
     * @param session
     * @param request
     * @return
     */
    @RequestMapping("/bookAdd.html")
    public String bookAdd(HttpSession session, HttpServletRequest request,
                          @RequestParam(value = "bookId", required = false) String bookId) {
        request.setAttribute("bookAdd", "bookAdd");
        List<BookType> bookTypes = bookTypeService.getBookTypeList("", null, null);
        session.setAttribute("bookTypes", bookTypes);
        if (bookId == null || bookId == "") {//新增
            session.removeAttribute("uploadFileError");
            session.removeAttribute("upBook");
            System.out.println("新增");
            session.removeAttribute("book");
            return "bookAdd";
        } else {//修改
            System.out.println("修改");
            Book book = bookService.getBookByBookId(Integer.parseInt(bookId));
            session.setAttribute("book", book);
            session.setAttribute("upBook", "upBook");
            return "bookAdd";
        }
    }

    /**
     * ajax验证图书是否重名
     *
     * @param bookName
     * @return
     */
    @RequestMapping("/bookNameIsExist.html")
    @ResponseBody
    public Object bookNameIsExist(HttpSession session, String bookName) {
        Book book = bookService.getBookByBookName(bookName);
        Book books = (Book) session.getAttribute("book");
        if (books == null) {
            if (book == null) {
                return JSONArray.toJSONString("noExist");
            } else {
                return JSONArray.toJSONString("exist");
            }
        } else {
            if (book == null || book.getBookName().equals(books.getBookName())) {
                return JSONArray.toJSONString("noExist");
            } else {
                return JSONArray.toJSONString("exist");
            }
        }

    }

    /**
     * 新增/修改图书
     *
     * @param book
     * @param bookPortrait_
     * @return
     */
    @RequestMapping(value = "/bookFileLoad.html", method = RequestMethod.POST)
    public String addBook(HttpSession session, Book book, HttpServletRequest request,
                          @RequestParam(value = "bookPortrait_", required = false) MultipartFile bookPortrait_,
                          String typeIds) {
        /*session作用域中修改对象*/
        String pathB = "";
        String fileName = "";
        Book upBook = (Book) session.getAttribute("book");
        if (!(bookPortrait_.isEmpty())) {//判断文件对象是否存在
            //定义上传目标路径(系统绝对路径，服务器端)
            // String path=session.getServletContext().getRealPath("/static/image/userManager"+ File.separator);
            /* path="D:\\y2\\使用SSM框架开发企业级项目\\bookworm\\src\\main\\webapp\\static\\image\\bookImages\\";*/
            pathB = "D:\\y2\\使用SSM框架开发企业级项目\\bookworm\\target\\bookworm\\static\\image\\bookImages\\";
            //获取原文件名
            String oldFileName = bookPortrait_.getOriginalFilename();
            //获取原文件后缀
            String prefix = FilenameUtils.getExtension(oldFileName);
            //定义后缀名集合，用于判断文件后缀是否违规
            List<String> ps = Arrays.asList("jpg", "png", "jpeg", "pneg", "PNG");
            //判断文件大小是否超过规定大小
            if (bookPortrait_.getSize() > 500000) {
                session.setAttribute("uploadFileError", "图片不能大于500kb！");
                if (upBook == null) {
                    return "redirect:/book/bookAdd.html";
                } else {
                    session.setAttribute("upBook", "upBook");
                    return "redirect:/book/bookAdd.html?bookId=" + book.getBookId() + "";
                }
            } else if (!ps.contains(prefix)) {//跟后缀名集合比较看是否包含指定格式
                session.setAttribute("uploadFileError", "图片格式不正确！");
                if (upBook == null) {
                    return "redirect:/book/bookAdd.html";
                } else {
                    session.setAttribute("upBook", "upBook");
                    return "redirect:/book/bookAdd.html?bookId=" + book.getBookId() + "";
                }
            }
            //使用系统时间的毫秒数+1000000的随机数+指定后缀来重命名文件名称，防止重名
            fileName = System.currentTimeMillis() + RandomUtils.nextInt(1000000) + "bookImage.jpg";

            File targetFileB = new File(pathB, fileName);//创建指定路径和文件名的文件、服务器端
            if (!targetFileB.exists()) {//判断文件是否存在
                targetFileB.mkdirs();//如果文件不存在则新建一个文件路径
            }
            try {
                //验证都成功后，使用该方法把MultpartFile中的文件流数据输出至目标文件中
                bookPortrait_.transferTo(targetFileB);
                book.setBookPortrait(fileName);
                session.removeAttribute("uploadFileError");
            } catch (Exception e) {
                e.printStackTrace();
                if (upBook == null) {//新增
                    return "redirect:/book/bookAdd.html";
                } else {//修改
                    session.setAttribute("upBook", "upBook");
                    return "redirect:/book/bookAdd.html?bookId=" + book.getBookId() + "";
                }
            }
            System.out.println("字段值：==" + fileName);
        } else {
            if (upBook == null) {
                //新增保存默认封面
                book.setBookPortrait("defaultBookPortrait.jpg");
            } else {
                //修改保存原有封面
                book.setBookPortrait(upBook.getBookPortrait());
            }
        }
        BookType bookType = new BookType();
        bookType.setTypeId(Integer.parseInt(typeIds));
        book.setTypeId(bookType);
        int row = 0;
        String info = "";
        if (upBook == null) {//新增
            row = bookService.addBook(book);
            info = "新增";
        } else {//修改
            row = bookService.updateBookByBookId(book);
            deleteFile(pathB + "\\" + upBook.getBookPortrait());
            info = "修改";
        }
        if (row > 0) {
            return "redirect:/book/bookManager.html";
        } else {
            request.setAttribute("loadFileError", info + "失败！");
            return "bookAdd";
        }
    }

    /**
     * 删除图书
     *
     * @param bookId
     * @return
     */
    @RequestMapping(value = "/delBook.html", method = RequestMethod.GET)
    @ResponseBody
    public Object delBook(String bookId) {
        Book book = bookService.getBookByBookId(Integer.parseInt(bookId));
        borrowingService.deleteByBookId(Integer.parseInt(bookId));
        int row = bookService.deleteBookByBookId(Integer.parseInt(bookId));
        /* String path1="D:\\y2\\使用SSM框架开发企业级项目\\bookworm\\src\\main\\webapp\\static\\image\\bookImages\\"+book.getBookPortrait();*/
        String path2 = "D:\\y2\\使用SSM框架开发企业级项目\\bookworm\\target\\bookworm\\static\\image\\bookImages\\" + book.getBookPortrait();
        if (row > 0) {
            /*deleteFile(path1);*/
            deleteFile(path2);//删除封面图片
        }
        return JSONArray.toJSONString(row);
    }

    /**
     * 删除文件
     *
     * @param path
     * @return
     */
    public boolean deleteFile(String path) {
        File file = new File(path);
        if (file.isDirectory()) {
            return true;
        } else {
            try {
                file.createNewFile();//删除文件
                file.delete();
                return file.exists();
            } catch (IOException e) {
                e.printStackTrace();
                return false;
            }
        }
    }

}
