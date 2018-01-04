<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"                 prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"                  prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"            prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <%
        String basePath=request.getContextPath();
    %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta name="keywords" content="">
    <meta name="" content="">
    <title>反馈列表</title>
    <link type="text/css" rel="stylesheet" href="${basePath}/static/assets/css/css.css">
    <style type="text/css">
        .buttonDiv select{
            border: 2px;
            border-color: #888 transparent transparent transparent;
            padding: 15px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 10px;
            cursor: pointer;
            background: white;
            vertical-align: inherit;
        }
        .buttonDiv input{
            background-color: #4CAF50; /* Green */
            border: none;
            color: white;
            padding: 15px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
        }
        .buttonDiv span{
            border: 1px;
            padding: 15px 10px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<section class="container changeApproval">
    <div class="buttonDiv">
        <form name="queryForm" action="/repair/list" method="post" id="queryForm">
            <span>学校：</span>
            <select name="schoolNo" >
                <option value="">--请选择--</option>
                <c:forEach var="item" items="${schoolList}">
                    <option value="${item.schoolNo}" <c:if test="${vo.schoolNo==item.schoolNo}">selected</c:if>>${item.schoolName}</option>
                </c:forEach>
            </select>
            <input value="查询" type="submit">
        </form>
    </div>
    <!--筛选-->
    <%--<div class="selectTab">
        <ul>
            <form name="queryForm" action="/repair/list" method="post" id="queryForm">
            <li>
                <select name="schoolNo">
                    <option>--请选择--</option>
                    <c:forEach var="item" items="${schoolList}">
                        <option value="${item.schoolNo}">${item.schoolName}</option>
                    </c:forEach>
                </select>
            </li>
            <li><input value="查询" type="submit"></li>
            </form>
        </ul>
    </div>--%>
    <div id="listDiv">
    <c:forEach var="item" items="${questionList}">
        <div class="itemGroup">
                <ul style="margin-left: 10px;">
                    <li><span>问题编号</span><p>${item.questionNo}</p></li>
                    <li><span>问题描述</span><p>${item.note}</p></li>
                    <li><span>反馈时间</span><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/> </li>
                    <li><span>申请人</span>${item.userName}</li>
                    <li><span>状态</span>
                        <c:if test="${item.state==10}">已创建</c:if>
                        <c:if test="${item.state==20}">学校同意</c:if>
                        <c:if test="${item.state==30}">修复上报</c:if>
                        <c:if test="${item.state==40}">已修复</c:if>
                        <c:if test="${item.state==99}">已废除</c:if>
                    </li>
                    <li>
                        <div class="buttonDiv">
                        <input type="button" value="详情" onclick="window.location.href='/repair/detail?questionNo=${item.questionNo}'">
                        <input type="button" value="修复上报" onclick="window.location.href='/repair/toRepair?questionNo=${item.questionNo}'">
                        </div>
                    </li>
                </ul>
        </div>
    </c:forEach>
    </div>
    <!--筛选结果-->
</section>
<script type="text/javascript" src="${basePath}/static/assets/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${basePath}/static/assets/js/public.js"></script>
<script type="text/javascript" src="${basePath}/static/assets/js/commons.js"></script>

<script type="text/javascript">
</script>
</body>
</html>