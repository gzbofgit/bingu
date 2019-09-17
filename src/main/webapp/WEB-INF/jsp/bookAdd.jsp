<%@ page import="cn.book.pojo.Admin" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="top.jsp" %>
<style>
    .row{
        display: flex;
        justify-content: center;
        align-items: center;
    }
    #bookForm{
        margin-left: 200px;
        width: 65%;
    }
</style>

<div class="col-lg-7" id="right" >
    <span class="h5" style="font-family: STZhongsong;padding-right: 15px;color: black">当前处于<span name="user" class="h4" style="color: red;">${book==null?'新增':'修改'}</span>页面</span>
    <div class="container">
        <form action="/book/bookFileLoad.html" method="post" id="bookForm" enctype="multipart/form-data" >
            <div class="row">
                <div class="col-lg-2">
                    <span class="h5">图书编号：</span>
                </div>
                <div class="col-lg-8">
                    <input name="bookId" value="${book.bookId}" class="input-sm form-control" readonly="readonly" placeholder="编号系统自动生成"
                           style="width: 80%;"/>
                </div>
                <div class="col-lg-2">
                    <span class="h5" style="margin-left:-100px;">${loadFileError}</span>
                </div>
            </div>
            <div class="row" style="padding-top: 18px">
                <div class="col-lg-2">
                    <span class="h5">图书名：</span>
                </div>
                <div class="col-lg-8">
                    <input name="bookName" value="${book.bookName}"  onblur="bookNameBlur()" class="input-sm form-control" placeholder="请输入图书名" style="width: 80%"/>
                </div>
                <div class="col-lg-2">
                    <span class="h6" name="bookNameInfo" style="margin-left:-100px;color: ${upBook==null ? 'red' :'#00FA98'}">*</span>
                </div>
            </div>
            <div class="row" style="padding-top: 18px">
                <div class="col-lg-2">
                    <span class="h5">图书价格：</span>
                </div>
                <div class="col-lg-8">
                    <input name="bookPrice" value="${book.bookPrice}"  class="input-sm form-control" onblur="bookPriceBlur()" placeholder="请输入图书价格"
                           style="width: 80%"/>
                </div>
                <div class="col-lg-2">
                    <span class="h6" name="bookPriceInfo" style="margin-left:-100px;color:${upBook==null ? 'red' :'#00FA98'}">*</span>
                </div>
            </div>
            <div class="row" style="padding-top: 18px">
                <div class="col-lg-2">
                    <span class="h5">图书作者：</span>
                </div>
                <div class="col-lg-8" style="display: flex;align-items: center">
                    <input name="bookAuthor" value="${book.bookAuthor}"  class="input-sm form-control" onblur="bookAuthorBlur()" placeholder="请输入作者名称"
                           style="width: 80%"/>
                </div>
                <div class="col-lg-2">
                    <span class="h6" name="bookAuthorInfo" style="margin-left:-100px;color: ${upBook==null ? 'red' :'#00FA98'}">*</span>
                </div>
            </div>
            <div class="row" style="padding-top: 18px">
                <div class="col-lg-2">
                    <span class="h5">出版社：</span>
                </div>
                <div class="col-lg-8">
                    <input name="bookIssue" value="${book.bookIssue}"  type="text" class="input-sm form-control" onblur="bookIssueBlur()"
                           placeholder="请输入出版社名称" style="width: 80%"/>
                </div>
                <div class="col-lg-2">
                    <span class="h6" name="bookIssueInfo" style="margin-left:-100px;color: ${upBook==null ? 'red' :'#00FA98'}">*</span>
                </div>
            </div>
            <div class="row" style="padding-top: 18px">
                <div class="col-lg-2">
                    <span class="h5">出版日期：</span>
                </div>
                <div class="col-lg-8">
                    <input name="bookDate" value="${book.bookDate}"  type="date" class="input-sm form-control" onblur="bookDateBlur()"
                           placeholder="请输入出版日期" style="width: 80%"/>
                </div>
                <div class="col-lg-2">
                    <span class="h6" name="bookDateInfo" style="margin-left:-100px;color:${upBook==null ? 'red' :'#00FA98'}">*</span>
                </div>
            </div>
            <div class="row" style="padding-top: 18px">
                <div class="col-lg-2">
                    <span class="h5">类别：</span>
                </div>
                <div class="col-lg-8">
                    <select name="typeIds" class="input-sm" onblur="typeIdBlur()" style="width: 100px;">
                        <option value="0">--请选择--</option>
                        <c:forEach items="${bookTypes}" var="item">
                            <option ${book.typeId.typeId==item.typeId?'selected':''}  value="${item.typeId}">${item.typeName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-lg-2">
                    <span class="h6" name="typeIdInfo" style="margin-left:-100px;color: ${upBook==null ? 'red' :'#00FA98'}">*</span>
                </div>
            </div>
            <div class="row" style="padding-top: 18px">
                <div class="col-lg-2">
                    <span class="h5">图书封面：</span>
                </div>
                <div class="col-lg-8" style="display: flex;align-items: center">
                    <input name="bookPortrait_" type="file" class="input-sm form-control"
                           placeholder="请选择图书封面" style="width: 80%" value=""/>
                </div>
                <div class="col-lg-2">
                    <span class="h6" name="bookPortraitInfo" style="margin-left:-100px;color: red">${uploadFileError}</span>
                </div>
            </div>
            <div class="row" style="padding-top: 18px">
                <div class="col-lg-2">
                    <span class="h5">图书库存：</span>
                </div>
                <div class="col-lg-8">
                    <input name="inventory" value="${book.inventory}"  class="input-sm form-control" onblur="inventoryBlur()" placeholder="请输入图书库存" style="width: 80%"/>
                </div>
                <div class="col-lg-2">
                    <span class="h6" name="inventoryInfo" style="margin-left:-100px;color: ${upBook==null ? 'red' :'#00FA98'}">*</span>
                </div>
            </div>
            <div class="row" style="padding-top: 18px">
                <div class="col-lg-2">
                    <span class="h5">图书位置：</span>
                </div>
                <div class="col-lg-8">
                    <input name="bookLocation" value="${book.bookLocation}"  class="input-sm form-control" onblur="bookLocationBlur()" placeholder="请输入图书位置" style="width: 80%"/>
                </div>
                <div class="col-lg-2">
                    <span class="h6" name="bookLocationInfo" style="margin-left:-100px;color: ${upBook==null ? 'red' :'#00FA98'}">*</span>
                </div>
            </div>
            <div class="row" style="padding-top: 18px">
                <div class="col-lg-6">
                    <input type="submit" id="bookSubmit" class="btn btn-success input-sm" value="提交" style="margin-left: 200px"/>
                </div>
                <div class="col-lg-6" style="display: ${book==null ? '' : 'none'} ">
                    <input type="reset" class="btn btn-danger input-sm" value="重置"/>
                </div>
            </div>
        </form>
    </div>
    <%--  接收用户名--%>
    <span name="bookName" style="display: none"></span>
</div>
<div class="col-lg-3" id="image" >
    <img style="display: ${book==null?'none':''}" src="/static/image/bookImages/${book.bookPortrait}" width="200" height="200" alt="">
</div>
<%@include file="foot.jsp" %>