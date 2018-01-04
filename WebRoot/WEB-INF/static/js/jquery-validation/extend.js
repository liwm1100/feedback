/*
 * Translated default messages for the jQuery validation plugin.
 * Language: CN
 */
jQuery.extend(jQuery.validator.messages, {
	required: "必填字段",
	remote: "请指定一个不重复的值",
	email: "请输入正确格式的电子邮件",
	url: "请输入合法的网址",
	date: "请输入合法的日期",
	dateISO: "请输入合法的日期 (ISO).",
	number: "请输入合法的数字",
	digits: "只能输入整数",
	creditcard: "请输入合法的信用卡号",
	equalTo: "请再次输入相同的值",
	accept: "请输入拥有合法后缀名的字符串",
	maxlength: jQuery.validator.format("允许的最大长度为 {0} 个字符"),
	minlength: jQuery.validator.format("允许的最小长度为 {0} 个字符"),
	rangelength: jQuery.validator.format("允许的长度为{0}和{1}之间"),
	range: jQuery.validator.format("请输入介于 {0} 和 {1} 之间的值"),
	max: jQuery.validator.format("请输入一个最大为 {0} 的值"),
	min: jQuery.validator.format("请输入一个最小为 {0} 的值")
});

//========== 自定义扩展 ===============

jQuery.validator.addMethod("isMobile", function(value, element) {
	var length = value.length;
	var str = /^(((13[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
	return this.optional(element) || (length == 11 && str.test(value));
}, "手机号码格式不正确");

jQuery.validator.addMethod("isPhone", function(value, element) {
	var length = value.length;
	var str = /^([0-9]{3,4}-)?[0-9]{7,8}$/;
	return this.optional(element) || str.test(value);
}, "电话号码不正确,例:010-88888888");

jQuery.validator.addMethod("isPassword", function(value, element) {
	var length = value.length;
	var str = /^\w{5,16}$/;
	return this.optional(element) || str.test(value);
}, "长度为5-16个字符,只能包含数字,大小写字母及下划线");

jQuery.validator.addMethod("isEng", function(value, element) {
	var length = value.length;
	var str = /^[a-zA-Z0-9]+$/;
	return this.optional(element) || str.test(value);
}, "只能输入数字及字母");
jQuery.validator.addMethod("isCode", function(value, element) {
	var length = value.length;
	var str = /^[a-z0-9]+$/;
	return this.optional(element) || str.test(value);
}, "只能输入数字及字母");
jQuery.validator.addMethod(        
        "selectNone",                             
        function(value, element)        // 验证规则    
        {    
                if (value == "none")        // select默认值需要设置为"none"(当然可以自定义其他值）    
                {        
                        return false;        
                }        
                else        
                {    
                        return true;        
                }    
        },        
        "必须选择一项"        // 默认验证消息（自定义规则信息的国际化是否不起作用？）    
);  
jQuery.validator.addMethod("isPostcode", function(value, element) {
	var length = value.length;
	var str = /^[0-9]{6}$/;
	return this.optional(element) || str.test(value);
}, "邮政编码格式不正确");

//路径匹配 以/开头,只能有 a-z A-Z 0-9 - _ / 字符
jQuery.validator.addMethod("validatePath", function(value, element) {
    return this.optional(element) || /^\/[a-zA-Z0-9-_\/]*$/.test(value);
}, "错误的路径,例子: /demo/1/a-b_c");