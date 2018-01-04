<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>收货</title>
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
        <!--操作按钮-->
        <div class="operation">
            <input type="button" onclick="saveStore()" value="确认收货">
        </div>
        <!--添加修改-->
        <form action="/admin/store/saveIn" name="saveform" id="saveform" method="post" >
        <div class="modify">
            <p >
                <span>进货单位：</span>
                <select id="companys" name="companys">
                    <option value="">--请选择--</option>
                    <c:forEach items="${companyList}" var="item">
                        <option value="${item.code},${item.name}"
                                <c:if test="${store.companyIn == item.code}">selected="selected"</c:if>
                        >${item.code}-${item.name}</option>
                    </c:forEach>
                </select>
            </p>
            <p><p><p>
            <p>
                <span>进货人：</span>
                <input type="text" name="userName" id="userName" value="${store.userName}">
            </p>
            <p>
                <span>备注：</span>
                <textarea id="remark" name="remark">${store.remark}</textarea>
            </p>
        </div>
        <!--分割线-->
        <hr class="borderB" style="margin-bottom:16px;">
        <div class="operation">
            <input type="button" onclick="addRow()" value="添加一行">
        </div>
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
                <th scope="col" width="8%">操作</th>
            </tr>
            <tr>
                <input type="hidden" id="ids" name="ids" value="${store.id}">
                <td><input type="text" id="barNos" name="barNos" value="${store.barNo}" onblur="checkBarNo(this)"></td>
                <td>
                    <select id="goodsInfos" name="goodsInfos" onchange="changeGoods(this)">
                        <option value="">--请选择--</option>
                        <c:forEach items="${goodsList}" var="item">
                            <option value="${item.goodsNo},${item.goodsName}"
                                    <c:if test="${store.goodsNo==item.goodsNo}">selected="selected"</c:if>
                            >${item.goodsNo}-${item.goodsName}</option>
                        </c:forEach>
                    </select>
                </td>
                <td><input type="text" name="goodsUnits" id="goodsUnits" value="${store.goodsUnit}"></td>
                <td><input type="text" name="goodsPrices" id="goodsPrices" value="${store.goodsPrice}"></td>
                <td><input type="text" name="nums" id="nums"  value="${store.num}" onblur="calcPrice(this)"></td>
                <td><input type="text" name="totalPrices" id="totalPrices" value="${store.totalPrice}"></td>
                <td>
                    <input type="text" name="goodsNotes" id="goodsNotes" value="${store.goodsNotes}">
                </td>
                <td></td>
            </tr>
            </tbody>
        </table>
        </form>
    </div>
</body>
<script type="text/javascript">
    function calcPrice(obj) {
        $(obj).parent().next().find("input").val('');
        if($(obj).val()==null||$(obj).val().length==0)return;
        var goodsPriceStr = $(obj).parent().parent().find("input[name='goodsPrices']").val();
        if(goodsPriceStr==null||goodsPriceStr.length==0)return;
        var goodsPrice = parseFloat(goodsPriceStr);
        var curNum = parseInt($(obj).val());
        $(obj).parent().next().find("input").val(goodsPrice*curNum);
    }
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
    function checkBarNo(obj) {
        var barNo = $(obj).val();
        if (barNo==null||barNo.length==0)return;
        $.ajax({
            type : "POST",
            url : "/admin/store/checkBarNoExist",
            data : {barNo:barNo},
            dataType : "json",
            async : false,
            success : function(data) {
                if (data.msg=='exist'){
                    alert("已存在该条形码");
                    $(obj).val('');
                }
            }
        });
    }
</script>
</html>