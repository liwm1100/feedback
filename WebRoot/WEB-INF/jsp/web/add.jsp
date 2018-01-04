<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>任务包详情</title>
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
    <div class="itemGroupTable">
        <ul>
            <input name="schoolNo" value="${school.schoolNo}" type="hidden">
            <li><label>学校</label><p>${school.schoolName}</p></li>
            <li>
                <label>班级</label>
                <p>
                    <select name="classNo">
                        <option>--请选择--</option>
                        <c:forEach var="item" items="${classList}">
                            <option value="${item.classNo}">${item.className}</option>
                        </c:forEach>
                    </select>
                </p>
            </li>
            <li>
                <label>上报类型</label>
                <p>
                    <select name="reportType">
                        <option>--请选择--</option>
                        <c:forEach var="item" items="${reportTypeList}">
                            <option value="${item.code}">${item.name}</option>
                        </c:forEach>
                    </select>
                </p>
            </li>
            <li>
                <label>故障类型</label>
                <p>
                    <select name="faultType">
                        <option>--请选择--</option>
                        <c:forEach var="item" items="${faultTypeList}">
                            <option value="${item.code}">${item.name}</option>
                        </c:forEach>
                    </select>
                </p>
            </li>
            <li>
                <label>故障情况描述</label>
                <p>
                    <textarea name="note"></textarea>
                </p>
            </li>
            <li>
                <label>上传图片</label>
                <p>
                    <input type="file" name="file">
                </p>
            </li>
            <li>
                <label>申报人姓名</label>
                <p>
                    <input type="text" name="userName">
                </p>
            </li>
            <li>
                <label>申报人联系电话</label>
                <p>
                    <input type="text" name="userPhone">
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
            url: "/save",
            type : "POST",
            data: formData,
            cache: false,
            processData: false,
            contentType: false,
            success: function (data) {
                $(".mask").hide();
                $(".animationTipBox").hide();
                if (data.msg == "relogin"){
                    window.location.href="/toAuth";
                }
                if (data.msg == "fail"){
                    alert("提交失败，联系管理员");
                }
                if (data.msg == "success"){
                    alert("提交成功");
                    var questionNo = data.questionNo;
                    window.location.href="/detail?questionNo="+questionNo;
                }
            }
        });
    }
</script>
</html>