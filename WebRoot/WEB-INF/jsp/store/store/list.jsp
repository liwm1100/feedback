<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <jsp:include page="../../includes/headjs.jsp"/>
    <title>产品列表</title>
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
            当前位置：<a href="#">进出货管理</a> > <a href="#">列表</a>
        </div>
        <!--查询-->
		<form action="/admin/store/list" method="post" name="frm" accept-charset="utf-8">
            <div class="query">
                <div class="queryL">
                    <p>
                        <span>条形码：</span>
                        <input id="barNoQuery" name="barNo" value="${queryVo.barNo}">
                    </p>
                    <p>
                        <span>产品名称：</span>
                        <input id="goodsNameQuery" name="goodsName" value="${queryVo.goodsName}">
                    </p>
                    <p>
                        <span>进货单位：</span>
                        <select id="companyIn" name="companyIn">
                            <option value="">--请选择--</option>
                            <c:forEach items="${companyList}" var="item">
                                <option value="${item.code}"
                                        <c:if test="${queryVo.companyIn == item.code}">selected="selected"</c:if>
                                >${item.code}-${item.name}</option>
                            </c:forEach>
                        </select>
                    </p>
                    <p>
                        <span>出货单位：</span>
                        <select id="companyOut" name="companyOut">
                            <option value="">--请选择--</option>
                            <c:forEach items="${schoolList}" var="item">
                                <option value="${item.schoolNo}"
                                        <c:if test="${queryVo.companyOut==item.schoolNo}">selected</c:if>>${item.schoolNo}-${item.schoolName}</option>
                            </c:forEach>
                        </select>
                    </p>
                    <p>
                        <span>类型：</span>
                        <select id="state" name="state">
                            <option value="">--请选择--</option>
                            <option value="10" <c:if test="${queryVo.state==10}">selected="selected"</c:if>>收货</option>
                            <option value="20" <c:if test="${queryVo.state==20}">selected="selected"</c:if>>已出库</option>
                        </select>
                    </p>
                    <p>
                        <span>备注：</span>
                        <input id="remark" name="remark" value="${queryVo.remark}">
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
             <a href="/admin/store/income">收货</a>
             <a href="/admin/store/outcome">出货</a>
        </div>
        <table class="tablelest" border="0" cellspacing="0" cellpadding="0" >
            <tbody>
            <tr class='table_listTr' >
                <th scope="col">序号</th>
                <th scope="col">条码</th>
                <th scope="col">产品编号</th>
                <th scope="col">产品名称</th>
                <th scope="col">单位</th>
                <th scope="col">价格</th>
                <th scope="col">数量</th>
                <th scope="col">类型</th>
                <th scope="col">操作时间</th>
                <th scope="col">操作</th>
            </tr>
            <c:forEach var="item" items="${page.list}" varStatus="index">
                <tr>
                    <td>${index.index+1}</td>
                    <td>${item.barNo}</td>
                    <td>${item.goodsNo}</td>
                    <td>${item.goodsName}</td>
                    <td>${item.goodsUnit}</td>
                    <td>${item.goodsPrice}</td>
                    <td>
                        <c:if test="${item.state==10}">${item.num}</c:if>
                        <c:if test="${item.state==20}">${item.num*-1}</c:if>

                    </td>
                    <td>
                        <c:if test="${item.state==10}">收货</c:if>
                        <c:if test="${item.state==20}">已出库</c:if>
                    </td>
                    <td><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td>
                        <a href="/admin/store/detail?id=${item.id}">详情</a>
                        <a href="/admin/store/toUpdate?id=${item.id}">修改</a>
                        <a href="javascript:void(0);" onclick="deleteGoods('${item.id}')">删除</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div class="paging">
             <jsp:include page="../../page/page.jsp"/>
        </div>
    </div>
  </div>
  <!--所有内容框结束-->
<script type="text/javascript">
    function deleteGoods(id) {
       if (confirm("确定要删除吗？")){
           $.ajax({
               type : "POST",
               url : "/admin/store/delete",
               data : {id:id},
               dataType : "json",
               async : false,
               success : function(data) {
                   if (data.msg=="success") {
                       alert("删除成功！");
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