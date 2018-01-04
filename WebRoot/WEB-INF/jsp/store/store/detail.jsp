<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>收货详情</title>
    <meta name="keywords" content="">
    <jsp:include page="../../includes/headjs.jsp"/>
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
<jsp:include page="../../includes/head.jsp" />
<jsp:include page="../../includes/left.jsp" />
    <!--右侧内容-->
    <div class="contentText">
        <!--当前位置-->
        <div class="location">
            当前位置：<a href="#">收货</a>
        </div>
        <!--添加修改-->
        <form action="/admin/store/saveIn" name="saveform" id="saveform" method="post" >
        <div class="modify">
            <p >
                <span><c:if test="${store.state==10}">进</c:if><c:if test="${store.state==20}">出</c:if>货单位：</span>
                <c:if test="${store.state==10}">${store.companyInName}</c:if><c:if test="${store.state==20}">${store.companyOutName}</c:if>
            </p>
            <p><p><p>
            <p>
                <span><c:if test="${store.state==10}">进货人</c:if><c:if test="${store.state==20}">领用人</c:if>：</span>
                ${store.userName}
            </p>
            <p>
                <span>备注：</span>
                ${store.remark}
            </p>
            <p>
                <span>操作时间：</span>
                <fmt:formatDate value="${store.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </p>

        </div>
        <!--分割线-->
        <hr class="borderB" style="margin-bottom:16px;">
        <!--table列表-->
        <table id="tbl" class="tablelest" border="0" cellspacing="0" cellpadding="0">
            <tbody>
            <tr class="table_listTr">
                <th scope="col" width="10%">条码</th>
                <th scope="col" width="16%">产品</th>
                <th scope="col" width="8%">单位</th>
                <th scope="col" width="8%">单价</th>
                <th scope="col" width="8%">数量</th>
                <th scope="col" width="8%">总计</th>
                <th scope="col" width="8%">备注</th>
            </tr>
            <tr>
                <td>${store.barNo}</td>
                <td>
                    ${store.goodsName}
                </td>
                <td>${store.goodsUnit}</td>
                <td>${store.goodsPrice}</td>
                <td><c:if test="${store.num<0}">${store.num*-1}</c:if><c:if test="${store.num>0}">${store.num}</c:if></td>
                <td>${store.totalPrice}</td>
                <td>${store.goodsNote}</td>
            </tr>
            </tbody>
        </table>
        </form>
    </div>
</body>
<script type="text/javascript">
    function addRow() {
        var trStr = $("#tbl").find("tr:eq(1)").clone();
        $(trStr).find("td:last").append("<input type='button' value='删除' onclick='deleteTr(this)'>");
        $(trStr).find("input[type='text']").val('');
        $("#tbl").append(trStr);
    }
    function deleteTr(obj) {
        $(obj).parent().parent().remove();
    }
    function saveStore() {
        $.ajax({
            type : "POST",
            url : "/admin/store/saveIn",
            data : $("#saveform").serialize(),
            dataType : "json",
            async : false,
            success : function(data) {
                if (data.msg=='success'){
                    alert("收货成功");
                    window.location.href = "/admin/store/list";
                }else{
                    alert(data.msg);
                }
            }
        });
    }
    function changeGoods(obj) {
        var goodsInfo = $(obj).val();
        if (goodsInfo!=null&&goodsInfo.length>0){
            var goodsNo = goodsInfo.split(",")[0];
            $.ajax({
                type : "POST",
                url : "/admin/store/getGoodsInfoByGoodsNo",
                data : {goodsNo:goodsNo},
                dataType : "json",
                async : false,
                success : function(data) {
                    if (data.goods!=null){
                        $(obj).parent().next("td").find("input").val(data.goods.unit);
                        $(obj).parent().next("td").next("td").find("input").val(data.goods.price);
                    }else{
                        alert(data.msg);
                    }
                }
            });
        }
    }
</script>
</html>