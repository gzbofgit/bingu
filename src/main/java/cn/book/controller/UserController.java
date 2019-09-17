package cn.book.controller;

import cn.book.pojo.Book;
import cn.book.pojo.User;
import cn.book.service.BookService;
import cn.book.service.BorrowingService;
import cn.book.service.UserService;
import com.alibaba.fastjson.JSONArray;
import org.junit.jupiter.api.Test;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.json.JsonArray;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Array;
import java.util.*;

@Controller
@RequestMapping("/user")
public class UserController {
    @Resource(name = "userService")
    private UserService userService;
    @Resource(name = "bookService")
    private BookService bookService;
    @Resource
    private BorrowingService borrowingService;

    /**
     * 跳转查看用户信息页面
     *
     * @return
     */
    @RequestMapping("/userManager.html")
    public String userManger(HttpSession session, HttpServletRequest request) {
        List<User> users = userService.getUserListByUserNameAndPaging("", 0, 9);
        //总行数
        int countRow = userService.getUserListByUserNameAndPaging("", null, null).size();
        //总页数
        int countPage = countRow % 9 == 0 ? countRow / 9 : (countRow / 9) + 1;
        //当前页码
        session.setAttribute("indexPage", 1);
        //总页数
        session.setAttribute("countPage", countPage);
        //用户名
        session.setAttribute("userName", "");
        //保存用户信息集合
        session.setAttribute("users", users);
        //保存用户管理页面标识(用于改变背景颜色)
        request.setAttribute("userManager", "userManager");
        //删除无用户信息表示符
        session.removeAttribute("userNull");
        return "userManager";
    }

    /**
     * 跳转新增用户页面
     *
     * @return
     */
    @RequestMapping("/userAdd.html")
    public String userAdd(HttpSession session, @RequestParam(value = "userId", required = false) String userId
            , HttpServletRequest request) {
        request.setAttribute("userAdd", "userAdd");//保存新增页面标识(用于改变背景颜色)
        /* session.removeAttribute("userManager");//删除用户管理页面标识*/
        if (userId != null && !("".equals(userId))) {//修改则保存修改用户到session中
            User user = userService.getUserByUserId(Integer.parseInt(userId));
            session.setAttribute("user", user);
        } else {
            session.removeAttribute("user");//新增则删除session中的用户
        }
        return "userAdd";
    }

    /**
     * 筛选用户，查找.分页等。
     *
     * @return
     */
    @RequestMapping("/filtrateUser.html")
    public String filtrateUser(String userName, String indexPage, HttpSession session) {
        List<User> users = userService.getUserListByUserNameAndPaging(userName, (Integer.parseInt(indexPage) - 1) * 9, 9);
        //总行数
        int countRow = userService.getUserListByUserNameAndPaging(userName, null, null).size();
        System.out.println(userName + "--" + indexPage);
        //总页数
        int countPage = countRow % 9 == 0 ? countRow / 9 : (countRow / 9) + 1;
        //当前页码
        session.setAttribute("indexPage", indexPage);
        //总页数
        session.setAttribute("countPage", countPage);
        //用户名
        session.setAttribute("userName", userName);
        session.setAttribute("users", users);
        if (users.size() <= 0) {
            session.setAttribute("userNull", "userNull");
        } else {
            session.removeAttribute("userNull");
        }
        return "userManager";
    }

    /**
     * 用户名称ajax
     *
     * @return
     */
    @RequestMapping(value = "/userNameIsNull.html", method = RequestMethod.GET)
    @ResponseBody
    public Object userNameIsNull(HttpSession session, String userName) {
        User user = userService.getUserByUserName(userName);
        User saveUser = (User) session.getAttribute("user");
        if (saveUser == null) {//新增页面
            System.out.println("新增");
            if (user != null) {
                return JSONArray.toJSONString("exist");
            } else {
                return JSONArray.toJSONString("onexist");
            }
        } else {//修改页面
            System.out.println("修改");
            if (user != null && !user.getUserName().equals(saveUser.getUserName())) {
                return JSONArray.toJSONString("exist");
            } else {
                return JSONArray.toJSONString("onexist");
            }
        }

    }

    /*新增/修改用户*/
    @RequestMapping("/addUser.html")
    @ResponseBody
    public Object addUser(HttpSession session, String userId,
                          String userName,String userPwd, String identity, String sex,
                          String birthData, String address, String phone, String isMember,String money) {
        User user = new User();
        user.setUserName(userName);
        user.setUserPwd(userPwd);
        user.setIdentity(identity);
        user.setSex(Integer.parseInt(sex));
        user.setBirthData("".equals(birthData) ? null : birthData);
        user.setAddress("".equals(address) ? null : address);
        user.setPhone(phone);
        user.setIsMember(Integer.parseInt(isMember));
        user.setMoney(money=="" || money==null ? 0:Double.parseDouble(money));
        User saveUser = (User) session.getAttribute("user");
        System.out.println("日期：" + birthData);
        int row = 0;
        if (saveUser != null) {//修改
            user.setUserId(Integer.parseInt(userId));
            row = userService.updateUserByUserId(user);
            if (row > 0) {
                return JSONArray.toJSONString(row);
            } else {
                return JSONArray.toJSONString(0);
            }
        } else {//新增
            row = userService.addUser(user);
            if (row > 0) {
                User user1 = userService.getUserByUserName(userName);
                return JSONArray.toJSONString(user1.getUserId());
            } else {
                return JSONArray.toJSONString(0);
            }
        }
    }

    /**
     * 查看用户详细信息
     *
     * @return
     */
    @RequestMapping(value = "/view", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public Object view(String userId) {
        System.out.println(userId);
        User user = userService.getUserByUserId(Integer.parseInt(userId));
        return JSONArray.toJSONString(user);
    }

    /**
     * 用户充值
     *
     * @param userId
     * @param upMoney
     * @return
     */
    @RequestMapping(value = "/up", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public Object up(String userId, String upMoney) {
        int row = userService.userUpByUserId(Integer.parseInt(userId), Double.parseDouble(upMoney));
        if (row > 0) {
            User user = userService.getUserByUserId(Integer.parseInt(userId));
            return JSONArray.toJSONString(user);
        } else {
            return JSONArray.toJSONString(0);
        }
    }

    /**
     * 删除用户
     *
     * @param userId
     * @return
     */
    @RequestMapping(value = "/delUser.html", method = RequestMethod.GET)
    @ResponseBody
    public Object delUser(String userId) {
        int line=borrowingService.deleteByUserId(Integer.parseInt(userId));
        int row = userService.deleteUserByUserId(Integer.parseInt(userId));
        return JSONArray.toJSONString(row);
    }

    /**
     * 验证归还日期是否违规
     * @param time
     * @param userName
     * @param bookId
     * @return
     */
    @RequestMapping("/moneyIsEnough.html")
    @ResponseBody
    public Object moneyIsEnough(String time, String userName, String bookId) {
        User user = userService.getUserByUserName(userName);
        Book book = bookService.getBookByBookId(Integer.parseInt(bookId));
        Map<String,String> biInfo=new HashMap<String,String>();
        int time_ = time.equals("0") ? 1 : Integer.parseInt(time);//借阅天数
        double money1 = book.getBookPrice() * 0.01;//非会员超出天数单价(天)
        double money2 =book.getBookPrice()*0.01*0.8;//会员超出天数单价(天)
        biInfo.put("borrowingTime",time_+"");
        if (time_ <= 3) {//3天
            biInfo.put("borrowingMoney","0");
            biInfo.put("success","pass");
            return JSONArray.toJSONString(biInfo);

        } else if (time_ <= 7) {//一星期
            if (user.getIsMember() == 0) {//非会员
                if (user.getMoney() >= (time_-3)*money1) {
                    System.out.println("非会员"+time_+"天借书金额："+(time_-3)*money1);
                    biInfo.put("borrowingMoney",(time_-3)*money1+"");
                    biInfo.put("success","pass");
                    return JSONArray.toJSONString(biInfo);
                } else {
                    biInfo.put("borrowingMoney",(time_-3)*money1+"");
                    biInfo.put("success","noPass");
                    return JSONArray.toJSONString(biInfo);
                }
            } else {//会员
                biInfo.put("borrowingMoney","0");
                biInfo.put("success","pass");
                return JSONArray.toJSONString(biInfo);
            }
        } else {//一星期以上
            if (user.getIsMember() == 0) {//非会员
                if (user.getMoney() >= (time_-3)*money1) {
                    System.out.println("非会员"+time_+"天借书金额："+(time_-3)*money1);
                    biInfo.put("borrowingMoney",(time_-3)*money1+"");
                    biInfo.put("success","pass");
                    return JSONArray.toJSONString(biInfo);
                } else {
                    biInfo.put("borrowingMoney",(time_-3)*money1+"");
                    biInfo.put("success","noPass");
                    return JSONArray.toJSONString(biInfo);
                }
            } else {//会员
                if (user.getMoney() >= (time_-7)*money2) {
                    System.out.println("会员"+time_+"天借书金额："+(time_-7)*money2);
                    biInfo.put("borrowingMoney",(time_-7)*money2+"");
                    biInfo.put("success","pass");
                    return JSONArray.toJSONString(biInfo);
                } else {
                    biInfo.put("borrowingMoney",(time_-7)*money2+"");
                    biInfo.put("success","onPass");
                    return JSONArray.toJSONString(biInfo);
                }
            }
        }
    }

    @Test
    public void test() {
        //九九乘法表
        for (int i = 1; i <= 9; i++) {
            for (int s = 1; s <= i; s++) {
                System.out.print(s + "*" + i + "=" + i * s + " ");
            }
            System.out.println();
        }

        int[] array = new int[6];
        array[0] = 1;
        array[1] = 3;
        array[2] = 5;
        array[3] = 7;
        array[4] = 9;
        int num = 6;
        int index = 0;

        for (int i = 0; i < array.length - 1; i++) {
            if (array[i] > num) {
                index = i;
                break;
            }
        }
        /*for (int s=array.length-1;s>index;s--){
            array[s]=array[s-1];
        }*/


        for (int i = array.length - 1; i > index; i--) {
            array[i] = array[i - 1];
        }
        array[index] = num;
        System.out.println(Arrays.toString(array));

        //冒泡排序
        int[] score = {11, 65, 78, 9, 20, 9};

        for (int i = 0; i < score.length; i++) {
            for (int j = 0; j < score.length - 1 - i; j++)
            // 减1是因为最后一位是自己不用比，减i同理，每循环i次，最后的i个值就不用比
            {
                //升序
                /*if (score[j] > score[j + 1]) {
                    int temp = score[j + 1];
                    score[j + 1] = score[j];
                    score[j] = temp;
                }*/
                //降序
                if (score[j] < score[j + 1]) {
                    int temp = score[j];
                    score[j] = score[j + 1];
                    score[j + 1] = temp;
                }
            }
        }
        System.out.println("分隔");
        for (int s = 0; s < score.length; s++) {
            System.out.print(score[s] + "==");
        }
    }
}
