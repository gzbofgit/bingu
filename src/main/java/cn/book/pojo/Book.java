package cn.book.pojo;

public class Book {
    private Integer bookId;//图书编号
    private String bookName;//图书名
    private double bookPrice;//图书价格
    private String bookAuthor;//图书作者
    private String bookIssue;//出版社
    private String bookDate;//出版日期
    private BookType typeId;//外键，引用类别表
    private String bookPortrait;//图书封面，保存封面地址
    private Integer inventory;//库存
    private String  bookLocation;//图书位置，根据图书馆的不同而不同,这里暂时不写

    public Integer getBookId() {
        return bookId;
    }

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public double getBookPrice() {
        return bookPrice;
    }

    public void setBookPrice(double bookPrice) {
        this.bookPrice = bookPrice;
    }

    public String getBookAuthor() {
        return bookAuthor;
    }

    public void setBookAuthor(String bookAuthor) {
        this.bookAuthor = bookAuthor;
    }

    public String getBookIssue() {
        return bookIssue;
    }

    public void setBookIssue(String bookIssue) {
        this.bookIssue = bookIssue;
    }

    public String getBookDate() {
        return bookDate;
    }

    public void setBookDate(String bookDate) {
        this.bookDate = bookDate;
    }

    public BookType getTypeId() {
        return typeId;
    }

    public void setTypeId(BookType typeId) {
        this.typeId = typeId;
    }

    public String getBookPortrait() {
        return bookPortrait;
    }

    public void setBookPortrait(String bookPortrait) {
        this.bookPortrait = bookPortrait;
    }

    public Integer getInventory() {
        return inventory;
    }

    public void setInventory(Integer inventory) {
        this.inventory = inventory;
    }

    public String getBookLocation() {
        return bookLocation;
    }

    public void setBookLocation(String bookLocation) {
        this.bookLocation = bookLocation;
    }
}
