<%--
  Created by IntelliJ IDEA.
  User: 辜建敏
  Date: 2019/5/14
  Time: 14:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <title>员工列表</title>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/gjm/css/common.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/gjm/css/desktop.css">
    <link rel='stylesheet' type="text/css" href='${pageContext.request.contextPath}/gjm/css/font-awesome.min.css'>
    <link rel='stylesheet' type="text/css" href="${pageContext.request.contextPath}/gjm/css/ui-dialog.css">


    <link rel='stylesheet' type="text/css" href='${pageContext.request.contextPath}/gjm/layui/css/layui.css'>

    <script src="${pageContext.request.contextPath}/gjm/js/common.js"></script>
    <script src="${pageContext.request.contextPath}/gjm/js/jquery-3.0.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/gjm/js/uploads.js"></script>
    <script src="${pageContext.request.contextPath}/gjm/js/layer.js"></script>
    <script src="${pageContext.request.contextPath}/gjm/js/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/gjm/js/dialog.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/gjm/js/sea.js" type="text/javascript"></script>


    <script src="${pageContext.request.contextPath}/gjm/layui/layui.js"></script>

    <script src="${pageContext.request.contextPath}/js/cfcoda.js" language="javascript"></script>
    <script src="${pageContext.request.contextPath}/js/time.js" language="javascript"></script>
    <link href="${pageContext.request.contextPath}/css/lanrenzhijia.css" rel="stylesheet" type="text/css" />

    <!--PC端样式引用，此处可以继续增加js和css文件引用-->
    <style type="text/css">
        td{
            text-align: center;
        }
    </style>
</head>
<body>
<div class="cssout">
    <div class="menuboxs">
        <ul>
            <li style="background-color:red;"><a href="${pageContext.request.contextPath}/staffindex.do">
                <i class="layui-icon" style="font-weight: bold;">&#xe613;</i>&nbsp;
                员工列表</a>
            </li>
            <li><a href="${pageContext.request.contextPath}/#.do">
                <i class="layui-icon" style="font-weight: bold;">&#xe62b;</i>&nbsp;
                部门设置</a></li>
            <li><a href="${pageContext.request.contextPath}/#.do">
                <i class="layui-icon" style="font-weight: bold;">&#xe6b2;</i>&nbsp;
                角色权限</a></li>
        </ul>
        <div style=" min-width:250px; float:left;background:none; padding-left:5px; margin-top:5px;">

        </div>
        <div class="clear"></div>
    </div>
</div>

<ul class="xhing">

<div class="cssout topnavsou">
    <div class="cssin">
        <span class="ksss">快速搜索：</span>
        <input name="S201_mhsou_keywords" id="S201_mhsou_keywords" type="text" class="bor int mhsouint" size="40" value='' placeholder="任务、办理人、时间...">
        <input type="button" name="Submit" class="btn1 btnsou" value="快速搜索">
        <div class="clear"></div>
    </div>
</div>
<div class="searchss"><a id="zkgb"><i class='ficon fa-search'></i>展开高级搜索</a></div>

<div class="cssout">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" CLASS="table_1">
        <tr class="tr_t">
            <td width="10%" nowrap class="td_l_c">编号</td>
            <td width="10%" nowrap class="td_l_c">账号</td>
            <td width="10%" nowrap class="td_l_c">姓名</td>
            <td width="10%" nowrap class="td_l_c">手机号码</td>
            <td width="10%" nowrap class="td_l_c">部门</td>
            <td width="10%" nowrap class="td_l_c">职位</td>
            <td width="15%" nowrap class="td_l_c">状态</td>
            <td width="25%" nowrap class="td_l_c">管理</td>
        </tr>
        <c:forEach items="${list}" var="s" varStatus="v">
            <tr class="tr" >
                <td nowrap class="td_l_c">
                        ${v.count}
                </td>
                <td nowrap class="td_l_c">${s.emp_user}</td>
                <Td nowrap class="td_l_c">${s.dname }</Td>
                <td nowrap class="td_l_c">${s.phone}</td>
                <td nowrap class="td_l_c">${s.dep_name}</td>
                <td nowrap class="td_l_c">${s.rname}</td>
                <c:if test="${s.emp_id eq 1}">
                    <td nowrap class="td_l_c">
                        ---
                    </td>
                    <td nowrap class="td_l_c">
                        ---
                    </td>
                </c:if>
                <c:if test="${s.emp_id ne 1}">
                    <td nowrap class="td_l_c">
                        <c:if test="${s.locked==0}">
                            <a class="fbtn i-sms" id="${s.emp_id}" onclick="ff(${s.locked},${s.emp_id});">
                                <i class="layui-icon" style="font-weight: bold;">&#xe756;</i>
                                <span>使用中</span>&nbsp;</a>
                        </c:if>
                        <c:if test="${s.locked==1}">
                            <a class="fbtn i-del" id="${s.emp_id}" onclick="ff(${s.locked},${s.emp_id});">
                                <i class="layui-icon" style="font-weight: bold;">&#xe756;</i>
                                <span>已禁用</span>&nbsp;</a>
                        </c:if>
                    </td>
                    <td nowrap="nowrap" class="td_l_c">
                        <a class="fbtn i-sms" href="${pageContext.request.contextPath}/jurisload/${s.emp_id}.do" style="background-color: #5ed1d4;">
                            <i class="layui-icon" style="font-weight: bold;">&#xe609;</i>
                            权限&nbsp;</a>
                        <a class="fbtn i-upd" href="#" onclick="layertc(${s.emp_id});" style="background-color:#0c83c9;">
                            <i class="layui-icon" style="font-weight: bold;">&#xe64c;</i>
                            修改&nbsp;</a>
                        <a class="fbtn i-sms"  href="${pageContext.request.contextPath}/findxiangqing/${s.emp_id}.do" style="background-color: #7bd463;">
                            <i class="layui-icon" style="font-weight: bold;">&#xe615;</i>
                            查看详情&nbsp;</a>
                    </td>
                </c:if>
            </tr>
        </c:forEach>
    </table>

</div>
<div class="h50b"></div>
<div class="clear"></div>
<div class="fixed_bg">

<!--分页代码开始-->
<div class="pagenums">
页次 : ${page}/${pages} 页   每页 : 10 条  总数 : ${counts} 条
    <c:if test="${page==1}">
        <a class=disabled href="${pageContext.request.contextPath}/indexload/1.do">首页</a>
        <a class=disabled href="${pageContext.request.contextPath}/indexload/${page-1}.do">上一页</a>
    </c:if>
    <c:if test="${page!=1}">
        <a class="layui-btn" href="${pageContext.request.contextPath}/indexload/1.do">首页</a>
        <a class="layui-btn" href="${pageContext.request.contextPath}/indexload/${page-1}.do">上一页</a>
    </c:if>
    -
    <c:if test="${page==pages}">
        <a class=disabled href="${pageContext.request.contextPath}/indexload/${page+1}.do">下一页</a>
        <a class=disabled href="${pageContext.request.contextPath}/indexload/${pages}.do">尾页</a>
    </c:if>
    <c:if test="${page!=pages}">
        <a class="layui-btn" href="${pageContext.request.contextPath}/indexload/${page+1}.do">下一页</a>
        <a class="layui-btn" href="${pageContext.request.contextPath}/indexload/${pages}.do">尾页</a>
    </c:if>
    <input class=pagenum type="number" max="${pages}" min="1" id="geturl" title='输入跳转页码'>
    <a class="layui-btn" id="al" href="#">跳转</a>

    </div>
    <!--分页代码结束-->
    </div>
    </ul>


    <div class="cssout" id="abc" style="background-color: #0c83c9; display:none; width: 500px; position:fixed;left: 470px;top: 150px; ">
    <div class="cssin">
    <form action="${pageContext.request.contextPath}/tijiao.do" method="post" id="myform">
    <input type="hidden" value="${emp_id}" name="empid"/>
    <ul>
    <li class="w100 bg" style="text-align: center;color: #0c83c9;font-size: 20px;"><dd class="isin"><B>修改角色</B></dd></li>
    <li class="w12 bg cl tr"><dd class="isin">部门</dd></li>
    <li class="w38"><dd class="isin">
    <select name="bumen">
    <option value="0">请选择部门</option>
    <c:forEach items="${dep}" var="d">
        <option value="${d.dep_id}">${d.dep_name}</option>
    </c:forEach>
    </select>
    </dd>
    </li>
    <li class="w12 bg tr"><dd class="isin">职务</dd></li>
    <li class="w38"><dd class="isin">
    <select name="zhiwu" id="zhiwu">
    <option value="0">请选择职务</option>
    </select>
    </dd>
    </li>
    </ul>
    <p style="width: 15px; ">&nbsp;</p>
    <span style="margin-left: 160px;"></span>
    <input type="submit" name="Submit" class="btn2 btnbaoc" value="修改">
    <input name="Back" type="button" id="aa" class="btn2 btnguanb" value="关闭">
    </form>
    </div>
    </div>
    <script type="text/javascript">
    var v=0;
    function ff(s,empid) {
    if(s==0){
    v=1;
    $("#"+empid).removeAttr("class");
    $("#"+empid).attr("class","fbtn i-del");
    $("#"+empid).removeAttr("onclick");
    $("#"+empid).attr("onclick","ff("+v+","+empid+");");
    $("#"+empid+" span").text("已禁用");
    alert("账号已被禁用！");
    }else{
    v=0;
    $("#"+empid).removeAttr("class");
    $("#"+empid).attr("class","fbtn i-sms");
    $("#"+empid).removeAttr("onclick");
    $("#"+empid).attr("onclick","ff("+v+","+empid+");");
    $("#"+empid+" span").text("使用中");
    alert("账号已被启用！");
    }
    $.post('updateLocked.do',{str:v,emp:empid},function () {
    });
    }
    </script>
    <script type="text/javascript">
    function layertc(empid) {
    $("[name='empid']").val(empid);
    layer.open({
    type: 1,
    title:false,
    area: ['500px', '230px'],
    content:$("#abc")
    });
    }

    $("#aa").click(function () {
    $("[name='bumen']").val(0);
    $("[name='zhiwu']").val(0);
    $("#abc").attr("style","display:none; width: 500px; position: absolute;left: 470px;top: 150px;");
    layer.closeAll();
    });

    function loadajax(dep){
    $.post('${pageContext.request.contextPath}/ajaxloadzhiwu.do',{depid:dep},function (data) {
    $("#zhiwu option").remove();
    var st="<option value='0'>请选择职务</option>";
    $.each(data,function () {
    st+="<option value='"+this.id+"'>"+this.NAME+"</option>";
    });
    $("#zhiwu").html(st);
    },'json');
    };

    $(function () {
    var dep=$("[name='bumen']").val();
    loadajax(dep);
    });

    $("[name='bumen']").change(function () {
    var dep=$("[name='bumen']").val();
    loadajax(dep);
    });

    $("#myform").submit(function () {
    var bumen=$("[name='bumen']").val();
    var zhiwu=$("[name='zhiwu']").val();
    if(bumen==0){
    alert("请选择一个部门!");
    return false;
    }else if(zhiwu==0){
    alert("请选择一个职务!");
    return false;
    }else{
    return true;
    }
    });

    $("#al").click(function () {
    var aa=$("#geturl").val();
    var b="${pages}";
    if(aa<1 || aa>b){
        alert("没有此页！");
    }else{
    location="${pageContext.request.contextPath}/indexload/"+aa+".do";
    }
    });

    </script>
    </body>
    </html>


