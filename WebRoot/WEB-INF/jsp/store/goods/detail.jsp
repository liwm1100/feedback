<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>详情</title>
    <meta name="keywords" content="">
    <jsp:include page="../../includes/headjs.jsp"/>
</head>

<body>
<jsp:include page="../../includes/head.jsp" />
<jsp:include page="../../includes/left.jsp" />
    <!--右侧内容-->
    <div class="contentText">
        <!--当前位置-->
        <div class="location">
            当前位置：<a href="#">详情</a>
        </div>
        <div class="operation">
            <a href="/admin/goods/list">返回</a>
        </div>
        <!--添加修改-->
        <div class="modify">
                <p class="popW50">
                    <span>产品名称：</span>
                    ${goods.goodsName}
                </p>
                <p class="popW50">
                    <span>产品编码：</span>
                    ${goods.goodsNo}
                </p>
                <p class="popW50">
                    <span>单位：</span>
                    ${goods.unit}
                </p>
                <p class="popW50">
                    <span>价格：</span>
                    ${goods.price}
                </p>
                <p class="popW50">
                    <span>创建时间：</span>
                    <fmt:formatDate value="${goods.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </p>
                <p class="popW50">
                    <span>创建人：</span>
                    ${goods.createName}
                </p>
                <p class="popW50">
                    <span>备注：</span>
                    ${goods.remark}
                </p>
        </div>
    </div>
</body>
</html>