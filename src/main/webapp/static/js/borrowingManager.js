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
        location.href = "/borrowing/filtrateBorrowing.html?indexPage=" + biSkipPage + "&term=" + term + "&overtime=" + overtime + "";
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
            location.href = "/borrowing/filtrateBorrowing.html?indexPage=" + biIndexPage + "&term=" + term + "&overtime=" + overtime + "";
        }, "JSON");
    }
}