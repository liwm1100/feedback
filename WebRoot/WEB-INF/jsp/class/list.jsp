<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <jsp:include page="../includes/headjs.jsp"/>
    <title>班级列表</title>
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
            当前位置：<a href="#">班级列表</a> > <a href="#">列表</a>
        </div>
        <!--查询-->
		<form action="/admin/classes/list" method="post" name="frm" accept-charset="utf-8">
            <div class="query">
                <div class="queryL queryLH">
                    <p>
                        <span>班级名称：</span>
                        <input id="classesNameQuery" name="className" value="${queryVo.className}">
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
             <a href="javascript:void(0)" onclick="addClass()">添加</a>
        </div>
        <table class="tablelest" border="0" cellspacing="0" cellpadding="0" >
            <tbody>
            <tr class='table_listTr' >
                <th scope="col">序号</th>
                <th scope="col">班级编号</th>
                <th scope="col">班级名称</th>
                <th scope="col">操作</th>
            </tr>
            <c:forEach var="item" items="${page.list}" varStatus="index">
                <tr>
                    <td>${index.index+1}</td>
                    <td>${item.classNo}</td>
                    <td>${item.className}</td>
                    <td>
                        <a href="javascript:void(0);" onclick="updateClass('${item.id}')">修改</a>
                        <a href="javascript:void(0);" onclick="deleteClass('${item.id}')">删除</a>
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
        <div id="t01" class="popCent">
            <!--弹窗头部-->
            <div class="pophead" >
                <div id="addFormHead">班级</div>
                <i><img src="${basePath}/static/img/ico/popesc.png"></i>
            </div>
            <!--弹窗内容-->
            <form id="saveform" method="post">
                <input type="hidden" name="id" id="classId">
            <div class="popText">
                <p class="popW50">
                    <span>班级名称：</span>
                    <input type="text" name="className" id="className">
                </p>
                <p class="popW50">
                    <span>班级编码：</span>
                    <input type="text" name="classNo" id="classNo">
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
    function addClass() {
        poptc('t01');
        $("#classNo").removeAttr("readonly");
        $("#classNo").val("");
        $("#classNoName").val("");
    }
    function updateClass(id) {
        poptc('t01');
        $("#classNo").attr("readonly","readonly");
        $.ajax({
            type : "POST",
            url : "/admin/classes/getInfoByNo",
            data : {id:id},
            dataType : "json",
            async : false,
            success : function(data) {
                if (data.data!=null) {
                    $("#classId").val(data.data.id);
                    $("#classNo").val(data.data.classNo);
                    $("#className").val(data.data.className);

                }
            }
        });
    }
    function save() {
        $.ajax({
            type : "POST",
            url : "/admin/classes/addOrUpdate",
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
    function deleteClass(id) {
        $.ajax({
            type : "POST",
            url : "/admin/classes/deleteClass",
            data : {id:id},
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