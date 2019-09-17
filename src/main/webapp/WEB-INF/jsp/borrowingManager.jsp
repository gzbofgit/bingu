<%@ page import="cn.book.pojo.Admin" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="top.jsp" %>
<div class="col-lg-10" id="right">
    <div class="container">
        <div class="row" style="margin:20px ">
            <form action="/borrowing/filtrateBorrowing.html?indexPage=1" method="post">
                <div class="col-lg-4">
                    <input class="checkbox  checkbox-inline" type="checkbox" ${overtime=='0' ?'':'checked'}
                           value="${overtime}" onclick="this.value=this.checked?1:0" name="overtime">超时
                </div>
                <div class="col-lg-4">
                    <input type="text" name="term" value="${term}" placeholder="请输入用户名或图书名，支持模糊查询"
                           class="form-control input-sm">
                </div>
                <div class="col-lg-4">
                    <input class="btn btn-primary input-sm" value="搜索" type="submit" style="width:80px"/>
                </div>
            </form>
        </div>
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
                <span class="h5" style="color: red">暂无符合条件的借阅信息,请重新选择筛选条件!</span>
            </div>
        </c:if>
        <div id="paging" class="row" style="margin-top: 30px">
            <div class="col-lg-4"><span class="h5">第 <span
                    id="biIndexPage">${borrowingNull==null? indexPage:indexPage-1}</span> /<span class="h5"
                                                                                                 name="biCountPage">${countPage}</span> 页</span>&nbsp;
                <span class="h5">跳转至<input type="text" style="width: 25px;height: 18px" onblur="pageVerifyBi()"
                                           name="biSkipPage">页&nbsp;
                <a href="javascript:void(0)" name="skipPageBi" class="btn btn-primary input-sm">GO</a></span>
                <span name="biSkipInfo" style="color: red" class="h6"></span>
            </div>
            <div class="col-lg-3"></div>
            <div class="col-lg-2">
                <c:if test="${indexPage>1}">
                    <a class="btn btn-info input-sm"
                       href="/borrowing/filtrateBorrowing.html?indexPage=1&term=${term}&overtime=${overtime}">首页</a>&nbsp
                    <a class="btn btn-info input-sm"
                       href="/borrowing/filtrateBorrowing.html?indexPage=${indexPage-1}&term=${term}&overtime=${overtime}">上一页</a>&nbsp
                </c:if>
            </div>
            <div class="col-lg-3">
                <c:if test="${indexPage<countPage}">
                    <a class="btn btn-info input-sm"
                       href="/borrowing/filtrateBorrowing.html?indexPage=${indexPage+1}&term=${term}&overtime=${overtime}">下一页</a>&nbsp
                    <a class="btn btn-info input-sm"
                       href="/borrowing/filtrateBorrowing.html?indexPage=${countPage}&term=${term}&overtime=${overtime}">末页</a>&nbsp
                </c:if>
            </div>
        </div>
    </div>
</div>
<%@include file="foot.jsp" %>
