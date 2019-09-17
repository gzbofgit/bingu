<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="top.jsp" %>
<style>
    .row{
        display: flex;
        justify-content: center;
        align-items: center;
    }
    #userForm{
        margin-left: 200px;
        width: 65%;
    }
</style>

<div class="col-lg-10" id="right" >
    <span class="h5" style="font-family: STZhongsong;padding-right: 15px;color: black">当前处于<span name="user" class="h4" style="color: red;">${user==null?'新增':'修改'}</span>页面</span>
    <div class="container">
        <form action="javascript:void(0)" method="post" id="userForm">
            <div class="row">
                <div class="col-lg-2" >
                    <span class="h5">用户编号：</span>
                </div>
                <div class="col-lg-8">
                    <input name="userId" class="input-sm form-control" value="${user==null?'':user.userId}" readonly="readonly" placeholder="编号系统自动生成" style="width: 80%;"/>
                </div>
                <div class="col-lg-2">
                    <span class="h5" name="userIdInfo" style="margin-left:-100px;color: red"></span>
                </div>
            </div>
            <div class="row" style="padding-top: 25px">
                <div class="col-lg-2" >
                    <span class="h5">用户名：</span>
                </div>
                <div class="col-lg-8">
                    <input name="userName" onblur="userNameBlur()" class="input-sm form-control" value="${user==null?'':user.userName}" placeholder="请输入用户名" style="width: 80%"/>
                </div>
                <div class="col-lg-2">
                    <span name="userNameInfo" class="h6 "  style="margin-left:-100px;color: ${user==null?'red':'#00FA98'}">*</span>
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
                    <span name="userPwdInfo" class="h6" style="color: #00FA98"></span>
                </div>
            </div>
            <div class="row" style="padding-top: 25px">
                <div class="col-lg-2" >
                    <span class="h5">身份证号码：</span>
                </div>
                <div class="col-lg-8">
                    <input name="identity" onblur="identityBlur()" class="input-sm form-control" value="${user==null?'':user.identity}" placeholder="请输入身份证号码" style="width: 80%"/>
                </div>
                <div class="col-lg-2">
                    <span name="identityInfo" class="h6 " style="margin-left:-100px;color: ${user==null?'red':'#00FA98'}">*</span>
                </div>
            </div>
            <div class="row" style="padding-top: 25px">
                <div class="col-lg-2" >
                    <span class="h5">性别：</span>
                </div>
                <c:if test="${user==null}">
                <div class="col-lg-8" style="display: flex;align-items: center">
                    <div ><span class="h5">男</span><input type="radio" name="sex" checked="checked" value="0" style="margin-left: 10px"></div>
                    <div><span class="h5" style="margin-left: 100px">女</span><input type="radio" name="sex" value="1" style="margin-left: 10px"></div>
                </div>
                </c:if>

                <c:if test="${user!=null}">
                    <div class="col-lg-8" style="display: flex;align-items: center">
                        <div ><span class="h5">男</span><input type="radio" name="sex" ${user.sex==0?'checked':''} value="0" style="margin-left: 10px"></div>
                        <div><span class="h5" style="margin-left: 100px">女</span><input type="radio" ${user.sex==1?'checked':''} name="sex" value="1" style="margin-left: 10px"></div>

                    </div>
                </c:if>
                <div class="col-lg-2">
                    <span name="sexInfo"  class="h5" style="margin-left:-100px;color: red"></span>
                </div>
            </div>
            <div class="row" style="padding-top: 25px">
                <div class="col-lg-2" >
                    <span class="h5">出生日期：</span>
                </div>
                <div class="col-lg-8">
                    <input name="birthData" onblur="birthDataBlur()" type="date" class="input-sm form-control" value="${user==null?'':user.birthData}" placeholder="请输入用户名" style="width: 80%"/>
                </div>
                <div class="col-lg-2">
                    <span name="birthDataInfo" class="h6" style="margin-left:-100px;color: red"></span>
                </div>
            </div>
            <div class="row" style="padding-top: 18px">
                <div class="col-lg-2" >
                    <span class="h5">住址：</span>
                </div>
                <div class="col-lg-8">
                    <input name="address" class="input-sm form-control" value="${user==null?'':user.address}" placeholder="请输入住址" style="width: 80%"/>
                </div>
                <div class="col-lg-2">
                    <span name="addressInfo" class="h5" style="margin-left:-100px;color: red"></span>
                </div>
            </div>
            <div class="row" style="padding-top: 25px">
                <div class="col-lg-2" >
                    <span class="h5">电话：</span>
                </div>
                <div class="col-lg-8">
                    <input name="phone" onblur="phoneBlur()" class="input-sm form-control" value="${user==null?'':user.phone}" placeholder="请输入电话号码" style="width: 80%"/>
                </div>
                <div class="col-lg-2">
                    <span name="phoneInfo" class="h6 " style="margin-left:-100px;color: ${user==null?'red':'#00FA98'}">*</span>
                </div>
            </div>
            <input type="hidden" name="money" value="${user==null?'':user.money}">
            <div class="row" style="padding-top: 25px">
                <div class="col-lg-2" >
                    <span class="h5">是否会员：</span>
                </div>
                <c:if test="${user==null}">
                <div class="col-lg-8" style="display: flex;align-items: center">
                    <div ><span class="h5">否</span><input type="radio" name="isMember" checked="checked" value="0" style="margin-left: 10px"></div>
                    <div><span class="h5" style="margin-left: 100px">是</span><input type="radio" name="isMember" value="1" style="margin-left: 10px"></div>
                </div>
                </c:if>

                <c:if test="${user!=null}">
                    <div class="col-lg-8" style="display: flex;align-items: center">
                        <div ><span class="h5">否</span><input type="radio" name="isMember" ${user.isMember==0?'checked':''} value="0" style="margin-left: 10px"></div>
                        <div><span class="h5" style="margin-left: 100px">是</span><input type="radio" name="isMember" ${user.isMember==1?'checked':''} value="1" style="margin-left: 10px"></div>
                    </div>
                </c:if>
                <div class="col-lg-2">
                    <span name="isMemberInfo" class="h5" style="margin-left:-100px;color: red"></span>
                </div>
            </div>
            <div class="row" style="padding-top: 25px">
                <div class="col-lg-6">
                    <input type="submit" id="mySubmit" class="btn btn-success input-sm" value="提交" style="margin-left: 200px"/>
                </div>
                <div class="col-lg-6" style="display: ${user==null ? '' : 'none'} ">
                    <input type="reset" class="btn btn-danger input-sm" value="重置"/>
                </div>
            </div>
        </form>
    </div>
    <%--  接收用户名--%>
    <span name="userName" style="display: none"></span>
</div>
<%@include file="foot.jsp" %>