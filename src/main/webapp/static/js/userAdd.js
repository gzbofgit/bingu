/*用户名验证*/
function userNameBlur() {
    var userName = $("input[name='userName']").val();
    if (userName != "" && userName != null) {
        $.get("/user/userNameIsNull.html", {userName: userName}, function (result) {
            if (result == "exist") {
                $("input[name='userName']").focus();
                $("span[name='userNameInfo']").text("用户名已被注册!");
                $("span[name='userNameInfo']").css("color", "red")
                return false;
            } else {
                $("span[name='userNameInfo']").text("*");
                $("span[name='userNameInfo']").css("color", "#00FA98");
                return true;
            }
        }, "JSON");
    } else {
        $("input[name='userName']").focus();
        $("span[name='userNameInfo']").text("用户名不能为空!");
        $("span[name='userNameInfo']").css("color", "red");
        return false;
    }
};

/*手机号验证*/
function phoneBlur() {
    var phone = $("input[name='phone']").val();
    var reg = /^1[3|4|5|8][0-9]\d{4,8}$/;
    if (phone == "" || phone == null) {
        $("input[name='phone']").focus();
        $("span[name='phoneInfo']").text("手机号码不能为空!");
        $("span[name='phoneInfo']").css("color", "red");
        return false;
    } else {
        if (!(reg.test(phone))) {
            $("input[name='phone']").focus();
            $("span[name='phoneInfo']").text("手机号格式不正确!");
            $("span[name='phoneInfo']").css("color", "red");
            return false;
        } else {
            $("span[name='phoneInfo']").text("*");
            $("span[name='phoneInfo']").css("color", "#00FA98");
            return true;
        }
    }
};

/*身份证验证*/
function identityBlur() {
    var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
    var identity = $("input[name='identity']").val();
    if (identity == "" || identity == null) {
        $("input[name='identity']").focus();
        $("span[name='identityInfo']").text("身份证不能为空!");
        $("span[name='identityInfo']").css("color", "red");
        return false;
    } else {
        if (!(reg.test(identity))) {
            $("#mySubmit").attr("type", "button");
            $("input[name='identity']").focus();
            $("span[name='identityInfo']").text("身份证格式错误!");
            $("span[name='identityInfo']").css("color", "red");
            return false;
        } else {
            $("span[name='identityInfo']").text("*");
            $("span[name='identityInfo']").css("color", "#00FA98");
            return true;
        }
    }
};

//密码输入框
function userPwdBlur() {
    var reg = /^[a-zA-Z]\w{5,17}$/;
    var userPwd = $("input[name='userPwd']");
    var userPwdInfo = $("span[name='userPwdInfo']");
    if (userPwd.val() == "" || userPwd.val() == null) {
        userPwd.focus();
        userPwdInfo.text("密码不能为空！");
        userPwdInfo.css("color", "red");
        return false;
    } else if (!(reg.test(userPwd.val()))) {
        userPwd.focus();
        userPwdInfo.text("密码格式错误！");
        userPwdInfo.css("color", "red");
        return false;
    } else {
        userPwdInfo.text("*");
        userPwdInfo.css("color", "#00FA98");
        return true;
    }
}

function birthDataBlur() {
    var birthData = $("input[name='birthData']");
    var birthDataInfo = $("span[name='birthDataInfo']");
    var time = new Date();
    var returnTime_ = time.getFullYear() + "-" + (time.getMonth() + 1) + "-" + time.getDate();//当前日期
    var starttime = new Date(returnTime_.replace(/-/g, "/"));
    var endtime = new Date((birthData.val()).replace(/-/g, "/"));
    if (birthData.val() != "" && birthData.val() != null) {
        if (endtime > starttime) {
            birthData.focus();
            birthDataInfo.text("出生日期不能大于今天！");
            birthDataInfo.css("color", "red")
            return false;
        } else {
            birthDataInfo.text("");
            birthDataInfo.css("color", "#00FA98")
            return true;
        }
    } else {
        return true;
    }
};
/*用户注册*/
$("#userLogin").click(function () {
    var userName = $("input[name='userName']").val();
    var userNameInfo = $("span[name='userNameInfo']").text();
    if (userName == "" || userName == null) {
        $("span[name='userNameInfo']").text("用户名不能为空!");
        $("span[name='userNameInfo']").css("color", "red")
        $("input[name='userName']").focus();
        return false;
    } else if (userNameInfo == "用户名已被注册!") {
        $("input[name='userName']").focus();
        $("span[name='userNameInfo']").text("用户名已被注册!");
        $("span[name='userNameInfo']").css("color", "red");
        return false;
    } else if (!userPwdBlur()) {
        return false;
    } else if (!identityBlur()) {
        return false;
    } else if (!birthDataBlur()) {
        return false;
    } else if (!phoneBlur()) {
        return false;
    } else {
        return true;
    }
})
//新增and修改
$("#mySubmit").click(function () {
    var userName = $("input[name='userName']").val();
    var userNameInfo = $("span[name='userNameInfo']").text();
    var userPwd = $("input[name='userPwd']").val();
    var userId = $("input[name='userId']").val();
    var identity = $("input[name='identity']").val();
    var sex = $("input[name='sex']:checked").val();
    var birthData = $("input[name='birthData']").val();
    var address = $("input[name='address']").val();
    var phone = $("input[name='phone']").val();
    var isMember = $("input[name='isMember']:checked").val();
    var money = $("input[name='money']").val();
    var user = $("span[name='user']");

    var userNames = $("span[name='userName']").text();

    if (userName == "" || userName == null) {
        $("span[name='userNameInfo']").text("用户名不能为空!");
        $("span[name='userNameInfo']").css("color", "red")
        $("input[name='userName']").focus();
        return false;
    } else if (userNameInfo == "用户名已被注册!") {
        $("input[name='userName']").focus();
        $("span[name='userNameInfo']").text("用户名已被注册!");
        $("span[name='userNameInfo']").css("color", "red");
        return false;
    } else if (userNames == userName) {
        $("input[name='userName']").focus();
        $("span[name='userNameInfo']").text("用户名已被注册!");
        $("span[name='userNameInfo']").css("color", "red");
        return false;
    } else if (!userPwdBlur()) {
        return false;
    } else if (!identityBlur()) {
        return false;
    } else if (!birthDataBlur()) {
        return false;
    } else if (!phoneBlur()) {
        return false;
    } else {
        $.post("/user/addUser.html", {
            userId: userId, userName: userName, userPwd: userPwd,
            identity: identity,
            sex: sex, birthData: birthData,
            address: address, phone: phone,
            isMember: isMember, money: money
        }, function (result) {
            if (user.text() == "新增") {
                if (result > 0) {
                    alert("添加成功,编号为：" + result);
                    $("span[name='userName']").text(userName);
                    $("input[name='userId']").val(result);
                } else {
                    alert("添加失败！");
                }
            } else {
                if (result > 0) {
                    alert("修改成功！");
                    location.href = "/user/userManager.html";
                } else {
                    alert("修改失败！");
                }
            }
        }, "JSON");
    }
});

