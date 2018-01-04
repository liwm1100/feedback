<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <jsp:include page="../../includes/headjs.jsp"/>
    <title>单位列表</title>
</head>
<!-- /Head -->
<!-- Body -->
<body>
<jsp:include page="../../includes/head.jsp" />
<jsp:include page="../../includes/left.jsp" />

<!--右侧内容-->
<div class="contentText">
    <!--内容区域-->
    <div class="ifCtext">
        <!--当前位置-->
        <div class="location">
            当前位置：<a href="#">单位管理</a> > <a href="#">列表</a>
        </div>
        <!--查询-->
		<form action="/admin/company/list" method="post" name="frm" accept-charset="utf-8">
            <div class="query">
                <div class="queryL queryLH">
                    <p>
                        <span>单位名称：</span>
                        <input id="nameQuery" name="name" value="${queryVo.name}">
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
             <a href="javascript:void(0)" onclick="addGoodsCompany()">添加</a>
        </div>
        <table class="tablelest" border="0" cellspacing="0" cellpadding="0" >
            <tbody>
            <tr class='table_listTr' >
                <th scope="col">序号</th>
                <th scope="col">单位编号</th>
                <th scope="col">单位名称</th>
                <th scope="col">联系人</th>
                <th scope="col">备注</th>
                <th scope="col">操作</th>
            </tr>
            <c:forEach var="item" items="${page.list}" varStatus="index">
                <tr>
                    <td>${index.index+1}</td>
                    <td>${item.code}</td>
                    <td>${item.name}</td>
                    <td>${item.user}</td>
                    <td>${item.remark}</td>
                    <td>
                        <a href="/admin/company/detail?goodsId=${item.id}">详情</a>
                        <a href="javascript:void(0);" onclick="updateGoodsCompany('${item.id}')">修改</a>
                        <a href="javascript:void(0);" onclick="deleteGoodsCompany('${item.id}')">删除</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div class="paging">
             <jsp:include page="../../page/page.jsp"/>
        </div>
    </div>

    <!--所有弹出内容区-->
    <div class="popTc">
        <!--弹窗-->
        <div id="t01" class="popCent">
            <!--弹窗头部-->
            <div class="pophead" >
                <div id="addFormHead"></div>
                <i><img src="${basePath}/static/img/ico/popesc.png"></i>
            </div>
            <!--弹窗内容-->
            <form id="saveform" method="post">
                <input type="hidden" name="id" id="companyId">
                <div class="popText">
                    <p class="popW50">
                        <span>单位名称：</span>
                        <input type="text" name="name" id="name">
                    </p>
                    <p class="popW50">
                        <span>联系人：</span>
                        <input type="text" name="user" id="user">
                    </p>
                    <p class="popW50">
                        <span>备注：</span>
                        <input type="text" name="remark" id="remark">
                    </p>
                </div>
            </form>
            <!--镗床提交按钮-->
            <div class="popAn">
                <em id="addErrorView"></em>
                <input id="closeBtn" type="button" class="popOneA" value="关闭">
                <input type="button" onclick="save()"class="popOne"  value="保存">
            </div>
        </div>
    </div>
    <!--弹窗结束-->

  </div>
  <!--所有内容框结束-->
<script type="text/javascript">
    function addGoodsCompany() {
        poptc('t01');
        $("#schoolNo").removeAttr("readonly");
        $("#schoolNo").val("");
        $("#schoolName").val("");
    }
    function updateGoodsCompany(id) {
        poptc('t01');
        $("#schoolNo").attr("readonly","readonly");
        $.ajax({
            type : "POST",
            url : "/admin/company/getInfoById",
            data : {goodsId:id},
            dataType : "json",
            async : false,
            success : function(data) {
                if (data.data!=null) {
                    $("#companyId").val(data.data.id);
                    $("#name").val(data.data.name);
                    $("#user").val(data.data.user);
                    $("#remark").val(data.data.remark);
                }
            }
        });
    }
    function save() {
        $.ajax({
            type : "POST",
            url : "/admin/company/addOrUpdate",
            data : $("#saveform").serialize(),
            dataType : "json",
            async : false,
            success : function(data) {
                if (data.msg=="success") {
                   alert("成功！");
                    location.reload(true);
                }else{
                    alert(data.msg);
                }
            }
        });
    }
    function deleteGoodsCompany(id) {
        $.ajax({
            type : "POST",
            url : "/admin/company/delete",
            data : {goodsId:id},
            dataType : "json",
            async : false,
            success : function(data) {
                if (data.msg=="success") {
                    alert("成功！");
                    location.reload(true);
                }else{
                    alert(data.msg);
                }
            }
        });
    }
</script>
</body>
</html>