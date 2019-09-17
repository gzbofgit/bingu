<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@include file="top.jsp"%>
<div class="col-lg-10" id="right">
    <ul>
        <li>请选择操作</li>
    </ul>
    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel"
         style="margin:0px 200px">
        <!-- 圆圈指示符 -->
        <ol class="carousel-indicators" >
            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
            <li data-target="#carousel-example-generic" data-slide-to="3"></li>
            <li data-target="#carousel-example-generic" data-slide-to="4"></li>
        </ol>
        <!-- 图片容器  -->
        <div class="carousel-inner" role="listbox">
            <div class="item active">
                <img src="/static/image/322813.jpg" style="max-width:1000px;max-height:480px;" alt="..." class="img-responsive">
                <div class="carousel-caption">
                    ...
                </div>
            </div>

            <div class="item">
                <img src="/static/image/322514.jpg" style="max-width:1000px;max-height:480px;" alt="..." class="img-responsive">
                <div class="carousel-caption">
                    ...
                </div>
            </div>

            <div class="item">
                <img src="/static/image/322371.jpg" style="max-width:1000px;max-height:480px;" alt="..." class="img-responsive">
                <div class="carousel-caption">
                    ...
                </div>
            </div>
            <div class="item">
                <img src="/static/image/323300.jpg" style="max-width:1000px;max-height:480px;" alt="..." class="img-responsive">
                <div class="carousel-caption">
                    ...
                </div>
            </div>
            <div class="item">
                <img src="/static/image/323301.jpg" style="max-width:1000px;max-height:480px;" alt="..." class="img-responsive">
                <div class="carousel-caption">
                    ...
                </div>
            </div>
        </div>
        <!-- 左右控制符 -->
        <!--  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
              <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
              <span class="sr-only">Previous</span>
          </a>
          <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
              <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
              <span class="sr-only">Next</span>
          </a>-->
    </div>
</div>
<%@include file="foot.jsp" %>

