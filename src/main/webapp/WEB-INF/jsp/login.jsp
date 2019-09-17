<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登入</title>
    <link rel="shortcut icon" href="/static/image/top/title.ico" type="image/x-icon">
    <link href="/static/image/top/title.ico" rel="icon" type="image/x-ico">
    <link rel="stylesheet" href="/static/css/bootstrap.css">
    <link rel="stylesheet" href="/static/css/login.css">
</head>
<body>
<div id="d">
    <form action="/admin/login.html" id="loginForm" class="container"
          style="display: flex;justify-content: center;margin-top: 90px" method="post">
        <div class="row">
            <div class="col-lg-12" style="display:flex;justify-content: center">
                <span class="h4">登入</span>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <hr>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <input id="name" type="text" placeholder="请输入用户名" name="name" class="form-control input-sm"
                           style="width: 400px;"/>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <span id="loginInfo" style="color: red;"></span>
                </div>
            </div>
            <div class="row">
               <%-- <div class="col-lg-12">
                    <input type="password" placeholder="请输入密码" name="pwd" onblur="pwdBlur()" class="form-control input-sm"
                           style="width: 400px"/>
                </div>--%>
                <div class="col-lg-11">
                    <input type="password" placeholder="请输入密码" name="pwd" onblur="pwdBlur()" class="form-control input-sm"
                           style="width: 400px"/>
                </div>
                <div id="byA" class="col-lg-1">
                    <img src="/static/image/by.png" width="20" height="20" onclick="switchoverA()" alt="" style="margin-left: -50px;margin-top: 5px">
                </div>
                <div id="zyA"  class="col-lg-1 by" style="display: none;">
                    <img src="/static/image/zy.png" width="20" height="20" onclick="switchoverA()" alt="" style="margin-left: -50px;margin-top: 5px">
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <%--全局异常抛出错误信息--%>
                    <div name="pwdInfo" class="info" style="color: red;">${exception.message }</div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-7 col-xs-6 col-md-6">
                    <input type="text" placeholder="请输入验证码" name="code" onblur="codeBlur()" class="form-control input-sm"/>
                </div>

                <div class="col-lg-2 col-xs-4 col-md-4" id="yzm">
                    <img class="img-rounded" alt=""
                         style="max-width: 70px;max-height: 70px;">
                </div>
                <div class="col-lg-1 col-xs-2 col-md-2">
                    <a href="#" id="sx"><img src="/static/image/login/sx.png" title="看不清楚？换一张"
                                             style="width: 20px;height: 20px;"/></a>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <span style="color: red;" id="codeInfo"></span>
                </div>
            </div>
            <div class="row" style="display: flex;align-items: center">
                <div class="col-lg-4" style="display: flex;align-items: center">
                    <input type="radio" name="role" checked="checked" value="0">管理员
                </div>
                <div class="col-lg-4" style="display: flex;align-items: center">
                    <input type="radio" name="role" value="1">用户
                </div>
                <div class="col-lg-4" style="display: flex;align-items: center">
                    <a href="#" data-toggle="modal"
                       data-target="#mymodal4">用户注册</a>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12" style="padding-bottom: 30px">
                    <input type="submit" id="login" value="登入" class="btn btn-primary" style="width: 400px"/>
                </div>
            </div>
        </div>
    </form>
</div>
<%--用户注册--%>
<div id="mymodal4" class="modal fade bs-example-modal-md">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <form action="/admin/userLogin.html" method="post" style="margin-left: 50px">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">&times;</button>
                    <h5 class="modal-title text-center">用户注册</h5>
                </div>
                <div class="media-body">
                    <div class="container" style="width: 600px">
                        <div class="row" style="padding-top: 25px;">
                            <div class="col-lg-2">
                                <span class="h5">用户名：</span>
                            </div>
                            <div class="col-lg-8">
                                <input name="userName" onblur="userNameBlur2()" class="input-sm form-control" placeholder="请输入用户名"
                                       style="width: 80%"/>
                            </div>
                            <div class="col-lg-2">
                                <span name="userNameInfo" class="h6" style="margin-left:-90px;color:red">*</span>
                            </div>
                        </div>
                        <div class="row" style="padding-top: 25px">
                            <div class="col-lg-2">
                                <span class="h5">密码：</span>
                            </div>
                            <div class="col-lg-7">
                                <input name="userPwd" type="password" onblur="userPwdBlur()" class="input-sm form-control" value="${user==null?'':user.userPwd}" placeholder="以字母开头,长度在6~18之间,只能包含字母、数字和下划线 " style="width: 80%"/>
                            </div>
                            <div id="by" class="col-lg-1">
                                <img src="/static/image/by.png" width="20" height="20" onclick="switchoverZ()" alt="" style="margin-left: -80px">
                            </div>
                            <div id="zy" class="col-lg-1" style="display: none;">
                                <img src="/static/image/zy.png" width="20" height="20" onclick="switchoverB()" alt="" style="margin-left: -80px">
                            </div>
                            <div class="col-lg-2">
                                <span name="userPwdInfo" class="h6" style="margin-left:-90px;color:red">*</span>
                            </div>
                        </div>
                        <div class="row" style="padding-top: 25px">
                            <div class="col-lg-2">
                                <span class="h5">身份证号：</span>
                            </div>
                            <div class="col-lg-8">
                                <input name="identity" onblur="identityBlur()" class="input-sm form-control" placeholder="请输入身份证号码"
                                       style="width: 80%"/>
                            </div>
                            <div class="col-lg-2">
                                <span name="identityInfo" class="h6 " style="margin-left:-90px;color: red">*</span>
                            </div>
                        </div>
                        <div class="row" style="padding-top: 25px">
                            <div class="col-lg-2">
                                <span class="h5">性别：</span>
                            </div>
                            <div class="col-lg-8" style="display: flex;align-items: center">
                                <div><span class="h5">男</span><input type="radio" name="sex" checked="checked" value="0"
                                                                     style="margin-left: 10px"></div>
                                <div><span class="h5" style="margin-left: 100px">女</span><input type="radio" name="sex"
                                                                                                value="1"
                                                                                                style="margin-left: 10px">
                                </div>
                            </div>
                            <div class="col-lg-2">
                                <span name="sexInfo" class="h5" style="margin-left:-100px;color: red"></span>
                            </div>
                        </div>
                        <div class="row" style="padding-top: 25px">
                            <div class="col-lg-2">
                                <span class="h5">出生日期：</span>
                            </div>
                            <div class="col-lg-8">
                                <input name="birthData" onblur="birthDataBlur()" type="date" class="input-sm form-control" placeholder="请输入用户名"
                                       style="width: 80%"/>
                            </div>
                            <div class="col-lg-2">
                                <span name="birthDataInfo" class="h6" style="margin-left:-90px;color: red"></span>
                            </div>
                        </div>
                        <div class="row" style="padding-top: 18px">
                            <div class="col-lg-2">
                                <span class="h5">住址：</span>
                            </div>
                            <div class="col-lg-8">
                                <input name="address" class="input-sm form-control" placeholder="请输入住址"
                                       style="width: 80%"/>
                            </div>
                            <div class="col-lg-2">
                                <span name="addressInfo" class="h5" style="margin-left:-90px;color: red"></span>
                            </div>
                        </div>
                        <div class="row" style="padding-top: 25px">
                            <div class="col-lg-2">
                                <span class="h5">电话：</span>
                            </div>
                            <div class="col-lg-8">
                                <input name="phone" onblur="phoneBlur()" class="input-sm form-control" placeholder="请输入电话号码"
                                       style="width: 80%"/>
                            </div>
                            <div class="col-lg-2">
                                <span name="phoneInfo" class="h6" style="margin-left:-90px;color:red">*</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="row" style="width: 550px;">
                        <div class="col-lg-12" >
                            <input id="userLogin" type="submit"  class="btn btn-primary" value="注册并登入"/>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
<script type="text/javascript" src="/static/js/jquery-1.12.4.js"></script>
<script type="text/javascript" src="/static/js/bootstrap.js"></script>
<script type="text/javascript" src="/static/js/Admin.js"></script>
<script type="text/javascript" src="/static/js/userAdd.js"></script>
<script type="text/javascript" src="/static/js/public.js"></script>
</html>