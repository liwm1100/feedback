//功能使用 - 张思学
$(function () {
    var $windH = $(window).height(),
        $loginH = $(".longinSign").height(),
        $leftNav = $(".leftNav").height(),
        $content = $(".contentText").height();
    //左右 最小高度 + 判断
    $(".leftNav,.ifCnav").css("min-height", $windH - 94);
    $(".contentText").css("min-height", $windH - 94 -12);
    if($content > $leftNav){
        $(".leftNav,.ifCnav").css("min-height", $content);
    }
    //登陆模块高度自居中
    $(".longinSign").css("paddingTop", ($windH - $loginH) / 3);
    //切换城市
    $('.cut').hover(function(){
        $('.popCut').stop().slideToggle(1000);
    })
    //单选
    $(".labelRadio").on('click',function () {
        var name = $(this).prev('input').attr('name');
        $("input[name='" +name+ "']").next('label').removeClass("labelRadioHover");
        $("input[name='" +name+ "']").removeAttr("checked");
        $(this).addClass("labelRadioHover");
        $(this).prev('input').attr("checked", "checked");
    })
    //多选
    $(".labelCheck").on('click',function(){
        var check = $(this).prev('input').attr('checked'),
            num = $(this).siblings('input').size(),
            name = $(this).prev('input').attr('name');
        if( check == undefined){
            $(this).prev('input').attr("checked","checked"); 
            $(this).addClass('labelCheckHover');
        }else{
            $(this).prev('input').removeAttr("checked");
            $(this).removeClass('labelCheckHover');
        }
        //判断是否全选
        if($("input[name='" +name+ "']:checked").length == num){
            $(this).parent().find('.checkAll').attr('type','1');
            $(this).parent().find('.checkAll').text('全不选');
            $(this).parents('.sele').find(".checkAll").attr('style','background: url(/static/img/ico/check1.png) no-repeat left center');
        }else{
            $(this).parent().find('.checkAll').attr('type','0');
            $(this).parent().find('.checkAll').text('全选');
            $(this).parents('.sele').find(".checkAll").removeAttr('style','background: url(/static/img/ico/check1.png) no-repeat left center');
        }
    })
    //全选 - 全不选
    $('.checkAll').on('click',function(){
        var name = $(this).attr('name'),
            type = $(this).attr('type'),
            text = '';
        if( type == 0 ){
            $(this).attr('type','1');
            $(this).text('全不选');
            $(this).attr('style','background: url(/static/img/ico/check1.png) no-repeat left center');
            $("input[name='" +name+ "']").attr("checked","checked"); 
            $("input[name='" +name+ "']").next('label').addClass("labelCheckHover");
            $.each($("input[name='" +name+ "']:checked").next('label'), function(i, item){
                text+=($(item).text()+',');
            })
            $(this).parents('.sele').find('.seleOk').html('').append(text);
        }else if( type == 1){
            $(this).attr('type','0');
            $(this).text('全选');
            $(this).removeAttr('style','background: url(/static/img/ico/check1.png) no-repeat left center');
            $("input[name='" +name+ "']").removeAttr("checked","checked");
            $("input[name='" +name+ "']").next('label').removeClass("labelCheckHover");
            $.each($("input[name='" +name+ "']:checked").next('label'), function(i, item){
                text+=($(item).text()+',');
            })
            $(this).parents('.sele').find('.seleOk').html('').append(text);
        }
    })
    //DIV模拟下拉
    $('.seleOk').on('click',function(){
        var css = $(this).parents('div').attr('class');
        if(css != 'popText'){
            $('.sele').append(
                $('<div/>').addClass('seleEsc').css({
                    'position':'fixed',
                    'width':'100%',
                    'height':'100%',
                    'top':'0',
                    'left':'0',
                    'background':'rgba(0,0,0,.0)',
                    'z-index':'1'
                })
            )
        }else{
            $('.popText').append(
                $('<div/>').addClass('seleEsc').css({
                    'position':'absolute',
                    'width':'660px',
                    'height':'100%',
                    'top':'0',
                    'left':'0',
                    'right':'0',
                    'margin':'0 auto',
                    'background':'rgba(0,0,0,.0)'
                })
            )
        }
        $(this).next('.seleList').toggle();
        $(this).next('.seleList').find('.labelCheck').on('click',function(){
            var name = $(this).prev('input').attr('name'), text = '';
            $.each($("input[name='" +name+ "']:checked").next('label'), function(i, item){
                text+=($(item).text()+',');
            })
            $(this).parents('.sele').find('.seleOk').html('').append(text);
        })
        $('.seleEsc').click(function(){
            $('.seleList').hide();
            $('.seleEsc').remove();
        })
    })
    //查询展开/收起
    $('#queryTab').toggle(
        function () {
            $('.queryL').css('overflow','inherit');
            $(this).find('span').toggle();
            $('.queryL').toggleClass('queryLH');
        },
        function () {
            $('.queryL').css('overflow','hidden');
            $(this).find('span').toggle();
            $('.queryL').toggleClass('queryLH');
        }
    )
    //table点击添加背景色
    $('.tablelest tr').on('click',function () {
        $('.tablelest tr').removeClass('backblue');
        $(this).addClass('backblue');
    })
    //导航树
    $('.ifCnavName').click(function () {
        $(this).find('i').toggleClass('xz_90');
        $(this).next('.ifCnavlist').stop().slideToggle(200)
        $('.ifCnav_xia').click(function () {
            $(this).find('i').toggleClass('xz_90');
            $(this).next('.ifCnavlist_c').stop().slideToggle(200)
        })
    })
    //上传文件 + 获取名称
    $(".inputFile a").click(function () {
        $(this).prev(".file").click();
        $(this).prev(".file").on("change", function () {
            var $filename = $(this).val();
            $(this).nextAll("i").text($filename);
        })
    })
    //左右切换回选择
    $(".lfXz li").click(function () {
        $(this).toggleClass("XzOver");
        //左拿到右
        $(".XzAn #XzL").click(function () {
            var $over = $(this).parent(".XzAn").parent(".lfXz").find(".L").find("li.XzOver");
            $(this).parent(".XzAn").parent(".lfXz").find(".R").append($over);
            $(this).parent(".XzAn").parent(".lfXz").find(".R").find(".XzOver").removeClass("XzOver")
        })
        //右拿到左
        $(".XzAn #XzR").click(function () {
            var $over = $(this).parent(".XzAn").parent(".lfXz").find(".R").find("li.XzOver");
            $(this).parent(".XzAn").parent(".lfXz").find(".L").append($over);
            $(this).parent(".XzAn").parent(".lfXz").find(".L").find(".XzOver").removeClass("XzOver")
        })
    })
    //信息修改切换 - class = processTab 至  processTabText
    $(".processTab strong").click(function(){
        var num = $(this).index(),
            cls = $(this).attr('class');
        $(".processTabText").hide().eq(num).show();
        $(".processTab strong").removeAttr('style');
        $(this).css('background-color','#65d255');
    })
    
});