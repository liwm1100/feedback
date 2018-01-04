<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<body>
<script type="text/javascript">
	$(function () {
		// 高亮显示选中的菜单
		$("#menu_son_"+$.cookie("menuCookie")).attr("class","leftNavOver");
		var parentId= $("#menu_son_"+$.cookie("menuCookie")).attr("pId");
		$("div[id^='menu_parent_']").attr("class","leftNavA");
		$("#menu_parent_"+parentId).attr("class","leftNavA leftNavAover");
	})
	function toPage(page, moduleId){
		// 选中节点设置cookie缓存
		if($.cookie("menuCookie")!=""){
			$.cookie("menuCookie", moduleId, { path: "/"});
		}else{
			$.cookie("menuCookie", moduleId, { path: "/"});
		}
		window.location.href="${basePath}" + page;
	}
</script>

<!--左侧导航-->
    <div class="leftNav" id="leftMenu">
		<div class="leftNavA leftNavAover" id="menu_parent_101">
			<a class="LNAclick">
				<span class="LNAb1">问题情况</span>
				<img class="LNAico" src="/static/img/ico/nav0.png">
			</a>
			<ul class="leftNavtab">
				<li>
					<a onclick="toPage('/admin/question/list','101001')" class="leftNavtabA" id="menu_son_101001" pid="101">
						<i><hr><em>&nbsp;</em></i><span>问题列表</span>
					</a>
				</li>
			</ul>
		</div>
		<div class="leftNavA leftNavAover" id="menu_parent_501">
			<a class="LNAclick">
				<span class="LNAb1">进出货管理</span>
				<img class="LNAico" src="/static/img/ico/nav0.png">
			</a>
			<ul class="leftNavtab">
				<li>
					<a onclick="toPage('/admin/store/list','501001')" class="leftNavtabA" id="menu_son_501001" pid="501">
						<i><hr><em>&nbsp;</em></i><span>进出货管理</span>
					</a>
				</li>
			</ul>
		</div>
		<c:if test="${userCurrent.type==1}">
			<div class="leftNavA" id="menu_parent_201">
				<a class="LNAclick">
					<span class="LNAb1">基础信息</span>
					<img class="LNAico" src="/static/img/ico/nav0.png">
				</a>
				<ul class="leftNavtab">
					<li>
						<a onclick="toPage('/admin/school/list','201001')" class="leftNavtabA" id="menu_son_201001" pid="201">
							<i><hr><em>&nbsp;</em></i><span>学校管理</span>
						</a>
					</li>
					<li>
						<a onclick="toPage('/admin/classes/list','201002')" class="leftNavtabA" id="menu_son_201002" pid="201">
							<i><hr><em>&nbsp;</em></i><span>班级管理</span>
						</a>
					</li>
					<li>
						<a onclick="toPage('/admin/goods/list','201003')" class="leftNavtabA" id="menu_son_201003" pid="201">
							<i><hr><em>&nbsp;</em></i><span>产品管理</span>
						</a>
					</li>
					<li>
						<a onclick="toPage('/admin/company/list','201004')" class="leftNavtabA" id="menu_son_201004" pid="201">
							<i><hr><em>&nbsp;</em></i><span>单位管理</span>
						</a>
					</li>
					<%--<li>
						<a onclick="toPage('/admin/store/list','201005')" class="leftNavtabA" id="menu_son_201005" pid="201">
							<i><hr><em>&nbsp;</em></i><span>进出货管理</span>
						</a>
					</li>--%>
				</ul>
			</div>
			<div class="leftNavA" id="menu_parent_999">
				<a class="LNAclick">
					<span class="LNAb1">系统设置</span>
					<img class="LNAico" src="/static/img/ico/nav0.png">
				</a>
				<ul class="leftNavtab">
					<li>
						<a onclick="toPage('/admin/dict/list','999001')" class="leftNavtabA" id="menu_son_999001" pid="999">
							<i><hr><em>&nbsp;</em></i><span>数据字典</span>
						</a>
					</li>
					<li>
						<a onclick="toPage('/admin/qrcode/index','999002')" class="leftNavtabA" id="menu_son_999002" pid="999">
							<i><hr><em>&nbsp;</em></i><span>二维码</span>
						</a>
					</li>
					<li>
						<a onclick="toPage('/admin/user/list','999003')" class="leftNavtabA" id="menu_son_999003" pid="999">
							<i><hr><em>&nbsp;</em></i><span>用户管理</span>
						</a>
					</li>
				</ul>
			</div>
		</c:if>
    </div>
    <!--左侧导航结束-->
</body>
</html>


