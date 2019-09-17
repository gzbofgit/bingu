package cn.book.service;

import cn.book.pojo.Admin;



public interface AdminService {

    Admin getAdminByName(String name,String pwd);

    Admin getAdminByName(String name);
}
