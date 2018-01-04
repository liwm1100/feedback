<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <jsp:include page="../includes/headjs.jsp"/>
    <title>用户列表</title>
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
            当前位置：<a href="#">用户管理</a> > <a href="#">列表</a>
        </div>
        <!--查询-->
		<form action="/admin/user/list" method="post" name="frm" accept-charset="utf-8">
            <div class="query">
                <div class="queryL queryLH">
                    <p>
                        <span>用户名称：</span>
                        <input id="userNameQuery" name="name" value="${queryVo.name}">
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
             <a href="javascript:void(0)" onclick="addUser()">添加</a>
        </div>
        <table class="tablelest" border="0" cellspacing="0" cellpadding="0" >
            <tbody>
            <tr class='table_listTr' >
                <th scope="col">序号</th>
                <th scope="col">用户账号</th>
                <th scope="col">用户名称</th>
                <th scope="col">用户类型</th>
                <th scope="col">操作</th>
            </tr>
            <c:forEach var="item" items="${page.list}" varStatus="index">
                <c:if test="${item.account != 'admin'}">
                <tr>
                    <td>${index.index+1}</td>
                    <td>${item.account}</td>
                    <td>${item.name}</td>
                    <td>
                        <c:if test="${item.type==1}">管理员</c:if>
                        <c:if test="${item.type==2}">学校管理员</c:if>
                        <c:if test="${item.type==3}">维修人员</c:if>
                    </td>
                    <td>
                        <a href="javascript:void(0);" onclick="updateUser('${item.id}')">修改</a>
                        <a href="javascript:void(0);" onclick="deleteUser('${item.id}')">删除</a>
                    </td>
                </tr>
                </c:if>
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
                <div id="addFormHead"></div>
                <i><img src="${basePath}/static/img/ico/popesc.png"></i>
            </div>
            <!--弹窗内容-->
            <form id="saveform" method="post">
                <input type="hidden" name="id" id="userId">
            <div class="popText">
                <p class="popW50">
                    <span>用户名称：</span>
                    <input type="text" name="name" id="name">
                </p>
                <p class="popW50">
                    <span>用户账号：</span>
                    <input type="text" name="account" id="account">
                </p>
                <p class="popW50">
                    <span>用户类型：</span>
                    <select name="type" id="type">
                        <option value="1">管理员</option>
                        <option value="2">学校管理员</option>
                        <option value="3">维修人员</option>
                    </select>
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
    function addUser() {
        poptc('t01');
        $("#name").val("");
        $("#account").val("");
    }
    function updateUser(id) {
        poptc('t01');
        $.ajax({
            type : "POST",
            url : "/admin/user/getInfoById",
            data : {id:id},
            dataType : "json",
            async : false,
            success : function(data) {
                if (data.data!=null) {
                    $("#userId").val(data.data.id);
                    $("#name").val(data.data.name);
                    $("#account").val(data.data.account);
                    $("select[name='type'] option[value='"+data.data.type+"']").prop("selected",true);
                }
            }
        });
    }
    function save() {
        $.ajax({
            type : "POST",
            url : "/admin/user/addOrUpdate",
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
    function deleteUser(id) {
        $.ajax({
            type : "POST",
            url : "/admin/user/deleteUser",
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