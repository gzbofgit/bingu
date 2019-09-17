package cn.book.pojo;

/**
 * 超时表
 */
public class Overtime {
    private Integer overtimeId;//超时表编号
    private Book bookId;//图书编号
    private User userId;//用户编号
    private Integer overtimeDay;//超时天数

    public Integer getOvertimeId() {
        return overtimeId;
    }

    public void setOvertimeId(Integer overtimeId) {
        this.overtimeId = overtimeId;
    }

    public Book getBookId() {
        return bookId;
    }

    public void setBookId(Book bookId) {
        this.bookId = bookId;
    }

    public User getUserId() {
        return userId;
    }

    public void setUserId(User userId) {
        this.userId = userId;
    }

    public Integer getOvertimeDay() {
        return overtimeDay;
    }

    public void setOvertimeDay(Integer overtimeDay) {
        this.overtimeDay = overtimeDay;
    }
}
