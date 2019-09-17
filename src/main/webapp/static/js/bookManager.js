/*查看图书详细信息*/
function bookView(bookId) {
    $.get("/book/view",{bookId:bookId},function (result) {
        $("img[name='bookPortrait']").attr("src","/static/image/bookImages/"+result.bookPortrait);
        $("span[name='bookId']").text(result.bookId);
        $("span[name='bookName']").text(result.bookName);
        $("span[name='bookPrice']").text(result.bookPrice);
        $("span[name='bookAuthor']").text(result.bookAuthor);
        $("span[name='bookIssue']").text(result.bookIssue);
        $("span[name='bookDate']").text(result.bookDate);
        $("span[name='typeId']").text(result.typeId.typeName);
        $("span[name='inventory']").text(result.inventory=="0" ?'无库存':result.inventory);
        $("span[name='bookLocation']").text(result.bookLocation==null || result.bookLocation==""?'暂定':result.bookLocation);
    },"JSON")
};
/*绑定跳转输入框失焦事件*/
function pageVerifyBook(){
    var bookSkipPage=$("input[name='bookSkipPage']").val();
    var bookCountPage=$("span[name='bookCountPage']").text();
    if(parseInt(bookCountPage)!=0){
        if(parseInt(bookSkipPage)>parseInt(bookCountPage)){
            $("span[name='bookSkipInfo']").text("跳转页码不能大于总页码！");
            $("input[name='bookSkipPage']").focus();
            return false;
        }else if(bookSkipPage==""||bookSkipPage==0){
            $("span[name='bookSkipInfo']").text("请输入正确的页码！");
            $("input[name='bookSkipPage']").focus();
            return false;
        }else{
            $("span[name='bookSkipInfo']").text("");
            return true;
        }
    }

};
/*跳转按钮单击事件*/
$("a[name='skipPageBook']").click(function () {
    var bookSkipPage=$("input[name='bookSkipPage']").val();
    var typeId=$("select[name='typeId']").val();
    var bookName=$("input[name='bookName']").val();
    var inventory=$("input[name='inventory']").val();
    if (bookSkipPage=="" || bookSkipPage==null ){
        $("span[name='bookSkipInfo']").text("请输入跳转页码！");
        $("input[name='bookSkipPage']").focus();
        return false;
    }else if(pageVerifyBook()){
        location.href="/book/filtrateBook.html?indexPage="+bookSkipPage+"&bookName="+bookName+"&typeId="+typeId+"&inventory="+inventory+"";
    }
});
/*删除图书*/
function delBook(bookId) {
    var indexPage=$("#bookIndexPage").text();
    var typeId=$("select[name='typeId']").val();
    var bookName=$("input[name='bookName']").val();
    var inventory=$("input[name='inventory']").val();
    if(confirm("是否删除")){
        $.get("/book/delBook.html",{bookId:bookId},function (result) {
            if(result>0){
                alert("删除成功");
                location.href="/book/filtrateBook.html?indexPage="+indexPage+"&bookName="+bookName+"&typeId="+typeId+"&inventory="+inventory+"";
            }else{
                alert("删除失败！");
            }
        },"JSON")
    }
};
//借阅用户输入框
$("#biUserName").click(function () {
    $("#borrowingInfo").hide();
})

//借阅用户输入框
$("#biUserName").blur(function () {
    var biUserName=$("input[name='biUserName']");
    var biUserNameInfo=$("span[name='biUserNameInfo']");

    if(biUserName.val()==""||biUserName.val()==null){
        biUserName.focus();
        biUserNameInfo.text("借阅用户不能为空！");
        biUserNameInfo.css("color","red");
    }else{
        $.get("/user/userNameIsNull.html",{userName:biUserName.val()},function (result) {
            if (result == "onexist") {
                biUserName.focus();
                biUserNameInfo.text("该用户不存在!");
                biUserNameInfo.css("color", "red");
            } else {
                $("#returnTime").show();//归还日期盒子
                biUserNameInfo.text("*");
                biUserNameInfo.css("color", "#00FA98");
            }
        },"JSON")
    }
});
/*得到时间差*/
function daysBetween(DateOne,DateTwo)
{
    var OneMonth = DateOne.substring(5,DateOne.lastIndexOf ('-'));
    var OneDay = DateOne.substring(DateOne.length,DateOne.lastIndexOf ('-')+1);
    var OneYear = DateOne.substring(0,DateOne.indexOf ('-'));

    var TwoMonth = DateTwo.substring(5,DateTwo.lastIndexOf ('-'));
    var TwoDay = DateTwo.substring(DateTwo.length,DateTwo.lastIndexOf ('-')+1);
    var TwoYear = DateTwo.substring(0,DateTwo.indexOf ('-'));

    var cha=((Date.parse(OneMonth+'/'+OneDay+'/'+OneYear)- Date.parse(TwoMonth+'/'+TwoDay+'/'+TwoYear))/86400000);
    return Math.abs(cha);
}
//得到借阅用户
function biBook(bookId) {
    $("input[name='biBookId']").val(bookId);

    $("input[name='biUserName']").val("");//借阅用户
    $("span[name='biUserNameInfo']").text("*");
    $("span[name='biUserNameInfo']").css("color","red");
    $("input[name='returnTime']").val("");//归还日期
    $("span[name='returnTimeInfo']").text("*");
    $("span[name='returnTimeInfo']").css("color","red");
    $("input[name='remarks']").val("");//归还日期
    $("#returnTime").hide();
    $("#borrowingInfo").hide();
}
//归还日期输入框
$("input[name='returnTime']").blur(function () {
    var biUserName=$("input[name='biUserName']");//借阅用户
    var returnTime=$("input[name='returnTime']");//归还日期
    var returnTimeInfo=$("span[name='returnTimeInfo']");
    var bookId=$("input[name='biBookId']").val();//图书id
    var borrowingTime=$("span[name='borrowingTime']");
    var borrowingMoney=$("span[name='borrowingMoney']");
    var borrowingInfo=$("#borrowingInfo");
    var time=new Date();
    var returnTime_=time.getFullYear()+"-"+(time.getMonth()+1)+"-"+time.getDate();//当前日期
    var starttime = new Date(returnTime_.replace(/-/g, "/"));
    var endtime = new Date((returnTime.val()).replace(/-/g, "/"));

   var time_=daysBetween(returnTime_,returnTime.val());//相隔天数
  /*  alert(returnTime_+"============当前日期："+returnTime_+"归还日期："+returnTime.val()+"相隔日期："+times);*/
    if(returnTime.val()==""||returnTime.val()==null){
         returnTime.focus();
         returnTimeInfo.text("请选择归还日期！");
         returnTimeInfo.css("color","red");
     }else if(endtime<starttime){
         returnTime.focus();
         returnTimeInfo.text("归还日期不能小于借阅日期!");

         returnTimeInfo.css("color","red");
     }else{
         $.get("/user/moneyIsEnough.html",{time:time_,userName:biUserName.val(),bookId:bookId},function (result) {
             if(result.success=="pass"){
                 returnTimeInfo.text("*");
                 returnTimeInfo.css("color","#00FA98");
             }else{
                 returnTime.focus();
                 returnTimeInfo.text("金额不足,重选归还日期或充值！");
                 returnTimeInfo.css("color","red");
             }
             borrowingInfo.show();
             borrowingTime.text(result.borrowingTime);
             borrowingMoney.text(result.borrowingMoney=="0"?'免费':result.borrowingMoney.substring(0,4)+"元");
         },"JSON")
     }
});
//借阅图书
$("#borrowingAdd").click(function () {
    var biUserName=$("input[name='biUserName']");//借阅用户
    var biUserNameInfo=$("span[name='biUserNameInfo']");
    var returnTime=$("input[name='returnTime']");//归还日期
    var returnTimeInfo=$("span[name='returnTimeInfo']");
    var remarks=$("input[name='remarks']");//备注
    var bookId=$("input[name='biBookId']").val();//图书id

    var indexPage=$("#bookIndexPage").text();
    var typeId=$("select[name='typeId']").val();
    var bookName=$("input[name='bookName']").val();
    var inventory=$("input[name='inventory']").val();

    var time=new Date();
    var returnTime_=time.getFullYear()+"-"+(time.getMonth()+1)+"-"+time.getDate();//当前日期
    var starttime = new Date(returnTime_.replace(/-/g, "/"));
    var endtime = new Date((returnTime.val()).replace(/-/g, "/"));

    var time_=daysBetween(returnTime_,returnTime.val());//相隔天数

    if(biUserName.val()==""||biUserName.val()==null){
        biUserName.focus();
        biUserNameInfo.text("借阅用户不能为空！");
        biUserNameInfo.css("color","red");
        return false;
    }else if(biUserNameInfo.text()=="该用户不存在!"){
        biUserName.focus();
        biUserNameInfo.text("该用户不存在!");
        biUserNameInfo.css("color", "red");
        return false;
    }else if(returnTime.val()==""||returnTime.val()==null){
        returnTime.focus();
        returnTimeInfo.text("请选择归还日期！");
        returnTimeInfo.css("color","red");
        return false;
    }else if(returnTimeInfo.text()=="归还日期不能小于借阅日期!"){
        returnTime.focus();
        returnTimeInfo.text("归还日期不能小于借阅日期!");
        returnTimeInfo.css("color","red");
        return false;
    }else if(returnTimeInfo.text()=="金额不足,重选归还日期或充值！"){
        returnTime.focus();
        returnTimeInfo.text("金额不足,重选归还日期或充值！");
        returnTimeInfo.css("color","red");
        return false;
    }else{
        $.get("/borrowing/borrowingAdd.html",{remarks:remarks.val(),borrowingTime:returnTime_,returnTime:returnTime.val(),time:time_,userName:biUserName.val(),bookId:bookId},function (result) {
            if(result=="success"){
                alert("借阅成功！");
                location.href="/book/filtrateBook.html?indexPage="+indexPage+"&bookName="+bookName+"&typeId="+typeId+"&inventory="+inventory+"";
            }else{
                alert("借阅失败！");
            }
        },"JSON")
    }
});