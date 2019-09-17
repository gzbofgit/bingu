//用户下拉列表
$("#userOperation").click(function () {
    $(".userOperationSon").toggle("slow");
    $(".bookOperationSon").hide();

});
//图书下拉列表
$("#bookOperation").click(function () {
    $(".bookOperationSon").toggle("slow");
    $(".userOperationSon").hide();
    /*$(".borrowingOperationSon").hide();*/
});
/*点击变色*/
$("li").click(function () {
    $("li").css("background-color","white");
    $(this).css("background-color","#29faf2");
});
//密码显示
function switchoverZ(object) {
    var zy = $("#zy");
    var by = $("#by");
    var userPwd = $("input[name='userPwd']");
    userPwd.attr("type", "text")
    zy.toggle();
    by.toggle();
}

//密码隐藏
function switchoverB(object) {
    var zy = $("#zy");
    var by = $("#by");
    var userPwd = $("input[name='userPwd']");
    userPwd.attr("type", "password")
    zy.toggle();
    by.toggle();
}

