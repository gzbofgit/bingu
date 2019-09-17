var imgs = ["0862.png", "1571.png", "1736.png", "5229.png", "6218.png",
    "6982.png", "7013.png", "7684.png", "7869.png", "9959.png","4233.png",
    "2184.png", "8517.png", "0412.png", "8708.png", "7101.png","0100.png",
    "3189.png", "2905.png", "4508.png", "4231.png", "6094.png","8722.png",
    "4852.png", "2901.png", "1047.png", "3999.png", "0173.png","7526.png",
    "0190.png", "3211.png"];
var values = ["0862", "1571", "1736", "5229", "6218",
              "6982", "7013", "7684", "7869", "9959","4233",
    "2184", "8517", "0412", "8708", "7101","0100",
    "3189", "2905", "4508", "4231", "6094","8722",
    "4852", "2901", "1047", "3999", "0173","7526",
    "0190", "3211"];
var num=Math.round(Math.random()*30);//随机数
$(function () {
   $("#yzm img").attr("src","/static/image/login/"+imgs[num]);
})
var index = num;//验证码下标
var roleInfo;//登入角色
/*管理员名称输入框失焦事件*/
$("input[name='name']").blur(function () {
    var name = $("input[name='name']").val();
    var role = $("input[name='role']:checked").val();
    if(role=="0"){
        roleInfo="管理员"
    }else{
        roleInfo="用户";
    }
    if (name != "" && name != null) {
        $.post("/admin/verifyName.html", {name: name,role:role}, function (result) {
            if (result == "onexist") {
                $("#loginInfo").text(roleInfo+"不存在！");
                $("input[name='name']").focus();
            }else{
                $("#loginInfo").text("");
            }
        }, "JSON");
    } else {
        $("#loginInfo").text("名称不能为空！");
        $("input[name='name']").focus();
    }
});
//用户注册ajax
function userNameBlur2(){
    var name=$("input[name='userName']");
    if (name.val() != "" && name.val() != null) {
        $.post("/admin/verifyName.html", {name: name.val(),role:1}, function (result) {
            if (result == "onexist") {
                $("span[name='userNameInfo']").text("*");
                $("span[name='userNameInfo']").css("color", "#00FA98");
                return true;
            }else{
                name.focus();
                $("span[name='userNameInfo']").text("用户名已被注册!");
                $("span[name='userNameInfo']").css("color", "red")
                return false;
            }
        }, "JSON");
    } else {
        name.focus();
        $("span[name='userNameInfo']").text("用户名不能为空!");
        $("span[name='userNameInfo']").css("color", "red");
        return false;
    }
}
/**
 * 切换验证码
 */
$("#sx img").click(function () {
    var object=$("#yzm img");
    if(index<31){
       /* if(index!=0){/!*因为默认为第一张，所以如果是第一次换则换成第二张*!/
            index=0;
            object.attr("src","/static/image/login/"+imgs[index]);
        }else{*/
            index++;
            if(index==31){//最后一次进来的时候9，++后变成10，所以最后一次进来要把index设置为0；
                index=0;
                object.attr("src","/static/image/login/"+imgs[index]);
            }
            object.attr("src","/static/image/login/"+imgs[index]);
     /*   }*/
    }else{//如果不小于10，则从0开始
        index=0;
        object.attr("src","/static/image/login/"+imgs[index]);
    }
});
/*验证码失焦*/
function codeBlur() {
    var code = $("input[name='code']");
    if (code.val() == "" || code.val() == null) {
        $("#codeInfo").text("验证码不能为空！");
        code.focus();
        return false;
    } else {
        if(code.val()==values[index]){
            $("#codeInfo").text("");
            return true;
        }else{
            $("#codeInfo").text("验证码错误！");
            code.focus();
            return false;
        }
    }
};
//密码款失焦
function pwdBlur(){
    var pwd=$("input[name='pwd']").val();
    if(pwd=="" || pwd==null) {
        $("div[name='pwdInfo']").html("密码不能为空！");
        $("input[name='pwd']").focus();
        return false;
    }else{
        $("div[name='pwdInfo']").html("");
        return true;
    }
}
/*登入*/
$("#login").click(function () {
    var name = $("input[name='name']").val();
    var loginInfo=$("#loginInfo");
    if(name=="" || name==null){
        $("#loginInfo").text("名称不能为空！");
        $("input[name='name']").focus();
        return false;
    }else if(loginInfo.text()==roleInfo+"不存在！"){
        $("#loginInfo").text(roleInfo+"不存在！");
        $("input[name='name']").focus();
        return false;
    }else if(!pwdBlur()){
        return false;
    }else if(!codeBlur()){
        return false;
    }else {
        return true;
    }
});
//密码显示
function switchoverA(object) {
    var zy = $("#zyA");
    var by = $("#byA");
    var userPwd = $("input[name='pwd']");
    userPwd.attr("type", "text")
    zy.toggle();
    by.toggle();
}

//密码隐藏
function switchoverA(object) {
    var zy = $("#zyA");
    var by = $("#byA");
    var userPwd = $("input[name='pwd']");
    userPwd.attr("type", "password")
    zy.toggle();
    by.toggle();
}