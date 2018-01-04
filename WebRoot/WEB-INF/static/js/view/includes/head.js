/**
 * Created by zhangning on 2016/8/25.
 */

function headShowtime()
{
    var today;
    var year;
    var month;
    var date;
    var strDate;
    today=new Date();
    var n_day = today.getDay();
    switch (n_day)
    {
        case 0:{
            strDate = "星期日"
        }break;
        case 1:{
            strDate = "星期一"
        }break;
        case 2:{
            strDate ="星期二"
        }break;
        case 3:{
            strDate = "星期三"
        }break;
        case 4:{
            strDate = "星期四"
        }break;
        case 5:{
            strDate = "星期五"
        }break;
        case 6:{
            strDate = "星期六"
        }break;
        case 7:{
            strDate = "星期日"
        }break;
    }
    year = today.getFullYear();
    month = today.getMonth()+1;
    date = today.getDate();
    if(month<10) month="0"+month;
    if(date<10) date="0"+date;
    document.getElementById('headclock').innerHTML = year + "年" + month + "月" + date + "日 " + strDate;
}

function editPwd() {
    clearEditPwd();
    $(".popTc1").show();
    $(".popTc1").find("#editPwdForm01").show();
    $(".popOneA").click(function () {
        $(".popTc1").hide();
    })
}

// 修改密码

$(function(){
    valdateEditPwdForm = $("#editPwdForm").validate();
});

function clearEditPwd() {
    $(".popTc1").find("#editPwdO1").val("") ;
    $(".popTc1").find("#editPwdN1").val("") ;
    $(".popTc1").find("#editPwdN2").val("") ;
    $("#editPwdErrorView").html("");
}

function changeCompany(selectedCode ,selectedName){
    if(null == selectedCode || null == selectedName || "" == selectedCode || "" == selectedName){
        alert("页面数据不正确，请重新刷新页面再尝试");
        return ;
    }
    var path = App.ctx + "/changeCompany";
    $.ajax({
        type: "POST",
        url: path,
        data: "code="+ $.base64.btoa(selectedCode),
        dataType:"json",
        async: false,
        success:function(data){
            if(data.state == 1){
                $(".head").find("#companySelectShow").html(selectedName);
                alert("保存成功");
            }else{
                alert("保存失败,原因：" + data.msg);
            }
        }
    });

}

function savePwd(){
    if(valdateEditPwdForm.form()){
        if($(".popTc1").find("#editPwdN1").val() != $(".popTc1").find("#editPwdN2").val()){
            $("#editPwdErrorView").html("新密码两次输入不一致");
            return;
        }

        if($(".popTc1").find("#editPwdN1").val() == $(".popTc1").find("#editPwdO1").val()){
            $("#editPwdErrorView").html("新旧密码一样");
            return;
        }

        var path = App.ctx + "/admin/editpwd";
        $.ajax({
            type: "POST",
            url: path,
            data: $("#editPwdForm").serialize(),
            dataType:"json",
            async: false,
            success:function(data){
                if(data.msg == "success"){
                    alert("保存成功");
                    $(".popTc1").hide();
                }else{
                    $("#editPwdErrorView").html(data.msg);
                }
            }
        });
    }
}

function exitSystem(logout) {
    $.cookie("menuCookie", null, { path: "/"});
    window.location.href=logout;
}
