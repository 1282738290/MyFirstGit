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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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


    <link rel='stylesheet' type="text/css" href='${pageContext.request.contextPath}/gjm/layui/css/layui.css'>

    <script src="${pageContext.request.contextPath}/gjm/js/common.js"></script>
    <script src="${pageContext.request.contextPath}/gjm/js/jquery-3.0.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/gjm/js/uploads.js"></script>
    <script src="${pageContext.request.contextPath}/gjm/js/layer.js"></script>
    <script src="${pageContext.request.contextPath}/gjm/js/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/gjm/js/dialog1.js" type="text/javascript"></script>
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
            <li style="background-color: red;"><a href="${pageContext.request.contextPath}/jurisload/${emp_id}.do">
                <i class="layui-icon" style="font-weight: bold;">&#xe613;</i>&nbsp;
                权限详情</a>
            </li>
            <li><a href="${pageContext.request.contextPath}/findxiangqing/${emp_id}.do">
                <i class="layui-icon" style="font-weight: bold;">&#xe62b;</i>&nbsp;
                员工详情</a></li>
            <li><a href="#" onclick="layertc();">
                <i class="layui-icon" style="font-weight: bold;">&#xe6b2;</i>&nbsp;
                修改</a></li>
            <li><a href="#" onclick="location='${pageContext.request.contextPath}/staffindex.do';">
                <i class="layui-icon" style="font-weight: bold;">&#xe6b2;</i>&nbsp;
                返回</a></li>
        </ul>
        <div style=" min-width:250px; float:left;background:none; padding-left:5px; margin-top:5px;">

        </div>
        <div class="clear"></div>
    </div>
</div>

<div class="cssout">
    <div class="set-icon">
        <div style="height:30px; line-height:30px; padding-left:10px;"><B style="font-size:16px;">详细权限</B></div>
        <ul>
            <c:forEach items="${listall}" var="a">
                <li>
                    <label class="qxyes qxtitle" style="background-image:none;"><i class="layui-icon" style="font-weight: bold;">&#xe61c;</i>&nbsp;${a.NAME}</label>
                    <div class="u-xxqx">
                        <dd>
                            <label>显示
                                <input type="checkbox" name="qxflag16" value="${a.id}"
                                       <c:if test="${a.sta==0}">checked</c:if>
                                       class="qxon"/>
                            </label>
                        </dd>
                        <c:forEach items="${a.sMenus}" var="sub">
                            <dd>
                                <label>${sub.NAME}
                                    <input type="checkbox" name="qxflag17" value="${sub.id}"
                                           <c:if test="${sub.subs==0}">checked</c:if>
                                           class="qxon"/>
                                </label>
                            </dd>
                        </c:forEach>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </div>

    <div class="cssout" id="abc" style="display:none; width: 500px; position:fixed;left: 470px;top: 150px; ">
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

    <script>
        function ff() {
            var qxon = document.getElementsByClassName('qxon');
            $.each(qxon,function (i,str) {
                //alert(i);
                if (qxon[i].checked) {
                    qxon[i].parentNode.className = "qxyes";
                } else {
                    qxon[i].parentNode.className = "qxno";
                }
                qxon[i].onclick = function() {
                    if (this.checked) {
                        this.parentNode.className = "qxyes";
                    } else {
                        this.parentNode.className = "qxno";
                    }
                }
            });
        };
        ff();
    </script>
    <div class="h50b"></div>
    <div class="fixed_bg_B">
        <input name="Back" onclick="location='${pageContext.request.contextPath}/staffindex.do';" type="button" id="Back" class="btn2 btnguanb" value="返回"/>
    </div>
</div>
<script type="text/javascript">
    function layertc() {
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

</script>
<!--文件末尾样式引用，此处可以继续增加js和css文件引用-->
</body>
</html>