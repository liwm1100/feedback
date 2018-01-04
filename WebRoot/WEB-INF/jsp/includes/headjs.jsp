<%
	String basePath=request.getContextPath();
%>
<meta charset="UTF-8">
<meta name="keywords" content="爱空间">
<link href="${basePath}/static/css/css.css" rel="stylesheet" type="text/css" />
<link href="${basePath}/static/css/page.css" rel="stylesheet" type="text/css" />
<script src="${basePath}/static/js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="${basePath}/static/js/jquery-base64/jquery.base64.js" type="text/javascript"></script>
<script src="${basePath}/static/js/nav.js" type="text/javascript" ></script>
<script src="${basePath}/static/js/method.js" type="text/javascript"></script>
<script src="${basePath}/static/js/paje.js" type="text/javascript"></script>
<script src="${basePath}/static/js/jquery.cookie.js" type="text/javascript"></script>
    
<!-- 验证框架 -->
<link href="${basePath}/static/js/jquery-validation/validate.css" type="text/css" rel="stylesheet" />
<script src="${basePath}/static/js/jquery-validation/jquery.validate.js" type="text/javascript"></script>
<script src="${basePath}/static/js/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
<script src="${basePath}/static/js/jquery-validation/extend.js" type="text/javascript"></script>
<!-- 验证框架end -->

<link rel="stylesheet" type="text/css" href="${basePath}/static/js/My97DatePicker/skin/WdatePicker.css" />
<script type="text/javascript" src="${basePath}/static/js/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript">
    $.base64.utf8encode = true;

	var App = {
		ctx : "${basePath}"
	};
</script>
