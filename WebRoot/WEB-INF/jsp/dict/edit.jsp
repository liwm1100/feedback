<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <jsp:include page="../includes/headjs.jsp"/>
    <title>派车单-列表</title>
    <style type="text/css">
        .query {
            margin: 0 auto;
            float: left;
            width: 100%;
            padding: 0 0 4px;
            margin-bottom: 16px;
            border-bottom: 1px dashed #d4d4d4;
        }
        .query .queryL {
            float: left;
            overflow: hidden;
            width: auto;
            max-width: 720px;
        }
        .query .queryL P {
            float: left;
            font-size: 12px;
            width: 240px;
            height: 28px;
            line-height: 28px;
            margin-bottom: 14px;
        }
        .query .queryL P span {
            float: left;
            text-align: right;
            width: 72px;
            color: #242a3f;
            margin-right: 12px;
        }
        .query .queryL P span i {
            font-style: normal;
            font-weight: normal;
            font-size: 14px;
            color: #ff1818;
            margin-right: 5px;
        }
        .query .queryL P input {
            float: left;
            font-size: 12px;
            font-family: "微软雅黑";
            width: 146px;
            border: 1px solid #d4d4d4;
            height: 28px;
            line-height: 28px;
            padding: 0 6px;
            color: #242a3f;
        }
        .query .queryL P select {
            float: left;
            width: 146px;
            border: 1px solid #d4d4d4;
            height: 28px;
            line-height: 28px;
            padding: 0 6px;
            color: #242a3f;
            font-family: "微软雅黑";
        }
        .query .queryL P label {
            color: #242a3f;
        }
        .query .queryL.queryLH {
            height: 32px;
        }
        .query .queryR {
            float: left;
        }
    </style>
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
            当前位置：<a href="#">数据字典</a> >
        </div>
        <form id="addForm" method="post">
            <table id="operatorTable" border="0" cellspacing="0" cellpadding="0" style="margin:auto auto;width:840px;">
                <tbody>
                <tr>
                    <td>
                        <div class="query" style="float:left; overflow:visible;">
                            <div class="queryL queryLH" style="overflow: visible;max-width: 840px;">
                                <p style="width:270px; position:relative;overflow:visible;">
                                    <span><i>*</i>类型名称:</span>
                                    <input type="hidden" name="typeId" value="${type.id}">
                                    <input type="text" style="width:140px;" value="${type.typeName}" name="typeName" id="typeName" class="{required:true,maxlength:32}">
                                </p>
                                <p style="width:270px; position:relative;overflow:visible;">
                                    <span><i>*</i>类型编码:</span>
                                    <input type="text" style="width:140px;" value="${type.typeCode}" name="typeCode" id="typeCode" class="{required:true,maxlength:32,isEng:true}">
                                </p>
                            </div>
                        </div>
                    </td>
                </tr>
                <c:forEach var="item" items="${dataList}" varStatus="index">
                    <tr>
                        <td>
                            <div class="query" style="float:left; overflow:visible;">
                                <div class="queryL queryLH" style="overflow: visible;max-width: 840px;">
                                    <p style="width:270px; position:relative;overflow:visible;">
                                        <span><i>*</i>数据名称:</span>
                                        <input type="hidden" name="ids" value="${item.id}">
                                        <input type="text" style="width:140px;" value="${item.name}" name="names" id="name${index.index}" class="{required:true,maxlength:32}">
                                    </p>
                                    <p style="width:270px; position:relative;overflow:visible;">
                                        <span><i>*</i>数据编码:</span>
                                        <input type="text" style="width:140px;" value="${item.code}" name="codes" id="code${index.index}" class="{required:true,maxlength:32,isEng:true}">
                                    </p>
                                    <p style="width:170px; position:relative;overflow:visible;">
                                        <input class="queryAn" style="width:80px;" type="button" value="＋" onclick="addRow('operatorTable');">
                                        <input class="queryAn" style="width:80px;margin-left:10px;" type="button" value="－" onclick="deleteRow(this);">
                                    </p>
                                </div>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div style="margin:0 auto;text-align:center;">
                <input style="background-color:#1d8bd8;height:25px;width:80px;border: medium none;border-radius: 5px;color: #fff;cursor: pointer;" type="button"  onclick="submitForm();" value="添加">
            </div>
        </form>
    </div>
<script type="text/javascript">
    function submitForm() {
        $.ajax({
            type : "POST",
            url : App.ctx + "/admin/dict/edit",
            data : $("#addForm").serialize(),
            dataType : "json",
            async : false,
            success : function(data) {
                if (data.msg == "success") {
                    alert("添加成功！");
                    location.href="/admin/dict/list";
                }else{
                    alert(data.msg);
                }
            }
        });
    }
    function addRow(tableId){
        var cloner = $("#"+tableId+" tr:last-child").clone(true);
        cloner.find("input[name='ids']").val("0")
        cloner.appendTo($("#"+tableId));
        $("#"+tableId+" tr:last-child").find("input[type='text']").each(function () {
            if($(this).attr("name") != 'positions'){
                $(this).val("");
            }else{
                $(this).val("99");
            }
        });
        /*$("#"+tableId).find("input[name='code']").each(function(i){
            $(this).attr("id",$(this).attr("name")+i);
        });*/
        $("#"+tableId).find("input[name='name']").each(function(i){
            $(this).attr("id",$(this).attr("name")+i);
        });
        $("#"+tableId).find("input[name='code']").each(function(i){
            $(this).attr("id",$(this).attr("name")+i);
            $(this).focus();
        });

    }

    function deleteRow(row){
        if($(row).parents("table:eq(0)").find("tr").length<=2){
            alert("再删就没了!");
            return;
        }
        $(row).parents("tr:eq(0)").remove();
    }
    function save() {

    }
</script>
  </div>
  <!--所有内容框结束-->
</body>
</html>