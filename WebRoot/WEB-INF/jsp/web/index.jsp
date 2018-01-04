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
</head>
<body>
<section class="container changeApproval">

    <!--筛选-->
    <div class="selectTab">
        <ul>
            <form name="queryForm" method="post" id="queryForm">
                <input type="hidden" name="state" id="state">
                <input type="hidden" name="sort" id="sort">
            </form>
            <li>
                <a class="active" href="javascript:void('')"><span style="width: 50%;">全部</span><i class="iconFold">&nbsp;</i></a>
                <ol>
                    <li class="active">全部</li>
                    <li onclick="query('10','state')">已创建</li>
                    <li onclick="query('20','state')">学校同意</li>
                    <li onclick="query('30','state')">修复上报</li>
                    <li onclick="query('40','state')">已修复</li>
                </ol>
            </li>
            <li><a href="javascript:void('')" onclick="query('0','date')">申请时间<i class="iconDown">&nbsp;</i></a></li>
            <li><a href="/toAdd">反馈问题</a></li>
        </ul>
    </div>
    <div id="listDiv">
    <c:forEach var="item" items="${questionList}">
        <div class="itemGroup">
            <a href="/detail?questionNo=${item.questionNo}">
                <ul>
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
                </ul>
            </a>
        </div>
    </c:forEach>
    </div>
    <!--筛选结果-->
</section>
<script type="text/javascript" src="${basePath}/static/assets/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${basePath}/static/assets/js/public.js"></script>
<script type="text/javascript" src="${basePath}/static/assets/js/commons.js"></script>

<script type="text/javascript">
    var state = "";
    var dateSort = "desc";
    var dateSortFlag = true;
    function query(data,type) {
        if(type == 'state'){
            state = data;
        }
        if(type == 'date'){
            dateSortFlag = !dateSortFlag;
        }
        if(dateSortFlag){
            dateSort = "desc";
        }else{
            dateSort = "asc";
        }
        $("#state").val(state);
        $("#sort").val(dateSort);
        $.ajax({
            url: "/getQuestionList",
            type : "POST",
            data: $("#queryForm").serialize(),
            dataType:"json",
            success: function (data) {
                $("#listDiv").html("");
                var str = "";
                if (data!=null){
                    for (var i=0;i<data.length;i++){
                        var date = (new Date(data[i].createTime)).Format("yyyy-MM-dd hh:mm:ss");
                        var state = "";
                        if (data[i].state == 10){
                            state = "已创建";
                        }
                        if (data[i].state == 20){
                            state = "学校同意";
                        }
                        if (data[i].state == 40){
                            state = "已修复";
                        }
                        if (data[i].state == 99){
                            state = "已废除";
                        }
                        str += "<div class='itemGroup'>"+
                                "<a href='/detail?questionNo="+ data[i].questionNo +"'>"+
                                "<ul>"+
                                "<li><span>问题编号</span><p>"+ data[i].questionNo +"</p></li>"+
                                "<li><span>问题描述</span><p>"+ data[i].note +"</p></li>"+
                                "<li><span>反馈时间</span>"+ date +"</li>"+
                                "<li><span>申请人</span>"+ data[i].userName +"</li>"+
                                "<li><span>状态</span>"+ state +"</li>"+
                                "</ul>"+
                                "</a>"+
                                "</div>";
                    }
                    $("#listDiv").html(str);
                }
            }
        });
    }
</script>
</body>
</html>