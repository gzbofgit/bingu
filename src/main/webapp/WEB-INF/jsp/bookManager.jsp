<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="top.jsp" %>
<div class="col-lg-10" id="right">
    <div class="container">
        <div class="row" style="margin:20px ">
            <form action="/book/filtrateBook.html?indexPage=1" method="post">
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
                    <input class="checkbox  checkbox-inline" type="checkbox" ${inventory!=null ?'checked':''}
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
        </div>
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
                        <span style="margin-left: 8px"><a href="javascript:void(0)" onclick="bookView(${item.bookId})"
                                                          data-toggle="modal"
                                                          data-target="#mymodal"><button
                                class="btn btn-success input-sm" style="font-size:11px">查看</button></a></span>
                        <span style="margin-left: 8px"><a href="/book/bookAdd.html?bookId=${item.bookId}"><button
                                class="btn btn-info input-sm" style="font-size:11px">修改</button></a></span>
                        <span style="margin-left: 8px"><a href="javascript:void(0)" onclick="delBook(${item.bookId})"><button
                                class="btn btn-danger input-sm" style="font-size:12px">删除</button></a></span>
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
                <span class="h5">跳转至<input type="text" style="width: 25px;height: 18px" onblur="pageVerifyBook()"
                                           name="bookSkipPage">页&nbsp;
                <a href="javascript:void(0)" name="skipPageBook" class="btn btn-primary input-sm">GO</a></span>
                <span name="bookSkipInfo" style="color: red" class="h6"></span>
            </div>
            <div class="col-lg-3"></div>
            <div class="col-lg-2">
                <c:if test="${indexPage>1}">
                    <a class="btn btn-info input-sm"
                       href="/book/filtrateBook.html?indexPage=1&bookName=${bookName}&typeId=${typeId}&inventory=${inventory}">首页</a>&nbsp
                    <a class="btn btn-info input-sm"
                       href="/book/filtrateBook.html?indexPage=${indexPage-1}&bookName=${bookName}&typeId=${typeId}&inventory=${inventory}">上一页</a>&nbsp
                </c:if>
            </div>
            <div class="col-lg-3">
                <c:if test="${indexPage<countPage}">
                    <a class="btn btn-info input-sm"
                       href="/book/filtrateBook.html?indexPage=${indexPage+1}&bookName=${bookName}&typeId=${typeId}&inventory=${inventory}">下一页</a>&nbsp
                    <a class="btn btn-info input-sm"
                       href="/book/filtrateBook.html?indexPage=${countPage}&bookName=${bookName}&typeId=${typeId}&inventory=${inventory}">末页</a>&nbsp
                </c:if>
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
                                         src="/static/image/1901119079_ii_cover.jpg" width="180px" height="280px"
                                         title="图书封面">
                                </a>
                            </div>
                            <div class="media-body">
                                <div class="row">
                                    <div class="col-sm-4 ">图书编号：</div>
                                    <div class="col-sm-8" style="margin-left: -50px"><span class="h6"
                                                                                           name="bookId"></span></div>
                                </div>
                                <div class="row" style="padding-top: 10px">
                                    <div class="col-sm-4 ">图书名：</div>
                                    <div class="col-sm-8" style="margin-left: -50px"><span class="h6"
                                                                                           name="bookName"></span></div>
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
                                                                                           name="bookDate"></span></div>
                                </div>
                                <div class="row" style="padding-top: 10px">
                                    <div class="col-sm-4 ">类别：</div>
                                    <div class="col-sm-8" style="margin-left: -50px"><span class="h6"
                                                                                           name="typeId"></span></div>
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
                    <div class="row" style="padding-top:20px;display: flex;align-items: center">
                        <div class="col-sm-2">
                            <span class="h5">借阅用户：</span>
                        </div>
                        <div class="col-sm-3">
                            <input type="text" name="biUserName" id="biUserName" class="form-control input-sm"
                                   placeholder="请输入用户名" style="margin-left: -100px"/>
                        </div>
                        <div class="col-sm-2">
                            <span name="biUserNameInfo" style="color: red;margin-left: -100px">*</span>
                        </div>
                    </div>
                    <div id="returnTime" style="display: none;">
                        <div class="row" style="padding-top:20px;display:flex;align-items: center">
                            <div class="col-sm-2">
                                <span class="h5">归还日期：</span>
                            </div>
                            <div class="col-sm-3">
                                <input type="date" name="returnTime" class="form-control input-sm" placeholder="请选择归还日期"
                                       style="margin-left: -100px;"/>
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
                            <input type="text" name="remarks" class="form-control input-sm" placeholder="请输入备注(选填)"
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
                                <span class="h4" name="borrowingMoney" style="margin-left: -100px">18.8</span>
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
<%@include file="foot.jsp" %>