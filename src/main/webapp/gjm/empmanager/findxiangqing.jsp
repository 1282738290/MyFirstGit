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
    <style>
        #tms{
            font-weight: bold;
            color: red;
        }

        #tms:hover{
            color: blue;
        }
    </style>
</head>
<body>

<div class="cssout">
    <div class="menuboxs">
        <ul>
            <li ><a href="${pageContext.request.contextPath}/jurisload/${emp_id}.do">
                <i class="layui-icon" style="font-weight: bold;">&#xe613;</i>&nbsp;
                权限详情</a>
            </li>
            <li style="background-color: red;"><a href="${pageContext.request.contextPath}/findxiangqing/${emp_id}.do">
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
    <div class="cssin">
        <ul>
            <li class="w100 bg" style="text-align: center;">
                <dd class="isin"><B>人员信息</B></dd>
            </li>

            <!--line-->
            <li class="w12 bg cl tr">
                <dd class="isin">账号:</dd>
            </li>
            <li class="w38">
                <dd class="isin">
                  ${map.emp_user}
                </dd>
            </li>
            <li class="w12 bg tr">
                <dd class="isin">姓名: </dd>
            </li>
            <li class="w38">
                <dd class="isin">
                    ${map.dname}
                </dd>
            </li>
            <!--end-->
            <!--line-->
            <li class="w12 bg cl tr">
                <dd class="isin">部门:</dd>
            </li>
            <li class="w38">
                <dd class="isin">
                    ${map.dep_name}
                </dd>
            </li>
            <li class="w12 bg tr">
                <dd class="isin">职务: </dd>
            </li>
            <li class="w38">
                <dd class="isin">
                    ${map.rname}
                </dd>
            </li>
            <!--end-->

            <!--line-->
            <li class="w12 bg cl tr">
                <dd class="isin">性别:</dd>
            </li>
            <li class="w38">
                <dd class="isin">
                    ${map.sex}
                </dd>
            </li>
            <li class="w12 bg tr">
                <dd class="isin">出生日期: </dd>
            </li>
            <li class="w38">
                <dd class="isin">
                   <fmt:formatDate value="${map.brothday}" pattern="yyyy-MM-dd"></fmt:formatDate>
                </dd>
            </li>
            <!--end-->

            <!--line-->
            <li class="w12 bg cl tr">
                <dd class="isin">籍贯:</dd>
            </li>
            <li class="w38">
                <dd class="isin">
                    ${map.dna}
                </dd>
            </li>
            <li class="w12 bg tr">
                <dd class="isin">学历: </dd>
            </li>
            <li class="w38">
                <dd class="isin">
                    ${map.standard}
                </dd>
            </li>
            <!--end-->
            <!--line-->
            <li class="w12 bg cl tr">
                <dd class="isin">联系电话:</dd>
            </li>
            <li class="w38">
                <dd class="isin">
                    ${map.phone}
                </dd>
            </li>
            <li class="w12 bg tr">
                <dd class="isin">联系qq: </dd>
            </li>
            <li class="w38">
                <dd class="isin">
                    ${map.qq}
                </dd>
            </li>
            <!--end-->
            <!--line-->
            <li class="w12 bg cl tr" style="height: 100px;">
                <dd class="isin">个人介绍:</dd>
            </li>
            <li class="w88">
                <dd class="isin">
                    ${map.self}
                </dd>
            </li>
            <li class="w100 bg" style="text-align: right;">
                <dd class="isin">
                      <span id="tms"><i class="layui-icon" style="font-weight: bold;">&#xe619;</i>
                        更多详情&nbsp;</span>
                </dd>
            </li>

            <div id="aaa" style="display: none;">
                <!--line-->
                <li class="w12 bg cl tr">
                    <dd class="isin">老家:</dd>
                </li>
                <li class="w88">
                    <dd class="isin">
                        ${map.oldhome}
                    </dd>
                </li>
                <li class="w12 bg cl tr">
                    <dd class="isin">住址: </dd>
                </li>
                <li class="w88">
                    <dd class="isin">
                        ${map.address}
                    </dd>
                </li>
                <!--end-->
                <!--line-->
                <li class="w12 bg cl tr">
                    <dd class="isin">紧急联系人:</dd>
                </li>
                <li class="w38">
                    <dd class="isin">
                        ${map.emergency}
                    </dd>
                </li>
                <li class="w12 bg tr">
                    <dd class="isin">紧急联系人方式: </dd>
                </li>
                <li class="w38">
                    <dd class="isin">
                        ${map.emergencyphone}
                    </dd>
                </li>
                <!--end-->
                <!--line-->
                <li class="w12 bg cl tr">
                    <dd class="isin">入职时间:</dd>
                </li>
                <li class="w88">
                    <dd class="isin">
                        <fmt:formatDate value="${map.entrytime}" pattern="yyyy-MM-dd"></fmt:formatDate>
                    </dd>
                </li>
                <li class="w12 bg cl tr">
                    <dd class="isin">电子邮箱: </dd>
                </li>
                <li class="w88">
                    <dd class="isin">
                        ${map.email}
                    </dd>
                </li>
                <!--end-->
            </div>
        </ul>
    </div>
    <div class="h50b"></div>
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
    var v=false;
        $("#tms").click(function () {

            if (v==false){
                v=true;
                $("#aaa").removeAttr("style");
                $("#aaa").attr("style","display:inline;");
            } else{
                v=false;
                $("#aaa").removeAttr("style");
                $("#aaa").attr("style","display:none;");
            }

        });

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
</body>
</html>


