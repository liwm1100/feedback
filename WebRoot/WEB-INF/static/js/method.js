//子页面弹出,在父页面打开 - 张思学
function poptc(iid) {
    var $pop = $(".popTc"),
        $id = "#" + iid;
    $pop.show(0, function () {
        $(this).find($id).show(0, function () {
            //弹窗关闭
            $(".pophead i,.popOneA,.popOneB").click(function(){
                $pop.hide();
                $pop.find(".popCent").hide();
                $pop.find(".popOneB").attr("class","popOneA");
                
            })
        });
    });
}

//.aSelect下拉菜单增加
function afileJia($cs) {
    var //获取
        $iId = $($cs).parents("p").find(".aSelect").find("strong:last").find('.redio').attr('id'),
        $iName = $($cs).parents("p").find(".aSelect").find("strong:last").find('.redio').attr('name'),
        $itext = $($cs).parents("p").find(".aSelect").find("strong:last").find('.labelRadio').text(),
        $iSel0 = $($cs).parents("p").find(".aSelect").find("strong:last").find('select').eq(0).html(),
        $iSel0id0 =$($cs).parents("p").find(".aSelect").find("strong:last").find('select').eq(0).attr('id').replace(/\D/g,""),
        $iSel0id1 =$($cs).parents("p").find(".aSelect").find("strong:last").find('select').eq(1).attr('id').replace(/\D/g,""),
        $num = 0;
    $num++;
    var //生成
        $input = $("<input/>").attr("type", "radio").attr("name", $iName).attr("id", $iId + $num).addClass("redio"),
        $label = $("<lable/>").attr("for", $iId + $num).attr("onclick", "popradio(this)").addClass("labelRadio").append($itext),
        $select0 = $("<select/>").attr('id','dept' + ++$iSel0id0).append($iSel0),
        $select1 = $("<select/>").attr('id','post' + ++$iSel0id1).append('<option>请选择</option>'),
        $jia = $("<input/>").attr("type","button").attr("onclick", "afileJia(this)").addClass("aSel aSelJia").append("&nbsp;"),
        $jian = $("<input/>").attr("type","button").attr("onclick", "afileJian(this)").addClass("aSel aSelJian").append("&nbsp;");
    //添加
    $($cs).parent("strong").parent("a").append($("<strong>").append($input, $label, $select0, $select1, $jia, $jian));
}
//.aSelect下拉菜单删除
function afileJian($cs) {
    var $aSelNum = $($cs).parents("p").find(".aSelect").find("strong").find(".aSelJian").length;
    if ($aSelNum > 1) {
        $($cs).parent("strong").remove();
    }
}
//.aSelect下拉单选
function popradio($cs){
    $($cs).parents().find(".labelRadioHover").removeClass('labelRadioHover');
    $($cs).parents().find("input[type='radio']").removeAttr("checked");
    $($cs).addClass("labelRadioHover");
    $($cs).prev().attr("checked", true);
}