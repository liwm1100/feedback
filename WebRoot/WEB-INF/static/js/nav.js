//$('.headNav') 控制leftNav展开缩小 - 张思学
function headclick() {
    //head点击展开缩小导航
    var $headNav = $('.headNav'),
        $leftNav = $('.leftNav').outerWidth();
    if ($leftNav > 125) {
        $('.leftNavA').removeClass('leftNavAover')
        $('.leftNav,.backNav').animate({
            width: '48px',
        });
        $('.contentText').animate({
            paddingLeft: '60px',
        });
        $('.ifCnav').animate({
            left:'48',
        });
    } else {
        $('.leftNav,.backNav').animate({
            width: '200px',
        });
        $('.contentText').animate({
            paddingLeft: '215px',
        });
        $('.ifCnav').animate({
            left:'200',
        });
    }
};

//头部导航，自动放入下拉框，自动计算显示位置 - 张思学
var $nav = function () {
    var $nav_ul = $('.nav ul').eq(0),
        $nav_a = $nav_ul.clone().removeClass('navList').addClass('navA'),
        $ul = $('<ul/>'),
        $now_width = 0;
    if ($('.navA').size() > 0) {
        $('.navA').replaceWith($nav_a);
    } else {
        $('.nav').append($nav_a);
    }
    $nav_a.find('li').each(function () {
        $now_width += $(this).outerWidth();
        if ($now_width > $nav_a.width()) {
            $ul.append($(this));
        }
    })
    if ($ul.find('li').size() > 0) {
        var $nav_b = $('<div/>').addClass('navB').append($('<span/>').click(function () {
            $(this).next().stop().slideToggle(500)
        }).addClass("navtoogle").append($("<img/>").prop({
            "src": "assets/img/ico/navtoogle.png"
        }))).append($ul);
        if ($('.navB').size() > 0) {
            $('.navB').replaceWith($nav_b);
        } else {
            $('.nav').append($nav_b);
        }
    }
}

//左侧导航，二级菜单展开 - 张思学
var $leftNav = function () {
    var $LNAclick = $('.LNAclick');
    $LNAclick.click(function () {
        var $leftNav = $('.leftNav').outerWidth();
        if ($leftNav < 125) {
            headclick();
        } else if($(this).next('.leftNavtab').css("display") == "block"){
            $(this).parent('.leftNavAover').toggleClass('leftNavAover');
        } else{
            $('.leftNavAover').removeClass('leftNavAover');
            $(this).parent('.leftNavA').toggleClass('leftNavAover');
        }
    });
};
$(document).on('ready', function () {
    $nav();
    $leftNav();
})
