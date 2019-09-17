/*查看用户详细信息*/
function userView(userId) {
   $.get("/user/view",{userId:userId},function (result) {
       $("span[name='userId']").text(result.userId)
       $("span[name='userName']").text(result.userName)
       $("span[name='identity']").text(result.identity)
       $("span[name='sex']").text(result.sex==0?'男':'女')
       $("span[name='birthData']").text(result.birthData==null||''?'不详':result.birthData)
       $("span[name='address']").text(result.address==null||''?'不详':result.address)
       $("span[name='phone']").text(result.phone)
       $("span[name='money']").text(result.money)
       $("span[name='isMember']").text(result.isMember==0?'否':'是')
   },"JSON")
}
/*用户充值*/
$("#upButton").click(function () {
    var userId= $("input[name='upUserId']").val();
    var upMoney=$("#upMoneyAdmin").val();
    var upInfo=$("#upInfo");
   /* 保留两位小数的正数*/
    var isNum=/^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$/;
    if(!isNum.test(upMoney)){
        upInfo.text("请输入合法金额,保留小数点后两位！");
        $("#upMoneyAdmin").focus();
        return;
    }
    $.get("/user/up",{userId:userId,upMoney:upMoney},function (result) {
        if(result!="0"){
            $("td[name='"+userId+"']").text(result.money)
            alert("用户:"+result.userName+"充值成功！");
            upInfo.text("");
            $("#upMoneyAdmin").val("");
            $("#mymoda2").modal("hide");
        }else{
            alert("用户:"+result.userName+"充值失败！")
        }
    },"JSON");
})
/*得到充值用户id*/
function  up(userId) {
    $("input[name='upUserId']").val(userId);
}
/*删除用户*/
function delUser(userId) {
    var indexPage=$("#userIndexPage").text();
    var userName=$("input[name='userName']").val();
    if(confirm("是否删除")){
        $.get("/user/delUser.html",{userId:userId},function (result) {
            if(result>0){
                alert("删除成功！");
                location.href="/user/filtrateUser.html?indexPage="+indexPage+"&userName="+userName+"";
            }else{
                alert("删除失败！");
            }
        },"JSON")
    }
}
/*绑定跳转输入框失焦事件*/
function pageVerifyUser(){
    var userSkipPage=$("input[name='userSkipPage']").val();
    var userCountPage=$("span[name='userCountPage']").text();
    if(parseInt(userCountPage)!=0){
        if(parseInt(userSkipPage)>parseInt(userCountPage)){
            $("span[name='userSkipInfo']").text("跳转页码不能大于总页码！");
            $("input[name='userSkipPage']").focus();
            return false;
        }else if(userSkipPage==""||userSkipPage==0){
            $("span[name='userSkipInfo']").text("请输入正确的页码！");
            $("input[name='userSkipPage']").focus();
            return false;
        }else{
            $("span[name='userSkipInfo']").text("");
            return true;
        }
    }

};
/*跳转按钮单击事件*/
$("a[name='skipPageUser']").click(function () {
    var userSkipPage=$("input[name='userSkipPage']").val();
    var userName=$("input[name='userName']").val();
    if (userSkipPage=="" || userSkipPage==null ){
        $("span[name='userSkipInfo']").text("请输入跳转页码！");
        $("input[name='userSkipPage']").focus();
        return false;
    }else if(pageVerifyUser()){
        location.href="/user/filtrateUser.html?indexPage="+userSkipPage+"&userName="+userName+"";
    }
});