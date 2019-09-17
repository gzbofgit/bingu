package cn.book.pojo;

/**
 * 借阅表
 */
public class Borrowing {
    private Integer borrowingId;//借阅编号
    private User userId;//借阅用户编号
    private Book bookId;//被借阅图书编号
    private String  borrowingTime;//借阅日期
    private String returnTime;//归还日期
    private String remarks;//备注

    public Integer getBorrowingId() {
        return borrowingId;
    }

    public void setBorrowingId(Integer borrowingId) {
        this.borrowingId = borrowingId;
    }

    public User getUserId() {
        return userId;
    }

    public void setUserId(User userId) {
        this.userId = userId;
    }

    public Book getBookId() {
        return bookId;
    }

    public void setBookId(Book bookId) {
        this.bookId = bookId;
    }

    public String getBorrowingTime() {
        return borrowingTime;
    }

    public void setBorrowingTime(String borrowingTime) {
        this.borrowingTime = borrowingTime;
    }

    public String getReturnTime() {
        return returnTime;
    }

    public void setReturnTime(String returnTime) {
        this.returnTime = returnTime;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
}
