package cn.book.controller;

import cn.book.pojo.Book;
import cn.book.pojo.BookType;
import cn.book.pojo.Borrowing;
import cn.book.pojo.User;
import cn.book.service.BookService;
import cn.book.service.BookTypeService;
import cn.book.service.BorrowingService;
import cn.book.service.UserService;
import com.alibaba.fastjson.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/userAction")
public class UserActionController {
    @Resource
    private BookService bookService;
    @Resource
    private BookTypeService bookTypeService;
    @Resource
    private BorrowingService borrowingService;
    @Resource
    private UserService userService;

    /**
     * 跳转用户书籍展示界面
     *
     * @param session
     * @return
     */
    @RequestMapping("/bookInfos.html")
    public String bookManager(HttpSession session, HttpServletRequest request) {
        List<BookType> bookTypes = bookTypeService.getBookTypeList("", null, null);

        List<Book> books = bookService.getBookByConditionsAndPaging(null, null, "", 0, 9);
        //图书选项卡标识
        request.setAttribute("myBook","myBook");
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

        //当前登入用户
        User user=(User)session.getAttribute("user");
        //订单数据
        List<Borrowing> borrowings = borrowingService.getBorrowingByName(user.getUserName(),null,null, 0, 9);
        //总行数
        int countRowBi = borrowingService.getBorrowingByName(user.getUserName(),null,null, null, null).size();
        //总页数
        int countPageBi = countRowBi % 9 == 0 ? countRowBi / 9 : (countRowBi / 9) + 1;
        //当前页码
        session.setAttribute("indexPageBi", 1);
        //总页数
        session.setAttribute("countPageBi", countPageBi);
        //条件
        session.setAttribute("term", "");
        //是否超时
        session.setAttribute("overtime", 0);
        //保存用户信息集合
        session.setAttribute("borrowings", borrowings);
        //删除无用户信息表示符
        session.removeAttribute("borrowingNull");
        if (borrowings.size() <= 0) {
            session.setAttribute("borrowingNull", "borrowingNull");
        } else {
            session.removeAttribute("borrowingNull");
        }
        return "myCenter";
    }

    /**
     * 筛选图书，查找.分页等。
     *
     * @return
     */
    @RequestMapping("/filtrateBook.html")
    public String filtrateBook(String typeId, String inventory, String bookName, String indexPage, HttpSession session,
                               HttpServletRequest request) {
        Integer typeId_ = "0".equals(typeId) || typeId == null || "".equals(typeId) ? null : Integer.parseInt(typeId);
        Integer inventory_ = "0".equals(inventory) || inventory == null || "".equals(inventory) ? null : 1;
        System.out.println(typeId + "==" + inventory + ":session：" + inventory_ + "图书名：" + bookName + "页码：" + indexPage);
        //图书选项卡标识
        request.setAttribute("myBook","myBook");
       /* //订单选项卡标识
        request.removeAttribute("myBorrowing");*/
        //当前登入用户
        User user=(User)session.getAttribute("user");
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
        //订单数据
        List<Borrowing> borrowings = borrowingService.getBorrowingByName(user.getUserName(),null,null, 0, 9);
        //总行数
        int countRowBi = borrowingService.getBorrowingByName(user.getUserName(),null,null, null, null).size();
        //总页数
        int countPageBi = countRowBi % 9 == 0 ? countRowBi / 9 : (countRowBi / 9) + 1;
        //当前页码
        session.setAttribute("indexPageBi", 1);
        //总页数
        session.setAttribute("countPageBi", countPageBi);
        //条件
        session.setAttribute("term", "");
        //是否超时
        session.setAttribute("overtime", 0);
        //保存用户信息集合
        session.setAttribute("borrowings", borrowings);
        //删除无用户信息表示符
        session.removeAttribute("borrowingNull");
        return "myCenter";
    }


    /**
     * 筛选记录，查找.分页等。
     *
     * @return
     */
    @RequestMapping("/filtrateBorrowing.html")
    public String filtrateBorrowing(String term,String overtime ,String indexPage, HttpSession session,
                                    HttpServletRequest request) {
        //订单选项卡标识
        request.setAttribute("myBorrowing","myBorrowing");
      /*  //图书选项卡标识
        request.removeAttribute("myBook");*/
        //当前登入用户
        User user=(User)session.getAttribute("user");
        Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");//可以方便地修改日期格式
        String time = dateFormat.format( now );
        if(("0").equals(overtime) || overtime==null){
            overtime="";//普通查询
        }else{
            overtime=time;//超时查询
        }
        //订单数据
       // List<Borrowing> borrowings = borrowingService.getBorrowingByName(null,"不",overtime, 0, 9);
        List<Borrowing> borrowings=borrowingService.getBorrowingByName(user.getUserName(),term,overtime,(Integer.parseInt(indexPage) - 1) * 9,9);
        //总行数
        int countRow = borrowingService.getBorrowingByName(user.getUserName(),term,overtime, null, null).size();
        System.out.println("条件："+term + "=" + indexPage);
        //总页数
        int countPage = countRow % 9 == 0 ? countRow / 9 : (countRow / 9) + 1;
        //当前页码
        session.setAttribute("indexPageBi", indexPage);
        //总页数
        session.setAttribute("countPageBi", countPage);
        //是否超时
        session.setAttribute("overtime",("").equals(overtime) || overtime==null? 0:1);
        //条件
        session.setAttribute("term", term);
        //借阅记录
        session.setAttribute("borrowings", borrowings);
        if (borrowings.size() <= 0) {
            session.setAttribute("borrowingNull", "borrowingNull");
        } else {
            session.removeAttribute("borrowingNull");
        }


        //图书数据
        List<BookType> bookTypes = bookTypeService.getBookTypeList("", null, null);

        List<Book> books = bookService.getBookByConditionsAndPaging(null, null, "", 0, 9);
        //总行数
        int countRowBook = bookService.getBookByConditionsAndPaging(null, null, "", null, null).size();
        //总页数
        int countPageBook = countRowBook % 9 == 0 ? countRowBook / 9 : (countRowBook / 9) + 1;
        //当前页码
        session.setAttribute("indexPage", 1);
        //总页数
        session.setAttribute("countPage", countPageBook);
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
        //删除无图书信息标识符
        session.removeAttribute("bookNull");
        return "myCenter";
    }

    /**
     * 开通会员
     * @param session
     * @return
     */
    @RequestMapping("/openIsMember.html")
    @ResponseBody
    public Object openIsMember(HttpSession session){
        User sUser=(User)session.getAttribute("user");
        int row=userService.openIsMemberByUserId(sUser.getUserId());
        if(row>0){
            session.setAttribute("user",userService.getUserByUserId(sUser.getUserId()));
            return JSONArray.toJSONString("success");
        }else{
            return JSONArray.toJSONString(row);
        }
    }

    /**
     * 刷新数据
     * @param request
     * @return
     */
    @RequestMapping("/flushUser.html")
    public String flushUser(HttpServletRequest request){
        request.setAttribute("myCenter","myCenter");
        return "myCenter";
    }
}
