<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>出货</title>
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
        .popW100 .inlineClass{
            background-color: #fff;
            cursor: pointer;
            display: block;
            color: #1d8bd8;
            float: left;
            text-align: center;
            font-size: 12px;
            font-family: '微软雅黑';
            min-width: 50px;
            border: 1px solid #1d8bd8;
            border-radius: 3px;
            margin: 0 8px 8px 10px;
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
            当前位置：<a href="#">出货</a>
        </div>
        <!--操作按钮-->
        <div class="operation">
            <input type="button" onclick="saveStore()" value="确认出货">
        </div>
        <!--添加修改-->
        <form action="/admin/store/saveOut" name="saveform" id="saveform" method="post" >
        <div class="modify">
            <p >
                <span>出货单位：</span>
                <select id="companys" name="companys">
                    <option value="">--请选择--</option>
                    <c:forEach items="${schoolList}" var="item">
                        <option value="${item.schoolNo},${item.schoolName}"
                                <c:if test="${store.companyOut==item.schoolNo}">selected</c:if>>${item.schoolNo}-${item.schoolName}</option>
                    </c:forEach>
                </select>
            </p>
            <p><p><p>
            <p>
                <span>领用人：</span>
                <input type="text" name="userName" id="userName" value="${store.userName}">
            </p>
            <p>
                <span>备注：</span>
                <textarea id="remark" name="remark">${store.remark}</textarea>
            </p>
        </div>
        <!--分割线-->
        <hr class="borderB" style="margin-bottom:16px;">

        <!--table列表-->
        <table id="tbl" class="tablelest" border="0" cellspacing="0" cellpadding="0">
            <tbody>
            <div class="modify">
                <p class="popW100">
                    <span>条形码：</span>
                    <input type="text" id="barNoQuery" name="barNoQuery">
                    <input class="inlineClass" type="button" onclick="queryGoods()" value="添加一行">
                </p>
            </div>
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
                <input type="hidden" id="barNos" name="barNos" value="${store.barNo}">
                <input type="hidden" id="goodsInfos" name="goodsInfos" value="${store.goodsNo},${store.goodsName}">
                <input type="hidden" name="goodsUnits" id="goodsUnits" value="${store.goodsUnit}">
                <input type="hidden" name="goodsPrices" id="goodsPrices" value="${store.goodsPrice}">
                <td>${store.barNo}</td>
                <td>${store.goodsName}</td>
                <td>${store.goodsUnit}</td>
                <td>${store.goodsPrice}</td>
                <td><input type="text" name="nums" id="nums" value="${store.num*-1}" onblur="checkNum(this)"></td>
                <td><input type="text" name="totalPrices" id="totalPrices" value="${store.totalPrice}"></td>
                <td>
                    <input type="text" name="goodsNotes" id="goodsNotes" value="${store.goodsNote}">
                </td>
                <td></td>
            </tr>
            </tbody>
        </table>
        </form>
    </div>
</body>
<script type="text/javascript">
    var trs = 2;
    function queryGoods() {
        var barNoQuery = $("#barNoQuery").val()
        if (barNoQuery==null||barNoQuery.length==0){
            alert("请填写条码");
            return;
        }
        $.ajax({
            type : "POST",
            url : "/admin/store/getGoodsStoreByBarNo",
            data : {barNoQuery:barNoQuery},
            dataType : "json",
            async : false,
            success : function(data) {
                if (data.msg=='success'){
                    var store = data.store;

                    var trStr;
                    if (trs==2){
                        trStr = $("#tbl").find("tr:eq(1)");
                        trs++;
                    }else if (trs>2){
                        trStr = $("#tbl").find("tr:eq(1)").clone();
                        $(trStr).find("td:last").append("<input type='button' value='删除' onclick='deleteTr(this)'>");
                    }
                    $(trStr).find("td:eq(0)").html(store.barNo);
                    $(trStr).find("td:eq(1)").html(store.goodsName);
                    $(trStr).find("td:eq(2)").html(store.goodsUnit);
                    $(trStr).find("td:eq(3)").html(store.goodsPrice);
                    $(trStr).find("input[name='ids']").val(store.id);
                    $(trStr).find("input[name='barNos']").val(store.barNo);
                    $(trStr).find("input[name='goodsInfos']").val(store.goodsNo+","+store.goodsName);
                    $(trStr).find("input[name='goodsUnits']").val(store.goodsUnit);
                    $(trStr).find("input[name='goodsPrices']").val(store.goodsPrice);
                    $("#tbl").append(trStr);
                }else{
                    alert(data.msg);
                }
            }
        });
    }
    function checkNum(obj) {
        $(obj).parent().next().find("input").val('');
        if($(obj).val()==null||$(obj).val().length==0)return;
        var curNum = parseInt($(obj).val());
        var goodsInfo = $(obj).parent().parent().find("input[name='goodsInfos']").val();
        if(goodsInfo==null||goodsInfo.length==0)return;
        var goodsPrice = parseFloat($(obj).parent().parent().find("input[name='goodsPrices']").val());
        var goodsNo = goodsInfo.split(",")[0];
        $.ajax({
            type : "POST",
            url : "/admin/store/checkNum",
            data : {goodsNo:goodsNo},
            dataType : "json",
            async : false,
            success : function(data) {
                if (data.msg=='success'){
                    if (data.errorMsg!=null){
                        alert(data.errorMsg);
                        $(obj).val('');
                    }else{
                        var maxNum = data.num;
                        if (curNum>maxNum){
                            alert("库存最大数量"+maxNum);
                            $(obj).val('');
                        }else{
                            $(obj).parent().next().find("input").val(goodsPrice*curNum);
                        }
                    }
                }else{
                    alert(data.msg);
                }
            }
        });
    }
    function addRow() {
        var trStr = $("#tbl").find("tr:eq(1)").clone();
        $(trStr).find("td:last").append("<input type='button' value='删除' onclick='deleteTr(this)'>");
        $("#tbl").append(trStr);
    }
    function deleteTr(obj) {
        $(obj).parent().parent().remove();
    }
    function saveStore() {
        $.ajax({
            type : "POST",
            url : "/admin/store/saveOut",
            data : $("#saveform").serialize(),
            dataType : "json",
            async : false,
            success : function(data) {
                if (data.msg=='success'){
                    alert("修改成功");
                    window.location.href="/admin/store/list";
                }else{
                    alert(data.msg);
                }
            }
        });
    }
</script>
</html>