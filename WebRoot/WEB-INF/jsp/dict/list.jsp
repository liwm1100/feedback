<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <jsp:include page="../includes/headjs.jsp"/>
    <title>字典-列表</title>
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
            当前位置：<a href="#">数据字典</a> > <a href="/admin/dict/list">列表</a>
        </div>
        <!--查询-->
		<form action="/admin/dict/list" method="post" name="frm" accept-charset="utf-8">
            <div class="query">
                <div class="queryL queryLH">
                    <p>
                        <span>问题编号：</span>
                        <input name="typeCode" value="">
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
             <a href="/admin/dict/toAdd" >添加</a>
        </div>
        <table class="tablelest" border="0" cellspacing="0" cellpadding="0" >
            <tbody>
            <tr class='table_listTr' >
                <th scope="col">序号</th>
                <th scope="col">编号</th>
                <th scope="col">名称</th>
                <th scope="col">状态</th>
                <th scope="col">操作</th>
            </tr>
            <c:forEach var="item" items="${page.list}" varStatus="index">
                <tr>
                    <td>${index.index+1}</td>
                    <td>${item.typeCode}</td>
                    <td>${item.typeName}</td>
                    <td>${item.state}</td>
                    <td>
                        <a href="/admin/dict/toEdit?typeId=${item.id}">修改</a>
                        <a href="javascript:void(0)" onclick="deleteDict(${item.id})">删除</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div class="paging">
             <jsp:include page="../page/page.jsp"/>
        </div>
    </div>
  </div>
  <!--所有内容框结束-->
<script type="text/javascript">
    function deleteDict(id) {
        if (confirm("确定要删除吗")){
            $.ajax({
                type : "POST",
                url : App.ctx + "/admin/dict/delete",
                data : {typeId:id},
                dataType : "json",
                async : false,
                success : function(data) {
                    if (data.msg == "success") {
                        alert("删除成功！");
                        location.href="/admin/dict/list";
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