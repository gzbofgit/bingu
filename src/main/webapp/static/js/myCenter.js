/*查看图书详细信息*/
function bookView(bookId) {
    $.get("/book/view", {bookId: bookId}, function (result) {
        $("img[name='bookPortrait']").attr("src", "/static/image/bookImages/" + result.bookPortrait);
        $("span[name='bookId']").text(result.bookId);
        $("span[name='bookName']").text(result.bookName);
        $("span[name='bookPrice']").text(result.bookPrice);
        $("span[name='bookAuthor']").text(result.bookAuthor);
        $("span[name='bookIssue']").text(result.bookIssue);
        $("span[name='bookDate']").text(result.bookDate);
        $("span[name='typeId']").text(result.typeId.typeName);
        $("span[name='inventory']").text(result.inventory == "0" ? '无库存' : result.inventory);
        $("span[name='bookLocation']").text(result.bookLocation == null || result.bookLocation == "" ? '暂定' : result.bookLocation);
    }, "JSON")
};

/*绑定跳转输入框失焦事件*/
function pageVerifyBook() {
    var bookSkipPage = $("input[name='bookSkipPage']").val();
    var bookCountPage = $("span[name='bookCountPage']").text();
    if (parseInt(bookCountPage) != 0) {
        if (parseInt(bookSkipPage) > parseInt(bookCountPage)) {
            $("span[name='bookSkipInfo']").text("跳转页码不能大于总页码！");
            $("input[name='bookSkipPage']").focus();
            return false;
        } else if (bookSkipPage == "" || bookSkipPage == 0) {
            $("span[name='bookSkipInfo']").text("请输入正确的页码！");
            $("input[name='bookSkipPage']").focus();
            return false;
        } else {
            $("span[name='bookSkipInfo']").text("");
            return true;
        }
    }

};
/*跳转按钮单击事件*/
$("a[name='skipPageBook']").click(function () {
    var bookSkipPage = $("input[name='bookSkipPage']").val();
    var typeId = $("select[name='typeId']").val();
    var bookName = $("input[name='bookName']").val();
    var inventory = $("input[name='inventory']").val();
    if (bookSkipPage == "" || bookSkipPage == null) {
        $("span[name='bookSkipInfo']").text("请输入跳转页码！");
        $("input[name='bookSkipPage']").focus();
        return false;
    } else if (pageVerifyBook()) {
        location.href = "/userAction/filtrateBook.html?indexPage=" + bookSkipPage + "&bookName=" + bookName + "&typeId=" + typeId + "&inventory=" + inventory + "";
    }
});
//借阅用户输入框
$("#biUserName").click(function () {
    $("#borrowingInfo").hide();
});

/*得到时间差*/
function daysBetween(DateOne, DateTwo) {
    var OneMonth = DateOne.substring(5, DateOne.lastIndexOf('-'));
    var OneDay = DateOne.substring(DateOne.length, DateOne.lastIndexOf('-') + 1);
    var OneYear = DateOne.substring(0, DateOne.indexOf('-'));

    var TwoMonth = DateTwo.substring(5, DateTwo.lastIndexOf('-'));
    var TwoDay = DateTwo.substring(DateTwo.length, DateTwo.lastIndexOf('-') + 1);
    var TwoYear = DateTwo.substring(0, DateTwo.indexOf('-'));

    var cha = ((Date.parse(OneMonth + '/' + OneDay + '/' + OneYear) - Date.parse(TwoMonth + '/' + TwoDay + '/' + TwoYear)) / 86400000);
    return Math.abs(cha);
}

//得到借阅书籍编号
function biBook(bookId) {
    $("input[name='biBookId']").val(bookId);

    $("input[name='biUserName']").val("");//借阅用户
    $("span[name='biUserNameInfo']").text("*");
    $("span[name='biUserNameInfo']").css("color", "red");
    $("input[name='returnTime']").val("");//归还日期
    $("span[name='returnTimeInfo']").text("*");
    $("span[name='returnTimeInfo']").css("color", "red");
    $("input[name='remarks']").val("");//归还日期
    /*$("#returnTime").hide();*/
    $("#borrowingInfo").hide();
}

//归还日期输入框
$("input[name='returnTime']").blur(function () {
    var biUserName = $("input[name='sessionUser']");//借阅用户
    var returnTime = $("input[name='returnTime']");//归还日期
    var returnTimeInfo = $("span[name='returnTimeInfo']");
    var bookId = $("input[name='biBookId']").val();//图书id
    var borrowingTime = $("span[name='borrowingTime']");
    var borrowingMoney = $("span[name='borrowingMoney']");
    var borrowingInfo = $("#borrowingInfo");
    var time = new Date();
    var returnTime_ = time.getFullYear() + "-" + (time.getMonth() + 1) + "-" + time.getDate();//当前日期
    var starttime = new Date(returnTime_.replace(/-/g, "/"));
    var endtime = new Date((returnTime.val()).replace(/-/g, "/"));

    var time_ = daysBetween(returnTime_, returnTime.val());//相隔天数
    /*  alert(returnTime_+"============当前日期："+returnTime_+"归还日期："+returnTime.val()+"相隔日期："+times);*/
    if (returnTime.val() == "" || returnTime.val() == null) {
        returnTime.focus();
        returnTimeInfo.text("请选择归还日期！");
        returnTimeInfo.css("color", "red");
        return false;
    } else if (endtime < starttime) {
        returnTime.focus();
        returnTimeInfo.text("归还日期不能小于借阅日期!");
        returnTimeInfo.css("color", "red");
        return false;
    } else {
        $.get("/user/moneyIsEnough.html", {time: time_, userName: biUserName.val(), bookId: bookId}, function (result) {
            if (result.success == "pass") {
                returnTimeInfo.text("*");
                returnTimeInfo.css("color", "#00FA98");
            } else {
                returnTime.focus();
                returnTimeInfo.text("金额不足,重选归还日期或充值！");
                returnTimeInfo.css("color", "red");
                return false;
            }
            borrowingInfo.show();
            borrowingTime.text(result.borrowingTime);
            borrowingMoney.text(result.borrowingMoney == "0" ? '免费' : result.borrowingMoney.substring(0, 4) + "元");
        }, "JSON")
    }
});
//借阅图书
$("#borrowingAdd").click(function () {
    var biUserName = $("input[name='sessionUser']");//借阅用户
    var biUserNameInfo = $("span[name='biUserNameInfo']");
    var returnTime = $("input[name='returnTime']");//归还日期
    var returnTimeInfo = $("span[name='returnTimeInfo']");
    var remarks = $("input[name='remarks']");//备注
    var bookId = $("input[name='biBookId']").val();//图书id

    var indexPage = $("#bookIndexPage").text();
    var typeId = $("select[name='typeId']").val();
    var bookName = $("input[name='bookName']").val();
    var inventory = $("input[name='inventory']").val();

    var time = new Date();
    var returnTime_ = time.getFullYear() + "-" + (time.getMonth() + 1) + "-" + time.getDate();//当前日期
    var starttime = new Date(returnTime_.replace(/-/g, "/"));
    var endtime = new Date((returnTime.val()).replace(/-/g, "/"));

    var time_ = daysBetween(returnTime_, returnTime.val());//相隔天数
    if (returnTime.val() == "" || returnTime.val() == null) {
        returnTime.focus();
        returnTimeInfo.text("请选择归还日期！");
        returnTimeInfo.css("color", "red");
        return false;
    } else if (returnTimeInfo.text()=="归还日期不能小于借阅日期!") {
        alert("来了")
        returnTime.focus();
        returnTimeInfo.text("归还日期不能小于借阅日期！");
        returnTimeInfo.css("color", "red");
        return false;
    } else if (returnTimeInfo.text() == "金额不足,重选归还日期或充值！") {
        alert("zu")
        returnTime.focus();
        returnTimeInfo.text("金额不足,重选归还日期或充值！");
        returnTimeInfo.css("color", "red");
        return false;
    } else {
        $.get("/borrowing/borrowingAdd.html", {
            remarks: remarks.val(),
            borrowingTime: returnTime_,
            returnTime: returnTime.val(),
            time: time_,
            userName: biUserName.val(),
            bookId: bookId
        }, function (result) {
            if (result == "success") {
                alert("借阅成功！");
                location.href = "/userAction/filtrateBook.html?indexPage=" + indexPage + "&bookName=" + bookName + "&typeId=" + typeId + "&inventory=" + inventory + "";
            } else {
                alert("借阅失败！");
            }
        }, "JSON")
    }
});

/*绑定跳转输入框失焦事件*/
function pageVerifyBi() {
    var biSkipPage = $("input[name='biSkipPage']").val();
    var biCountPage = $("span[name='biCountPage']").text();
    if (parseInt(biCountPage) != 0) {
        if (parseInt(biSkipPage) > parseInt(biCountPage)) {
            $("span[name='biSkipInfo']").text("跳转页码不能大于总页码！");
            $("input[name='biSkipPage']").focus();
            return false;
        } else if (biSkipPage == "" || biSkipPage == 0) {
            $("span[name='biSkipInfo']").text("请输入正确的页码！");
            $("input[name='biSkipPage']").focus();
            return false;
        } else {
            $("span[name='biSkipInfo']").text("");
            return true;
        }
    }

};
/*跳转按钮单击事件*/
$("a[name='skipPageBi']").click(function () {
    var biSkipPage = $("input[name='biSkipPage']").val();
    var term = $("input[name='term']").val();
    var overtime = $("input[name='overtime']").val();
    if (biSkipPage == "" || biSkipPage == null) {
        $("span[name='biSkipInfo']").text("请输入跳转页码！");
        $("input[name='biSkipPage']").focus();
        return false;
    } else if (pageVerifyBi()) {
        location.href = "/userAction/filtrateBook.html?indexPage=" + biSkipPage + "&term=" + term + "&overtime=" + overtime + "";
    }
});

//归还书籍
function restoreBook(borrowingId, bookId) {
    var biIndexPage = $("#biIndexPage").text();
    var term = $("input[name='term']").val();
    var overtime = $("input[name='overtime']").val();
    if (confirm("确认归还吗？")) {
        $.get("/borrowing/restoreBook.html", {borrowingId: borrowingId, bookId: bookId}, function (result) {
            if (result == "success") {
                alert("归还成功！");
            } else {
                alert("归还失败！")
            }
            location.href = "/userAction/filtrateBorrowing.html?indexPage=" + biIndexPage + "&term=" + term + "&overtime=" + overtime + "";
        }, "JSON");
    }
}

/*用户充值*/
$("#upButton").click(function () {
    var userId = $("#userId").val();
    var upMoney = $("#upMoneyUser").val();
    var upInfo = $("#upInfo");
    /* 保留两位小数的正数*/
    var isNum = /^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$/;
    if (!isNum.test(upMoney)) {
        upInfo.text("请输入合法金额,保留小数点后两位！");
        $("#upMoney").focus();
        return;
    }
    $.get("/user/up", {userId: userId, upMoney: upMoney}, function (result) {
        if (result != "0") {
            $("input[name='money']").val(result.money)
            alert("充值成功！");
            upInfo.text("");
            $("#upMoney").val("");
            $("#mymodal3").modal("hide");
        } else {
            alert("充值失败！")
        }
    }, "JSON");
});

//充值模态框按钮
function up2() {
    $("#upMoneyUser").val("");
    $("#upInfo").text("");
};

/*用户名验证*/
function userNameBlur() {
    var userName = $("input[name='userName']").val();
    if (userName != "" && userName != null) {
        $.get("/user/userNameIsNull.html", {userName: userName}, function (result) {
            if (result == "exist") {
                $("input[name='userName']").focus();
                $("span[name='userNameInfo']").text("用户名已被注册,请重新输入!");
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
    }else{
        return true;
    }
}

/*个人中心修改*/
$("#mySubmit").click(function () {
    var userName = $("input[name='userName']").val();
    var userPwd = $("input[name='userPwd']").val();
    var userId = $("#userId").val()
    var identity = $("input[name='identity']").val();
    var sex = $("input[name='sex']:checked").val();
    var birthData = $("input[name='birthData']").val();
    var address = $("input[name='address']").val();
    var phone = $("input[name='phone']").val();
    var isMember = $("input[name='isMember']:checked").val();
    var money = $("input[name='money']").val();
    var userNameInfo = $("span[name='userNameInfo']").text();

    if (userName == "" || userName == null) {
        $("input[name='userNameInfo']").text("用户名不能为空!");
        $("input[name='userNameInfo']").css("color", "red")
        $("input[name='userName']").focus();
        return false;
    }else if (userNameInfo == "用户名已被注册,请重新输入!") {
        $("input[name='userName']").focus();
        $("span[name='userNameInfo']").text("用户名已被注册,请重新输入!");
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
            if (result > 0) {
                alert("保存成功！");
                location.href = "/admin/skipLogin.html";
            } else {
                alert("保存失败！");
            }
        }, "JSON");
    }
});

/*开通会员*/
function openIsMember() {
    if (confirm("确认开通吗？")) {
        $.get("/userAction/openIsMember.html", function (result) {
            if (result == "success") {
                alert("开通成功");
                location.href = "/userAction/flushUser.html";
            } else {
                alert("开通失败");
            }
        }, "JSON")
    }
}
