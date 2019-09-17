/*绑定跳转输入框失焦事件*/
function pageVerifyType() {
    var typeSkipPage = $("input[name='typeSkipPage']").val();
    var typeCountPage = $("span[name='typeCountPage']").text();
    if (parseInt(typeCountPage) != 0) {
        if (parseInt(typeSkipPage) > parseInt(typeCountPage)) {
            $("span[name='typeSkipInfo']").text("跳转页码不能大于总页码！");
            $("input[name='typeSkipPage']").focus();
            return false;
        } else if (typeSkipPage == "" || typeSkipPage == 0) {
            $("span[name='typeSkipInfo']").text("请输入正确的页码！");
            $("input[name='typeSkipPage']").focus();
            return false;
        } else {
            $("span[name='typeSkipInfo']").text("");
            return true;
        }
    }
};

/*跳转按钮单击事件*/
$("a[name='skipPageType']").click(function () {
    var typeSkipPage = $("input[name='typeSkipPage']").val();//用户输入跳转页码
    var typeName = $("input[name='typeName']").val();
    if (typeSkipPage == "" || typeSkipPage == null) {
        $("span[name='typeSkipInfo']").text("请输入跳转页码！");
        $("input[name='typeSkipPage']").focus();
        return false;
    } else if (pageVerifyType()) {
        location.href = "/bookType/filtrateType.html?indexPage=" + typeSkipPage + "&typeName=" + typeName + "";
    }
});

/*保存图书信息按钮*/
$("button[name='bookTypeAdd']").click(function () {
    var indexPage = $("#bookTypeIndexPage").text();//当前页码
    var typeName = $("input[name='typeName']").val();//类别输入框
    var upTypeName = $("input[name='upTypeName']");//修改类别输入框
    var typeNameInfo = $("span[name='typeNameInfo']");
    var info = $("span[name='info']");
    if (upTypeName.val() == "" || upTypeName.val() == null) {
        typeNameInfo.text("类别名不能为空！");
        typeNameInfo.css("color", "red");
        upTypeName.focus();
        return false;
    } else if (typeNameInfo.text() == "类别名已存在！") {
        typeNameInfo.text("类别名已存在！");
        typeNameInfo.css("color", "red");
        upTypeName.focus();
        return false;
    } else {
        $.get("/bookType/bookTypeAdd.html", {upTypeName: upTypeName.val()}, function (result) {
            if (result > 0) {
                alert(info.text() + "成功！");
                $("#mymodal3").modal("hide");
                location.href = "/bookType/filtrateType.html?indexPage=" + indexPage + "&typeName=" + typeName + "";
            } else {
                alert(info.text() + "失败！");
            }
        }, "JSON");
    }
});
/*类别名重名验证*/
$("input[name='upTypeName']").blur(function () {
    var upTypeName = $("input[name='upTypeName']");
    var typeNameInfo = $("span[name='typeNameInfo']");
    if (upTypeName.val() == "" || upTypeName.val() == null) {
        typeNameInfo.text("类别名不能为空！");
        typeNameInfo.css("color", "red");
        upTypeName.focus();
        return false;
    } else {
        $.get("/bookType/bookTypeIsExist.html", {upTypeName: upTypeName.val()}, function (result) {
            if (result != "onExist") {
                typeNameInfo.text("类别名已存在！");
                typeNameInfo.css("color", "red");
                upTypeName.focus();
                return false;
            } else {
                typeNameInfo.text("");
                return true;
            }
        }, "JSON")
    }
});
/*修改得到修改对象*/
function upBookType(typeId) {
    var typeNameInfo = $("span[name='typeNameInfo']");
    var upTypeName = $("input[name='upTypeName']");
    var info = $("span[name='info']");
    typeNameInfo.text("");
    $.get("/bookType/upBookType", {typeId: typeId}, function (result) {
        info.text("修改");
        upTypeName.val(result.typeName);
    }, "JSON")
}
/*新增类别删除修改对象*/
$("button[name='addBookType']").click(function () {
    var typeNameInfo = $("span[name='typeNameInfo']");
    var info = $("span[name='info']");
    var upTypeName = $("input[name='upTypeName']");
    info.text("新增");
    upTypeName.val("");
    typeNameInfo.text("");
    $.get("/bookType/addBookType.html", function (result) {
    }, "JSON")
});
//删除图书
function delBookType(typeId) {
    var indexPage = $("#bookTypeIndexPage").text();
    var typeName = $("input[name='typeName']").val();
    if(confirm("确定删除吗?这将会导致该类别图书全部删除！")) {
        $.get("/bookType/delBookType.html", {typeId: typeId}, function (result) {
             if(result>0){
                 alert("删除成功!");
                 location.href = "/bookType/filtrateType.html?indexPage=" + indexPage + "&typeName=" + typeName + "";
             }
        }, "JSON")
    }
};