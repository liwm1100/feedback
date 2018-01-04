<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta name="keywords" content="">
    <meta name="" content="">
    <title>上报</title>
    <link type="text/css" rel="stylesheet" href="${basePath}/static/assets/css/css.css">
    <script type="text/javascript" src="${basePath}/static/assets/js/jquery-1.8.3.min.js"></script>
    <style type="text/css">
        .itemGroupTable ul li input,select,textarea {
            float: left;
            font-size: 12px;
            font-family: "微软雅黑";
            width: 100%;
            border: 1px solid #d4d4d4;
            height: 28px;
            line-height: 28px;
            padding: 0 6px;
            color: #242a3f;
        }
    </style>
</head>
<body>
<section class="container taskDetail">
    <h2 class="subTitle">基本信息</h2>
    <form action="/save" name="saveform" id="saveform" method="post" enctype="multipart/form-data">
        <input type="hidden" name="token" value="${token}">
        <input type="hidden" name="questionNo" id="questionNo" value="${questionNo}">
        <input type="hidden" name="resultId" value="${result.id}">
        <div class="itemGroupTable">
        <ul>
            <li>
                <label>是否同意</label>
                <p>
                   <input type="text" name="adminState" id="adminState" value="${result.adminState}">
                </p>
            </li>
            <li>
                <label>预计时间</label>
                <p>
                    <input type="date" name="bookDate" id="bookDate" value="<fmt:formatDate value='${result.bookDate}' pattern='yyyy-MM-dd'/>">
                </p>
            </li>
            <li>
                <label>故障检测</label>
                <p>
                    <input type="text" name="questionWhere" id="questionWhere" value="${result.questionWhere}">
                </p>
            </li>
            <li>
                <label>维修结果</label>
                <p>
                    <input type="text" name="repairResult" id="repairResult" value="${result.repairResult}">
                </p>
            </li>
            <li>
                <label>更换配件</label>
                <p>
                    <input type="text" name="repairChange" id="repairChange" value="${result.repairChange}">
                </p>
            </li>
            <li>
                <label>修复时间</label>
                <p>
                    <input type="date" name="repairDate" id="repairDate" value="<fmt:formatDate value='${result.repairDate}' pattern='yyyy-MM-dd'/>">
                </p>
            </li>
            <li>
                <label>价格</label>
                <p>
                    <input type="text" name="repairPrice" id="repairPrice" value="${result.repairPrice}">
                </p>
            </li>
            <li>
                <label>维修图片</label>
                <p>
                    <input class="file" type="file" name="file">
                </p>
            </li>
            <li>
                <label></label>
                <p>
                    <input type="button" onclick="save()" value="提  交">
                </p>
            </li>
        </ul>
    </div>
    </form>
    <c:if test="${result.repairPicUrl != null}">
    <h2 class="subTitle">维修图片</h2>
    <div class="changeLog">
        <div class="itemGroup">
            <ul>
                <li class="imgLst">
                    <ul>
                        <li><a href="${result.repairPicUrl}" target="_blank"> <img src="${result.repairPicUrl}"></a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
    </c:if>
</section>
<style type="text/css">
    .mask{
        width: 100%;
        height: 100%;
        background-color: #000;
        opacity: .8;
        position: fixed;
        left: 0;
        top: 0;
        z-index: 1000;
    }
    .animationTipBox{
        font-size: 14px;
        width: 37px;
        height: 37px;
        border-radius: 8px;
        position: fixed;
        left: 50%;
        top: 50%;
        z-index: 1001;
        -webkit-animation: alertAnimation .3s ease-in-out 0 1;
        -moz-animation: alertAnimation .3s ease-in-out 0 1;
        animation: alertAnimation .3s ease-in-out 0 1;
    }
</style>
<div class="mask" style="display: none"></div>
<div class="animationTipBox" style="display: none">
    <img src="${basePath}/static/img/mask.gif">
</div>
</body>
<script type="text/javascript">
    function save() {
        $(".mask").show();
        $(".animationTipBox").show();
        var formData = new FormData($("#saveform")[0]);
        $.ajax({
            url: "/repair/save",
            type : "POST",
            data: formData,
            cache: false,
            processData: false,
            contentType: false,
            success: function (data) {
                if (data.msg == "relogin"){
                    $(".mask").hide();
                    $(".animationTipBox").hide();
                    window.location.href="/repair/toLogin";
                }
                if (data.msg == "fail"){
                    alert("提交失败，联系管理员");
                }
                if (data.msg == "success"){
                    alert("提交成功");
                    window.location.href="/repair/list";
                }
            }
        });
    }
</script>
</html>