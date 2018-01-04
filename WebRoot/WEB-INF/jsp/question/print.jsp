<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta name="keywords" content="">
    <meta name="" content="">
    <title>详情</title>
    <link type="text/css" rel="stylesheet" href="${basePath}/static/assets/css/css.css">
    <script type="text/javascript" src="${basePath}/static/assets/js/jquery-1.8.3.min.js"></script>
</head>
<body>
<section class="container taskDetail">
    <h2 class="subTitle">基本信息</h2>
    <div class="itemGroupTable">
        <ul>
            <li><label>问题编号</label><p>${question.questionNo}</p></li>
            <li><label>学校</label><p>${question.schoolName}</p></li>
            <li>
                <label>班级</label>
                <p>
                    <c:forEach var="item" items="${classList}">
                        <c:if test="${item.classNo == question.classNo}">
                            ${item.className}
                        </c:if>
                    </c:forEach>
                </p>
            </li>
            <li>
                <label>上报类型</label>
                <p>
                    <c:forEach var="item" items="${reportTypeList}">
                        <c:if test="${item.code == question.reportType}">
                            ${item.name}
                        </c:if>
                    </c:forEach>
                </p>
            </li>
            <li>
                <label>故障类型</label>
                <p>
                    <c:forEach var="item" items="${faultTypeList}">
                        <c:if test="${item.code == question.faultType}">
                            ${item.name}
                        </c:if>
                    </c:forEach>
                </p>
            </li>
            <li>
                <label>故障情况描述</label>
                <p>
                    ${question.note}
                </p>
            </li>
            <li>
                <label>申报人姓名</label>
                <p>
                    ${question.userName}
                </p>
            </li>
            <li>
                <label>申报人电话</label>
                <p>
                    ${question.userPhone}
                </p>
            </li>
            <li>
                <label>状态</label>
                <p>
                    <c:if test="${question.state==10}">已创建</c:if>
                    <c:if test="${question.state==20}">学校同意</c:if>
                    <c:if test="${question.state==40}">已修复</c:if>
                    <c:if test="${question.state==99}">已废除</c:if>
                </p>
            </li>
        </ul>
    </div>
    <h2 class="subTitle">反馈图片</h2>
    <div class="changeLog">
        <div class="itemGroup">
            <ul>
                <li class="imgLst">
                    <ul>
                        <li><a href="${question.picUrl}" target="_blank"> <img src="${question.picUrl}"></a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</section>
</body>
<script type="text/javascript">
    $(function () {
        window.print();
    })
</script>
</html>