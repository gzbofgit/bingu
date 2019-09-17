<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>书虫</title>
    <link rel="shortcut icon" href="/static/image/top/title.ico" type="image/x-icon">
    <link rel="stylesheet" href="/static/css/bootstrap.css">

    <link rel="stylesheet" href="/static/css/awesome-bootstrap-checkbox.css">
    <link rel="stylesheet" href="/static/css/myCenter.css">
</head>
<body>
<div class="container nav-justified">
    <!--标题-->
    <div class="row" name="title">
        <div class="col-lg-8 col-sm-6 col-xs-6">
            <img src="/static/image/top/logo.png"/>
            <span class="h3" id="title" style="color: white">书虫系统</span>
        </div>

        <div class="col-lg-4 col-sm-6 col-xs-6" style="display: flex;align-items: center;padding-left: 190px">
            <span class="h5"
                  style="font-family: STZhongsong;padding-right: 15px;color: white">欢迎您：${user.isMember==1?'会员':'用户'}<span
                    class="h4" style="color: red;">${admin.name}${user.userName}</span></span>
            <a href="/admin/logout.html" class="btn btn-danger input-sm">退出</a>
            <input type="hidden" id="userId" value="${user.userId}">
        </div>
    </div>
    <!--时间-->
    <div class="row" name="time">
        <div class="col-lg-4 col-sm-6 col-xs-6">
            <section class="publicTime">
                <img src="/static/image/top/sz.png" height="35" width="35"/>
                <span id="time" style="color: white;">2015年1月1日 11:11  星期一</span>
            </section>
        </div>
        <div class="col-lg-4 col-sm-6 col-xs-6">
            <%--  <a href="#" class="h5">首页></a>--%>
        </div>
        <div class="col-lg-4 col-sm-6 col-xs-6">
            <a href="#" style="color: white;">温馨提示：为了能正常浏览，请使用谷歌游览器 ^_^</a>
        </div>
    </div>
    <!--操作区-->
</div>
<div id="tables" class="container nav-justified">
    <div class="row">
        <div class="col-lg-12">
            <ul class="nav nav-tabs nav-justified">
                <li class="${myCenter==null?'':'active'}"><a href="#myCenter" data-toggle="tab" style="font-size: 15px">个人中心</a></li>
                <li class="${myBook==null?'':'active'}"><a href="#bookInfos" data-toggle="tab" style="font-size: 15px">书籍列表</a>
                </li>
                <!--此行默认显示-->
                <li class="${myBorrowing==null?'':'active'}"><a href="#myIndent" data-toggle="tab"
                                                                style="font-size: 15px">我的订单</a></li>
            </ul>
        </div>
    </div>

    <!--选项卡面板-->
    <div class="tab-content ">
        <%--个人中心--%>
        <div class="${myCenter==null?'tab-pane fade':'tab-pane fade in active'}" id="myCenter" style="height: 460px;">
            <div style="margin-top: 40px;display: flex;justify-content: center">
                <form action="javascript:void(0)" method="post" id="form" style="width: 600px">
                    <div class="row">
                        <div class="col-lg-3">
                            <span class="h6">用户名：</span>
                        </div>
                        <div class="col-lg-5">
                            <input name="userName" onblur="userNameBlur()" class="input-sm form-control" value="${user.userName}"
                                   placeholder="请输入用户名"/>
                        </div>
                        <div class="col-lg-4">
                            <span name="userNameInfo" class="h6" style="color: #00FA98"></span>
                        </div>
                    </div>
                    <div class="row" style="padding-top: 18px">
                        <div class="col-lg-3">
                            <span class="h6">密码：</span>
                        </div>
                        <div class="col-lg-4">
                            <input name="userPwd" type="password" onblur="userPwdBlur()" class="input-sm form-control"
                                   value="${user.userPwd}" placeholder="以字母开头，长度在6~18之间，只能包含字母、数字和下划线 "/>
                        </div>
                        <div id="by" class="col-lg-1">
                            <img src="/static/image/by.png" width="20" height="20" onclick="switchoverZ()" alt="">
                        </div>
                        <div id="zy" class="col-lg-1" style="display: none;">
                            <img src="/static/image/zy.png" width="20" height="20" onclick="switchoverB()" alt="">
                        </div>
                        <div class="col-lg-4">
                            <span name="userPwdInfo" class="h6" style="color: #00FA98"></span>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 18px">
                        <div class="col-lg-3">
                            <span class="h6">身份证号码：</span>
                        </div>
                        <div class="col-lg-5">
                            <input name="identity" onblur="identityBlur()" class="input-sm form-control" value="${user.identity}"
                                   placeholder="请输入身份证号码"/>
                        </div>
                        <div class="col-lg-4">
                            <span name="identityInfo" class="h6" style="color: #00FA98"></span>
                        </div>
                    </div>
                    <div class="row" style="padding-top: 18px">
                        <div class="col-lg-3">
                            <span class="h6">性别：</span>
                        </div>
                        <div class="col-lg-5" style="display: flex;align-items: center">
                            <div><span class="h6">男</span><input type="radio" name="sex" ${user.sex==0?'checked':''}
                                                                 value="0" style="margin-left: 10px"></div>
                            <div><span class="h6" style="margin-left: 100px">女</span><input
                                    type="radio" ${user.sex==1?'checked':''} name="sex" value="1"
                                    style="margin-left: 10px"></div>

                        </div>
                        <div class="col-lg-4">
                            <span name="sexInfo" class="h5" style="margin-left:-100px;color: red"></span>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 18px">
                        <div class="col-lg-3">
                            <span class="h6">出生日期：</span>
                        </div>
                        <div class="col-lg-5">
                            <input type="date" name="birthData" onblur="birthDataBlur()" class="input-sm form-control" value="${user.birthData}"
                                   placeholder="请选择出生日期"/>
                        </div>
                        <div class="col-lg-4">
                            <span name="birthDataInfo" class="h6" style="color: #00FA98"></span>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 18px">
                        <div class="col-lg-3">
                            <span class="h6">住址：</span>
                        </div>
                        <div class="col-lg-5">
                            <input name="address" class="input-sm form-control"
                                   value="${user.address=="" || user.address==null?"暂无":user.address}"
                                   placeholder="请输入地址"/>
                        </div>
                        <div class="col-lg-4">
                            <span name="addressInfo" class="h6" style="color: #00FA98"></span>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 18px">
                        <div class="col-lg-3">
                            <span class="h6">电话：</span>
                        </div>
                        <div class="col-lg-5">
                            <input name="phone" onblur="phoneBlur()" class="input-sm form-control" value="${user.phone}"
                                   placeholder="请输入电话号码"/>
                        </div>
                        <div class="col-lg-4">
                            <span name="phoneInfo" class="h6" style="color: #00FA98"></span>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 18px">
                        <div class="col-lg-3">
                            <span class="h6">用户余额：</span>
                        </div>
                        <div class="col-lg-5">
                            <div class="input-group">
                                <input name="money" class="input-sm form-control" readonly="readonly"
                                       value="${user.money}"/>
                                <span class="input-group-btn">
                        <button type="button" onclick="up2()" class="btn btn-primary input-sm" data-toggle="modal"
                                data-target="#mymodal3">充值</button>
                    </span>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <span name="moneyInfo" class="h6" style="color: #00FA98"></span>
                        </div>
                    </div>

                    <div class="row" style="padding-top: 25px;display: none;">
                        <div class="col-lg-2" >
                            <span class="h5">是否会员：</span>
                        </div>
                            <div class="col-lg-8" style="display: flex;align-items: center">
                                <div ><span class="h5">否</span><input type="radio" name="isMember" ${user.isMember==0?'checked':''} value="0" style="margin-left: 10px"></div>
                                <div><span class="h5" style="margin-left: 100px">是</span><input type="radio" name="isMember" ${user.isMember==1?'checked':''} value="1" style="margin-left: 10px"></div>
                            </div>
                        <div class="col-lg-2">
                            <span name="isMemberInfo" class="h5" style="margin-left:-100px;color: red"></span>
                        </div>
                    </div>
                    
                    <div class="row" style="padding-top: 18px;display:flex;justify-content: center">
                        <div class="col-lg-3" style="display: ${user.isMember==1?'none':''}">
                            <a href="javascript:void(0)" onclick="openIsMember()"  class="btn btn-success input-sm">开通会员</a>
                        </div>
                        <div class="col-lg-3">
                            <input type="submit" id="mySubmit" class="btn btn-success input-sm" value="保存"/>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <%--图书--%>
        <div class="${myBook==null?'tab-pane fade':'tab-pane fade in active'}" id="bookInfos" style="height: 500px;">
            <div style="display: flex;justify-content: center">
                <div class="row" style="margin-top: 20px">
                    <div class="col-lg-12">
                        <form action="/userAction/filtrateBook.html?indexPage=1" method="post">
                            <div class="col-lg-1">
                                <select name="typeId" class="input-sm" style="width: 75px;">
                                    <option value="0">类别</option>
                                    <c:forEach items="${bookTypes}" var="item">
                                        <option ${typeId==item.typeId?'selected':''}
                                                value="${item.typeId}">${item.typeName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-lg-3">
                                <input class="checkbox  checkbox-inline"
                                       type="checkbox" ${inventory!=null ?'checked':''}
                                       value="${inventory}" onclick="this.value=this.checked?1:0" name="inventory">无库存
                            </div>
                            <div class="col-lg-4">
                                <input type="text" name="bookName" value="${bookName}" placeholder="请输入图书名，支持模糊查询"
                                       class="form-control input-sm">
                            </div>
                            <div class="col-lg-4">

                                <input class="btn btn-primary input-sm" value="搜索" type="submit" style="width:80px"/>
                            </div>
                        </form>
                        <hr>
                        <table id="bookInfo" width="1000px">
                            <tr>
                                <th>图书名</th>
                                <th>图书价格(元)</th>
                                <th>出版日期</th>
                                <th>类别</th>
                                <th>图书库存</th>
                                <th>操作</th>
                            </tr>

                            <c:forEach items="${books}" var="item">
                                <tr id="${item.bookId}">
                                    <td>${item.bookName}</td>
                                    <td>${item.bookPrice}</td>
                                    <td>${item.bookDate}</td>
                                    <td>${item.typeId.typeName}</td>
                                    <td>${item.inventory==0?'无库存':item.inventory}</td>
                                    <td colspan="3">
                                        <c:if test="${item.inventory>0}">
                        <span><a href="javascript:void(0)" onclick="biBook(${item.bookId})" data-toggle="modal"
                                 data-target="#mymodal2"><button class="btn btn-warning input-sm"
                                                                 style="font-size:11px">借阅</button></a></span>
                                        </c:if>
                                        <span style="margin-left: 8px"><a href="javascript:void(0)"
                                                                          onclick="bookView(${item.bookId})"
                                                                          data-toggle="modal"
                                                                          data-target="#mymodal"><button
                                                class="btn btn-success input-sm"
                                                style="font-size:11px">查看</button></a></span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                        <c:if test="${bookNull!=null}">
                            <div class="text-center" style="margin-top: 50px">
                                <span class="h5" style="color: red">暂无符合条件的图书信息,请重新选择筛选条件!</span>
                            </div>
                        </c:if>
                        <div id="paging" class="row" style="margin-top: 30px">
                            <div class="col-lg-4"><span class="h5">第<span
                                    id="bookIndexPage">${bookNull==null? indexPage:indexPage-1}</span>/<span class="h5"
                                                                                                             name="bookCountPage">${countPage}</span> 页</span>&nbsp;
                                <span class="h5">跳转至<input type="text" style="width: 25px;height: 18px"
                                                           onblur="pageVerifyBook()"
                                                           name="bookSkipPage">页&nbsp;
                <a href="javascript:void(0)" name="skipPageBook" class="btn btn-primary input-sm">GO</a></span>
                                <span name="bookSkipInfo" style="color: red" class="h6"></span>
                            </div>
                            <div class="col-lg-3"></div>
                            <div class="col-lg-2">
                                <c:if test="${indexPage>1}">
                                    <a class="btn btn-info input-sm"
                                       href="/userAction/filtrateBook.html?indexPage=1&bookName=${bookName}&typeId=${typeId}&inventory=${inventory}">首页</a>&nbsp
                                    <a class="btn btn-info input-sm"
                                       href="/userAction/filtrateBook.html?indexPage=${indexPage-1}&bookName=${bookName}&typeId=${typeId}&inventory=${inventory}">上一页</a>&nbsp
                                </c:if>
                            </div>
                            <div class="col-lg-3">
                                <c:if test="${indexPage<countPage}">
                                    <a class="btn btn-info input-sm"
                                       href="/userAction/filtrateBook.html?indexPage=${indexPage+1}&bookName=${bookName}&typeId=${typeId}&inventory=${inventory}">下一页</a>&nbsp
                                    <a class="btn btn-info input-sm"
                                       href="/userAction/filtrateBook.html?indexPage=${countPage}&bookName=${bookName}&typeId=${typeId}&inventory=${inventory}">末页</a>&nbsp
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--订单--%>
        <div class="${myBorrowing==null?'tab-pane fade':'tab-pane fade in active'}" id="myIndent"
             style="height: 500px;">
            <div style="display: flex;justify-content: center">
                <div class="row" style="margin-top: 20px">
                    <form action="/userAction/filtrateBorrowing.html?indexPage=1" method="post">
                        <div class="col-lg-4">
                            <input class="checkbox  checkbox-inline" type="checkbox" ${overtime=='0' ?'':'checked'}
                                   value="${overtime}" onclick="this.value=this.checked?1:0" name="overtime">超时
                        </div>
                        <div class="col-lg-4">
                            <input type="text" name="term" value="${term}" placeholder="请输入图书名,支持模糊查询"
                                   class="form-control input-sm">
                        </div>
                        <div class="col-lg-4">
                            <input class="btn btn-primary input-sm" value="搜索" type="submit" style="width:80px"/>
                        </div>
                    </form>
                    <hr>
                    <table id="userInfo" width="1000px">
                        <tr>
                            <th>用户</th>
                            <th>借阅图书</th>
                            <th>借阅日期</th>
                            <th>归还日期</th>
                            <th>备注</th>
                            <th>操作</th>
                        </tr>
                        <c:forEach items="${borrowings}" var="item">
                            <tr id="${item.borrowingId}">
                                <td>${item.userId.userName}</td>
                                <td>${item.bookId.bookName}</td>
                                <td>${item.borrowingTime}</td>
                                <td>${item.returnTime}</td>
                                <td>${item.remarks=="" || item.remarks==null ? '无':item.remarks}</td>
                                <td colspan="3">
                        <span style="margin-left: 8px" onclick="restoreBook(${item.borrowingId},${item.bookId.bookId})"><button
                                class="btn btn-danger input-sm" style="font-size:12px">归还</button></span>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                    <c:if test="${borrowingNull!=null}">
                        <div class="text-center" style="margin-top: 50px">
                            <span class="h5" style="color: red">暂无符合该用户借阅的图书信息!</span>
                        </div>
                    </c:if>
                    <div id="paging" class="row" style="margin-top: 30px">
                        <div class="col-lg-4"><span class="h5">第 <span
                                id="biIndexPage">${borrowingNull==null? indexPageBi:indexPageBi-1}</span> /<span
                                class="h5"
                                name="biCountPage">${countPageBi}</span> 页</span>&nbsp;
                            <span class="h5">跳转至<input type="text" style="width: 25px;height: 18px"
                                                       onblur="pageVerifyBi()"
                                                       name="biSkipPage">页&nbsp;
                <a href="javascript:void(0)" name="skipPageBi" class="btn btn-primary input-sm">GO</a></span>
                            <span name="biSkipInfo" style="color: red" class="h6"></span>
                        </div>
                        <div class="col-lg-3"></div>
                        <div class="col-lg-2">
                            <c:if test="${indexPageBi>1}">
                                <a class="btn btn-info input-sm"
                                   href="/userAction/filtrateBorrowing.html?indexPage=1&term=${term}&overtime=${overtime}">首页</a>&nbsp
                                <a class="btn btn-info input-sm"
                                   href="/userAction/filtrateBorrowing.html?indexPage=${indexPageBi-1}&term=${term}&overtime=${overtime}">上一页</a>&nbsp
                            </c:if>
                        </div>
                        <div class="col-lg-3">
                            <c:if test="${indexPageBi<countPageBi}">
                                <a class="btn btn-info input-sm"
                                   href="/userAction/filtrateBorrowing.html?indexPage=${indexPageBi+1}&term=${term}&overtime=${overtime}">下一页</a>&nbsp
                                <a class="btn btn-info input-sm"
                                   href="/userAction/filtrateBorrowing.html?indexPage=${countPageBi}&term=${term}&overtime=${overtime}">末页</a>&nbsp
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%--模态框:图书查看--%>
<div id="mymodal" class="modal fade bs-example-modal-sm">
    <div class="modal-dialog modal-body">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title text-center">图书信息</h4>
            </div>
            <div class="media-body"><!--主体-->
                <div class="container">
                    <div class="row" style="padding-top:20px;">
                        <div class="media col-sm-6"><!--媒体对象-->
                            <div class="media-left">
                                <a href="#">
                                    <img name="bookPortrait" class="media-object"
                                         src="/static/image/1901119079_ii_cover.jpg" width="180px"
                                         height="280px"
                                         title="图书封面">
                                </a>
                            </div>
                            <div class="media-body">
                                <div class="row">
                                    <div class="col-sm-4 ">图书编号：</div>
                                    <div class="col-sm-8" style="margin-left: -50px"><span class="h6"
                                                                                           name="bookId"></span>
                                    </div>
                                </div>
                                <div class="row" style="padding-top: 10px">
                                    <div class="col-sm-4 ">图书名：</div>
                                    <div class="col-sm-8" style="margin-left: -50px"><span class="h6"
                                                                                           name="bookName"></span>
                                    </div>
                                </div>
                                <div class="row" style="padding-top: 10px">
                                    <div class="col-sm-4">图书价格：</div>
                                    <div class="col-sm-8" style="margin-left: -50px"><span class="h6"
                                                                                           name="bookPrice"></span>
                                    </div>
                                </div>
                                <div class="row" style="padding-top: 10px">
                                    <div class="col-sm-4 ">图书作者：</div>
                                    <div class="col-sm-8" style="margin-left: -50px"><span class="h6"
                                                                                           name="bookAuthor"></span>
                                    </div>
                                </div>
                                <div class="row" style="padding-top: 10px">
                                    <div class="col-sm-4">出版社：</div>
                                    <div class="col-sm-8" style="margin-left: -50px"><span class="h6"
                                                                                           name="bookIssue"></span>
                                    </div>
                                </div>
                                <div class="row" style="padding-top: 10px">
                                    <div class="col-sm-4">出版日期：</div>
                                    <div class="col-sm-8" style="margin-left: -50px"><span class="h6"
                                                                                           name="bookDate"></span>
                                    </div>
                                </div>
                                <div class="row" style="padding-top: 10px">
                                    <div class="col-sm-4 ">类别：</div>
                                    <div class="col-sm-8" style="margin-left: -50px"><span class="h6"
                                                                                           name="typeId"></span>
                                    </div>
                                </div>
                                <div class="row" style="padding-top: 10px">
                                    <div class="col-sm-4">图书库存：</div>
                                    <div class="col-sm-8" style="margin-left: -50px"><span class="h6"
                                                                                           name="inventory"></span>
                                    </div>
                                </div>
                                <div class="row" style="padding-top: 10px">
                                    <div class="col-sm-4">图书位置：</div>
                                    <div class="col-sm-8" style="margin-left: -50px"><span class="h6"
                                                                                           name="bookLocation"></span>
                                    </div>
                                </div>
                            </div>
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
<%--模态框:借阅图书--%>
<div id="mymodal2" class="modal fade bs-example-modal-body">
    <div class="modal-dialog modal-body">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h5 class="modal-title text-center">填写借阅信息</h5>
            </div>
            <div class="media-body"><!--主体-->
                <div class="container">
                    <div id="returnTime">
                        <div class="row" style="padding-top:20px;display:flex;align-items: center">
                            <div class="col-sm-2">
                                <span class="h5">归还日期：</span>
                            </div>
                            <div class="col-sm-3">
                                <input type="date" name="returnTime" class="form-control input-sm"
                                       placeholder="请选择归还日期"
                                       style="margin-left: -100px;"/>
                                <input type="hidden" name="sessionUser" value="${user.userName}"
                                       class="form-control input-sm"/>
                                <%-- 借阅图书编号--%>
                                <input type="hidden" name="biBookId" class="form-control input-sm"/>
                            </div>
                            <div class="col-sm-2">
                                <span name="returnTimeInfo" style="color: red;margin-left: -100px">*</span>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="padding-top:20px;display: flex;align-items: center">
                        <div class="col-sm-2">
                            <span class="h5">备注：</span>
                        </div>
                        <div class="col-sm-3">
                            <input type="text" name="remarks" class="form-control input-sm"
                                   placeholder="请输入备注(选填)"
                                   style="margin-left: -100px"/>
                        </div>
                        <div class="col-sm-2">
                            <span name="remarksInfo"></span>
                        </div>
                    </div>

                    <div id="borrowingInfo" style="display: none">
                        <div class="row" style="padding-top:20px;display: flex;align-items: center">
                            <div class="col-sm-2">
                                <span class="h5">借阅天数：</span>
                            </div>
                            <div class="col-sm-10">
                                <span class="h4" name="borrowingTime" style="margin-left: -100px">9</span>天
                            </div>
                        </div>
                        <div class="row" style="padding-top:20px;display: flex;align-items: center">
                            <div class="col-sm-2">
                                <span class="h5">所需金额：</span>
                            </div>
                            <div class="col-sm-10">
                                            <span class="h4" name="borrowingMoney"
                                                  style="margin-left: -100px">18.8</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-danger" data-dismiss="modal">关闭</button>
                <button id="borrowingAdd" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>
<%--用户充值--%>
<div id="mymodal3" class="modal fade bs-example-modal-sm">
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
                                <input type="text" id="upMoneyUser" class="form-control input-sm" placeholder="请输入充值金额">
                                <span class="input-group-btn">
                                <button type="button" id="upButton" class="btn btn-primary input-sm">确定</button>
                                </span>
                            </div>
                        </div>
                        <div class="col-sm-12" style="margin-top: 10px">
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
</div>
</body>
</html>
<script src="/static/js/jquery-1.12.4.js"></script>
<script src="/static/js/bootstrap.js"></script>
<script src="/static/js/myCenter.js"></script>
<script src="/static/js/public.js"></script>
