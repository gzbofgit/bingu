package cn.book.controller;

import cn.book.pojo.Book;
import cn.book.pojo.Borrowing;
import cn.book.pojo.User;
import cn.book.service.BookService;
import cn.book.service.BorrowingService;
import cn.book.service.UserService;
import com.alibaba.fastjson.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/borrowing")
public class BorrowingController {
    @Resource
    private BookService bookService;
    @Resource
    private UserService userService;
    @Resource
    private BorrowingService borrowingService;

    /**
     * 跳转借阅管理界面
     *
     * @param session
     * @param request
     * @return
     */
    @RequestMapping("/borrowingManager.html")
    public String borrowingManager(HttpSession session, HttpServletRequest request) {
        List<Borrowing> borrowings = borrowingService.getBorrowing("", null, 0, 9);
        //总行数
        int countRow = borrowingService.getBorrowing("", null, null, null).size();
        //总页数
        int countPage = countRow % 9 == 0 ? countRow / 9 : (countRow / 9) + 1;
        //当前页码
        session.setAttribute("indexPage", 1);
        //总页数
        session.setAttribute("countPage", countPage);
        //条件
        session.setAttribute("term", "");
        //是否超时
        session.setAttribute("overtime", 0);
        //保存用户信息集合
        session.setAttribute("borrowings", borrowings);
        //保存用户管理页面标识(用于改变背景颜色)
        request.setAttribute("borrowingManager", "borrowingManager");
        //删除无用户信息表示符
        session.removeAttribute("borrowingNull");
        return "borrowingManager";
    }

    /**
     * 筛选记录，查找.分页等。
     *
     * @return
     */
    @RequestMapping("/filtrateBorrowing.html")
    public String filtrateBorrowing(String term, String overtime, String indexPage, HttpSession session) {
        Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");//可以方便地修改日期格式
        String time = dateFormat.format(now);
        if (("0").equals(overtime) || overtime == null) {
            overtime = "";
        } else {
            overtime = time;
        }
        System.out.println("时间：" + overtime);

        List<Borrowing> borrowings = borrowingService.getBorrowing(term, overtime, (Integer.parseInt(indexPage) - 1) * 9, 9);
        //总行数
        int countRow = borrowingService.getBorrowing(term, overtime, null, null).size();
        System.out.println(term + "--" + indexPage);
        //总页数
        int countPage = countRow % 9 == 0 ? countRow / 9 : (countRow / 9) + 1;
        //当前页码
        session.setAttribute("indexPage", indexPage);
        //总页数
        session.setAttribute("countPage", countPage);
        //是否超时
        session.setAttribute("overtime", ("").equals(overtime) || overtime == null ? 0 : 1);
        //条件
        session.setAttribute("term", term);
        //借阅记录
        session.setAttribute("borrowings", borrowings);
        if (borrowings.size() <= 0) {
            session.setAttribute("borrowingNull", "borrowingNull");
        } else {
            session.removeAttribute("borrowingNull");
        }
        return "borrowingManager";
    }

    /**
     * 新增一条借阅记录
     *
     * @param remarks
     * @param borrowingTime
     * @param returnTime
     * @param time
     * @param userName
     * @param bookId
     * @return
     */
    @RequestMapping(value = "/borrowingAdd.html", method = RequestMethod.GET)
    @ResponseBody
    public Object borrowingAdd(String remarks, String borrowingTime, String returnTime, String time, String userName, String bookId,
                               HttpSession session) {
        User user = userService.getUserByUserName(userName);//用户
        Book book = bookService.getBookByBookId(Integer.parseInt(bookId));//图书
        Borrowing borrowing = new Borrowing();//借阅对象
        int time_ = time.equals("0") ? 1 : Integer.parseInt(time);//借阅天数
        double money = 0;
        double money1 = book.getBookPrice() * 0.01;//非会员超出天数单价(天)
        double money2 = book.getBookPrice() * 0.01 * 0.8;//会员超出天数单价(天)
        borrowing.setUserId(user);
        borrowing.setBookId(book);
        borrowing.setReturnTime(returnTime);
        borrowing.setRemarks(remarks);
        if (time_ <= 3) {//3天
            money = 0;
        } else if (time_ <= 7) {//一星期
            if (user.getIsMember() == 0) {//非会员
                money = (time_ - 3) * money1;
            } else {//会员
                money = 0;
            }
        } else {//一星期以上

            if (user.getIsMember() == 0) {//非会员
                money = (time_ - 3) * money1;
            } else {//会员
                money = (time_ - 7) * money2;
            }
        }
        int row = borrowingService.addBorrowing(borrowing);//新增借阅记录
        if (row > 0) {
            bookService.minusInventoryByBookId(book.getBookId());//根据书籍编号库存-1

            userService.userMoneyMinusByUserId(user.getUserId(),money);//根据用户编号扣除余额
            //刷新作用域的用户信息
            session.setAttribute("user", userService.getUserByUserName(userName));
            return JSONArray.toJSONString("success");
        }
        return JSONArray.toJSONString(row);
    }

    /**
     * 归还书籍
     *
     * @param borrowingId
     * @param bookId
     * @return
     */
    @RequestMapping("/restoreBook.html")
    @ResponseBody
    public Object restoreBook(String borrowingId, String bookId) {
        int row = borrowingService.restoreBook(Integer.parseInt(borrowingId));//归还书籍
        if (row > 0) {
            //根据书籍编号库存+1
            int line = bookService.inventoryInsertByBookId(Integer.parseInt(bookId));
            if (line > 0) {
                return JSONArray.toJSONString("success");
            } else {
                return JSONArray.toJSONString("error");
            }
        }
        return JSONArray.toJSONString("error");
    }
}
