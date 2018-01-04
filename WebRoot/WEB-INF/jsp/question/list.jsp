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
    <jsp:include page="../includes/headjs.jsp"/>
    <script type="text/javascript" src="${basePath}/static/assets/js/commons.js"></script>
    <title>问题-列表</title>
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
            当前位置：<a href="#">问题管理</a> > <a href="">列表</a>
        </div>
        <!--查询-->
		<form action="/admin/question/list" method="post" name="frm" id="frm" accept-charset="utf-8">
            <div class="query">
                <div class="queryL ">
                    <p>
                        <span>问题编号：</span>
                        <input name="questionNo" value="${queryVo.questionNo}">
                    </p>
                    <p>
                        <span>学校名称：</span>
                        <input name="schoolName" value="${queryVo.schoolName}">
                    </p>
                    <p>
                        <span>状态：</span>
                        <select name="state">
                            <option value="">--请选择--</option>
                            <option value="10"<c:if test="${queryVo.state == 10}">selected</c:if>>已创建</option>
                            <option value="20"<c:if test="${queryVo.state == 20}">selected</c:if>>学校同意</option>
                            <option value="20"<c:if test="${queryVo.state == 30}">selected</c:if>>修复上报</option>
                            <option value="40"<c:if test="${queryVo.state == 40}">selected</c:if>>已修复</option>
                            <option value="99"<c:if test="${queryVo.state == 99}">selected</c:if>>已废除 </option>
                        </select>
                    </p>
                    <p>
                        <span>是否同意：</span>
                        <input name="adminState" value="${queryVo.adminState}">
                    </p>
                    <p>
                        <span>上报类型：</span>
                        <select name="reportType">
                            <option value="">--请选择--</option>
                            <c:forEach var="item" items="${reportTypeList}">
                                <option value="${item.code}" <c:if test="${item.code == queryVo.reportType}">selected</c:if>>${item.name}</option>
                            </c:forEach>
                        </select>
                    </p>
                    <p>
                        <span></span>
                    </p>
                    <p>
                        <span>创建时间：</span>
                        <input name="dateStart" value="<fmt:formatDate value="${queryVo.dateStart}" pattern="yyyy-MM-dd"/>"onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly>
                    </p>
                    <p>
                        <span>~</span>
                        <input name="dateEnd" value="<fmt:formatDate value="${queryVo.dateEnd}" pattern="yyyy-MM-dd"/>"onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate" readonly>
                    </p>
               </div>
              <div class="queryR">
                    <input class="bton backgreen" type="submit" value="查询">
              </div>
            </div>
        </form>
        <!--操作按钮-->
        <!--操作按钮-->
        <div class="operation">
             <a href="javascript:void(0)" onclick="exportList()">导出</a>
             <c:if test="${userCurrent.type==1}">
                 <a href="javascript:void(0)" onclick="deleteQuestion()">删除</a>
             </c:if>
        </div>
        <table class="tablelest" border="0" cellspacing="0" cellpadding="0" >
            <tbody>
            <tr class='table_listTr' >
                <th scope="col">序号</th>
                <th scope="col">选择</th>
                <th scope="col">问题编号</th>
                <th scope="col">学校</th>
                <th scope="col">问题描述</th>
                <th scope="col">状态</th>
                <th scope="col">创建时间</th>
                <th scope="col" width="25%">操作</th>
            </tr>
            <c:forEach var="item" items="${page.list}" varStatus="index">
                <tr>
                    <td>${index.index+1}</td>
                    <td><input type="checkbox" name="questionIds" value="${item.id}"></td>
                    <td>${item.questionNo}</td>
                    <td>${item.schoolName}</td>
                    <td>${item.note}</td>
                    <td>
                        <c:if test="${item.state==10}">已创建</c:if>
                        <c:if test="${item.state==20}">学校同意</c:if>
                        <c:if test="${item.state==30}">修复上报</c:if>
                        <c:if test="${item.state==40}">已修复</c:if>
                        <c:if test="${item.state==99}">已废除</c:if>
                    </td>
                    <td><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
                    <td>
                        <a href="/admin/question/showDetail?questionNo=${item.questionNo}" >查看</a>
                        <a href="javascript:void(0);" onclick="auditSchool('${item.questionNo}')">学校审批</a>
                        <a href="/admin/question/toUpdate?questionNo=${item.questionNo}" >后台修改</a>
                        <%--<a href="javascript:void(0);" onclick="auditClass('${item.questionNo}')">后台修改</a>--%>
                        <a href="javascript:void(0);" onclick="confirmRepair('${item.questionNo}')">确认修复</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div class="paging">
             <jsp:include page="../page/page.jsp"/>
        </div>
    </div>

    <!--所有弹出内容区-->
    <div class="popTc">
        <!--弹窗-->
        <div id="t01" class="popCent" style="width: 300px;">
            <!--弹窗头部-->
            <div class="pophead" >
                <div id="addFormHead">学校审批</div>
                <i><img src="${basePath}/static/img/ico/popesc.png"></i>
            </div>
            <!--弹窗内容-->
            <form id="schoolForm" method="post">
            <div class="popText" style="width: 300px;">
                <p>
                    <span>备注：</span>
                    <input type="hidden" name="questionNo">
                    <textarea name="schoolNote" style="width: 250px;"></textarea>
                </p>
            </div>
            </form>
            <!--镗床提交按钮-->
            <div class="popAn">
                <em id="addErrorView"></em>
                <input type="button" onclick="refuseSchool()" style="background-color: #1d8bd8;"  value="不同意">
                <input type="button" onclick="agreeSchool()"  style="background-color: #1d8bd8;margin-left: 10px;" value="同意">
            </div>
        </div>
        <!--弹窗-->
        <%--<div id="t02" class="popCent" style="width: 300px;">
            <!--弹窗头部-->
            <div class="pophead" >
                <div id="addFormHead2">修复上报</div>
                <i><img src="${basePath}/static/img/ico/popesc.png"></i>
            </div>
            <!--弹窗内容-->
            <form action="/admin/question/save" name="saveform" id="saveform" method="post" enctype="multipart/form-data">
            <input type="hidden" name="resultId" id="resultId">
            <input type="hidden" name="questionNo" id="questionNo">
            <div class="popText" style="width: 300px;">
                <p >
                    <span>是否同意：</span>
                    <input type="text" name="adminState" id="adminState">
                </p>
                <p>
                    <span>预计时间：</span>
                    <input type="text" name="bookDate" id="bookDate"
                           onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate" >
                </p>
                <p>
                    <span>故障检测：</span>
                    <input type="text" name="questionWhere" id="questionWhere">
                </p>
                <p>
                    <span>维修结果：</span>
                    <input type="text" name="repairResult" id="repairResult">
                </p>
                <p>
                    <span>更换配件：</span>
                    <input type="text" name="repairChange" id="repairChange">
                </p>
                <p>
                    <span>修复时间：</span>
                    <input type="text" name="repairDate" id="repairDate"
                           onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate" >
                </p>
                <p>
                    <span>价格：</span>
                    <input type="text" name="repairPrice" id="repairPrice">
                </p>
                <p class="popW100">
                    <span>维修图片</span>
                    <b class="inputFile">
                        <img src="${basePath}/static/img/ico/touxiang.png" style="float:left;margin-right:20px;" id="repairPicUrl" width="80px" height="80px">
                        <input class="file" type="file" name="file" id="imgUrl">
                        <a>选取文件</a>
                        <i>未选择文件</i>
                        <strong>图片文件（不能超过1024k）</strong>
                    </b>
                </p><p></p>
            </div>

            <!--镗床提交按钮-->
            <div class="popAn">
                <em id="addErrorView2"></em>
                <input id="saveBtn" type="button" onclick="saveQuestion()" style="background-color: #1d8bd8;" value="保存">
            </div>
            </form>
        </div>--%>
    </div>
    <!--弹窗结束-->

  </div>
  <!--所有内容框结束-->
<style type="text/css">
    .popTc .popCent .popAn input.btnClass{
        background-color: #cecece;
    }
</style>
<script type="text/javascript">
    $(function () {
        $("#imgUrl").change(function(event) {
            var img=$("#repairPicUrl")[0];
            var files=event.target.files,file;
            if(files&&files.length>0) {
                file=files[0];
                try {
                    var fileReader=new FileReader();
                    fileReader.onload=function(event) {
                        img.src=event.target.result;
                    };
                    fileReader.readAsDataURL(file);
                } catch(e) {
                    var error=$("#addErrorView2");
                    if(error) {
                        error.innerHTML="您的浏览器不支持图片预览！";
                    }
                }
            }
        });
    })
    function auditSchool(questionNo) {
        poptc("t01");
        $("#schoolForm").find("input[name='questionNo']").val(questionNo);
        $("#schoolForm").find("input[name='schoolNote']").val("");
    }
    function auditClass(questionNo) {
        $("#saveform").find("input[name='questionNo']").val(questionNo);
        poptc("t02");
        $.ajax({
            type : "POST",
            url : "/admin/question/getQuestionResult",
            data : {questionNo:questionNo},
            dataType : "json",
            async : false,
            success : function(data) {
                var question = data.data;
                if (question!=null) {
                    for(var k in question){
                        $("#saveform").find("[id='"+k+"']").val(question[k]);
                        $("#resultId").val(question.id);
                        $("#bookDate").val((new Date(question.bookDate)).Format("yyyy-MM-dd"));
                        $("#repairDate").val((new Date(question.repairDate)).Format("yyyy-MM-dd"));
                        $("#repairPicUrl").attr("src",question.repairPicUrl);
                    }
                }
            }
        });
    }
    function confirmRepair(questionNo) {
        if (confirm("确定要完成修复吗？")){
            $.ajax({
                type : "POST",
                url : "/admin/question/confirmRepair",
                data : {questionNo:questionNo},
                dataType : "json",
                async : false,
                success : function(data) {
                    if (data.msg=="success") {
                        alert("成功");
                        location.reload(true);
                    }else{
                        alert(data.msg);
                    }
                }
            });
        }
    }
    
    function agreeSchool() {
        $.ajax({
            type : "POST",
            url : "/admin/question/agreeSchool",
            data : $("#schoolForm").serialize(),
            dataType : "json",
            async : false,
            success : function(data) {
                if (data.msg=="success") {
                    alert("成功");
                    location.reload(true);
                }else{
                    alert(data.msg);
                }
            }
        });
    }
    function refuseSchool() {
        $.ajax({
            type : "POST",
            url : "/admin/question/refuseSchool",
            data : $("#schoolForm").serialize(),
            dataType : "json",
            async : false,
            success : function(data) {
                if (data.msg=="success") {
                    alert("成功");
                    location.reload(true);
                }else{
                    alert(data.msg);
                }
            }
        });
    }
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
                        location.reload(true);
                    }else{
                        alert(data.msg);
                    }
                }
            });
    }
    function exportList() {
        $("<form action='/admin/question/exportQuestions' method='post'></form>")
                .append($("#frm").find("input").clone())
                .append($("#frm").find("select").clone())
                .appendTo("body")
                .submit();
    }
    function deleteQuestion() {
        if(confirm("确定要删除吗")){
            var ids="";
            $("input[name='questionIds']:checked").each(function () {
                ids += $(this).val()+",";
            });
            if(ids.length<1){
                alert("请选择");
                return
            }
            ids = ids.substring(0,ids.length-1);
            $.ajax({
                type : "POST",
                url : "/admin/question/deleteQuestion",
                data : {ids:ids},
                dataType : "json",
                async : false,
                success : function(data) {
                    if (data.msg=="success") {
                        alert("成功");
                        location.reload(true);
                    }else{
                        alert(data.msg);
                    }
                }
            });
        }
    }
</script>
</body>
</html>