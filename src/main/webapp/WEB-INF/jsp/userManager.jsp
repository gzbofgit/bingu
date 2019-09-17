<%@ page import="cn.book.pojo.Admin" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="top.jsp" %>
<div class="col-lg-10" id="right">
    <div class="container">
        <div class="row" style="margin:20px ">
            <form action="/user/filtrateUser.html?indexPage=1" method="post">
                <div class="col-lg-4">
                </div>
                <div class="col-lg-4">
                    <input type="text" name="userName" value="${userName}" placeholder="请输入用户名，支持模糊查询"
                           class="form-control input-sm">
                </div>
                <div class="col-lg-4">
                    <input class="btn btn-primary input-sm" value="搜索" type="submit" style="width:80px"/>
                </div>
            </form>
        </div>
        <table id="userInfo" width="1000px">
            <tr>
                <th>姓名</th>
                <th>性别</th>
                <th>电话</th>
                <th>余额</th>
                <th>是否会员</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${users}" var="item">
                <tr id="${item.userId}">
                    <td>${item.userName}</td>
                    <td>${item.sex==0?"男":"女"}</td>
                    <td>${item.phone}</td>
                    <td name="${item.userId}">${item.money}</td>
                    <td>${item.isMember==0? '否':'是'}</td>
                    <td colspan="3">
                        <span style="margin-left: 8px"><a href="javascript:void(0)" onclick="userView(${item.userId})" data-toggle="modal"
                                 data-target="#mymodal"><button class="btn btn-success input-sm" style="font-size:11px">查看</button></a></span>
                        <span style="margin-left: 8px"><a href="javascript:void(0)" onclick="up(${item.userId})" data-toggle="modal"
                                 data-target="#mymoda2"><button class="btn btn-primary input-sm" style="font-size:11px">充值</button></a></span>
                        <span style="margin-left: 8px"><a href="/user/userAdd.html?userId=${item.userId}"><button
                                class="btn btn-info input-sm" style="font-size:11px">修改</button></a></span>
                        <span style="margin-left: 8px"><a href="javascript:void(0)" onclick="delUser(${item.userId})"><button
                                class="btn btn-danger input-sm" style="font-size:12px">删除</button></a></span>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <c:if test="${userNull!=null}">
            <div class="text-center" style="margin-top: 50px">
                <span class="h5" style="color: red">暂无符合条件的用户信息,请重新选择筛选条件!</span>
            </div>
        </c:if>
        <div id="paging" class="row" style="margin-top: 30px">
            <%--<div class="col-lg-1"><span class="h5">第${userNull==null? indexPage:indexPage-1}/${countPage}页</span></div>--%>
            <div class="col-lg-4"><span class="h5">第 <span
                    id="userIndexPage">${userNull==null? indexPage:indexPage-1}</span> /<span class="h5"
                                                                                              name="userCountPage">${countPage}</span> 页</span>&nbsp;
                <span class="h5">跳转至<input type="text" style="width: 25px;height: 18px" onblur="pageVerifyUser()"
                                           name="userSkipPage">页&nbsp;
                <a href="javascript:void(0)" name="skipPageUser" class="btn btn-primary input-sm">GO</a></span>
                <span name="userSkipInfo" style="color: red" class="h6"></span>
            </div>
            <div class="col-lg-3"></div>
            <div class="col-lg-2">
                <c:if test="${indexPage>1}">
                    <a class="btn btn-info input-sm"
                       href="/user/filtrateUser.html?indexPage=1&userName=${userName}">首页</a>&nbsp
                    <a class="btn btn-info input-sm"
                       href="/user/filtrateUser.html?indexPage=${indexPage-1}&userName=${userName}">上一页</a>&nbsp
                </c:if>
            </div>
            <div class="col-lg-3">
                <c:if test="${indexPage<countPage}">
                    <a class="btn btn-info input-sm"
                       href="/user/filtrateUser.html?indexPage=${indexPage+1}&userName=${userName}">下一页</a>&nbsp
                    <a class="btn btn-info input-sm"
                       href="/user/filtrateUser.html?indexPage=${countPage}&userName=${userName}">末页</a>&nbsp
                </c:if>
            </div>
        </div>
    </div>
</div>
<%--模态框:用户查看--%>
<div id="mymodal" class="modal fade bs-example-modal-sm">
    <div class="modal-dialog modal-body">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h5 class="modal-title text-center">用户信息</h5>
            </div>
            <div class="media-body"><!--主体-->
                <div class="container">
                    <div class="row" style="padding-top:20px; ">
                        <div class="col-sm-2">
                            <span class="h5">用户编号：</span>
                        </div>
                        <div class="col-sm-3">
                            <span class="h5" name="userId" style="margin-left: -75px"></span>
                        </div>
                    </div>
                    <div class="row" style="padding-top:20px; ">
                        <div class="col-sm-2">
                            <span class="h5">用户名：</span>
                        </div>
                        <div class="col-sm-3">
                            <span class="h5" name="userName" style="margin-left: -75px"></span>
                        </div>
                    </div>
                    <div class="row" style="padding-top:20px; ">
                        <div class="col-sm-2">
                            <span class="h5">身份证号码：</span>
                        </div>
                        <div class="col-sm-3">
                            <span class="h5" name="identity" style="margin-left: -75px"></span>
                        </div>
                    </div>
                    <div class="row" style="padding-top:20px; ">
                        <div class="col-sm-2">
                            <span class="h5">性别：</span>
                        </div>
                        <div class="col-sm-3">
                            <span class="h5" name="sex" style="margin-left: -75px"></span>
                        </div>
                    </div>
                    <div class="row" style="padding-top:20px; ">
                        <div class="col-sm-2">
                            <span class="h5">出生日期：</span>
                        </div>
                        <div class="col-sm-3">
                            <span class="h5" name="birthData" style="margin-left: -75px"></span>
                        </div>
                    </div>
                    <div class="row" style="padding-top:20px; ">
                        <div class="col-sm-2">
                            <span class="h5">住址：</span>
                        </div>
                        <div class="col-sm-3">
                            <span class="h5" name="address" style="margin-left: -75px"></span>
                        </div>
                    </div>
                    <div class="row" style="padding-top:20px; ">
                        <div class="col-sm-2">
                            <span class="h5">电话：</span>
                        </div>
                        <div class="col-sm-3">
                            <span class="h5" name="phone" style="margin-left: -75px"></span>
                        </div>
                    </div>
                    <div class="row" style="padding-top:20px; ">
                        <div class="col-sm-2">
                            <span class="h5">用户余额：</span>
                        </div>
                        <div class="col-sm-3">
                            <span class="h5" name="money" style="margin-left: -75px"></span>
                        </div>
                    </div>
                    <div class="row" style="padding-top:20px; ">
                        <div class="col-sm-2">
                            <span class="h5">用户是否会员：</span>
                        </div>
                        <div class="col-sm-3">
                            <span class="h5" name="isMember" style="margin-left: -75px"></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-danger" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<%--模态框:充值--%>
<div id="mymoda2" class="modal fade bs-example-modal-sm">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h5 class="modal-title text-center">用户充值</h5>
            </div>
            <div class="media-body"><!--主体-->
                <div class="container">
                    <div class="row" style="padding-top:20px; ">
                        <div class="col-sm-12">
                            <div class="input-group" style="width: 260px">
                                <input type="text" id="upMoneyAdmin" class="form-control input-sm" placeholder="请输入充值金额">
                                <span class="input-group-btn">
                                <button type="button" id="upButton" class="btn btn-primary input-sm">确定</button>
                                </span>
                                <%--  充值时接收用户id--%>
                                <input name="upUserId" style="display: none"/>

                            </div>
                        </div>
                        <div class="col-sm-12">
                            <span id="upInfo" style="color: red;"></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </div>
</div>
<%@include file="foot.jsp" %>

