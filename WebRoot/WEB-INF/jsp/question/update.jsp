<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>修改</title>
    <meta name="keywords" content="">
    <jsp:include page="../includes/headjs.jsp"/>
    <style type="text/css">
        .modify p.popW100 {
            float: left;
            width: 100%;
        }
        .modify p .fileTouxiang {
            display: block;
            float: left;
            width: 100%;
            overflow: hidden;
            padding: 13px 0 13px 101px;
        }
    </style>
</head>

<body>
<jsp:include page="../includes/head.jsp" />
<jsp:include page="../includes/left.jsp" />
    <!--右侧内容-->
    <div class="contentText">
        <!--当前位置-->
        <div class="location">
            当前位置：<a href="#">修复上报</a>
        </div>
        <!--操作按钮-->
        <div class="operation">
            <input type="button" onclick="saveQuestion()" value="保存">
           <%-- <a>删除</a>
            <a>取消</a>--%>
        </div>
        <!--添加修改-->
        <div class="modify">
            <form action="/admin/question/save" name="saveform" id="saveform" method="post" enctype="multipart/form-data">
                <input type="hidden" name="resultId" id="resultId" value="${questionResult.id}">
                <input type="hidden" name="questionNo" id="questionNo" value="${questionNo}">
                <p >
                    <span>是否同意：</span>
                    <input type="text" name="adminState" id="adminState" value="${questionResult.adminState}">
                </p>
                <p><p><p>
                <p>
                    <span>预计时间：</span>
                    <input type="text" name="bookDate" id="bookDate" value="<fmt:formatDate value='${questionResult.bookDate}' pattern='yyyy-MM-dd'/>"
                           onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate" >
                </p>
                <p><p><p>
                <p>
                    <span>故障检测：</span>
                    <input type="text" name="questionWhere" id="questionWhere" value="${questionResult.questionWhere}">
                </p>
                <p><p><p>
                <p>
                    <span>维修结果：</span>
                    <input type="text" name="repairResult" id="repairResult" value="${questionResult.repairResult}">
                </p>
                <p><p><p>
                <p>
                    <span>更换配件：</span>
                    <input type="text" name="repairChange" id="repairChange" value="${questionResult.repairChange}">
                </p>
                <p><p><p>
                <p>
                    <span>修复时间：</span>
                    <input type="text" name="repairDate" id="repairDate" value="<fmt:formatDate value='${questionResult.repairDate}' pattern='yyyy-MM-dd'/>"
                           onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate" >
                </p>
                <p><p><p>
                <p>
                    <span>价格：</span>
                    <input type="text" name="repairPrice" id="repairPrice" value="${questionResult.repairPrice}">
                </p>
                <p><p><p>
                <p class="popW100">
                    <span>维修图片</span>
                    <b class="inputFile">
                        <input class="file" type="file" name="file" id="imgUrl">
                        <a>选取文件</a>
                        <i>未选择文件</i>
                        <strong>图片文件（不能超过1024k）</strong>
                    </b>
                    <em class="fileTouxiang">
                        <c:if test="${questionResult.repairPicUrl != null}">
                            <a href="${questionResult.repairPicUrl}?x=<%=Math.random()%>" target="_blank">
                                <img src="${questionResult.repairPicUrl}?x=<%=Math.random()%>" style="float:left;margin-right:20px;" id="repairPicUrl" width="80px" height="80px">
                            </a>
                        </c:if>
                        <c:if test="${questionResult.repairPicUrl == null}">
                            <img src="${basePath}/static/img/ico/touxiang.png" style="float:left;margin-right:20px;" id="repairPicUrl" width="80px" height="80px">
                        </c:if>
                    </em>
                </p>
            </form>
        </div>
    </div>
</body>
<script type="text/javascript">
    function saveQuestion() {
        $("#saveBtn").addClass("btnClass");
        var formData = new FormData($("#saveform")[0]);
        $.ajax({
            url: "/admin/question/save",
            type : "POST",
            data: formData,
            cache: false,
            processData: false,
            contentType: false,
            success: function (data) {
                if (data.msg=="success") {
                    alert("成功");
                    location.href="/admin/question/list";
                }else{
                    alert(data.msg);
                }
            }
        });
    }
</script>
</html>