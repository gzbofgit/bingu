<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="top.jsp" %>
<div class="col-lg-10" id="right">
    <div class="container">
        <div class="row" style="margin:20px ">
            <form action="/bookType/filtrateType.html?indexPage=1" method="post" id="typeForm">
                <div class="col-lg-4">
                    <button type="button" name="addBookType" class="btn btn-success input-sm" data-toggle="modal"
                            data-target="#mymodal3">
                        新增类别
                    </button>
                </div>
                <div class="col-lg-4">
                    <input type="text" name="typeName" value="${typeName}" placeholder="请输入类别名，支持模糊查询"
                           class="form-control input-sm">
                </div>
                <div class="col-lg-4">
                    <input class="btn btn-primary input-sm" value="搜索" type="submit" style="width:80px"/>
                </div>
            </form>
        </div>
        <table id="typeInfo" width="1000px">
            <tr>
                <th>类别名</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${bookTypes}" var="item">
                <tr id="${item.typeId}">
                    <td>${item.typeName}</td>
                    <td colspan="2">
                        <span onclick="upBookType(${item.typeId})" data-toggle="modal" data-target="#mymodal3"><button
                                class="btn btn-info input-sm" style="font-size:12px">修改</button></span>
                        <span style="margin-left: 8px" onclick="delBookType(${item.typeId})"><button class="btn btn-danger input-sm" style="font-size:12px">删除</button></span>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <c:if test="${bookTypeNull!=null}">
            <div class="text-center" style="margin-top: 50px">
                <span class="h5" style="color: red">暂无符合条件的类别信息,请重新选择筛选条件!</span>
            </div>
        </c:if>
        <div id="paging" class="row" style="margin-top: 30px">
            <%--如果没有数据则页码-1--%>
            <div class="col-lg-4"><span class="h5">第 <span
                    id="bookTypeIndexPage">${bookTypeNull==null? indexPage:indexPage-1}</span>/<span class="h5"
                                                                                                     name="typeCountPage">${countPage}</span> 页</span>&nbsp;
                <span class="h5">跳转至<input type="text" style="width: 25px;height: 18px" onblur="pageVerifyType()"
                                           name="typeSkipPage">页&nbsp;
                <a href="javascript:void(0)" name="skipPageType" class="btn btn-primary input-sm">GO</a></span>
                <span name="typeSkipInfo" style="color: red" class="h6"></span>
            </div>
            <div class="col-lg-3"></div>
            <div class="col-lg-2">
                <c:if test="${indexPage>1}">
                    <a class="btn btn-info input-sm"
                       href="/bookType/filtrateType.html?indexPage=1&typeName=${typeName}">首页</a>&nbsp
                    <a class="btn btn-info input-sm"
                       href="/bookType/filtrateType.html?indexPage=${indexPage-1}&typeName=${typeName}">上一页</a>&nbsp
                </c:if>
            </div>
            <div class="col-lg-3">
                <c:if test="${indexPage<countPage}">
                    <a class="btn btn-info input-sm"
                       href="/bookType/filtrateType.html?indexPage=${indexPage+1}&typeName=${typeName}">下一页</a>&nbsp
                    <a class="btn btn-info input-sm"
                       href="/bookType/filtrateType.html?indexPage=${countPage}&typeName=${typeName}">末页</a>&nbsp
                </c:if>
            </div>
        </div>
    </div>
</div>
<div id="mymodal3" class="modal fade bs-example-modal-body">
    <div class="modal-dialog modal-body">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h5 class="modal-title text-center"><span name="info">${bookType==null?'新增':'修改'}</span>类别</h5>
            </div>
            <div class="media-body"><!--主体-->
                <div class="container">
                    <div class="row" style="padding-top:20px;display: flex;align-items: center">
                        <div class="col-sm-1">
                            <span class="h5">类别名：</span>
                        </div>
                        <div class="col-sm-3">
                            <input type="text" name="upTypeName" value="${bookType.typeName}"
                                   class="form-control input-sm" placeholder="请输入类别名"/>
                        </div>
                        <div class="col-sm-2">
                            <span name="typeNameInfo"></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-danger" data-dismiss="modal">关闭</button>
                <button name="bookTypeAdd" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>
<%@include file="foot.jsp" %>