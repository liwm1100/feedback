<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" name="viewport">
<meta content="no-cache" http-equiv="pragma">
<meta content="no-cache" http-equiv="cache-control">
<meta content="0" http-equiv="expires">
<title>登录</title>
    <script type="text/javascript" src="${basePath}/static/assets/js/jquery-1.8.3.min.js"></script>
    <style type="text/css">
    .rz_no{ overflow:hidden;}
    .rz_no img{ display:block; margin:2rem auto; width:36.6%;}
    .rz_no strong{ text-align:center; display:block; font-weight:normal; font-size:0.75rem; color:#919191; margin-bottom:2rem;}
    .rz_notop{ margin-top:8rem;}
    .rz_no .inputClass {width: 20%;}
</style>
</head>

<body style=" background:#f4f4f4">
	<!--暂无施工-->
    <form action="/auth" method="post">
        <div class="rz_no rz_notop">
            <img src="${basePath}/static/assets/img/head.png">
            <strong>学校编号：<input type="text" name="schoolNo"></strong>
            <strong><input class="inputClass" type="submit" value="登  录"></strong>
        </div>
    </form>
</body>
<script type="text/javascript">
    $(function () {
        var error = "${error}";
        if (error!=null&&error.length>0){
            alert(error);
            window.location.href = "/toAuth";
        }
    })
    function showDetail() {
        var questionNo = $("#questionNo").val();
        if (questionNo==null||questionNo.length==0){
            alert("请填写问题编号在查询");
            return;
        }
        window.location.href = "/detail?questionNo="+questionNo+"&type=show";
    }
</script>
</html>
