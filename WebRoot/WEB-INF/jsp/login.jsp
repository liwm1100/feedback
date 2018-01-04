<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String basePath=request.getContextPath();
%>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>登录</title>
    <meta name="keywords" content="爱空间">
    <link href="${basePath}/static/css/css.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="${basePath}/static/js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="${basePath}/static/js/paje.js"></script>
</head>

<body>
    <div class="login">
        <div class="loginC">
            <img class="loginIco1" src="${basePath}/static/img/login/ico1.png">
            <img class="loginIco2" src="${basePath}/static/img/login/ico2.png">
            <img class="loginIco3" src="${basePath}/static/img/login/ico3.png">
            <div class="longinSign">
                <form action="${basePath}/admin/login" method="post">
                    <img src="${basePath}/static/img/login/name.png">
                    <p><input type="text" name="account"  placeholder="请输入账号"></p>
                    <p><input type="password" name="password" placeholder="请输入密码"></p>
                   <%-- <p>
                        <input type="text" placeholder="请输入验证码">
                        <img src="${basePath}/static/img/delete/yzm.png">
                    </p>--%>
                    <em class="loginError">${error}</em>
                    <input class="loginBottom" type="submit" value="登录">
                </form>
            </div>
        </div>
        <div class="loginB">
            <hr class="loginHr">
            <div class="loginIkj"><p>Copyright @2017 </p></div>
        </div>
    </div>
</body>

</html>