function bookNameBlur() {
    var bookName = $("input[name='bookName']");
    var bookNameInfo = $("span[name='bookNameInfo']");
    if (bookName.val() == "" || bookName.val() == null) {
        bookNameInfo.text("图书名不能为空！");
        bookName.focus();
        return false;
    } else {
        $.get("/book/bookNameIsExist.html", {bookName: bookName.val()}, function (result) {
            if (result == "exist") {
                bookNameInfo.text("图书名已存在！");
                bookNameInfo.css("color", "red");
                bookName.focus();
                return false;
            } else {
                bookNameInfo.text("*");
                bookNameInfo.css("color", "#00FA98");
                return true;
            }
        }, "JSON");
    }
}

function bookPriceBlur() {
    /*正整数正则表达式*/
    var reg = /^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$/;
    var bookPrice = $("input[name='bookPrice']");
    var bookPriceInfo = $("span[name='bookPriceInfo']");
    if (bookPrice.val() == "") {
        bookPriceInfo.text("单价不能为空！");
        bookPrice.focus();
        bookPriceInfo.css("color", "red");
        return false;
    } else if (bookPrice.val() == "0" || (!reg.test(bookPrice.val()))) {
        bookPriceInfo.text("请输入不为0的正数(保留小数点后两位)！");
        bookPrice.val("");
        bookPrice.focus();
        bookPriceInfo.css("color", "red");
        return false;
    } else {
        bookPriceInfo.text("*");
        bookPriceInfo.css("color", "#00FA98");
        return true;
    }
};

function bookAuthorBlur() {
    var bookAuthor = $("input[name='bookAuthor']");
    var bookAuthorInfo = $("span[name='bookAuthorInfo']");
    if (bookAuthor.val() == "") {
        bookAuthorInfo.text("图书作者不能为空！");
        bookAuthor.focus();
        bookAuthorInfo.css("color", "red");
        return false;
    } else {
        bookAuthorInfo.text("*");
        bookAuthorInfo.css("color", "#00FA98");
        return true;
    }
};

function bookIssueBlur() {
    var bookIssue = $("input[name='bookIssue']");
    var bookIssueInfo = $("span[name='bookIssueInfo']");
    if (bookIssue.val() == "") {
        bookIssueInfo.text("图书出版社不能为空！");
        bookIssue.focus();
        bookIssueInfo.css("color", "red");
        return false;
    } else {
        bookIssueInfo.text("*");
        bookIssueInfo.css("color", "#00FA98");
        return true;
    }
};

function bookDateBlur() {
    var bookDate = $("input[name='bookDate']");
    var bookDateInfo = $("span[name='bookDateInfo']");

    var time = new Date();
    var returnTime_ = time.getFullYear() + "-" + (time.getMonth() + 1) + "-" + time.getDate();//当前日期
    var starttime = new Date(returnTime_.replace(/-/g, "/"));
    var endtime = new Date((bookDate.val()).replace(/-/g, "/"));
    if (bookDate.val() == "") {
        bookDateInfo.text("图书出版日期不能为空！");
        bookDate.focus();
        bookDateInfo.css("color", "red");
        return false;
    }else if(endtime > starttime){
        bookDateInfo.text("出版日期不能大于今天！");
        bookDate.focus();
        bookDateInfo.css("color", "red");
        return false;
    } else {
        bookDateInfo.text("*");
        bookDateInfo.css("color", "#00FA98");
        return true;
    }
};

function typeIdBlur() {
    var typeId = $("select[name='typeIds']");
    var typeIdInfo = $("span[name='typeIdInfo']");
    if (typeId.val() == "0") {
        typeIdInfo.text("请选择图书类别！");
        typeId.focus();
        typeIdInfo.css("color", "red");
        return false;
    } else {
        typeIdInfo.text("*");
        typeIdInfo.css("color", "#00FA98");
        return true;
    }
};

function inventoryBlur() {
    var reg = /^[1-9]+[0-9]*]*$/;
    var inventory = $("input[name='inventory']");
    var inventoryInfo = $("span[name='inventoryInfo']");
    if (inventory.val() == "") {
        inventoryInfo.text("请输入图书库存！");
        inventoryInfo.css("color", "red");
        inventory.focus();
        return false;
    } else if (inventory.val() == "0" || (!reg.test(inventory.val()))) {
        inventoryInfo.text("请输入不为0的正整数！");
        inventory.val("");
        inventory.focus();
        inventoryInfo.css("color", "red");
        return false;
    } else {
        inventoryInfo.text("*");
        inventoryInfo.css("color", "#00FA98");
        return true;
    }
};

function bookLocationBlur() {
    var bookLocation = $("input[name='bookLocation']");
    var bookLocationInfo = $("span[name='bookLocationInfo']");
    if (bookLocation.val() == "") {
        bookLocationInfo.text("请输入图书位置！");
        bookLocationInfo.css("color", "red");
        bookLocation.focus();
        return false;
    } else {
        bookLocationInfo.text("*");
        bookLocationInfo.css("color", "#00FA98");
        return true;
    }
};


/*表单提交事件*/
$("#bookForm").submit(function () {
    var bookName = $("input[name='bookName']");
    var bookNameInfo = $("span[name='bookNameInfo']");
    if (bookName.val() == "" || bookName.val() == null) {
        bookNameInfo.text("图书名不能为空！");
        bookName.focus();
        return false;
    } else if (bookNameInfo.text() == "图书名已存在！") {
        bookNameInfo.text("图书名已存在！");
        bookNameInfo.css("color", "red");
        bookName.focus();
        return false;
    } else if (!bookPriceBlur()) {
        return false;
    } else if (!bookAuthorBlur()) {
        return false;
    } else if (!bookIssueBlur()) {
        return false;
    } else if (!bookDateBlur()) {
        return false;
    } else if (!typeIdBlur()) {
        return false;
    } else if (!inventoryBlur()) {
        return false;
    } else if (!bookLocationBlur()) {
        return false;
    }else{
        return true;
    }
});
