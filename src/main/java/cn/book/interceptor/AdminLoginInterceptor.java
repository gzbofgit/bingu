package cn.book.interceptor;

import cn.book.pojo.Admin;
import cn.book.pojo.User;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AdminLoginInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session=request.getSession();
        User user=(User)session.getAttribute("user");

        Admin admin=(Admin)session.getAttribute("admin");
        if(null==user){
            if(null==admin){
                response.sendRedirect("/admin/error.html");
                return false;
            }else{
                return true;
            }
        }else{
            return true;
        }
    }
}
