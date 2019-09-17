<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>书虫</title>
    <link rel="shortcut icon" href="/static/image/top/title.ico" type="image/x-icon">
    <link rel="stylesheet" href="/static/css/bootstrap.css">
    <link rel="stylesheet" href="/static/css/top.css">
    <link rel="stylesheet" href="/static/css/awesome-bootstrap-checkbox.css">
</head>
<body>
<div class="container nav-justified" >
    <!--标题-->
    <div class="row" name="title">
        <div class="col-lg-8 col-sm-6 col-xs-6">
            <img src="/static/image/top/logo.png"/>
            <span class="h3" id="title">书虫系统</span>
        </div>

        <div class="col-lg-4 col-sm-6 col-xs-6" style="display: flex;align-items: center;padding-left: 190px">
            <span class="h5" style="font-family: STZhongsong;padding-right: 15px;color: white">欢迎您：${identity}<span class="h4" style="color: red;">${admin.name}</span></span>
                <a href="/admin/logout.html" class="btn btn-danger input-sm">退出</a>
        </div>
    </div>
    <!--时间-->
    <div class="row" name="time">
        <div class="col-lg-4 col-sm-6 col-xs-6" >
            <section class="publicTime">
                <img src="/static/image/top/sz.png" height="35" width="35"/>
                <span id="time" style="color: white;">2015年1月1日 11:11  星期一</span>
            </section>
        </div>
        <div class="col-lg-4 col-sm-6 col-xs-6">
        </div>
        <div class="col-lg-4 col-sm-6 col-xs-6">
            <a href="#" style="color: white;">温馨提示：为了能正常浏览，请使用谷歌游览器 ^_^</a>
        </div>
    </div>




    <div class="row" name="operation">
        <div class="col-lg-2 col-sm-6 col-xs-6" id="left">
            <ul style="margin-left: -50px">
                <li id="userOperation"><a href="#"><img src="/static/image/top/yh.png" style="margin-right:10px" height="25" width="25"/>用户管理<span
                        class="caret"></span></a>
                <li style="display:${userManager==null ? 'none':''};background-color:${userManager==null ? '':'#29faf2'} " class="userOperationSon"><a href="/user/userManager.html">查看用户信息</a></li>
                <li style="display:${userAdd==null ? 'none':''};background-color:${userAdd==null ? '':'#29faf2'}" class="userOperationSon"><a href="/user/userAdd.html">新增/修改用户</a></li>
                </li>
                <li id="bookOperation"><a href="#"><img src="/static/image/top/tsg.png" style="margin-right:10px" height="25" width="25"/>图书管理<span
                        class="caret"></span></a>
                <li style="display: ${bookManager==null ? 'none':''};background-color:${bookManager==null ? '':'#29faf2'} " class="bookOperationSon"><a href="/book/bookManager.html">查看图书信息</a></li>
                <li style="display: ${bookAdd==null ? 'none':''};background-color:${bookAdd==null ? '':'#29faf2'} " class="bookOperationSon"><a href="/book/bookAdd.html">新增/修改图书</a></li>
                </li>

                <li style="background-color:${typeManager==null ? '':'#29faf2'} " id="bookTypeOperation"><a href="/bookType/bookTypeManager.html"><img src="/static/image/top/lb.png" style="margin-right:10px" height="25" width="25"/>类别管理</a></li>

                <li style="background-color:${borrowingManager==null ? '':'#29faf2'} " id="borrowingOperation"><a href="/borrowing/borrowingManager.html"><img src="/static/image/top/jy.png" style="margin-right:10px" height="25" width="25"/>借阅管理</a>


                <li><a href="/admin/logout.html"><img src="/static/image/top/tc.png" style="margin-right:10px" height="25" width="25"/>退出系统</a></li>
            </ul>
        </div>
<script src="/static/js/jquery-1.12.4.js"></script>
<script src="/static/js/bootstrap.js"></script>
<script src="/static/js/time.js"></script>
<script src="/static/js/public.js"></script>