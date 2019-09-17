package cn.book.interceptor;

import cn.book.pojo.User;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UserLoginInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session=request.getSession();
        User user =(User) session.getAttribute("user");
        if(null==user){
            response.sendRedirect("/error.html");
            return false;
        }
        return true;
    }
}
