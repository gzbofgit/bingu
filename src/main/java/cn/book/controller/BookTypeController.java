package cn.book.controller;

import cn.book.pojo.Book;
import cn.book.pojo.BookType;
import cn.book.service.BookService;
import cn.book.service.BookTypeService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import org.junit.jupiter.api.Test;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.json.JsonArray;
import javax.persistence.criteria.CriteriaBuilder;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/bookType")
public class BookTypeController {

    @Resource
    private BookTypeService bookTypeService;

    @Resource
    private BookService bookService;

    /**
     * 跳转图书类别管理页面
     *
     * @param session
     * @param request
     * @return
     */
    @RequestMapping("/bookTypeManager.html")
    public String BookTypeManager(HttpSession session, HttpServletRequest request) {
        List<BookType> bookTypes = bookTypeService.getBookTypeList("", 0, 9);
        //总行数
        int countRow = bookTypeService.getBookTypeList("", null, null).size();
        //总页数
        int countPage = countRow % 9 == 0 ? countRow / 9 : (countRow / 9) + 1;
        //当前页码
        session.setAttribute("indexPage", 1);
        //总页数
        session.setAttribute("countPage", countPage);
        //类别名
        session.setAttribute("typeName", "");
        //类别集合
        session.setAttribute("bookTypes", bookTypes);
        //保存一个类别管理标识,用于变色
        request.setAttribute("typeManager", "typeManager");
        //删除无类别信息标识符
        session.removeAttribute("typeNull");
        return "bookTypeManager";
    }

    /**
     * 筛选用户，查找.分页等。
     *
     * @return
     */
    @RequestMapping("/filtrateType.html")
    public String filtrateUser(String typeName, String indexPage, HttpSession session) {
        List<BookType> bookTypes = bookTypeService.getBookTypeList(typeName, (Integer.parseInt(indexPage) - 1) * 9, 9);
        //总行数
        int countRow = bookTypeService.getBookTypeList(typeName, null, null).size();
        //总页数
        int countPage = countRow % 9 == 0 ? countRow / 9 : (countRow / 9) + 1;
        //当前页码
        session.setAttribute("indexPage", indexPage);
        //总页数
        session.setAttribute("countPage", countPage);
        //类别名
        session.setAttribute("typeName", typeName);
        //类别集合
        session.setAttribute("bookTypes", bookTypes);
        if (bookTypes.size() <= 0) {
            session.setAttribute("bookTypeNull", "bookTypeNull");
        } else {
            session.removeAttribute("bookTypeNull");
        }
        return "bookTypeManager";
    }

    /**
     * 新增/修改类别
     *
     * @param session
     * @param upTypeName
     * @return
     */
    @RequestMapping("/bookTypeAdd.html")
    @ResponseBody
    public Object bookTypeAdd(HttpSession session, String upTypeName) {
        int row = 0;
        BookType bookType = new BookType();
        bookType.setTypeName(upTypeName);
        BookType bookType_1 = (BookType) session.getAttribute("bookType");
        if (bookType_1 == null) {//新增
            session.removeAttribute("bookType");
            row = bookTypeService.addBookType(bookType);
        } else {//修改
            bookType.setTypeId(bookType_1.getTypeId());
            row = bookTypeService.updateBookTypeByTypeId(bookType);
        }
        return JSONArray.toJSONString(row);
    }

    /**
     * 类别名重名验证
     *
     * @param upTypeName
     * @return
     */
    @RequestMapping("/bookTypeIsExist.html")
    @ResponseBody
    public Object bookTypeIsExist(HttpSession session, String upTypeName) {
        BookType bootTypeByTypeName = bookTypeService.getBootTypeByTypeName(upTypeName);
        BookType bookType = (BookType) session.getAttribute("bookType");
        if (bookType == null) {//新增类别
            if (bootTypeByTypeName == null) {
                return JSONArray.toJSONString("onExist");
            } else {
                return JSONArray.toJSONString("exist");
            }
        } else {//修改类别
            if (bootTypeByTypeName != null && !(upTypeName.equals(bookType.getTypeName()))) {
                return JSONArray.toJSONString("exist");
            } else {
                return JSONArray.toJSONString("onExist");
            }
        }
    }

    /**
     * 修改类别保存对象
     *
     * @param session
     * @param typeId
     * @return
     */
    @RequestMapping(value = "/upBookType", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public Object upBookType(HttpSession session, String typeId) {
        BookType bookType = bookTypeService.getBootTypeByTypeId(Integer.parseInt(typeId));
        session.setAttribute("bookType", bookType);
        return JSONArray.toJSONString(bookType);
    }

    /**
     * 新增删除修改对象
     *
     * @param session
     * @return
     */
    @RequestMapping("/addBookType.html")
    @ResponseBody
    public Object addBookType(HttpSession session) {
        session.removeAttribute("bookType");
        return JSONArray.toJSONString("");
    }

    /**
     * 删除类别
     *
     * @param typeId
     * @return
     */
    @RequestMapping("/delBookType.html")
    @ResponseBody
    public Object delBookType(String typeId) {
        bookService.deleteBookByTypeId(Integer.parseInt(typeId));
        int row = bookTypeService.deleteBookTypeByTypeId(Integer.parseInt(typeId));
        return JSONArray.toJSONString(row);
    }
}
