/**
 * Created by wangyanbo on 2017/7/3.
 */
$(function () {
    //select tab
    $(".selectTab > ul > li > a").click(function () {
        var fold = $(this).find(".iconFold"),
            select = $(this).nextAll("ol");
        $(this).addClass("active");
        $(this).parent("li").siblings().find("a").removeClass("active");
        $(this).parent("li").siblings().find("ol").slideUp();
        $(this).parent("li").siblings().find(".iconFold").removeClass("iconUnFold");
        $(".mask").remove();
        if(fold.length && select.length){
            fold.toggleClass("iconUnFold");
            select.slideToggle();
            console.log(fold && select);
            $("<div/>").addClass("mask").appendTo("body");
        }
    });

    $(".selectTab ol li").click(function () {
        var text = $.trim($(this).text());
        $(this).addClass("active").siblings().removeClass("active");
        $(this).parents("ol").slideUp();
        $(this).parents("li").find(".iconFold").removeClass("iconUnFold");
        $(this).parents("li").find("span").html(text);
        $(".mask").remove();
    });

    //textarea 字数监控
    $("textarea").bind("propertychange input", function() {
        var num = $(this).val().length;
        $(this).parent().find(".wordNum .num").text(num);
    });

    function popOffsetTop(e) {

    }

    //关闭弹窗
    $("button[type=reset]").click(function () {
        $(this).parents(".popWrap").hide();
        $(".mask").remove();
    });
    $("button[type=submit]").click(function () {
        $(this).parents(".popWrap").hide();
        $(".mask").remove();
    });
})

