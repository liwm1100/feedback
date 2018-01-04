<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <script src="${basePath}/static/js/jquery-1.11.2.min.js" type="text/javascript"></script>
    <script src="${basePath}/static/js/jquery-validation/jquery.validate.js" type="text/javascript"></script>
    <script src="${basePath}/static/js/jquery.cookie.js" type="text/javascript"></script>
    <script type="text/javascript" src="${basePath}/static/js/view/includes/head.js"></script>
</head>
<body onload="headShowtime()">
<!--头部-->
    <div class="head">
        <div class="logo">管理系统</div>
        <div class="headNav" onclick="headclick()"><img src="${basePath}/static/img/ico/headtoogle.png"></div>
        <div class="cut">
            <%--<#if Session["http-ikj-wolf-common-zn-current-user-companys"]??>

                <#if Session["http-ikj-wolf-common-zn-current-user-company-name"]??>
                    <span id="companySelectShow">${Session["http-ikj-wolf-common-zn-current-user-company-name"]}</span>
                <#else>
                    <span id="companySelectShow">请选择</span>
                </#if>
                <div class="popCut">
                    <#list Session["http-ikj-wolf-common-zn-current-user-companys"] as company>
                        <a onclick="changeCompany('${company.organizationCode}','${company.name}')">${company.name}</a>
                    </#list>
                </div>
            </#if>--%>
        </div>

        <div class="function">
            <strong>欢迎
                <span>
                    ${userCurrent.name}
                </span>
                <var id="headclock"></var>
            </strong>
            <ul>
                <li><a onclick="editPwd()">修改密码</a>
                    <hr>
                </li>
                <li><a href="#">帮助</a>
                    <hr>
                </li>
                <li><a onclick="exitSystem('/admin/logout')">退出</a></li>
                <%--<#if Session["http-ikj-wolf-common-zn-system-logout-url"]??>
                    <#--<li><a href="">退出</a></li>-->
                    <li><a onclick="exitSystem('${Session['http-ikj-wolf-common-zn-system-logout-url']}')">退出</a></li>
                </#if>--%>
            </ul>
        </div>
    </div>
    <!--导航-->
    <div class="nav">
        <ul class="navList">
            <li><a href="javascript:void(0);">反馈系统</a></li>
            <%--<#if Session['http-ikj-wolf-common-zn-access-apps']??>
                <#list Session['http-ikj-wolf-common-zn-access-apps'] as app>
                    <li><a href="${app.domain}">${app.name}</a></li>
                </#list>
            </#if>--%>
        </ul>
    </div>

    <%-- 修改密码弹窗  --%>
    <div class="popTc popTc1">
        <form id="editPwdForm" method="post">
            <!--弹窗-->
            <div id="editPwdForm01" class="popCent" >
                <!--弹窗头部-->
                <div class="pophead" >
                    <div>修改密码</div>
                    <%--<i><img src="${basePath}/static/img/ico/popesc.png"></i>--%>
                </div>
                <!--弹窗内容-->
                <div class="popText" style="width: 420px; display: block;">
                    <p class="popW100">
                        <span>旧密码</span>
                        <input id="editPwdO1" type="password" style="width: auto;" name="oldPassword" class="{required:true,isPassword:true}">
                    </p>
                    <p class="popW100">
                        <span>新密码</span>
                        <input id="editPwdN1" type="password" style="width: auto;" name="newPassword1" class="{required:true,isPassword:true}">
                    </p>
                    <p class="popW100">
                        <span>确认密码</span>
                        <input id="editPwdN2" type="password" style="width: auto;" name="newPassword2" class="{required:true,isPassword:true,equalTo:'#editPwdN1' }" >
                    </p>
                </div>
                <!-- 提交按钮 -->
                <div class="popAn">
                        <em id="editPwdErrorView"></em>
                        <input  id="divBtn" class="popOne" type="button" value="保存" onclick="savePwd()" style="margin-left:70px;">
                        <input type="button" class="popOneA" value="取消" onclick="">
                </div>
            </div>
            <!--弹窗结束-->
        </form>

    </div>

</body>
</html>


