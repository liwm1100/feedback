<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="expires" content="0">
    <meta name="keywords" content="">
    <meta name="" content="">
    <jsp:include page="../includes/headjs.jsp"/>
    <script type="text/javascript" src="${basePath}/static/assets/js/commons.js"></script>
    <title>问题-详情</title>
</head>
<!-- /Head -->
<!-- Body -->
<body>
<jsp:include page="../includes/head.jsp" />
<jsp:include page="../includes/left.jsp" />

<!--右侧内容-->
<div class="contentText">
    <!--内容区域-->
    <div class="ifCtext">
        <!--当前位置-->
        <div class="location">
            当前位置：<a href="#">问题管理</a> > <a href="">详情</a>
        </div>
        <div class="operation">
            <a href="/admin/question/toPrint?questionNo=${question.questionNo}" target="_blank">打印</a>
        </div>
        <!--查询-->
        <div class="modify">
            <p class="popW100">
                <span>问题编号：</span>
                ${question.questionNo}
            </p>
            <p class="popW100">
                <span>所属学校：</span>
                <c:forEach var="item" items="${schoolList}">
                    <c:if test="${question.schoolNo == item.schoolNo}">
                        ${item.schoolName}
                    </c:if>
                </c:forEach>
            </p>
            <p class="popW100">
                <span>所属班级：</span>
                <c:forEach var="item" items="${classList}">
                    <c:if test="${question.classNo == item.classNo}">
                        ${item.className}
                    </c:if>
                </c:forEach>
            </p>
            <p class="popW100">
                <span>上报类型</span>
                <c:forEach var="item" items="${reportTypeList}">
                    <c:if test="${item.code == question.reportType}">
                        ${item.name}
                    </c:if>
                </c:forEach>
            </p>
            <p class="popW100">
                <span>故障类型</span>
                <c:forEach var="item" items="${faultTypeList}">
                    <c:if test="${item.code == question.faultType}">
                        ${item.name}
                    </c:if>
                </c:forEach>
            </p>
            <p class="popW100">
                <span>问题描述：</span>
                ${question.note}
            </p>
            <p class="popW100">
                <span>申报人姓名：</span>
                ${question.userName}
            </p>
            <p class="popW100">
                <span>申报人电话：</span>
                ${question.userPhone}
            </p>
            <p class="popW100">
                <span>学校意见：</span>
                ${question.schoolNote}
            </p>
            <p class="popW100">
                <span>学校审批时间：</span>
                <fmt:formatDate value="${question.auditTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </p>
            <p class="popW100">
                <span>是否同意：</span>
                ${questionResult.adminState}
            </p>
            <p class="popW100">
                <span>预计时间：</span>
                <fmt:formatDate value="${questionResult.bookDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </p>
            <p class="popW100">
                <span>故障检测：</span>
                ${questionResult.questionWhere}
            </p>
            <p class="popW100">
                <span>维修结果：</span>
                ${questionResult.repairResult}
            </p>
            <p class="popW100">
                <span>更换配件：</span>
                ${questionResult.repairChange}
            </p>
            <p class="popW100">
                <span>修复时间：</span>
                <fmt:formatDate value="${questionResult.repairDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </p>
            <p class="popW100">
                <span>价格：</span>
                ${questionResult.repairPrice}
            </p>
            <p class="popW100">
                <span>问题图片：</span>
                <b class="inputFile">
                    <a href="${question.picUrl}" target="_blank">
                    <img src="${question.picUrl}" style="float:left;margin-right:20px;" width="80px" height="80px">
                    </a>
                </b>
            </p>
            <p class="popW100">
                <span>维修图片</span>
                <b class="inputFile">
                    <a href="${questionResult.repairPicUrl}?x=<%=Math.random()%>" target="_blank">
                      <img src="${questionResult.repairPicUrl}?x=<%=Math.random()%>" style="float:left;margin-right:20px;" id="repairPicUrl" width="80px" height="80px">
                    </a>
                </b>
            </p>
        </div>
    </div>
  </div>
  <!--所有内容框结束-->
</body>
</html>